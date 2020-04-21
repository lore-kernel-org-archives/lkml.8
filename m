Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C8C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88197206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479474;
	bh=2hhaL3b04GTa9hGkzgDtd8Jti5DfwEcuKgZiFOrKA4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lAJlyzSQmXq153S9o1onAcp+JKLEFiEGMsCTrS7Efy3eXEVPxkR5IiyhTB3uiCGGC
	 G2JHz2bZi1zdsawPckkgNjNilyBiRs4uc3x8FfNI8eaKPko1w9kJ7FdHB/P6kZbgYB
	 rB+2Tc7Qq5oFBM6piFtENfAHmKTF99jqEphouR48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgDUObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbgDUObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:12 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5019F206D4;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=2hhaL3b04GTa9hGkzgDtd8Jti5DfwEcuKgZiFOrKA4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZgCunWSTEpCKIDm+O41UNN6tUk+WQOXMM5rvDiW/0R/lDdQquI8kDIRdAbZJ92UH
         Z+F0iqQngMOhJ8NMs6h67aYAV/LGs2fAbk/TVB/Z19IVhW8AIK2IxE/9PB3ddLHlBs
         quL3b8zpJprxVm8Ev5e3jt/nHZg1hPew+eJJJthE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqM-Gm; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/5] scripts: sphinx-pre-install: change the warning for version < 2.4.4
Date:   Tue, 21 Apr 2020 16:31:06 +0200
Message-Id: <79584d317ba16f5d4f37801c5ee57cf04085f962.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by Jon, change the version check, in order to not
emit a warning if version is >= 1.7.9, but below 2.4.4.

After this patch, if someone used an older version, it will
say:

	./scripts/sphinx-pre-install
	Sphinx version 1.7.9
	Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.
	Detected OS: Fedora release 31 (Thirty One).

	To upgrade Sphinx, use:

		/devel/v4l/docs/sphinx_1.7.9/bin/python3 -m venv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

	If you want to exit the virtualenv, you can use:
		deactivate

	All optional dependencies are met.
	Needed package dependencies are met.

If Sphinx is not detected at all, it

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 249edb3932af..0d5684c08bbc 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -29,6 +29,8 @@ my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
 my $min_version;
+my $rec_version = "1.7.9";	# PDF won't build here
+my $min_pdf_version = "2.4.4";	# Min version where pdf builds
 
 #
 # Command line arguments
@@ -254,7 +256,7 @@ sub get_sphinx_version($)
 
 sub check_sphinx()
 {
-	my $rec_version;
+	my $default_version;
 	my $cur_version;
 
 	open IN, $conf or die "Can't open $conf";
@@ -271,15 +273,15 @@ sub check_sphinx()
 	open IN, $requirement_file or die "Can't open $requirement_file";
 	while (<IN>) {
 		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
-			$rec_version=$1;
+			$default_version=$1;
 			last;
 		}
 	}
 	close IN;
 
-	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
+	die "Can't get default sphinx version from $requirement_file" if (!$default_version);
 
-	$virtenv_dir = $virtenv_prefix . $rec_version;
+	$virtenv_dir = $virtenv_prefix . $default_version;
 
 	my $sphinx = get_sphinx_fname();
 	if ($sphinx eq "") {
@@ -294,7 +296,7 @@ sub check_sphinx()
 
 	if ($cur_version lt $min_version) {
 		printf "ERROR: Sphinx version is %s. It should be >= %s (recommended >= %s)\n",
-		       $cur_version, $min_version, $rec_version;;
+		       $cur_version, $min_version, $default_version;
 		$need_sphinx = 1;
 		return;
 	}
@@ -302,6 +304,13 @@ sub check_sphinx()
 	if ($cur_version lt $rec_version) {
 		printf "Sphinx version %s\n", $cur_version;
 		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
+		print "         If you want pdf, you need at least $min_pdf_version.\n";
+		$rec_sphinx_upgrade = 1;
+		return;
+	}
+	if ($cur_version lt $min_pdf_version) {
+		printf "Sphinx version %s\n", $cur_version;
+		print "Note: It is recommended at least Sphinx version $min_pdf_version if you need PDF support.\n";
 		$rec_sphinx_upgrade = 1;
 		return;
 	}
-- 
2.25.2

