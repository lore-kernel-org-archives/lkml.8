Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BEC433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88713207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjzgIcU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGQNzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgGQNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20EFC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so17218901wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPH+QD7EGY89rpfM+jPOD+8I8Jq38VLlFewJk4yzuOM=;
        b=VjzgIcU3+ooip1M3AXK8TOgT0tdwcKF6NfoM8oDGAwDytuhYS3FzrGb+gD0Sjj04RP
         6tyujb+FQaCiDYHM2ixzWByHiOOkfBd0lBsy9VaxV+PtktCvhVOceqQZ+cKcGruuUrA0
         O7Gv5SFLmuApMRfZ4hdAu4HGPK1lB5nEBEfUyYFoDANRIzWirPpShVehPf4xCLYivPps
         iB2xoC8Y6/AfyoniZHOquXz01a98gHtBPW5io+sA1mafGTG8zdNDuQHU+/7aGle0kbSz
         m/3XeCqXw41/d+ARjP+Ax1G3nDZ5ChIQ52kQUK5FqdILlK3EDB/vZfoYqY0F57+cPyl0
         1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPH+QD7EGY89rpfM+jPOD+8I8Jq38VLlFewJk4yzuOM=;
        b=B7ZoPnxcIpM/yy6CQxExxNPDO1nN2QdDvQiK5wHz04aJ1XJgKLsL21cskkm9HQO9rX
         MKxpiJtKowuHMU85SCTT9lI49/CFqkKF0HwTWP0rU5hMlV0E7EewJC6wmDWe5Tmmm5Wo
         9TnaUS2SFL6QvcMy8AyLSVZr0l+iJeuEUQpfYx8tKqOIcBG+gNUv6YWSOTfrHXjmwbEW
         /QO/r1FbgBhp92NiI0MiFuniGToej8dqrtcgSIadiQvDvD4OXqVIKEKNcDlkTZARD2hd
         oYzm1FazwWtpKnqWeqsFLMbwCcCL9NGQVTHtPu5s+i9KVlgUBGxiWSCb7AczhM7rE52I
         e/yg==
X-Gm-Message-State: AOAM533V0ml0Q04zXgUQ1DgMY7T8XsBZC+0STAjjpfBYHCC8Gih/8y4z
        zhjPez6OLc9oFNq17cCQTPur7g==
X-Google-Smtp-Source: ABdhPJw8rtOM08fs2Dc82BjfBnHOOT1pIb5vMuLLZE4XFUuoUcXbreINH3AZhhkT4VVddL8v21h2jw==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr9115687wma.145.1594994079322;
        Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 12/14] spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
Date:   Fri, 17 Jul 2020 14:54:22 +0100
Message-Id: <20200717135424.2442271-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only way this driver can be probed by MFD via its parent device.

No other reference to 'microchip,at91sam9g45-usart-spi' exists in the kernel.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
 684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-at91-usart.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 88033422a42ae..8c8352625d232 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -681,13 +681,6 @@ static const struct dev_pm_ops at91_usart_spi_pm_ops = {
 			   at91_usart_spi_runtime_resume, NULL)
 };
 
-static const struct of_device_id at91_usart_spi_dt_ids[] = {
-	{ .compatible = "microchip,at91sam9g45-usart-spi"},
-	{ /* sentinel */}
-};
-
-MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
-
 static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
-- 
2.25.1

