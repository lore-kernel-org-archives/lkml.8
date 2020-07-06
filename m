Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BAEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31318206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bn951av1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgGFNeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgGFNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so42148672wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTimBbBqnMIcQ4eF+VH5m9hye6WMpkC2MlXIy//Z9tM=;
        b=bn951av1tIBYht5lk9qvY08u0Jgt22BUCKc6vohyqII3OtrGaVeusFgOTPFhqV+i2k
         p06vfQqGi7JFF4w8LRU6xPFLkIdxuI9J0W8p4lHaQpIytn8kmIblmkWpEIO17UKu+gPf
         FXeWg/QFad9y2n/5Q8UzWgI3E11IBWoAiWlUX7yiymCFcvPQex79oxP8yohjP6Wsdjol
         SVkyuBtzjZ/SHYPWMfIDXcXPdKkuaWT6aAmYFvyBne/hm6iaMSsqC427PTvk+2Dq8+ki
         W7eZeeuLkAhkX4IudL6VGhPcZ6DO+hSxad4t9YaHQaSXU7OGASjpxkSL2XDydREO5DXp
         giBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTimBbBqnMIcQ4eF+VH5m9hye6WMpkC2MlXIy//Z9tM=;
        b=F2m4znT8WDYQdeMk8nfzzrSbIuEnwhCOaFnJX59lm3QRGt2VTKo2Ls5N9TCvt0D+h5
         f6iHAsGYGgM+DwNT7xgKb6iCPrJ48j5WvtE2bwro9Hs+J1LAtvhi0Q1+sGsm8qAP4m7l
         38sjHdGWtXTpgVPWypSFgP+yaYQKTciTnKB9VRp17vszFBB7RsCwkdyrOdmhu8Ap89bC
         vzGgbzUEE8VdKQnYukl/q3BPjd0tE+qV6lMz+WMid9TaLlxib2o16dSVdU8RlFGrlLpw
         6VCQHf9/NLNgWG+D0Nt7wr4qXaDT77vJ7SKnctAu3qUNlSsdBPF4yuxXDVRgfFtZo0mx
         GLvg==
X-Gm-Message-State: AOAM530yVSo8F+fOizXLuGjXxcEPOw4n1SQBxtzJ4+JXOpTlChTFubHH
        5SAAv9EC61XkWdMToIyHAKMkXA==
X-Google-Smtp-Source: ABdhPJy2ORInauH49b7tohotkeMYtKjc4Phc6yZfNYXtKYgAdNWMLI138LZhx0E2XlgFikEOm95mpA==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr52128827wmg.118.1594042439124;
        Mon, 06 Jul 2020 06:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kevin Wells <kevin.wells@nxp.com>,
        Roland Stigge <stigge@antcom.de>
Subject: [PATCH 12/32] usb: gadget: udc: lpc32xx_udc: Staticify 2 local functions
Date:   Mon,  6 Jul 2020 14:33:21 +0100
Message-Id: <20200706133341.476881-13-lee.jones@linaro.org>
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

These are not used outside of this sourcefile, so make them static.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/lpc32xx_udc.c:1929:6: warning: no previous prototype for ‘udc_send_in_zlp’ [-Wmissing-prototypes]
 1929 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 | ^~~~~~~~~~~~~~~
 drivers/usb/gadget/udc/lpc32xx_udc.c:1943:6: warning: no previous prototype for ‘udc_handle_eps’ [-Wmissing-prototypes]
 1943 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 | ^~~~~~~~~~~~~~

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Kevin Wells <kevin.wells@nxp.com>
Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 465d0b7c6522a..4a112670cc6c4 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1926,7 +1926,7 @@ static const struct usb_ep_ops lpc32xx_ep_ops = {
 };
 
 /* Send a ZLP on a non-0 IN EP */
-void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
+static void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 {
 	/* Clear EP status */
 	udc_clearep_getsts(udc, ep->hwep_num);
@@ -1940,7 +1940,7 @@ void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
  * This function will only be called when a delayed ZLP needs to be sent out
  * after a DMA transfer has filled both buffers.
  */
-void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
+static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 {
 	u32 epstatus;
 	struct lpc32xx_request *req;
-- 
2.25.1

