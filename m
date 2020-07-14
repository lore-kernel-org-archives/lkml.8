Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CE022208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raat87E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGNLSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgGNLQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE6C08C5EE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so20829153wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=271JiKK80FLwolRF6spciLtpgZEz0e7WX3q5gXVxSzM=;
        b=raat87E0F+i5FkKKSfcO3L2BJ5q4wOj/rW3ptZDMlqpAJZ9MaUq1eZax/zYLu3u1ge
         +ZyWI3fFRpkmoWUgc+bymQ9frEC7/F/B8Q1NHD3kAgIQ/7Z1kiTsvp4eMiHBIuvmPQ/d
         FEknbe7lLIOAsbdIS5yrDLkZrtppZzfTEMJFXUnasPMvnauSITv7zvkVKwj2/0xVFxMh
         SXs6P9KeDUBqrH8rP7LfVq+F0db6vfdk3Z/uJilq1e5+7TGTLUh8dK55PbTqHpBb3gjg
         1gwM6YZOar952H6zAlL5fSktswLL5YpeaAWDTx727Q9tMQRM0EP1u+hCI2Gfs35Ni1K8
         6PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=271JiKK80FLwolRF6spciLtpgZEz0e7WX3q5gXVxSzM=;
        b=Xa3AH++eaqCWXRMPr7FZX0xftI2E2HGvhhVlGmcE3JDnTn92/1FcwMy9R7JogoPloM
         +o7k44G3YjcSxZyybybTUbeElbAC4ts2WecJuQivALwUsPHn/3GTlGSDYWI2QOPZChNU
         1M70EfFBajXnKHhr1p+UYX+L6GLI90lWOf/U7khWTpDu8bDGUFHYfGV7qVvlQDUEgn50
         VnxlEc73EsyIDpicyHbdXiVw5RYhMb++zEbCXLkJ6eRBKIwvv80BtVGjpzEw91DFrdOa
         arxWDZbCt1K3QnW04fFryCSvEDIg29qLqS7aq+VnMYn/K++wEwiiiu+2bB7j2QxsyfuX
         hVgA==
X-Gm-Message-State: AOAM5314AA+pLSe9U6xZuPB9RByyacqAljl890qLEXjx9gWm3CJnWJVv
        qJ2w7fcMQqQ4wkFT5j1FMY5Lkw==
X-Google-Smtp-Source: ABdhPJxHSXSpUZXfp2uA6lo+uRLlOTalaig2KsNnaQ+tQtCBvn+WX9e2f1GMQPSpjVH56EMB/KpxqA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4774395wrq.189.1594725355155;
        Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jaswinder Singh <jassi.brar@samsung.com>
Subject: [PATCH 05/17] dma: pl330: Demote obvious misuse of kerneldoc to standard comment block
Date:   Tue, 14 Jul 2020 12:15:34 +0100
Message-Id: <20200714111546.1755231-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No 'struct' title is provided.  Nor are any attribute descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/pl330.c:295: warning: cannot understand function prototype: 'struct pl330_reqcfg '

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jaswinder Singh <jassi.brar@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6a158eef6b8ad..4fc7aeec70a81 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -284,7 +284,7 @@ struct pl330_config {
 	u32		irq_ns;
 };
 
-/**
+/*
  * Request Configuration.
  * The PL330 core does not modify this and uses the last
  * working configuration if the request doesn't provide any.
-- 
2.25.1

