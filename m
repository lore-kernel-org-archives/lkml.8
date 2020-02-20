Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B452C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE73207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBTUbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:31:48 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:35239 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728400AbgBTUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:31:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C3767182CED5B;
        Thu, 20 Feb 2020 20:31:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jail73_66bdb5886c035
X-Filterd-Recvd-Size: 7972
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Feb 2020 20:31:45 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Subject: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */ comments to fallthrough;
Date:   Thu, 20 Feb 2020 12:30:21 -0800
Message-Id: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
to allow clang 10 and higher to work at finding missing fallthroughs too.

Requires a git repository and overwrites the input files.

Typical command use:
    ./scripts/cvt_fallthrough.pl <path|file>

i.e.:

   $ ./scripts/cvt_fallthrough.pl block
     converts all files in block and its subdirectories
   $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
     converts a single file

A fallthrough comment with additional comments is converted akin to:

-		/* fall through - maybe userspace knows this conn_id. */
+		fallthrough;    /* maybe userspace knows this conn_id */

A fallthrough comment or fallthrough; between successive case statements
is deleted.

e.g.:

    case FOO:
    	/* fallthrough */ (or fallthrough;)
    case BAR:

is converted to:

    case FOO:
    case BAR:

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100755 scripts/cvt_fallthrough.pl

diff --git a/scripts/cvt_fallthrough.pl b/scripts/cvt_fallthrough.pl
new file mode 100755
index 000000..6585e4
--- /dev/null
+++ b/scripts/cvt_fallthrough.pl
@@ -0,0 +1,215 @@
+#!/usr/bin/perl -w
+
+# script to modify /* fallthrough */ style comments to fallthrough;
+# use: perl cvt_fallthrough.pl <paths|files>
+# e.g.: perl cvtfallthrough.pl drivers/net/ethernet/intel
+
+use strict;
+
+my $P = $0;
+my $modified = 0;
+my $quiet = 0;
+
+sub expand_tabs {
+    my ($str) = @_;
+
+    my $res = '';
+    my $n = 0;
+    for my $c (split(//, $str)) {
+	if ($c eq "\t") {
+	    $res .= ' ';
+	    $n++;
+	    for (; ($n % 8) != 0; $n++) {
+		$res .= ' ';
+	    }
+	    next;
+	}
+	$res .= $c;
+	$n++;
+    }
+
+    return $res;
+}
+
+my $args = join(" ", @ARGV);
+my $output = `git ls-files -- $args`;
+my @files = split("\n", $output);
+
+foreach my $file (@files) {
+    my $f;
+    my $cvt = 0;
+    my $del = 0;
+    my $text;
+
+# read the file
+
+    next if ((-d $file));
+
+    open($f, '<', $file)
+	or die "$P: Can't open $file for read\n";
+    $text = do { local($/) ; <$f> };
+    close($f);
+
+    next if ($text eq "");
+
+    # for style:
+
+    # /* <fallthrough comment> */
+    # case FOO:
+
+    # while (comment has fallthrough and next non-blank, non-continuation line is (case or default:)) {
+    #   remove newline, whitespace before, fallthrough comment and whitespace after
+    #   insert newline, adjusted spacing and fallthrough; newline
+    # }
+
+    my $count = 0;
+    my @fallthroughs = (
+	'fallthrough',
+	'@fallthrough@',
+	'lint -fallthrough[ \t]*',
+	'[ \t.!]*(?:ELSE,? |INTENTIONAL(?:LY)? )?',
+	'intentional(?:ly)?[ \t]*fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)',
+	'(?:else,?\s*)?FALL(?:S | |-)?THR(?:OUGH|U|EW)[ \t.!]*(?:-[^\n\r]*)?',
+	'[ \t.!]*(?:Else,? |Intentional(?:ly)? )?',
+	'Fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+	'[ \t.!]*(?:[Ee]lse,? |[Ii]ntentional(?:ly)? )?',
+	'fall(?:s | |-)?thr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+    );
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '(((?:[ \t]*\n)*[ \t]*)(/\*\s*(?!\*/)?\b' . "$ft" . '\s*(?!\*/)?\*/(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[1];
+		my $pos_after = $+[3];
+
+		# try to maintain any additional comment on the same line
+		my $comment = "";
+		if ($regex =~ /\\r/) {
+		    $comment = $fallthrough;
+		    $comment =~ s@^/\*\s*@@;
+		    $comment =~ s@\s*\*/\s*$@@;
+		    $comment =~ s@^\s*(?:intentional(?:ly)?\s+|else,?\s*)?fall[s\-]*\s*thr(?:ough|u|ew)[\s\.\-]*@@i;
+		    $comment =~ s@\s+$@@;
+		    $comment =~ s@\.*$@@;
+		    $comment = "\t/* $comment */" if ($comment ne "");
+		}
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;${comment}\n");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+        } while ($count > 0);
+
+    # Reset the fallthroughs types to a single regex
+
+    @fallthroughs = (
+	'fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)'
+    );
+
+    # Convert the // <fallthrough> style comments followed by case/default:
+
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '(((?:[ \t]*\n)*[ \t]*)(//[ \t]*(?!\n)?\b' . "$ft" . '[ \t]*(?!\n)?\n(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[1];
+		my $pos_after = $+[3];
+
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;\n");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+    } while ($count > 0);
+
+    # Convert /* fallthrough */ comment macro lines with trailing \
+
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '((?:[ \t]*\\\\\n)*([ \t]*)(/\*[ \t]*\b' . "$ft" . '[ \t]*\*/)([ \t]*))\\\\\n*([ \t]*(?:case\s+|default\s*:))';
+
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[2];
+		my $pos_after = $+[4];
+
+		my $oldline = "${space_before}${fallthrough}${space_after}";
+		my $len = length(expand_tabs($oldline));
+
+		my $newline = "${space_before}fallthrough;${space_after}";
+		$newline .= "\t" while (length(expand_tabs($newline)) < $len);
+
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "$newline");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+    } while ($count > 0);
+
+    # delete any unnecessary fallthrough; between successive cases and default:
+
+    do {
+	pos($text) = 0;
+	$count = $text =~ s/(case\s+\w+\s*:\n)[ \t]*fallthrough;\n((?:\s*default\s*:|\s*case\s+\w+\s*:))/$1$2/;
+	$del += $count;
+    } while ($count > 0);
+
+# write the file if something was changed
+
+    if ($cvt > 0 || $del > 0) {
+	$modified = 1;
+
+	open($f, '>', $file)
+	    or die "$P: Can't open $file for write\n";
+	print $f $text;
+	close($f);
+
+	if (!$quiet) {
+	    print "fallthroughs:";
+	    print "	converted: $cvt" if ($cvt > 0);
+	    print "	deleted: $del" if ($del > 0);
+	    print "	$file\n";
+	}
+    }
+}
+
+if ($modified && !$quiet) {
+    print <<EOT;
+
+Warning: these changes may not be correct.
+
+These changes should be carefully reviewed manually and not combined with
+any functional changes.
+
+Compile, build and test your changes.
+
+You should understand and be responsible for all object changes.
+
+Make sure you read Documentation/SubmittingPatches before sending
+any changes to reviewers, maintainers or mailing lists.
+EOT
+}
-- 
2.24.0

