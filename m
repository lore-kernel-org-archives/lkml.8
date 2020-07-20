Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D3C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7738F2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORFXjj2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgGTJOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63264C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:14:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so9786638pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OgGatn92pn/mnj6HtZstu6jkm6gd4UA0RdQ6VPZ+TmQ=;
        b=ORFXjj2peS1SWBYqeUz/r7LE24pHwRsT7JPbfVH5mFcqrhoaN2VaPtjoL8nkwzOySk
         zxoLTupZcFLfRAyHU32QRUsPLAVJ+FATtKxtkPL2wJ+Z4Pexien2UZBWRMJcnUhxGjaj
         AsKkGlbbX94dWxrc3TLBH54mRxZoI9Cs0loEJxPJGA650ol7C2FFM/D7RTGfn4IqRx52
         oLPHVoglWudrxthhhXOZzkwJ/9XqKyhOttot/Sp9toFv/yCwY5EzJmECihM9JvONgHYk
         zmQPIxPvUFdULB5auiQgL3eMCV1uP+/YHigcto7hprR+wN3qOh+Ql4wuQ0mDnFpw9ZsT
         5JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OgGatn92pn/mnj6HtZstu6jkm6gd4UA0RdQ6VPZ+TmQ=;
        b=oQLbEA+JqFn6GfJAlN2O6HUU/YXXuP3xf0z1Az7D7iVosqGZKUPJmIt6KfRdaFtYoQ
         FMZLRLhVpfQrWJUScF07hSGEG4PBdbEEqv/JAmO6ZTrt6/MViM7xXgV/KehLlF4R/m1a
         U37SGhsEK/+xOvssMtIW0/is4Z+Z3SCdE4KW/X8NofZ//mbg84F0Q9FSIoq8ZSFVtOSB
         EnjiKvnvPL53DDg7TPqPsgArsBHpTwG3xnaS1t1yqr/gi19f3FCKapQOaphEwwDSsEWz
         YFVmJUh+4aCouhLKkGrj00854N0igM1mjM5JcnkMmZqqEicfcpnDvLh9yReF75zZqwBa
         n8kA==
X-Gm-Message-State: AOAM533y6/rhbjUMxXNtx9mKk1Y/gFQUrlVv+YognU0XIt+vVldkMmzq
        E0c6kcfkxbbg1quePG/FbrRi1yGdo7mEGQ==
X-Google-Smtp-Source: ABdhPJzM+4thIezZhVyXpy0+FfrJpNjkiinA17WMz2ifXMSx/ZTjIapWv8xXyQjatRoREGNSR5cF7w==
X-Received: by 2002:a17:90a:26ac:: with SMTP id m41mr21877321pje.169.1595236488926;
        Mon, 20 Jul 2020 02:14:48 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id w9sm16276548pfq.178.2020.07.20.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:48 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 1/2] staging: rtl8192e: add space before open parenthesis
Date:   Mon, 20 Jul 2020 14:44:41 +0530
Message-Id: <20200720091442.19532-1-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

