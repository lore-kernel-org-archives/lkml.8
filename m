Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651DC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B9422203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbKjjlMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGNLU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGNLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE2C08E8A9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so20874859wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWVbeI3JQ64+Db8G4vi0TII3jbdljajswVKqeX2AaNk=;
        b=pbKjjlMz+yuId3GnPdr+6e7242L15C8zpZ8cI32mV6xd6AgENPK00kT71vMS4zOEUQ
         BZiKrF66/XjLDH28yMZs8xHjFIparf2OgetsOT625Mif3xJ1q8QNLhyQtuK7TGfZUNIr
         CCj18IDVn978g2dBSbIwr5b38Pq9EwmlS120Y77bC8ePRFzM8Q56ZfUktL7RchA2vkT5
         u5WCyG9mExt5AiqtFF84SoZFQZZshdlOkMoEgh6kK8rhIdvqnnVvWrj3OTAyPe9rWQLc
         ErVVxOlolsFySUFnE8kq65UQFNT1RnKfPw0BhzkytqrRJQZNY7Rt5ThFUPrGUW6rf9Ea
         d7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWVbeI3JQ64+Db8G4vi0TII3jbdljajswVKqeX2AaNk=;
        b=VNy6qXwo88MahvfPBQfIX4EBPVfd5RjEWURyzww+I18OkJhpkPNW8B/eFsE6TP/v2A
         fDaGYDlk57UkXs0D6NfqnmdeOUjZJZ0m5DQJGu5r6clK3i3lS4Wu/3NkU37uzhPwbyST
         AyNOzt6BXjjQypmvJpQ9xKphU/kRwqTimOJ1V/4i7GReiCWfEDmtVnWinTwFALaj8Sf3
         /eQl2SqLvK3mGycnc1G2V/RqPep5BukHy7RgQqAt1TmyFh9sgUSluA9sn4nXMMzjnccE
         361oe7BjIIsvld/5Gsfa/aURmNKfoysbA/u6OkvlJOu5QTLy0OUqKQA2bINWl/fjcRqA
         4ZsA==
X-Gm-Message-State: AOAM530h4JqCzTSliK4z78ewYkKEbCxwHUlQbn3ATjig7s7twvKeh3Vi
        y2Ekw5mAYHd9v3TR4uE//XkRvA==
X-Google-Smtp-Source: ABdhPJy/Z9vM5I8MKYqwiF/ImZ+zlunr0KhgAAKurSmz0v7+QqjmsliobL9ygI2dqTBBUF+btm1W9g==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4756252wrq.104.1594725368354;
        Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 16/17] dma: ioat: init: Correct misspelling of function parameter 'c' for channel
Date:   Tue, 14 Jul 2020 12:15:45 +0100
Message-Id: <20200714111546.1755231-17-lee.jones@linaro.org>
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

 drivers/dma/ioat/init.c:608: warning: Function parameter or member 'c' not described in 'ioat_free_chan_resources'
 drivers/dma/ioat/init.c:608: warning: Excess function parameter 'chan' description in 'ioat_free_chan_resources'

Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ioat/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 20a4f36a2f6ea..8a53f5c96b168 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -602,7 +602,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 
 /**
  * ioat_free_chan_resources - release all the descriptors
- * @chan: the channel to be cleaned
+ * @c: the channel to be cleaned
  */
 static void ioat_free_chan_resources(struct dma_chan *c)
 {
-- 
2.25.1

