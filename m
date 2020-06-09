Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C724207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q35TGCGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFIKth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgFIKru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:47:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A3C008637
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 03:47:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so21825710ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nJBKYN0yMS8AJgBotdxC1qOHMAr254b0bdL2BOSVBX8=;
        b=q35TGCGg2mkkEjc2wKlEhVaWy46yXIz+7jdW6N6OkmJb73py5fZiUzxTInYQq0bo+F
         D97pelWumzAAEdcO8aFTs9/xmUjvxBzF5dgRrVlNpV0QPs4BmirmqiXT60dogulqVqDk
         /2/8mlHTtSWjanvIyzfTh11muRWkGWkVC1kL+s9b3aXLnqcsYKp4KBrqOK4Gd54yPPet
         n8MSEc59ajB3s538tDFCCfQD/bylg4wisxrZJMp9ApiHtzVsi+QMSeyoo0xeNqwe8zhv
         TTgpCcwVcQ1EuY5KZIhARuAFN4xdFt8NdIM8OlX4WRiuMtUaKoYHy93CvXg2HxkKZOv8
         12mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nJBKYN0yMS8AJgBotdxC1qOHMAr254b0bdL2BOSVBX8=;
        b=mMxSxfoIX5Qg7p8xvh5EbZ/k4/+Er3gMC+Gyl5Uo3KUN+EEuGJoIBngu0Pd0T835kg
         spRj2fqHmvbazghWERY47ajKZkU6gdnTMAGpXnKtx26MERHgxz+J2IUqgfeitCcdXDsR
         iLH5nKuWCo/lUJyg/ic6lJ690u/mQg4tarqXNxNeEU5SbDYjX78sesLBG5lc0kK9Kj6F
         b4JVu9P++/+YlmuHevAPa1HxkbxHdEGELSpm2xRVewDhJhMG6Ben3xAjdfN4cLw9YxmW
         +2XSuM8Jp4/dG/6ezIyv0h0mwtyO880NoBZ3F14gpq157fJ2OTO+WAsECcUNEPqfVPNe
         WWEw==
X-Gm-Message-State: AOAM533BpmPeyfO+zV5h7yy3CR9Ex6xuJO7Ebs687FJGHm6HQzdZe08D
        evM7YEFGIGU22aW5An6dbhiTNw==
X-Google-Smtp-Source: ABdhPJwbs89Sxz204nqQDsKgXCoF+iaDYcP3btNQRBahLuS6eOL/DHBbG2RDImrJGYxnwGfYKSDVQg==
X-Received: by 2002:a17:906:e247:: with SMTP id gq7mr24263420ejb.107.1591699661849;
        Tue, 09 Jun 2020 03:47:41 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:41 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 4/7] printk: Add pr_debug_level macro over dynamic one
Date:   Tue,  9 Jun 2020 13:46:01 +0300
Message-Id: <20200609104604.1594-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new pr_debug_level macro over dynamic_debug level one
to allow dynamic debugging to show only important messages.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 include/linux/printk.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index ceea84aa705b..2a6eca56010f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -416,12 +416,18 @@ extern int kptr_restrict;
  */
 #define pr_debug(fmt, ...)			\
 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	dynamic_pr_debug_level(lvl, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_debug(fmt, ...) \
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_level(lvl, fmt, ...) \
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
-- 
2.17.1

