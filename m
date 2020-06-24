Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F9D206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emOdUiDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbgFXPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404338AbgFXPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FDCC061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so2865110wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4d9MV/8IVDi6H6NDx3txaJsaoNizmHMUDUqyGZyRwc=;
        b=emOdUiDeUe+KFeHCqP/4Vwih/dwJXxtgOfA8pOQGoiPOx4UIAFEj52mjFAk5DhMU86
         gT5Wkp7zH2kxwdj2nAgh4si1eNBmRt6zQrHV/KaItnIMe2juaJ0mQG5otPsahO1pCdPJ
         uNv7FOOfhL9aTrRneY9in0QBdNS0svXag+qoK1jXiCuIROyJEZl6vCMGfgtx9e1iQCaZ
         fTogXsdUIy5yY0iXLhZIm6MgIN9gDmrnno6dwDdaJSxcXxVh5LP/EdDdXAVtip1VfRmS
         Qvg6LFloU7LYSBu/IitxhtD60aQwVHctr3SlOUisidawyOoQ3WVkyHKCgnAfwUkNPuA6
         Jdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4d9MV/8IVDi6H6NDx3txaJsaoNizmHMUDUqyGZyRwc=;
        b=sfwCYkc/ysN/2FBVFGKCwUASvvElJpfhkl++QQBarmK/1blbpe3N5VNgCrSOim8GU7
         HRpgkH8bNHiXFuGp/1lPY2RvGTousCMJY55xJOcbphX7bqxH3QdoYybcd1cN3fvGy4MX
         kozogEsyx6qm23pihomL2pN8YRvytoGL/ZMy7RcpIayak7DoMKtZbMiIgjU+aV8hUO5a
         2l2tk+Ty3FbgOPCAnue8racrL4XjGaZUZfM3uhwP7WnZJDhgV+fi+5I4CXFUx8lkW/3k
         YzBD3cZD9HmmnEi/5wQS9TKgjn9AG1V8CR8i+53YCbJadpAuMdjL1+pY67bBBhVmXHT6
         u3Zw==
X-Gm-Message-State: AOAM530qoDH36hqbvGK9x+iNh4/zSkJfbsq2O/NSltFSWf3xwKrT9lp0
        2/s7MitiNXTrolTTojmHGS4PzA==
X-Google-Smtp-Source: ABdhPJygPsccHa5jOlhVGhJlJB4d/4S7eDfjo8Nvz6itCY61Cz7n4glf/TvzYk4QWergu4UvpagYdQ==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr29834871wmg.88.1593011082536;
        Wed, 24 Jun 2020 08:04:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jamey Hicks <jamey.hicks@hp.com>,
        Andrew Zabolotny <zap@homelink.ru>
Subject: [PATCH 2/8] backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
Date:   Wed, 24 Jun 2020 15:57:15 +0100
Message-Id: <20200624145721.2590327-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been missing since the conversion to 'struct device' in 2007.

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 78b0333586258..db56e465aaff3 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -179,6 +179,7 @@ ATTRIBUTE_GROUPS(lcd_device);
  * lcd_device_register - register a new object of lcd_device class.
  * @name: the name of the new object(must be the same as the name of the
  *   respective framebuffer device).
+ * @parent: pointer to the parent's struct device .
  * @devdata: an optional pointer to be stored in the device. The
  *   methods may retrieve it by using lcd_get_data(ld).
  * @ops: the lcd operations structure.
-- 
2.25.1

