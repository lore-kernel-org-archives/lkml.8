Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A80206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvqllLl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgF3NwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388462AbgF3Nvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B8C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so19685112wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHXWFB9CtCq3ogRoTXjYaAYG+vDjtwvgXpZpFIdOYUs=;
        b=hvqllLl1pn0fatf/QsCkR7Paee5bgvm0WeS+Joju1W2knw4rOIxqtF8Wm+Zd5pvEe8
         GoX/KnP89+9iW2Xbpy8h8z0bvLxExRdZ9OKDSLwyiSa5DvtS2vVETgmjXcl1ptlC6fRD
         P8C0LFP3/W8lQl21D8XVlp4UmiRd8MtWlkpo5AtnqcW1mM4cve/yg2D1ZCVTrLUVpv5v
         fdR9ocabGIPny5c6K3qt/6oPd+jAMIUuq+KD28kCas/xzpPYjmVn1gFcOsLbI23SrPrw
         9bqNhAyEzfRXdIb8wLt19KfIIaJL6xolGLI9R988mc1PX0CKEaFHGilGUcVnc4FSRIza
         oNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHXWFB9CtCq3ogRoTXjYaAYG+vDjtwvgXpZpFIdOYUs=;
        b=eQlSWh0ghIVUSmSYaTgLuU94nNpwCc8y1Gs6OzY0SpD0xR4/zF64Uf8CxPDHaZhGmi
         s6zoih9QrPpwDHuGKb0G9iBWhr8hS8//FOq9HaG2qb14oA0kqMMBdtF1z0TsOnxwXwWr
         Rlj8U/XRPRyN8yXV/GuA0siUmbPDl9f6c65A42Lv9ZGmLJj9TV0X5dtyO2WzMrcNUkV+
         mWk0ffwUvjQfa8sAww6ON9Z4tBrVt6RRJ2NcOvdhWNhJQaNCbc5rLzHo5SWmk1M7WV44
         xeZgzZJ4ZLxCYlyT2dTM5OH32n/8mtUVPrJL4KOs4+6G2yagZ1hrmvT3xRPkegIsRHMX
         cznA==
X-Gm-Message-State: AOAM533qtp+6WWEJW2vayGIDZJjPt27mZnjebUFMHGeTNMfOXu3G+u6A
        pVepFm3+HF2eLnga/NvcOc4B5g==
X-Google-Smtp-Source: ABdhPJy8971wuT/pclHPRWG3d6DRtSEvF8CePSBrYNq9om1ZWVq5Pob2KizrOYchZ8agKjF2/t3iMQ==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr13876541wmd.86.1593525101687;
        Tue, 30 Jun 2020 06:51:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 26/30] misc: eeprom: at24: Tell the compiler that ACPI functions may not be used
Date:   Tue, 30 Jun 2020 14:51:06 +0100
Message-Id: <20200630135110.2236389-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.

Fixes the following W=1 kernel build warning:

 drivers/misc/eeprom/at24.c:228:36: warning: ‘at24_acpi_ids’ defined but not used [-Wunused-const-variable=]

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 9ff18d4961ceb..2591c21b2b5d8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -225,7 +225,7 @@ static const struct of_device_id at24_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
 
-static const struct acpi_device_id at24_acpi_ids[] = {
+static const struct acpi_device_id __maybe_unused at24_acpi_ids[] = {
 	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
 	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
 	{ /* END OF LIST */ }
-- 
2.25.1

