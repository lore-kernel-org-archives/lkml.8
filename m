Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C07C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EC6206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479483;
	bh=Ps99F9PFRvMCZhRBvdlxLhbqU4z1Ty16TYpU4e80mKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ef6x01RUSrhuscxYJGVZ8enARhxyt5ax2gjespRfKvrKwUsn+s9JRnNFk3/lDZP35
	 S+wVAge/GEFPRRmVSBIi+6mjPhlYJxHJfCN9PYg1a2qGJ4NA6ZYgM39pPLPlFZNt1S
	 DkwNEIX/DBo+g40cQUcUbaT+QM1gHZaySG74GHOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgDUObR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgDUObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:13 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50580206D6;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=Ps99F9PFRvMCZhRBvdlxLhbqU4z1Ty16TYpU4e80mKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lbvt2f3iR5vvXQqXyWG3Z2PluydtylOqj8fvgiYB1fJjt7kjGlfbzAPL2cPOPHQhw
         OFZgprygdFYs9wC8puykhrHu2jMYeAanQUkxcsqYv2Acuipb8mNgdLh5zA4IImulNF
         9ecFUtsguYTDbgkXrZcp80eCYIypF6g5FnoK1UpA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqQ-HZ; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/5] scripts: sphinx-pre-install: change recommendation text if venv exists
Date:   Tue, 21 Apr 2020 16:31:07 +0200
Message-Id: <bcf79d0399a1c3444ca938dcdce599c3273980ab.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one is running a Sphinx version older than what's recommended,
but there's already a newer working virtual env, change the
text, as it is just a matter of switching to the new venv, instead
of creating a new one from scratch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 0d5684c08bbc..938b65d40fc8 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -29,6 +29,7 @@ my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
 my $min_version;
+my $cur_version;
 my $rec_version = "1.7.9";	# PDF won't build here
 my $min_pdf_version = "2.4.4";	# Min version where pdf builds
 
@@ -257,7 +258,6 @@ sub get_sphinx_version($)
 sub check_sphinx()
 {
 	my $default_version;
-	my $cur_version;
 
 	open IN, $conf or die "Can't open $conf";
 	while (<IN>) {
@@ -703,8 +703,6 @@ sub check_needs()
 		print "Unknown OS\n\n";
 	}
 
-	print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
-
 	# Check python command line, trying first python3
 	$python_cmd = findprog("python3");
 	$python_cmd = check_program("python", 0) if (!$python_cmd);
@@ -786,24 +784,36 @@ sub check_needs()
 		@activates = sort {$b cmp $a} @activates;
 		my ($activate, $ver);
 		foreach my $f (@activates) {
-			$activate = $f;
-			next if ($activate lt $min_activate);
+			next if ($f lt $min_activate);
 
-			my $sphinx_cmd = $activate;
+			my $sphinx_cmd = $f;
 			$sphinx_cmd =~ s/activate/sphinx-build/;
 			next if (! -f $sphinx_cmd);
 
 			$ver = get_sphinx_version($sphinx_cmd);
-			last if ($ver ge $min_version);
+			if ($need_sphinx && ($ver ge $min_version)) {
+				$activate = $f;
+				last;
+			} elsif ($ver gt $cur_version) {
+				$activate = $f;
+				last;
+			}
 		}
-		if ($need_sphinx && ($activate ne "")) {
-			printf "\nNeed to activate Sphinx (version $ver) on virtualenv with:\n";
-			printf "\t. $activate\n";
-			deactivate_help();
-			exit (1);
+		if ($activate ne "") {
+			if ($need_sphinx) {
+				printf "\nNeed to activate Sphinx (version $ver) on virtualenv with:\n";
+				printf "\t. $activate\n";
+				deactivate_help();
+				exit (1);
+			} else {
+				printf "\nYou may also use a newer Sphinx (version $ver) with:\n";
+				printf "\tdeactivate && . $activate\n";
+			}
 		} else {
 			my $rec_activate = "$virtenv_dir/bin/activate";
 
+			print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
+
 			if ($need_venv) {
 				printf "\t$python_cmd -m venv $virtenv_dir\n";
 			} else {
-- 
2.25.2

