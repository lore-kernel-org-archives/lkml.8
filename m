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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07454C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FA72076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeldzWSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGQNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:21:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA69C061755;
        Fri, 17 Jul 2020 06:21:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so11045917wrs.11;
        Fri, 17 Jul 2020 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ko4G2119lYc0uTwNuj7vMJzlWRIXCHJZupnhhr04iU=;
        b=eeldzWSRtx+DirKvk8WUh2cvTwkYf/ob1gY0P7wjM4iFiZlCRA3iVXJgBsr0EaAonM
         IKEPTUADV4O86lH7oEckLbvtMQHHNg+5C/MbaNlllniyLIXnamLyw2qYwiwQaxFglc8C
         HdeWtfHPFkiHR/J5s2QP9Gd3nhBwqem283qCjq+Dq9y9nhGPOtNSdlMxzHHmVAKrUIuM
         O6/E70sVH30JEBPRLFJ5hLW1COw35Ykq5ZcHIEbbi+ICHmONVEHGk65mlpieVK/wKGYq
         zwuDvXlyJtndB2qUEUHKW+Wgd3+WgiBr0Q6XmnCenxig7wcuJdK2HB6VzW0TMeUIJD24
         HmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ko4G2119lYc0uTwNuj7vMJzlWRIXCHJZupnhhr04iU=;
        b=Lnkmgh1twJQn8uBPAeKjSGYLuTWeh5HO/ElVt0IUSmASGSouxCcGqdCpiLFIAS+CWa
         sMxBiBQxqbEwG74Mh0NCayW8ptJTuP4xWJB9dJEMrkXMVZjOXPLf9iifIipiQQR5oGIu
         knYczLpLSqKgQUgVQRcz1HpFLzhNSnyyc4xRjap/yibsI0c5uc6M+qVTLG4MSgB7KPTX
         8c/RYqSbwaZSTHvcO2sNGtRPxgEf9Nk6Z09mAxDg4p1PP692DywaUPJcTtYJm+GP29pI
         rC6yFuIOHaGCqsqFg1Oj4fHasjKfHGKdQXdlKUiGPrzdhcy2fBrge23kHPYhFR3vAAhs
         tasQ==
X-Gm-Message-State: AOAM530P3bTb8gzKL9KsWZEleAH20P+MMAdCioWXzNsJPLxk5BZZjcnh
        xQoZFypS+VoQrd/hZVIgBotUK4+68pM=
X-Google-Smtp-Source: ABdhPJyqqHs446YAhhEXHqfgnlWFqT1KWSiM87oEWv/8Gcww8XrJ7NUlsApyGUI+oMNTWFNRktqn9Q==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr10135899wrs.353.1594992099433;
        Fri, 17 Jul 2020 06:21:39 -0700 (PDT)
Received: from einonmac.psycm.cf.ac.uk.net (81.91.2.81.in-addr.arpa. [81.2.91.81])
        by smtp.googlemail.com with ESMTPSA id f197sm14996637wme.33.2020.07.17.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:21:38 -0700 (PDT)
From:   Mark Einon <mark.einon@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Einon <mark.einon@gmail.com>
Subject: [PATCH] net: ethernet: et131x: Remove redundant register read
Date:   Fri, 17 Jul 2020 14:21:35 +0100
Message-Id: <20200717132135.361267-1-mark.einon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the removal of an unused variable assignment (remove
unused variable 'pm_csr') the associated register read can also go,
as the read also occurs in the subsequent et1310_in_phy_coma()
call.

Signed-off-by: Mark Einon <mark.einon@gmail.com>
---
 drivers/net/ethernet/agere/et131x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 8806e1e4c20f..41f8821f792d 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -983,7 +983,6 @@ static void et1310_setup_device_for_multicast(struct et131x_adapter *adapter)
 	}
 
 	/* Write out the new hash to the device */
-	readl(&adapter->regs->global.pm_csr);
 	if (!et1310_in_phy_coma(adapter)) {
 		writel(hash1, &rxmac->multi_hash1);
 		writel(hash2, &rxmac->multi_hash2);
@@ -1023,7 +1022,6 @@ static void et1310_setup_device_for_unicast(struct et131x_adapter *adapter)
 		  (adapter->addr[4] << ET_RX_UNI_PF_ADDR1_5_SHIFT) |
 		   adapter->addr[5];
 
-	readl(&adapter->regs->global.pm_csr);
 	if (!et1310_in_phy_coma(adapter)) {
 		writel(uni_pf1, &rxmac->uni_pf_addr1);
 		writel(uni_pf2, &rxmac->uni_pf_addr2);
@@ -3444,7 +3442,6 @@ static irqreturn_t et131x_isr(int irq, void *dev_id)
 			/* Tell the device to send a pause packet via the back
 			 * pressure register (bp req and bp xon/xoff)
 			 */
-			readl(&iomem->global.pm_csr);
 			if (!et1310_in_phy_coma(adapter))
 				writel(3, &iomem->txmac.bp_ctrl);
 		}
-- 
2.26.2

