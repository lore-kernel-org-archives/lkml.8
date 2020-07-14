Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50923C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D93821D90
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt0GCA6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGNLSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGNLQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A8C08C5EF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so20906389wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QiZP1EJ4HMANCxwy0emf1RpubxHNKPeVfuS0vb5jwJ0=;
        b=Bt0GCA6sAZ1Dhav8uxfVkLsp+I/g50wOtMFqyePzqFC2JGKGQxf3cofzFqQLhNbxix
         MYHy7BJqu7ePGOEXENWyzEDOqRnf7hx4HmX+xp/YqM9BmOTD2QM8AHwRHx8+rdCKXCic
         Pyjf/Qqn5u/+f+t2ojun7ZEgZQ26jHK8sFVi7bFwAMD2KWCNJeaUK/snV2iHB/lrurng
         h2WH838TmE6UU8l1dStBAttQpIHjjbZDEUOqOTzlzpn/lcbltMLgIlmu3iJyR3SW1lMm
         wl7f4eeoVNZIyCvMf8vK2JiVtvZbc0GHpPNzkvbArAVJhlqNI1knGxYIRsaYRGwWSPZy
         Ip0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QiZP1EJ4HMANCxwy0emf1RpubxHNKPeVfuS0vb5jwJ0=;
        b=EGyNf8eYt9QJr8LerA/gqii8kLAGMDLXllLiauDu9pFMOsCWkoFUFo8XhKVa6vsu+6
         HvIic/INpR5Ou6jB2P5hWH2KP4aTlQpLdoFGC+qRUotRfDAZ5RBKqVNfkitfA4LWSqfc
         hZt9/1043Nj2HW+v7yzLwvXgLNjRbG17qD919D6nO1m2hM6D3mPbYMtPWMrQ+ss1NHas
         fnOldNQvsdDKHOVjbZlvkJq1kEtM/3/YliLRNSfXT+Sl9lJDdnFhSVvdeTVTs3lKHLHd
         72oFH8XjGXXQszmr7oL0sQ+/yLV/JW5STouu5EwxCF4btXaYZRRt7yhTUP75JoKhINx3
         v6rQ==
X-Gm-Message-State: AOAM532G0f2nNvodwFw7Lji7nhS0GqgOHIbfqU89rVU4QXZMjepO1/Kd
        s/dOCfFJtUUrbGXp0JlX9BzhTg==
X-Google-Smtp-Source: ABdhPJwkiwpi8l/2xIcMFabgGHg0sSEJz0lNu3Gqu0LiD5h2i/XCtSzTUFZ2AhtZQDnFonigsMSt8A==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4524901wrw.63.1594725356234;
        Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Per Forlin <per.forlin@stericsson.com>,
        Jonas Aaberg <jonas.aberg@stericsson.com>
Subject: [PATCH 06/17] dma: ste_dma40: Supply 2 missing struct attribute descriptions
Date:   Tue, 14 Jul 2020 12:15:35 +0100
Message-Id: <20200714111546.1755231-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/ste_dma40.c:398: warning: Function parameter or member 'dma_addr' not described in 'd40_lcla_pool'
 drivers/dma/ste_dma40.c:601: warning: Function parameter or member 'dma_parms' not described in 'd40_base'

Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index de8bfd9a76e9e..21e2f1d0c2109 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -381,6 +381,7 @@ struct d40_desc {
  * struct d40_lcla_pool - LCLA pool settings and data.
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
+ * @dma_addr: DMA address, if mapped
  * @base_unaligned: The orignal kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
  * @pages: The number of pages needed for all physical channels.
@@ -534,6 +535,7 @@ struct d40_gen_dmac {
  * mode" allocated physical channels.
  * @num_log_chans: The number of logical channels. Calculated from
  * num_phy_chans.
+ * @dma_parms: DMA parameters for the channel
  * @dma_both: dma_device channels that can do both memcpy and slave transfers.
  * @dma_slave: dma_device channels that can do only do slave transfers.
  * @dma_memcpy: dma_device channels that can do only do memcpy transfers.
-- 
2.25.1

