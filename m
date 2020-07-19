Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0238207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R11UaFD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgGSK4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:56:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C050C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 03:56:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so7366284plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIKfZ2h/OsqeEjg5s5ssaDZDoJKCseBDD+tGu/EIuW4=;
        b=R11UaFD8k9tSfOmd+txBsHd9GJep6vkYfYA1rH3RNiySIOlBQD1c957vAiFnE4P7cp
         GKEe1RCqQHNct1x4Gich+h9mWEyS+sMq7eFp5pJMapGs5hMmdKcCoBZOA3Xh8Jnm6W48
         qbApEh4NkLKl0Nxw03jtzFVylpe+J1h2FAFl1SR5b/rbAvUTJy3ifDf1VLPSW8vt1++a
         cHDehwCiblta4DjNA+o5XViosRrMCdsKDjGSR2hg6Tn5oLUoI3whDJUwZXEvVeFlrA5p
         ArcHXhcd8f3tvyMtSUQO/Cm8Klmhx5QR+R400he1vP65Mc6EBzMYiyfTbBc5nkYn8oKc
         X00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIKfZ2h/OsqeEjg5s5ssaDZDoJKCseBDD+tGu/EIuW4=;
        b=eFSGtsQbMI9Mv1MiESUGm2xwurK7VDmwL2JNicdfcd55DLCLb9H3NN7DlpQydtZzqW
         J42eSORPXsxSA5iskeVJ46feAmNg3rSEP30zpYBsFOFPG3oJfRkoGRrhn0MWv6A2LU7G
         aNEo0g8zfi8blK+IkkspmpF7e7IdPbMOaXcGeGrj4C4wSEaSuQD0GHqfQsQ+2diK/QxK
         h24n5BkfLMCOD9RVtygTIphLAI31+4aGFF17+1Xi4AhQzhwCdWy5t16ree+/4bOTI+C2
         SUSF+WFeLsLRKW5DYaAfvtfJ+shhpI0iLaotDBovLxDveAHbOhkO0SsohoeyOalgv33+
         ZvXA==
X-Gm-Message-State: AOAM530pRvzo566edDvXs5vvQAs3NxBJwIn+vOJGt++xC04MfN8DMRJT
        w5RRBib2jItKELa2d3s0r0CPXyExNp3+rQ==
X-Google-Smtp-Source: ABdhPJxgZ/UW5D6dLsCW3Vjn0xw5bnMpFN7wql1vOqCF0jjPLQZMMG99ddPCF2aZok2eCLNa5zpJJA==
X-Received: by 2002:a17:90a:f6d8:: with SMTP id er24mr17144956pjb.203.1595156164592;
        Sun, 19 Jul 2020 03:56:04 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id o26sm13299253pfp.219.2020.07.19.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 03:56:04 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 1/2] staging: rtl8192e: Fixed a coding style error
Date:   Sun, 19 Jul 2020 16:25:56 +0530
Message-Id: <20200719105557.12605-1-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719092236.GB171181@kroah.com>
References: <20200719092236.GB171181@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    rtllib_crypt_ccmp.c: Fixed the error - space required before the
    open parenthesis '(' on line #281.

Signed-off-by: Darshan D V <darshandv10@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 0cbf4a1a326b..b2af802b9451 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -278,7 +278,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		int aad_len, ret;
 
 		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
-		if(!req)
+		if (!req)
 			return -ENOMEM;
 
 		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
-- 
2.17.1

