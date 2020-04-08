Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066DBC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39BF2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361334;
	bh=fxhR9AK7Zg45UxZjCZAP7Ym4x86F4tRCBgIQ+kzm/qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9RwNvbxJMv4v2MxVag0moaYoJWolgeWO4aKx8wMfELkeCoDOqgcYiTbjM6iN2Z0M
	 qTeKi7jjJQiYCEEmrqXfA3jxRtoS+qGBJyXIRBYvkGJ0Ykd6DnXDU17OPSDRqNC7CI
	 ZlF63DUQRkRZQCwKrBvyxNZA4se04Q9uEPqvozCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgDHPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36062082D;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=fxhR9AK7Zg45UxZjCZAP7Ym4x86F4tRCBgIQ+kzm/qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3tEPjT0MuWXm0XkGG/VGr+kFTO6RbBTkV91oiVHLQP752jRb8t5JcTlVdAcYvB4G
         WnHCBaV8XDhnkwHTYbklftGRS0b9EbhNqABeh6kBkqFaGv4IV3ZiUd5npKDsiimVUy
         OScE6dp3h3v9jfNa9ygXQXBnAzrIg+rbfNIw3mnc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD31-000cH4-1n; Wed, 08 Apr 2020 17:55:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 5/6] scripts: sphinx-pre-install: add support for OpenMandriva
Date:   Wed,  8 Apr 2020 17:55:24 +0200
Message-Id: <d48a6ae0a6382841fe8c6924eac32ae88d0c0bda.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586361086.git.mchehab+huawei@kernel.org>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
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
index 3ae732a028db..dab8e3daeed7 100755
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

