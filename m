Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742B520758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5E+REp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHSSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgHSSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597862836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=n1r99O9sF3KmCtBpBDuUEdXHcIRahMGRsJ4wLhKM7X4=;
        b=P5E+REp7gRU3eJF6KCLNr5qmrvKi4g+HZL3CqDBoDpLIvK/fVGdNwjtwqbeeGdLro++uqL
        KXXpMWh+n+NUlqOOIgsLLHB326BvN8fEaGJru5Lj+o5semlbLGMDa2eV0bjCbujbrgKWy/
        cxAqc66L1zPJWuQkBsXcATmeXu9X5CQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ZO-WHR5lMhmP7f-a6deGHg-1; Wed, 19 Aug 2020 14:47:13 -0400
X-MC-Unique: ZO-WHR5lMhmP7f-a6deGHg-1
Received: by mail-qt1-f200.google.com with SMTP id m88so17346059qtd.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n1r99O9sF3KmCtBpBDuUEdXHcIRahMGRsJ4wLhKM7X4=;
        b=XnpfB4At09b2phdoMgfs/nRf6hN7gvNrutd4u84slSXeiiZipHzKHJY0z2l7QD+blD
         JMrShzeNlQTgNAqW9trRkOF/wlNICKXInXiKaA5dAjaUv5Zlbyi/JxZ7J9EyzOPd6QzA
         Iie295ukYuNamvTS78N/rTeafcqZ6ZF6f+8VR1WNmguWPnuCnuBRiLJMrCBXoT1KYzEP
         Isf/KCYepbBXY4pK13yl0mG8GUxMN3ECO0KG0rFg3Q0AuSp4FkCEkiu3oYAenP0nWG88
         s/0ripuzvCqWeWHvAiMieSqT9u/y6rlGOZbVgzv+IkeE40NKEKYBVMcHxrBNX9mL9lzs
         oI8w==
X-Gm-Message-State: AOAM532kNKSzQxQU0BN+PJzGC95r54hFxkwRfFmG2DDINphLVWqVEio9
        bVLm8N0n82Om6pikNh06D+DyDjh1A4AQZu0W+pqkr0HMVKRvea7yfIHxEGNJa4nI8phBg5K9t2s
        +8TdYnq/P0xX+0HWGlYr+bPOV
X-Received: by 2002:ac8:568a:: with SMTP id h10mr23862123qta.239.1597862832926;
        Wed, 19 Aug 2020 11:47:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzBbFyRJFyOM+0EEV33sP7wXkBj/aJZVelGHRYuIOT/f/OlA76miUUwSBAv7jlSbeVETUZcw==
X-Received: by 2002:ac8:568a:: with SMTP id h10mr23862108qta.239.1597862832688;
        Wed, 19 Aug 2020 11:47:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 20sm29006673qtp.53.2020.08.19.11.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:47:12 -0700 (PDT)
From:   trix@redhat.com
To:     agross@kernel.org, bjorn.andersson@linaro.org, sibis@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: qcom: initialize local variable
Date:   Wed, 19 Aug 2020 11:46:37 -0700
Message-Id: <20200819184637.15648-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

pdr_interface.c:596:6: warning: Branch condition evaluates
  to a garbage value
        if (!req.service_path[0])
            ^~~~~~~~~~~~~~~~~~~~

This check that req.service_path was set in an earlier loop.
However req is a stack variable and its initial value
is undefined.

So initialize req to 0.

Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/qcom/pdr_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 088dc99f77f3..f63135c09667 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -569,7 +569,7 @@ EXPORT_SYMBOL(pdr_add_lookup);
 int pdr_restart_pd(struct pdr_handle *pdr, struct pdr_service *pds)
 {
 	struct servreg_restart_pd_resp resp;
-	struct servreg_restart_pd_req req;
+	struct servreg_restart_pd_req req = { 0 };
 	struct sockaddr_qrtr addr;
 	struct pdr_service *tmp;
 	struct qmi_txn txn;
-- 
2.18.1

