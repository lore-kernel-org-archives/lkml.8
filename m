Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C03C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883476;
	bh=eTRORk/5dw45Vrop63iOVFOaPnzFTb2+02aghgSWZc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwlRVB9iPVEIniXO6JYTJh1wl9R0AoffblVWJJ0rVYyhTM1hcKcPTdaizbtwtnx4F
	 G46fD/tWK2bZo1Ra9h38vsJFr//HcEqFDO5EtXA/Y+BBeiuLlGA4KbJoV0YDCyZZ6/
	 yRSSlze0w64mqaXta+w2O1panJ/mDLBHXXUshHT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407447AbgDNQ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391093AbgDNQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:56:30 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC1F20787;
        Tue, 14 Apr 2020 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883377;
        bh=eTRORk/5dw45Vrop63iOVFOaPnzFTb2+02aghgSWZc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fx3aQKCG85n9h6bNivFZpifDrZgRUxcyhIJigG/JYuVJH2Vyp5cvMq5XkO8JEObOJ
         n2NAtoYIPTchsxid7ZpkL4zm5N67bDxPGUE5PuiO/J9H06wblGGKI4e+aMiXQDyO5k
         gV9kuntIaT55zymrgTc0E0tJEqm+8TFJ4AKayG1Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOr9-0068yo-5M; Tue, 14 Apr 2020 18:56:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH v2 5/6] scripts: sphinx-pre-install: add support for OpenMandriva
Date:   Tue, 14 Apr 2020 18:56:12 +0200
Message-Id: <692809729c6818a0b0f75513da15970c53d5565c.1586883286.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586883286.git.mchehab+huawei@kernel.org>
References: <cover.1586883286.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that Mageia and OpenMandriva will reunite on a single
distribution. In any case, both came from Mandriva. So, it is
close enough to use the same logic.

So, add support for it.

Tested with OpenMandriva 4.1 and with Mageia 7.1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 86e14b9fd537..89b033285caf 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -494,7 +494,7 @@ sub give_mageia_hints()
 		"convert"		=> "ImageMagick",
 		"Pod::Usage"		=> "perl-Pod-Usage",
 		"xelatex"		=> "texlive",
-		"rsvg-convert"		=> "librsvg2-tools",
+		"rsvg-convert"		=> "librsvg2",
 	);
 
 	my @tex_pkgs = (
@@ -503,16 +503,29 @@ sub give_mageia_hints()
 
 	$map{"latexmk"} = "texlive-collection-basic";
 
+	my $packager_cmd;
+	my $noto_sans;
+	if ($system_release =~ /OpenMandriva/) {
+		$packager_cmd = "dnf install";
+		$noto_sans = "noto-sans-cjk-fonts";
+		@tex_pkgs = ( "texlive-collection-fontsextra" );
+	} else {
+		$packager_cmd = "urpmi";
+		$noto_sans = "google-noto-sans-cjk-ttc-fonts";
+	}
+
+
 	if ($pdf) {
-		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
-				   "google-noto-sans-cjk-ttc-fonts", 2);
+		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+				    "/usr/share/fonts/TTF/NotoSans-Regular.ttf"],
+				   $noto_sans, 2);
 	}
 
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-	printf("You should run:\n\n\tsudo urpmi $install\n");
+	printf("You should run:\n\n\tsudo $packager_cmd $install\n");
 }
 
 sub give_arch_linux_hints()
@@ -626,6 +639,10 @@ sub check_distros()
 		give_mageia_hints;
 		return;
 	}
+	if ($system_release =~ /OpenMandriva/) {
+		give_mageia_hints;
+		return;
+	}
 	if ($system_release =~ /Arch Linux/) {
 		give_arch_linux_hints;
 		return;
-- 
2.25.2

