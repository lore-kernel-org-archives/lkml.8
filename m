Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3516C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6620720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8l3xiex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgGFNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgGFNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046EC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so39370374wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ji1N62aOzIlUoLXMMPXkjOjy05RAsl1PzqHcrZ4EBKA=;
        b=I8l3xiexa/B1JIJEy1ir1PTxhlP/Lj9nM5zUnk6opUF/S6bgIchyQgbqNywo7zJNiU
         CoQXFx15q77CxSXe0ZRx0B6u3hwF7yxGPD7hJYpfn2bPzbIVajT32LzABpWqvW/U963W
         rUfVYKYz0ltiAGwB2k/N9DNXTj1wqtMBeV3wSCHJspqZ6qVlC/PJj7n8N2Tb7Ciy5Hs1
         YD5+rf7z0Dd+Kbwx1fUXzNmr9b19aJ2JgHb6AopyQqJZZVptVhkZMnlql+lUz0ue0xbF
         8kR979vuUk/grhSLXPoSlAHDyv5f75q8fcqNYTPokp9FBt6qc7wkfcTDvRW9v3MCYpNU
         OHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ji1N62aOzIlUoLXMMPXkjOjy05RAsl1PzqHcrZ4EBKA=;
        b=rGVUWl7e8PY+ATXoSEEXqIjHnLUUpM5GxckiQJwkdehOQJY3a96dDbYh50hKseNX/v
         b5QXRdL1dM0TFSSOM52XA5YrfzPRuKsRlzqGe3ciq7zc7y6Z9TwRMuhXA6iILeFOikWu
         OLUu5LkZAaPIrEdR6L/ndPnmONbFfdO/iwViIn/eGJ3i0pc+Nnnp6of+h+sDxem7Jkui
         iFZDLqKo13/DunPkcznspoUT8yxhN35+msdVuEr7suKT5Yz4CtSUMAwYV9aXuRwgUfkE
         P/NQ8LjfwHBXFQWA8fcxYADgIwUZGsRI+IZGsSLM7tDBbFODnh97yxzaM8TrEXEyfTxq
         +Sgw==
X-Gm-Message-State: AOAM533PwNXMpbF1X7ojlghffO4V6A2JFAR7E59Z3gO0QNPlimGEs/vR
        RieFlBbwC5n/zJbaMVvpu4M4aA==
X-Google-Smtp-Source: ABdhPJzhwy+WhKHOCtml4H28kvQrBHwIYwg1EY7OKr3wVvJUBRZghnh3fq3dov0lUX5F0Rb16y1JmA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr39593585wmb.113.1594042435462;
        Mon, 06 Jul 2020 06:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 09/32] usb: gadget: udc: atmel_usba_udc: Remove set but unused variable 'pp'
Date:   Mon,  6 Jul 2020 14:33:18 +0100
Message-Id: <20200706133341.476881-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e78355b577c4b ("usb: gadget: udc: atmel: Don't use DT to
configure end point") pulled out all functionality dealing with 'pp'.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/atmel_usba_udc.c: In function ‘atmel_udc_of_init’:
 drivers/usb/gadget/udc/atmel_usba_udc.c:2106:22: warning: variable ‘pp’ set but not used [-Wunused-but-set-variable]
 2106 | struct device_node *pp;
 | ^~

Cc: Cristian Birsan <cristian.birsan@microchip.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index d69f61ff01819..a10b8d406e62b 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2103,7 +2103,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
-	struct device_node *pp;
 	int i, ret;
 	struct usba_ep *eps, *ep;
 	const struct usba_udc_config *udc_config;
@@ -2128,7 +2127,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 						GPIOD_IN);
 
 	if (fifo_mode == 0) {
-		pp = NULL;
 		udc->num_ep = udc_config->num_ep;
 		udc->configured_ep = 1;
 	} else {
@@ -2144,7 +2142,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	INIT_LIST_HEAD(&eps[0].ep.ep_list);
 
-	pp = NULL;
 	i = 0;
 	while (i < udc->num_ep) {
 		const struct usba_ep_config *ep_cfg = &udc_config->config[i];
-- 
2.25.1

