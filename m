Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC17C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC5E22B48
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEk08p4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgGSMJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:09:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E5C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:09:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so8590921pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mqZUlCTg2NTclDz7vEQxsR/h1muYnX46vKiUf6iB7eA=;
        b=KEk08p4FXY6nGRqNogyZYWU7XKJCf71Yvsn9/7c4DPu5CUwkXmzYb8qkUiNMHISoxU
         z4+HKHeuKM4tjy9hP2d1VS4oTtBHrScxjWExHosp8rQfosxpuIQy+n6YeJWDhtbDN3ZP
         KznMRhNqpjxL8Z5ZV51TUa9V3hZ2V6HYRdqCa5JVN/VLqbAlb93mTImEGjob+lfVAtYh
         1YftXhI2LwjboXNabBAYR58Xk9+Dn2Z1jejc/7IIJJBnWwFBxn+KFyNsvVcEyySJuDGg
         yKAlyzIXW2NLr5lxqSC7OY3Oaa+abaSQ/2NQyzNGfg4LdehhjQRFr1kuHgtpFw6R3yhM
         AN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mqZUlCTg2NTclDz7vEQxsR/h1muYnX46vKiUf6iB7eA=;
        b=VHtjYwwojqdPH8dQXu++uN8RodPcnTPCHPWFbImsDf+8zncHLrqpORaDam/zkSS66x
         xylHZM/J9ut/hT18fR0Znt2zhUvsEhEVzm1TbiX2PuHeM9AOetNBPbl2dImRc+a3GXxL
         yXbdUxoVhibRv80gASZYffDuqEyy8n13jIt9l5SdNLSfMvsbALiQ9TrDhoyYVj03srx5
         UOxrhU42tNFma+XzpoGOhKpiVaXK7/JtDam9fA/rwBLNLhH7OaKFAFA4PSp92gF4TaKZ
         ucrnXrhAljPzMMNyWXD9HIv3VXZeEAmRre7zxTHzxTKABhV6RkUH3+2frXiwyyZ9dH2F
         vSKg==
X-Gm-Message-State: AOAM533voE0xrjp5wwbFuMCyB2MfLivlMHSKL+fKSlC6YQ+1I4Q8T0lY
        JIBdnrD5+Y2y7T4EyM6GD14=
X-Google-Smtp-Source: ABdhPJy4Hmdzwxg9e7n0mTJmL33K0QkyOjs+WxlLxCi5MbTQo7jp053TJV082YctDI23oNtiZRRynQ==
X-Received: by 2002:a17:902:fe85:: with SMTP id x5mr14604700plm.282.1595160565094;
        Sun, 19 Jul 2020 05:09:25 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id z11sm13258466pfk.46.2020.07.19.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 05:09:24 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 1/2] staging: rtl8192e: add space before open parenthesis
Date:   Sun, 19 Jul 2020 17:39:17 +0530
Message-Id: <20200719120918.17862-1-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtllib_crypt_ccmp.c: 

Fix the coding style error by adding a space before
open parenthesis '(' in a conditional statement.

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

