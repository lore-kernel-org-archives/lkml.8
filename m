Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A2C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A230207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgG1QYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:24:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:38462 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbgG1QYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:24:04 -0400
IronPort-SDR: pjAdoghT3dIQ4BdsXPIP6jxl3EVsRAH83EAfnImj5SzIrX243WWIRjcLvz8L4k2IG8qjHtZrI/
 570qg0f2kOqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151236180"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="151236180"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 09:20:56 -0700
IronPort-SDR: M1iOCrXIwQVbYblO1JTLgs5Wv/lcEYHyN+gMzYqV9suGvZ5PKuBTGNpWTsx4dkNM0sLKO2jUnH
 Ixd+FRBS+pTw==
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="328383867"
Received: from kmolinar-mobl4.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.212.162.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 09:20:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] scripts/kernel-doc: optionally treat warnings as errors
Date:   Tue, 28 Jul 2020 11:20:40 -0500
Message-Id: <20200728162040.92467-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild bot recently added the W=1 option, which triggered
documentation cleanups to squelch hundreds of kernel-doc warnings.

To make sure new kernel contributions don't add regressions to
kernel-doc descriptors, this patch suggests an option to treat
warnings as errors in CI/automated tests.

A -Werror command-line option is added to the kernel-doc script. When
this option is set, the script will return the number of warnings
found. The caller can then treat this positive return value as an
error and stop the build.

Using this command line option is however not straightforward when the
kernel-doc script is called from other scripts. To align with typical
kernel compilation or documentation generation, the Werror option is
also set by checking the KCFLAGS environment variable, or if
KDOC_WERROR is defined, as in the following examples:

KCFLAGS="-Wall -Werror" make W=1 sound/
KCFLAGS="-Wall -Werror" make W=1 drivers/soundwire/
KDOC_WERROR=1 make htmldocs

Note that in the last example the documentation build does not stop,
only an additional log is provided.

Credits to Randy Dunlap for suggesting the use of environment variables.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2: reworded ChangeLog as suggested by Jonathan Corbet.

 scripts/kernel-doc | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e991d7f961e9..d1b445665ad6 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -81,6 +81,7 @@ Output selection modifiers:
 Other parameters:
   -v			Verbose output, more warnings and other information.
   -h			Print this help.
+  -Werror		Treat warnings as errors.
 
 EOF
     print $message;
@@ -273,6 +274,7 @@ my $kernelversion;
 my $dohighlight = "";
 
 my $verbose = 0;
+my $Werror = 0;
 my $output_mode = "rst";
 my $output_preformatted = 0;
 my $no_doc_sections = 0;
@@ -319,6 +321,18 @@ if (defined($ENV{'KBUILD_VERBOSE'})) {
 	$verbose = "$ENV{'KBUILD_VERBOSE'}";
 }
 
+if (defined($ENV{'KDOC_WERROR'})) {
+	$Werror = "$ENV{'KDOC_WERROR'}";
+}
+
+if (defined($ENV{'KCFLAGS'})) {
+	my $kcflags = "$ENV{'KCFLAGS'}";
+
+	if ($kcflags =~ /Werror/) {
+		$Werror = 1;
+	}
+}
+
 # Generated docbook code is inserted in a template at a point where
 # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
 # https://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
@@ -433,6 +447,8 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	push(@export_file_list, $file);
     } elsif ($cmd eq "v") {
 	$verbose = 1;
+    } elsif ($cmd eq "Werror") {
+	$Werror = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
 	usage();
     } elsif ($cmd eq 'no-doc-sections') {
@@ -2262,4 +2278,9 @@ if ($verbose && $warnings) {
   print STDERR "$warnings warnings\n";
 }
 
-exit($output_mode eq "none" ? 0 : $errors);
+if ($Werror && $warnings) {
+    print STDERR "$warnings warnings as Errors\n";
+    exit($warnings);
+} else {
+    exit($output_mode eq "none" ? 0 : $errors)
+}
-- 
2.25.1

