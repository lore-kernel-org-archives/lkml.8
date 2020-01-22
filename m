Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EA21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl7IZ5IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVQj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:39:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36752 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:39:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so7898065wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7/wRTYqfTREfU6U2Q7BRDCb6VZrd3/MsAyFitVuvzmY=;
        b=nl7IZ5INznZAl++C38LYeMJHiwWxwhURFY/z8dz9NTGRqlDx8185MSMGO00yOHlPwc
         OEoaavKPkPXmf+2S6MtvLzpp+bL4V1uQO2vdPiQCCWt3Q0v2NL7CtAbOY2JWnfOAHoq5
         WxelVbfxlyECaPzs+MeLDU6Irk8/yl3x5j7nTtJw8mH9sEws2qFvjRbTTDi9F10U1K95
         RrV7rREAW1mRGN3lLTkrmDx5hRwCJAEfSDOSVVC22C+yAFCZXm4u4IgwIM7WcYNx+EJk
         JnlifmhdLPNm1bI8lCzVjkJZ0K10dS80dmmIap23G315NgICtrJYlQaOMfvdaIqHEzWS
         a9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7/wRTYqfTREfU6U2Q7BRDCb6VZrd3/MsAyFitVuvzmY=;
        b=m3OTHsDfmRsGveZDN1Y2MmeplAun/MZzcr0wgNV0b+nphKNDk0yXCAU+x1NNfehQ8s
         HmR19wKe5O6+GT4RR7gag+aVJayzCFltTKbuaZMqAY1rycd13qzgFmVgeID6RNsZ2Xdm
         XK3OaT8L1xPzsJu0m2WjFEBpgRquFkt3oNVAps22HLnbzrigJYMF6j5Xjv5bqL4Pre8t
         okAnJV/cnT6R8HUgDm6MYCz10bxniq7d8YRUprwc7Ra79Pky3MW9xfG21dJE1C+WAgWl
         IrKE318g3jOPzmc6w6FsOZXYexmu+GXy0vHXOAC/M5qwtMGBT8qRo3NfIkTMPNd0iL6g
         N3bw==
X-Gm-Message-State: APjAAAV+Tx1josjvU2LHa6EtFUfjAHz2dlqGwdKVeUV1nBjJIqaoC00L
        XwOvCSD9eDgqbvW4ivpmQsgvOXrR78w=
X-Google-Smtp-Source: APXvYqz6aevbO2yNiLua5epDBALNHDOVliX4C2AKnPjoHpRSOmi3I7hvRmx+gOtOkwpAA8yYB9TDZA==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr3936976wmb.42.1579711194506;
        Wed, 22 Jan 2020 08:39:54 -0800 (PST)
Received: from localhost.localdomain (lneuilly-657-1-69-3.w80-11.abo.wanadoo.fr. [80.11.53.3])
        by smtp.gmail.com with ESMTPSA id j2sm4908557wmk.23.2020.01.22.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:39:53 -0800 (PST)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6] checkpatch: add command-line option for TAB size
Date:   Wed, 22 Jan 2020 17:38:52 +0100
Message-Id: <20200122163852.124417-3-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20190508122721.7513-4-borneo.antonio@gmail.com>
References: <20190508122721.7513-4-borneo.antonio@gmail.com> <49e0fb2cd3b0a80848f67212167fdbab4b5b8a97.camel@perches.com> <CAAj6DX2=KYJb1_CmyDFra5gpufb2KHU8mT4Nd1UMTHhYs9N1zw@mail.gmail.com> <20190508183606.14767-1-borneo.antonio@gmail.com> <CAAj6DX3aZ+_q1Vi7A+fyje9-s27dYO5_MEhZ_EU-DEVSXwNzkw@mail.gmail.com> <20190509093929.23507-1-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding style requires a size of 8 characters for
both TAB and indentation, and such value is embedded as magic
value allover the checkpatch script.
This makes hard to reuse the script by other projects with
different requirements in their coding style (e.g. OpenOCD [1]
requires TAB size of 4 characters [2]).

Replace the magic value 8 with a variable.

Add a command-line option "--tab-size" to let the user select a
TAB size value other than 8.

[1] http://openocd.org/
[2] http://openocd.org/doc/doxygen/html/stylec.html#styleformat

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Erik Ahlén <erik.ahlen@avalonenterprise.com>
Signed-off-by: Spencer Oliver <spen@spen-soft.co.uk>

---

v1 -> v2
        add the command line option

v2 -> v3
        rewrite commit msg to remove script readability issue

v3 -> v4
        check for command line value positive

v4 -> v5
        exclude --tab-size=1

v5 -> v6
	rebased

---
 scripts/checkpatch.pl | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c1be774b0ed..8bac825665ef 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -64,6 +64,7 @@ my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
+my $tabsize = 8;
 
 sub help {
 	my ($exitcode) = @_;
@@ -98,6 +99,7 @@ Options:
   --show-types               show the specific message type in the output
   --max-line-length=n        set the maximum line length, if exceeded, warn
   --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --tab-size=n               set the number of spaces for tab (default 8)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
   --mailback                 only produce a report in case of warnings/errors
@@ -215,6 +217,7 @@ GetOptions(
 	'list-types!'	=> \$list_types,
 	'max-line-length=i' => \$max_line_length,
 	'min-conf-desc-length=i' => \$min_conf_desc_length,
+	'tab-size=i'	=> \$tabsize,
 	'root=s'	=> \$root,
 	'summary!'	=> \$summary,
 	'mailback!'	=> \$mailback,
@@ -267,6 +270,9 @@ if ($color =~ /^[01]$/) {
 	die "Invalid color mode: $color\n";
 }
 
+# skip TAB size 1 to avoid additional checks on $tabsize - 1
+die "Invalid TAB size: $tabsize\n" if ($tabsize < 2);
+
 sub hash_save_array_words {
 	my ($hashRef, $arrayRef) = @_;
 
@@ -1217,7 +1223,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tabsize) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2230,7 +2236,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tabsize;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3198,7 +3204,7 @@ sub process {
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
-# more than 8 must use tabs.
+# more than $tabsize must use tabs.
 		if ($rawline =~ /^\+\s* \t\s*\S/ ||
 		    $rawline =~ /^\+\s*        \s*/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3217,7 +3223,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3239,11 +3245,11 @@ sub process {
 		if ($perl_version_ok &&
 		    $sline =~ /^\+\t+( +)(?:$c90_Keywords\b|\{\s*$|\}\s*(?:else\b|while\b|\s*$)|$Declare\s*$Ident\s*[;=])/) {
 			my $indent = length($1);
-			if ($indent % 8) {
+			if ($indent % $tabsize) {
 				if (WARN("TABSTOP",
 					 "Statements should start on a tabstop\n" . $herecurr) &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/8)@e;
+					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/$tabsize)@e;
 				}
 			}
 		}
@@ -3261,8 +3267,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tabsize) .
+					" "  x ($pos % $tabsize);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3733,11 +3739,11 @@ sub process {
 			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
 
 			if ($check && $s ne '' &&
-			    (($sindent % 8) != 0 ||
+			    (($sindent % $tabsize) != 0 ||
 			     ($sindent < $indent) ||
 			     ($sindent == $indent &&
 			      ($s !~ /^\s*(?:\}|\{|else\b)/)) ||
-			     ($sindent > $indent + 8))) {
+			     ($sindent > $indent + $tabsize))) {
 				WARN("SUSPECT_CODE_INDENT",
 				     "suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
-- 
2.25.0

