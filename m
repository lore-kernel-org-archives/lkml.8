Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7293AC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A6722208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHR0K+KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGNLTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgGNLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C909C08C5F9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so20825773wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AREbkFQeq62jMhEbsCGiKpcIyUmzmEoBeESlFrgp8DE=;
        b=pHR0K+KIKxD5EhQKwXJRi/S4mxtDdDxisRS89L6rsYWjar6xsf8yjwNVsm+/g1upct
         IjWqNYsequpP4EokGC40Vu6cXEx/yZuCdZaq0N3/OFVgliYwoxdDkSpoT0u76/HuKY6U
         MUbzo7YLYjjS7/pll5iVgV7Q58ymHgPYlsRuP2liz2R5WxN22Oi1Kk4KwrQO9/oZusKt
         OQkwybdZ3gHPd3FOQszTItGnFNRuTo22n7TnlJGNSowr7quZ7wNDgooiGSqS4dtCo1t5
         8Tcq5cilV0VQoGtWhZTw8JfUhrmhODcrz7h4EDAXTRcu12wQcylbZ4ozZzb2AmspBtFl
         XHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AREbkFQeq62jMhEbsCGiKpcIyUmzmEoBeESlFrgp8DE=;
        b=q61eR26RYvm7TN8SC2jynVSElJRZNvINzTCcTd5IWHovsJw2eOt1oAEhz4YMVa06+G
         1qCkXNZtnlVuVERyrmXj0A9p1Y7DOPQTbJoYeN4/TBy8stqQUdqv9/MwbeYMYZcqgsvW
         n64fHV1LxVa0PkkT9OYDGg2bFTsy5lSGUTeMrfwILUnoOQ21zTNI5aXkUalHmHr9YMJ5
         edxr2T+hqUshaV46QVwKkjX1SvEQgfgv8lCpuPK7MzXbtQ2dvnZtwWMIj2KJIXsYQvRO
         R12EKKVWslSzNrkPSAmruyLXjljT9EZh4wbZbx3U6c+KFTrLO1OpMdtZbI0j0igWFZ/s
         dA/A==
X-Gm-Message-State: AOAM533EPSfTLJ50Wm3/3sdtlbU+s3767rM1HvXhUwCVScXaxz68jHEp
        bnJeF0AisU7rTzzWjvu5BaQVigz/Eio=
X-Google-Smtp-Source: ABdhPJyAH8JGNWD20qUSqWUGbGK+bbNu7uHkKBBKvWNRnQi1cZAEQOcb1acarwwp6TN9Ch6DTWsG9A==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr4591674wrq.91.1594725359812;
        Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Subject: [PATCH 09/17] dma: sun4i-dma: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue, 14 Jul 2020 12:15:38 +0100
Message-Id: <20200714111546.1755231-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/sun4i-dma.c:321: warning: Function parameter or member 'priv' not described in '__execute_vchan_pending'
 drivers/dma/sun4i-dma.c:321: warning: Function parameter or member 'vchan' not described in '__execute_vchan_pending'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'chan' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'src' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'dest' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'len' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'sconfig' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:435: warning: Function parameter or member 'direction' not described in 'generate_ndma_promise'
 drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'chan' not described in 'generate_ddma_promise'
 drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'src' not described in 'generate_ddma_promise'
 drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'dest' not described in 'generate_ddma_promise'
 drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'len' not described in 'generate_ddma_promise'
 drivers/dma/sun4i-dma.c:501: warning: Function parameter or member 'sconfig' not described in 'generate_ddma_promise'
 drivers/dma/sun4i-dma.c:577: warning: Function parameter or member 'contract' not described in 'get_next_cyclic_promise'
 drivers/dma/sun4i-dma.c:596: warning: Function parameter or member 'vd' not described in 'sun4i_dma_free_contract'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: "Emilio López" <emilio@elopez.com.ar>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/sun4i-dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e7ff09a5031db..e8b6633ae6612 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -307,7 +307,7 @@ static void set_pchan_interrupt(struct sun4i_dma_dev *priv,
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-/**
+/*
  * Execute pending operations on a vchan
  *
  * When given a vchan, this function will try to acquire a suitable
@@ -419,7 +419,7 @@ static int sanitize_config(struct dma_slave_config *sconfig,
 	return 0;
 }
 
-/**
+/*
  * Generate a promise, to be used in a normal DMA contract.
  *
  * A NDMA promise contains all the information required to program the
@@ -486,7 +486,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	return NULL;
 }
 
-/**
+/*
  * Generate a promise, to be used in a dedicated DMA contract.
  *
  * A DDMA promise contains all the information required to program the
@@ -543,7 +543,7 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	return NULL;
 }
 
-/**
+/*
  * Generate a contract
  *
  * Contracts function as DMA descriptors. As our hardware does not support
@@ -565,7 +565,7 @@ static struct sun4i_dma_contract *generate_dma_contract(void)
 	return contract;
 }
 
-/**
+/*
  * Get next promise on a cyclic transfer
  *
  * Cyclic contracts contain a series of promises which are executed on a
@@ -589,7 +589,7 @@ get_next_cyclic_promise(struct sun4i_dma_contract *contract)
 	return promise;
 }
 
-/**
+/*
  * Free a contract and all its associated promises
  */
 static void sun4i_dma_free_contract(struct virt_dma_desc *vd)
-- 
2.25.1

