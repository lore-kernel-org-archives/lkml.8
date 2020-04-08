Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E4C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7788120769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361343;
	bh=RUaryCbv17f6M0wJZuEKYC+1eCtdsCGZDFGcjpJ2bvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjuR1ReU3+PmeLlbNBkfqlG1GDFqSWWCi48RfFo9RixrlrynIZMtzhexFuTfN7Pus
	 2rqK3b8mxJI5TrEcLdRXXVCL0UfBfs4p6HpcZ5EzLLDL9fm/38Iw5aes80a2rwvh3R
	 m6spfy9RhQR/Ml2z10zRBcGo+jiE0a8GlAFHMu6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgDHPza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2AE20784;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=RUaryCbv17f6M0wJZuEKYC+1eCtdsCGZDFGcjpJ2bvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MngAIaoQ1aGaiq4PCfX1sAsvWuDBPXpd5kULd4rVUlBz8bIGnWolNXWdTAd/e27+r
         hS9O/4G/6lqQuNIE+Pl/rxOJ44psBsAdNVPBoerebCPb5C6zfaJAUF5/hmlQsHmluv
         CS0sjagV+IALwitO4zFeia2Bj7fYQWAsjrLa9gUQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD31-000cGx-0q; Wed, 08 Apr 2020 17:55:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 4/6] scripts: sphinx-pre-install: address some issues with Gentoo
Date:   Wed,  8 Apr 2020 17:55:23 +0200
Message-Id: <4e6d0b6f7aa15e92fc6dffdfb8cd7e30272b6408.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586361086.git.mchehab+huawei@kernel.org>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some small misdetections with Gentoo. While they
don't cause too much trouble, it keeps recomending to
install things that are already there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 7234482475a3..3ae732a028db 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -560,7 +560,8 @@ sub give_gentoo_hints()
 			   "media-fonts/dejavu", 2) if ($pdf);
 
 	if ($pdf) {
-		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf"],
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf",
+				    "/usr/share/fonts/noto-cjk/NotoSerifCJK-Regular.ttc"],
 				   "media-fonts/noto-cjk", 2);
 	}
 
@@ -575,10 +576,10 @@ sub give_gentoo_hints()
 	my $portage_imagemagick = "/etc/portage/package.use/imagemagick";
 	my $portage_cairo = "/etc/portage/package.use/graphviz";
 
-	if (qx(cat $portage_imagemagick) ne "$imagemagick\n") {
+	if (qx(grep imagemagick $portage_imagemagick 2>/dev/null) eq "") {
 		printf("\tsudo su -c 'echo \"$imagemagick\" > $portage_imagemagick'\n")
 	}
-	if (qx(cat $portage_cairo) ne  "$cairo\n") {
+	if (qx(grep graphviz $portage_cairo 2>/dev/null) eq  "") {
 		printf("\tsudo su -c 'echo \"$cairo\" > $portage_cairo'\n");
 	}
 
-- 
2.25.2

