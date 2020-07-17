Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51A2206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buf2jTJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGQPE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgGQPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:04:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC7C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:04:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so6771433pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I3qgUlUz2ghXUHtKCviLmiSJF24mSfILYglOMEde6BY=;
        b=buf2jTJm3jP9V4ezfLOqBPmR9I3AQjlO7VvumQQZQTXquwNQYQeElGyv03QIE9TPEO
         C5A/QnBze2oTltyu672WIHcwb6YWjybrCJBQhssEw2VOUnBsHolM5/FMklDgaevMAJqG
         jlXgVVlP8nRflojMy5LTNzCjgf5XJIbXU+sLye/85YzkAMkXaoUbCJHBf4ODuX8MRsZ7
         6GBsaDYpS1IU+f8NoWje8EBqJVYZ3fq8pljNXEc4tOk8vDoiH3YgPFnSnRYrR6bS5SmL
         3Gdn4/UUNJ0o7LPO0lolDHxGrsdaDAjSJqfmnRISuvrYeMDGiI1qvIa3G/anTPg/DyFK
         GvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3qgUlUz2ghXUHtKCviLmiSJF24mSfILYglOMEde6BY=;
        b=Pp54XxsyZumP6I44rB/OnxJQstDSyEzkgOnsQEDXcv0m1ax5VtUqclCaGtefhzpIgc
         y62fg1DvOVnP4mDt+MGwU4i0YCqcvtoldMkckmw/oP8t0MB3lLU0ukKRrFDJhu+NWlvA
         QfdSnaXhNVfcP8WcSHQSYeUazGvd2aP6Zwu7xLrvh55plp5CimlqCz//aDf544RR8RmB
         W1uk+oP9ia37fSpIi7TLrvFWtEUDgrLUwFS9sjhJkdJ5kO7hm4PWyMnGbp3T6awIohzy
         0bUaD5LBSfSKMixvb94oX3PH5TRyuU8UYIQYI6evECPCd5y8AwG4iK4qVrPh22XU0o5O
         gT/A==
X-Gm-Message-State: AOAM533jIXH0dWmBdGCHhos2atlIag/Cwh0Fh8igPPxQU0H4oziesPmT
        A82BoXvw1T8rjeZaKLCClc6GxtvHTgy0pw==
X-Google-Smtp-Source: ABdhPJxkdDX1dzkcY205fCPDZe+N5VJKduAGSZLazqMLjDkc4GqKl7QI1Z0RfxivwTQcE/f+5FOYZQ==
X-Received: by 2002:a63:531e:: with SMTP id h30mr8691437pgb.165.1594998297506;
        Fri, 17 Jul 2020 08:04:57 -0700 (PDT)
Received: from DV.bbrouter ([117.192.86.0])
        by smtp.gmail.com with ESMTPSA id o42sm3259180pje.10.2020.07.17.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:04:56 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     darshandv10@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fixed the space and indentation coding styles
Date:   Fri, 17 Jul 2020 20:34:51 +0530
Message-Id: <20200717150451.13735-1-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtllib_crypt_ccmp.c: Fixed the error - space required before the
open parenthesis '(' on line #281.

rtllib_crypt_ccmp.c: Fixed the warning - suspect code indent for
conditional statements on line #338

Signed-off-by: Darshan D V <darshandv10@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 0cbf4a1a326b..b60e2a109ce4 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -278,7 +278,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		int aad_len, ret;
 
 		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
-		if(!req)
+		if (!req)
 			return -ENOMEM;
 
 		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
@@ -337,7 +337,7 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 		}
 		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
 			crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
-				return -1;
+			return -1;
 	} else if (len == 0) {
 		data->key_set = 0;
 	} else {
-- 
2.17.1

