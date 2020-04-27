Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290C1C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159862084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD0Fk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:40:57 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:57318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgD0Fk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:40:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CBBFF100E7B40;
        Mon, 27 Apr 2020 05:40:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl97_7daddaa7d028
X-Filterd-Recvd-Size: 5572
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 05:40:53 +0000 (UTC)
Message-ID: <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
Subject: [PATCH] get_maintainer: Add email addresses from .yaml files
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Sun, 26 Apr 2020 22:40:52 -0700
In-Reply-To: <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
         <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.yaml files can contain maintainer/author addresses and it seems
unlikely or unnecessary that individual MAINTAINER file section
entries for each .yaml file will be created.

So dd the email addresses found in .yaml files to the default
get_maintainer output.

The email addresses are marked with "(in file)" when using the
"--roles" or "--rolestats" options.

Miscellanea:

o Change $file_emails to $email_file_emails to avoid visual
  naming conflicts with @file_emails

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6cbcd1..6d973f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -57,7 +57,7 @@ my $status = 0;
 my $letters = "";
 my $keywords = 1;
 my $sections = 0;
-my $file_emails = 0;
+my $email_file_emails = 0;
 my $from_filename = 0;
 my $pattern_depth = 0;
 my $self_test = undef;
@@ -69,6 +69,12 @@ my $vcs_used = 0;
 
 my $exit = 0;
 
+my @files = ();
+my @fixes = ();			# If a patch description includes Fixes: lines
+my @range = ();
+my @keyword_tvi = ();
+my @file_emails = ();
+
 my %commit_author_hash;
 my %commit_signer_hash;
 
@@ -266,7 +272,7 @@ if (!GetOptions(
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
 		'sections!' => \$sections,
-		'fe|file-emails!' => \$file_emails,
+		'fe|file-emails!' => \$email_file_emails,
 		'f|file' => \$from_filename,
 		'find-maintainer-files' => \$find_maintainer_files,
 		'mpath|maintainer-path=s' => \$maintainer_path,
@@ -424,6 +430,22 @@ sub read_all_maintainer_files {
     }
 }
 
+sub maintainers_in_file {
+    my ($file) = @_;
+
+    return if ($file =~ m@\bMAINTAINERS$@);
+
+    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+	open(my $f, '<', $file)
+	    or die "$P: Can't open $file: $!\n";
+	my $text = do { local($/) ; <$f> };
+	close($f);
+
+	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	push(@file_emails, clean_file_emails(@poss_addr));
+    }
+}
+
 #
 # Read mail address map
 #
@@ -504,12 +526,6 @@ sub read_mailmap {
 
 ## use the filenames on the command line or find the filenames in the patchfiles
 
-my @files = ();
-my @fixes = ();			# If a patch description includes Fixes: lines
-my @range = ();
-my @keyword_tvi = ();
-my @file_emails = ();
-
 if (!@ARGV) {
     push(@ARGV, "&STDIN");
 }
@@ -527,7 +543,7 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails)) {
+	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
 	    open(my $f, '<', $file)
 		or die "$P: Can't open $file: $!\n";
 	    my $text = do { local($/) ; <$f> };
@@ -539,10 +555,6 @@ foreach my $file (@ARGV) {
 		    }
 		}
 	    }
-	    if ($file_emails) {
-		my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
-		push(@file_emails, clean_file_emails(@poss_addr));
-	    }
 	}
     } else {
 	my $file_cnt = @files;
@@ -923,6 +935,8 @@ sub get_maintainers {
 		print("\n");
 	    }
 	}
+
+	maintainers_in_file($file);
     }
 
     if ($keywords) {
@@ -1835,7 +1849,7 @@ tm toggle maintainers
 tg toggle git entries
 tl toggle open list entries
 ts toggle subscriber list entries
-f  emails in file       [$file_emails]
+f  emails in file       [$email_file_emails]
 k  keywords in file     [$keywords]
 r  remove duplicates    [$email_remove_duplicates]
 p# pattern match depth  [$pattern_depth]
@@ -1960,7 +1974,7 @@ EOT
 		bool_invert(\$email_git_all_signature_types);
 		$rerun = 1;
 	    } elsif ($sel eq "f") {
-		bool_invert(\$file_emails);
+		bool_invert(\$email_file_emails);
 		$rerun = 1;
 	    } elsif ($sel eq "r") {
 		bool_invert(\$email_remove_duplicates);


