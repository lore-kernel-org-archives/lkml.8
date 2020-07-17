Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F64C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE97C20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcVlGaOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGQQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgGQQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F5C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so15965230wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31Tvqv5NM4OFlqEMdtTKPK1d2uzVylaWVS7jDebvxGA=;
        b=ZcVlGaOL/eDTv4lz5JNlb4hvtqD+61w7PMNxH3NBGKRHyPqzJ4uTAIwYuWJ3ev4dFT
         5ehYJVF7nzM9II9CEoOhTa5w10VsHMdfcTywQSHOaEckBYNSBkF+sGd21ZfrWfQIlEBL
         qgQPBZ0oVg2jhGx6D3/GJrJ7VfP/4KBF/PtN6vkRzd4z/rXUzkcOw01OfBXm95uVCErX
         lKoBUJ2uPi9lXqc/vfY3vePmqyzN6UUSmJO6WeZa9wZw1PmU+UxCbVUiYkom0kazHefl
         ngHnsxDuAtEVfKz7u+Q4npgGQh/o4Y/5k2CT7Ca7cmyxxW5Z1s1cBljlyLx11/+NZJdw
         cQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31Tvqv5NM4OFlqEMdtTKPK1d2uzVylaWVS7jDebvxGA=;
        b=F8ykKuIC487KbQggM84Kun7SdzgLtfnZnREe/e1/QoRGSvZSNg1Mdl4fXlRPMKoSuR
         tXURbSYkW66R5I/f37RXAmQuquOwu8THGxfHzWR7rW0CgN9e9IX0unQm51nXo/vemD2p
         kqh7+XPf2VpxwEDdNCuSzdBU7NKwLKzDryDmCfchZUhpiwvnfEHNfpMDp4G0CBIq5Jdn
         ZU2xUwMLj9TvDiBx3py/XIkjZw3XgOZj9aP3EX8Zt6++gSE8PUHTFTPF9snWGHSd06E3
         zp2VvagjZziCgSrSFvl5gffokR0hSZHf5Wem3im+LdkzWioVRzfyG+P0wGjwKWz5I6Yv
         y5Bg==
X-Gm-Message-State: AOAM5307vRJaOPsIYWwv1uSxvpX8zdtHKYUGZ7qamwE6BkHDPrJkJDRd
        nPjqc0i50DiF+/MbAb/8lnDiNA==
X-Google-Smtp-Source: ABdhPJznCryOGiaapGhkR1ssu1klQe40/wpuzaMcITlbW08G7kOfQATkKGR7vsCaF9kKxBdVSbniuQ==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr10596923wml.142.1595004983177;
        Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Bendorff Jensen <abj@rosetechnology.dk>,
        Soren Andersen <san@rosetechnology.dk>
Subject: [PATCH 22/30] iio: adc: mcp320x: Change ordering of compiler attribute macro
Date:   Fri, 17 Jul 2020 17:55:30 +0100
Message-Id: <20200717165538.3275050-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc gets confused if the variable does not follow th
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/mcp320x.c:96: warning: Function parameter or member '____cacheline_aligned' not described in 'mcp320x'

Cc: Oskar Andero <oskar.andero@gmail.com>
Cc: Bendorff Jensen <abj@rosetechnology.dk>
Cc: Soren Andersen <san@rosetechnology.dk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/mcp320x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 2c0eb5de110ca..191a8f644ffe7 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -91,7 +91,7 @@ struct mcp320x {
 	struct mutex lock;
 	const struct mcp320x_chip_info *chip_info;
 
-	u8 tx_buf ____cacheline_aligned;
+	u8 ____cacheline_aligned tx_buf;
 	u8 rx_buf[4];
 };
 
-- 
2.25.1

