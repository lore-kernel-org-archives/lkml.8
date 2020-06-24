Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA8C20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPM0JoTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404400AbgFXPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFXPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A3C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so2844752wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjEPJ8/mm+wq5v36TYnyxcBS/a58z/cHHdKeFkfsfDE=;
        b=zPM0JoTekc3JwBTNgIwFO0P3svCMqz6zlvJHpDXyqSoLZJPlvT/40LKl7KnfnXmcOt
         qzD/hMl0Xi1GGBucNTt7iR4B4Xu1v04fUHYnRuvCkawtPjRw8DidaYzoxiJu6TZLLrOr
         Z5F3E2NaRAqvya3W1eGzceaDjDFLn/S08pifh4nAlO3JVcKUm5EOTsr3xiIuocLLSsTd
         /xyUNzkGVlysC/Y0PAaGQhWXhrhlJgo3T0Y83UmpYsnTZd6zUE+GCCuRwdATo1kAt5nc
         NljRyk6f15Lt1rFcApUW2wX5Kdbn9BDptRox73TfhNF0TsdTMSIopA8pPN/+fwS71EaG
         SURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjEPJ8/mm+wq5v36TYnyxcBS/a58z/cHHdKeFkfsfDE=;
        b=LaxFI9UOvoXsyrlN51J1RA4KkTkIULmrpe4Iz3OyuhVYXV5H3NnDixGcnnNGCJx+ue
         td22Km7Hg2ajmXJC1N9g3bSzVVWbW+A2+akEwUXlfjrSJfcFRteWeHCO7bpYWn1+HC+H
         auOp10o1G/0yeY7tHuRMwe5lEBuCUczuTNBgbJVm7vVd//l7RH7xIRX4DMm4i/1lmu++
         NHmtgjbeORiP+N/IwLwKx9NVhtHX+t5uWZAoskI+sQU80AHE5qgbcNCsXftqMIUZwRPo
         rrSj6/tNXs2XpJBD0mUGq8COqNI9GQlcHzIqCWrz1NLGR/nxHH6vSdbgPyeS/RkP3qv3
         /BLA==
X-Gm-Message-State: AOAM532YNDIRN+aI92n032xwliuqm53cWE2HXPArjTYRLfk0TSh1M8nx
        HFBE2bmb22hGcUpuRXq6iCC0bQ==
X-Google-Smtp-Source: ABdhPJyBpq4p7XjDew8RzlYmMmVACRb7x1fhGgY5R/YmeMhjkFjmrwgSZSWjfeVp7THuMLPsMbh1fA==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr25791251wmj.44.1593011084237;
        Wed, 24 Jun 2020 08:04:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: [PATCH 3/8] backlight: ili922x: Add missing kerneldoc descriptions for CHECK_FREQ_REG() args
Date:   Wed, 24 Jun 2020 15:57:16 +0100
Message-Id: <20200624145721.2590327-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 's' not described in 'CHECK_FREQ_REG'
 drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 'x' not described in 'CHECK_FREQ_REG'

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Software Engineering <sbabic@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/ili922x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index 9c5aa3fbb2842..8cb4b9d3c3bba 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -107,6 +107,8 @@
  *	lower frequency when the registers are read/written.
  *	The macro sets the frequency in the spi_transfer structure if
  *	the frequency exceeds the maximum value.
+ * @s: pointer to controller side proxy for an SPI slave device
+ * @x: pointer to the read/write buffer pair
  */
 #define CHECK_FREQ_REG(s, x)	\
 	do {			\
-- 
2.25.1

