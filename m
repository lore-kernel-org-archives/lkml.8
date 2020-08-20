Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0992206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASMCNvoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHTIvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHTIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:51:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E4C061757;
        Thu, 20 Aug 2020 01:51:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so684769pjd.0;
        Thu, 20 Aug 2020 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ar+rI+xGDP4PssjfL9GqrHFQRasXWCFc3IqAQQhSYEQ=;
        b=ASMCNvoellD7szN4qArS90zy/x+CkLjVo9aX2itUUDPdsnmxyAsB6GtPaHdSDtqHOd
         rkflihx4G6UG2Du0p9HYYLcJICuBxTJYbUDl1aH4hN8P6bF+omUVoAtghlZF71z0F9qq
         drlct4R+7Gpp7k0e/xkjBOza6PLJgTwX/4q/BnJqO4VHF1XDJ10qi8+6NgVtJ7jBy6R9
         Ku0ORXG2Bl91tGTiQDxXO5mQgN/pFID2CgoyZrW/KRakq5v0O6Fn/4eCpoKsH7F9Yopl
         aWvd6GyuwIuwzE7+hiF1oG5lRs5T+tTAbCTTacgCry4U8tkLqQdEPzftt5Ya0FlwhxV7
         5xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ar+rI+xGDP4PssjfL9GqrHFQRasXWCFc3IqAQQhSYEQ=;
        b=P/UB35Odi1rBZLYOdowZDZROw48SFuIuSlU7CWYrxxJv7rZJ3eg+xnB5Y7+PPZA2WW
         wYGKCq+ykJsPTO9EzF3xUHUUKZl74JxUiERvJL5jp+U0WIeQumprwIzZiu8DnBEZ1xoS
         0WDua8ogPQ36xH0WCHBsX78xHpyTLd2pU/+trJPJ/NaC3/eHnf/aC9lWh1YCtDB/EPuV
         22j+qCqi8i2Ym/+omzxJMursHKlw56KdZXKVsGk6Y8aeHrZsSqlsMSNoR4GAOBwPfeIy
         Vx/yCgL+pFGtd0j7Vi2b30at52zwkcg2WXAsDlfuc0Z7E3QB0JNR3oK0UCzMhWjm6vT2
         fl3w==
X-Gm-Message-State: AOAM533rhUbq9omKUf0MGdXAF/tRekTh5LbpLb7r6WQvxs9HP6CK9D9j
        WpWqEYm/u4vYs3ZjlDJmqlc=
X-Google-Smtp-Source: ABdhPJzwg/kSvmTns70zUU1N5icVsDSJ+MQrnF9Iz8GxpzsfWfaG+/FybKXsUw3JzQncr+lYPMyc1g==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr1739558pjg.184.1597913499779;
        Thu, 20 Aug 2020 01:51:39 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id v8sm21683336pju.1.2020.08.20.01.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:51:39 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:21:27 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 5/6] staging: wfx/hif_rx.c: Fix spelling mistake
 "negociation" => "negotiation"
Message-ID: <eab6bcb570dcd1407efc8163ff8ff976f623ae9c.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/hif_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index cc7c0cf226ba..1d32973d8ec1 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -118,7 +118,7 @@ static int hif_keys_indication(struct wfx_dev *wdev,
 
 	// SL_PUB_KEY_EXCHANGE_STATUS_SUCCESS is used by legacy secure link
 	if (body->status && body->status != HIF_STATUS_SLK_NEGO_SUCCESS)
-		dev_warn(wdev->dev, "secure link negociation error\n");
+		dev_warn(wdev->dev, "secure link negotiation error\n");
 	memcpy(pubkey, body->ncp_pub_key, sizeof(pubkey));
 	memreverse(pubkey, sizeof(pubkey));
 	wfx_sl_check_pubkey(wdev, pubkey, body->ncp_pub_key_mac);
-- 
2.17.1

