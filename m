Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C640C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53DF206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD9E5MJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIKQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgIKPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:52:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F44C0617A9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:53:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so11580857wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSX1220TX4nBv/to4x2cUHJT6pHMGs2wo2XJAzKfPBI=;
        b=gD9E5MJpoF0egAKojTQ7SebWqO2PTicZS6HeZZoFENGrfKJSaQqSJw3FFcqFNutSso
         CJWzR0Teb2GUh4MQ0xzJ58fk2CU6kzzfMWK+sewcSNFKy6HJh4SRRkWFmj5XWJnZI1De
         3EyPfZo+oudgUtG+uy5ZtwaRnA9g2gpEfQn4pFJtEQjSlIT5auKEpxiVmV7+G+iiVnX+
         khQ6eRVg/EC4EbTn6lI0mqMGckZ1Ms47fik9ofRI/GUy76oyhh98ipBnwR76Ibt3Xf7m
         Eurhwo68yze9Lu/0k6A7r+crgvLSMovOI00EItyBYiX4fesJYLnp/9PPyx5fEztr5GBG
         JsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSX1220TX4nBv/to4x2cUHJT6pHMGs2wo2XJAzKfPBI=;
        b=IE6msgv08aEDgf2dSm76r9yuqMBFvdNH/xSGPa1FI8U8D/wSVBBAazOfgslZb/7rlD
         GJx+nANQP6asu1WUU1CrFrBO1txjDs6fufp8vC8dzvmTEFNJ5OTW6IgCkVV4SewogbTz
         lcA7GeMSLIPcxUhLUBEQ3Q/+2wXbX0idM7T25LsuYdf993zeecmbH6gSTuFRc8eUrDWy
         UpKWUqnGIu7zcOpQlGSuKU0ulrRDJbRC6ctyb+lBQ4ddq2BYEyAPEF7SrGqX1ccOVc8A
         GDocxP45k6/EgCDMKfU8HQNVaLB2LT6by93b+Mc1k+afs9Xe0KpvxvdVpDu9WtCkri41
         IMFA==
X-Gm-Message-State: AOAM533Tx9gNiJfeRt42cVHmS4B1Ko6uxkC9AdDsq0e3cD8TxEq96iIG
        OY32qSofb1TF5HBTuzyaVXw=
X-Google-Smtp-Source: ABdhPJwkO+cMwRRtchemIWINqQ+AQixG0xGQoOMNX6Izs0x4b8kITi7lLzWZGJSU0T3L9fVjGmQKvg==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr2372918wrp.271.1599832413408;
        Fri, 11 Sep 2020 06:53:33 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id n21sm4582934wmi.21.2020.09.11.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:53:32 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fsl_pamu: Replace use of kzfree with kfree_sensitive
Date:   Fri, 11 Sep 2020 14:53:25 +0100
Message-Id: <20200911135325.66156-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
treewide: rename kzfree() to kfree_sensitive()") and is now simply an
alias for kfree_sensitive(). So just replace it with kfree_sensitive().

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 099a11a35fb9..b9a974d97831 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -1174,7 +1174,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (irq != NO_IRQ)
 		free_irq(irq, data);
 
-	kzfree(data);
+	kfree_sensitive(data);
 
 	if (pamu_regs)
 		iounmap(pamu_regs);
-- 
2.28.0

