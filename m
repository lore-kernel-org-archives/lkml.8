Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B92EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F22206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:01:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:3223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgGXXB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:01:57 -0400
IronPort-SDR: RjNo21/M2EvMYM+wPxQi2QIKdcBEtVG5x0WhKbzjHRJ9rq3u5eG4roDLGPhePuZKo+gf2qQZQr
 iAm0M7kuV/8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130350260"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="130350260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:01:56 -0700
IronPort-SDR: YCYknJH/6/3nGS40azfETu73MprlCZdLh0l0/PInkO1/7UF18q8L1m2dxSsSxcL2qfykyllYOx
 DtCQq4k2Z/Uw==
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="285074376"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:01:55 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] scripts/kernel-doc: optionally treat warnings as errors
Date:   Fri, 24 Jul 2020 18:01:38 -0500
Message-Id: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
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
warnings as errors in CI/automated tests. A command-line option is
provided to the kernel-doc script, as well as a check on environment
variables to turn this optional behavior on.

Examples for the two subsystems I contribute to:

KCFLAGS="-Wall -Werror" make W=1 sound/
KCFLAGS="-Wall -Werror" make W=1 drivers/soundwire/

Randy Dunlap also suggested adding a log for when generating
documentation. The documentation build is however not stopped for now.

KDOC_WERROR=1 make htmldocs

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
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

