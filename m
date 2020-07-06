Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C793C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2A220702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDhKb4d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgGFNeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgGFNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CAC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so29668343wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3O86wjxqNkOu1v6Uq0UsZIVMC/nMKC8xbmSovx4mwRU=;
        b=xDhKb4d1kq4g63PE6Kw+d0pJTKLnw/IIJQRWCvGGBRKLAySHr3nXCYdnP0FF+KYdgl
         vilMW0c0k6s1Ego/Dne9r8otV3SFOpks3w1DdJX6EPTI97pwdrKlIb2UKkbKdM3aDVlj
         oSrJ9yzAacAEyGyCdl7WGdOS1ZgDlhAHAlm1LeHkd9CpJeixRsVwXY0hZ/8oKIB1aA7R
         tQf8xNsPpdj7GOKICfWv8NpWcwtVpUjJFXZFlcmBUynkOisE2Sqp7YJSGA42CjzUdB7j
         d48tqL2Z+IA4acMLvxU18EamPKiWgdTtUL2LpLPFNEyrurJ1mT7m8OpdBkl5rzIdpn3b
         0snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3O86wjxqNkOu1v6Uq0UsZIVMC/nMKC8xbmSovx4mwRU=;
        b=msfdj+b6SfcS15KbkaG8uNxbQ2CuCDa2zCFvnSBr+u3kG50QanyfDqiRVwPpIQnjuh
         dVw5H0jUnygnMihxA89Wnsp9ZM6HNP6gf8iU0PdWCb+67fAKqB59ycMBLEetzx03DGfZ
         Ydf96rjeiKmxnKdq2Wn0VSiAuz/Emx8KRCxnXVU/hIIpLg9jfWhEgSTV+yuCoc+77uJX
         I42av2Kn+Yzq2f8KAhE9tPJIBsadifP7f40HFlT8YkfL3UUYhDB6T+0frI6Mjh1TZSbQ
         zQmEzaAEh+ZCp55oVQAJIwkD7tf7PoDI6icMoKsErhG1wGpc4XjKNibOdwm98kUvKMQ/
         8/Uw==
X-Gm-Message-State: AOAM530OtbpW12pjSnXiuxYsMaKIbV2yeQmO9W18GcjnZE8MVfTb/MZx
        GkRUdzXNOUprOtWsYhQ50YcfmvvxVP0=
X-Google-Smtp-Source: ABdhPJz+ya1juxEYdu8hRa5da9rRY9b7wU9z75P/hBna1EEO/zxK6KolWddZ+pI9eP30hH8G324USg==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr51112738wma.4.1594042452163;
        Mon, 06 Jul 2020 06:34:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 23/32] usb: gadget: udc: max3420_udc: Remove set, but never checked variable 'addr'
Date:   Mon,  6 Jul 2020 14:33:32 +0100
Message-Id: <20200706133341.476881-24-lee.jones@linaro.org>
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

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/max3420_udc.c: In function ‘max3420_handle_setup’:
 drivers/usb/gadget/udc/max3420_udc.c:626:5: warning: variable ‘addr’ set but not used [-Wunused-but-set-variable]
 626 | u8 addr;
 | ^~~~

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/max3420_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 23f33946d80c4..52884bae4af11 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -623,7 +623,6 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
 static void max3420_handle_setup(struct max3420_udc *udc)
 {
 	struct usb_ctrlrequest setup;
-	u8 addr;
 
 	spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);
 
@@ -647,7 +646,7 @@ static void max3420_handle_setup(struct max3420_udc *udc)
 				USB_TYPE_STANDARD | USB_RECIP_DEVICE)) {
 			break;
 		}
-		addr = spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
+		spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
 		dev_dbg(udc->dev, "Assigned Address=%d\n", udc->setup.wValue);
 		return;
 	case USB_REQ_CLEAR_FEATURE:
-- 
2.25.1

