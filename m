Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1E20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JPlJwOyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHNWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgHNWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:40:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF12C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:40:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 62so9794760qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S+Nq4NH8jPvnXfz2GyxerSue0wCYMn7S7LmKnPKVOT8=;
        b=JPlJwOyxCUlIU8uursfJxCa63kd5rWUfURylxigZ9fCMpK8ivmBXELZ6jo/4KQjGKE
         EsVQl3ZwOdVdD5ERWmY+zm0womFqwFjZrgvy4Dm4f3zbjmfUZSgNjNCvpoxS3ukBGxBw
         frGZSymSwOCdkJRHbIAE6PUpWNUGTbvV09Tw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S+Nq4NH8jPvnXfz2GyxerSue0wCYMn7S7LmKnPKVOT8=;
        b=oH2FxQ5zB0dI5SHYh2BpYSZ9004VRUDHMZWA7ISAvcI8csswJe/YR7yW1iMT/XpO/g
         46h69aUMygoq6MovJ9/FFko3JtmmIf4YSn5IRls6JfS8ER3qh+Gqz0L01rY7DF7YMZH0
         S+jv6pOPHt0zwSEJSaTUI/0oPh6M7E/dsYlxCpCbPSRVapLbxNwEdgzQm91Bh3Dl7yEH
         KFYrF35QC6rrvvvQV9K2ICFZJOGaqEvq5eHp4KkcrckQQBMfXZ3zUbhbFZsR8k2wbTVK
         x/IVt/xiEjHtTqgnnjfrVOweztUTXEOFKnPyZRq2ixRjxjIxiwyfz3KSQxaf4WFbTWjP
         QeSA==
X-Gm-Message-State: AOAM531b+tCwWNyHq7woR5KeIFe2MxUMk+XzegS6KcyDxXcGz9QuSRMG
        6hNMFltifINmi1jTjYxoDym4Jw==
X-Google-Smtp-Source: ABdhPJx2pQHmDGGlxfcYQ9WzotzTKwUVTuGYihj3Wf/o5S6pc9v5a+U8H/ZWecmXhMFjt+eQOkU19Q==
X-Received: by 2002:a37:a64a:: with SMTP id p71mr4047056qke.296.1597444819686;
        Fri, 14 Aug 2020 15:40:19 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id r18sm11909804qtc.90.2020.08.14.15.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:40:18 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] i2c: iproc: Fix checkpatch warnings by using 'BIT' macro
Date:   Fri, 14 Aug 2020 15:40:08 -0700
Message-Id: <20200814224008.107430-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix additional checkpatch warnings in the iProc I2C driver by using
'BIT' marcro.

Reported-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 688e92818821..d8295b1c379d 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -720,7 +720,7 @@ static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 			/* mark the last byte */
 			if (!process_call && (i == msg->len - 1))
-				val |= 1 << M_TX_WR_STATUS_SHIFT;
+				val |= BIT(M_TX_WR_STATUS_SHIFT);
 
 			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 		}
@@ -738,7 +738,7 @@ static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
 		 */
 		addr = i2c_8bit_addr_from_msg(msg);
 		/* mark it the last byte out */
-		val = addr | (1 << M_TX_WR_STATUS_SHIFT);
+		val = addr | BIT(M_TX_WR_STATUS_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 	}
 
-- 
2.17.1

