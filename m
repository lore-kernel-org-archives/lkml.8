Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC642C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7807206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="os0d0dx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgGFNeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgGFNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC9C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so40970676wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7/LG8QKfAsUZ5xCCuI2vnf7Sj+c5EJvPq+Icl9Ejy0=;
        b=os0d0dx8lY4PrV0VCx4VZCbRVDM3s7vVVnY/vA+18e1qU3P3/R/bJTVXFEoxZBax3b
         H1evzJuHhO3Vf9lGtD/CevHBEjo0+SNdxVktW9IoKWmB/6rtywuxMeCHzwvvtwgP0gZv
         iDOnInpllmtroWuWZ0seJrk6D1D3YOVkjFObAGw+RXxVOq6bTk9TABngguksuBbbeMSb
         E+fx0zxFxP07AGEaRcKKn+ANTY3M6cY1izjCqRv23X6tLJUCdKZ3+bll9J/WTLpLQIvX
         SNlAaXxAnaPkVju6B1V7ZJ03U6SKfOX+L1LAEHgGxR58QOar2re6Pj23qdjIRBLb/rre
         aXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7/LG8QKfAsUZ5xCCuI2vnf7Sj+c5EJvPq+Icl9Ejy0=;
        b=iIU1AVsWEWKQhXYIvPJq174wqdV9sJ097vAvUp8z+d3ug1nX2ZYVtlRpXBcU7F8NVF
         hgAvqLVdIC456jYH6uesXImHsgyBfWygOUIJ87b7XXTygv07ob/Nu46r1mgOcvc3Ly6w
         cxkVvklmIg1FcbKAi3FZYxHUmuo4kkPQQTZo/+ZmxeG0AfYuifR5bC0CYO1BoVJQ/mCu
         B/Njh4/6pxYJmsACRpsSJbdd3BlqW0eP3H8keaY1iGIqTQlyDoRFi89yU4T7ziPEE5zC
         WwKARDjNZKsK5O807pvClMQlzzj6pqI4EFPYOEEMy9tYJBu3C8iqs3T7/nrLEo+AxVK7
         r9jA==
X-Gm-Message-State: AOAM533PqbcsY7F4xqka5cb5muXNDieUbKhBcYMMiK96nHpXEkEnnMEz
        JfpKtW70DG7KMdu+Vgr1CNMaRg==
X-Google-Smtp-Source: ABdhPJxDvbV0BLobErzaVbEqiNwKzRAQTJlQ4Ma/Du+Zq1WMwRCa/vj3m927hR86GBAms5PrHXR14w==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr45407084wrs.33.1594042436907;
        Mon, 06 Jul 2020 06:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Al Borchers <alborchers@steinerpoint.com>
Subject: [PATCH 10/32] usb: gadget: legacy: nokia: Remove unused static variable 'product_nokia'
Date:   Mon,  6 Jul 2020 14:33:19 +0100
Message-Id: <20200706133341.476881-11-lee.jones@linaro.org>
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

Looks as though it's never been used.  Driver was introduced in 2010.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/legacy/nokia.c:65:19: warning: ‘product_nokia’ defined but not used [-Wunused-const-variable=]
 65 | static const char product_nokia[] = NOKIA_LONG_NAME;
 | ^~~~~~~~~~~~~

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Al Borchers <alborchers@steinerpoint.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/legacy/nokia.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/legacy/nokia.c
index 978c1a34a9320..2e15f9a32ce9f 100644
--- a/drivers/usb/gadget/legacy/nokia.c
+++ b/drivers/usb/gadget/legacy/nokia.c
@@ -62,7 +62,6 @@ FSG_MODULE_PARAMETERS(/* no prefix */, fsg_mod_data);
 #define STRING_DESCRIPTION_IDX		USB_GADGET_FIRST_AVAIL_IDX
 
 static char manufacturer_nokia[] = "Nokia";
-static const char product_nokia[] = NOKIA_LONG_NAME;
 static const char description_nokia[] = "PC-Suite Configuration";
 
 static struct usb_string strings_dev[] = {
-- 
2.25.1

