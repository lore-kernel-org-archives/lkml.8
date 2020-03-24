Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA57AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5442051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsW374mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCXRQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35895 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgCXRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so4444062wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=wsW374mOQPitsWt3vt2KwtkDWsZMU8m6589gm4fuard7w9RdhLRNpaxiCYlzBVhmHY
         DpsETlUEE7c7bXqL7kkVolG+owKSIL8oAy8seQua82SE6rHhrmFK6oFLeddvk+nr4REO
         mS1Rm7KDRdlwyE2GGQtBpx6hlDVF8jbe7fHes0LjrDuKgm4GGUfqT76E9IN2yQ2Vpm+h
         uoeAJSM9ULRBt22HlqkTzCFGNIejwmZTky1R70wV/4Il6Uoo+RUVuRqayfn0+kbim9KL
         4Kj7J+UmbDOlcB+owNGDxyBFR9LeYhDK7E3tjaJsgKy6JcNSJZGoH2XR/P3uaAvQujT6
         gNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=L7MkGQjxJ8nr3A8Red2JaZ6AnR1GPpiGRFMaKX76xRuMUr5hxCly955dJXLxpnJQ6A
         3AQZxADFa4LC0zs8egvXwjeAIYYEJ9kuDF/oD36UenXzqaDXDZOzKfS5BsbdeV9usrhb
         k0r1Q9mTPJ+k7KQr/GzjiAeo29UIOsR0wLpM7SFclaCygH5h5iMqwNTG6+pGTj97l98c
         kyeJ8Ue9j+xgU5UZ6XwvOrffVyCSG4y4Lozhyra32UiJ78SFZW2SHcOYDrdUk/AXsAQH
         v4pjK2q3/0kny+2Odull6Jqu5CcORAg3zSLqX0vc0RZBdDqXfYcOTNVMxhU/hyTf9+e3
         Pcog==
X-Gm-Message-State: ANhLgQ0A2ywgrOeyZLTfDzxtJthWnN+xAfWPFAsa86jLZtG6aZoxKcvE
        4cU+nWoYbRpQg80i/N7vBiImBA==
X-Google-Smtp-Source: ADFU+vvQ5gJrLjUC0Ps8+Mdl46TuSA289oQWJE8tPldAqsVm3GVu6GL2qoBfiv4UroZ9aqCsPf7LyQ==
X-Received: by 2002:a1c:648b:: with SMTP id y133mr6570766wmb.173.1585070176382;
        Tue, 24 Mar 2020 10:16:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m11sm5269514wmf.9.2020.03.24.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:16:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: core: add root_only member to nvmem device struct
Date:   Tue, 24 Mar 2020 17:15:59 +0000
Message-Id: <20200324171600.15606-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are planning to move to use sysfs is_bin_visible callback,
having root_only as part of nvmem_device will help decide correct
permissions.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c  | 1 +
 drivers/nvmem/nvmem.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e8f7bea93abf..7d28e1cca4e0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -377,6 +377,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.type = &nvmem_provider_type;
 	nvmem->dev.bus = &nvmem_bus_type;
 	nvmem->dev.parent = config->dev;
+	nvmem->root_only = config->root_only;
 	nvmem->priv = config->priv;
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
diff --git a/drivers/nvmem/nvmem.h b/drivers/nvmem/nvmem.h
index be0d66d75c8a..16c0d3ad6679 100644
--- a/drivers/nvmem/nvmem.h
+++ b/drivers/nvmem/nvmem.h
@@ -20,6 +20,7 @@ struct nvmem_device {
 	struct kref		refcnt;
 	size_t			size;
 	bool			read_only;
+	bool			root_only;
 	int			flags;
 	enum nvmem_type		type;
 	struct bin_attribute	eeprom;
-- 
2.21.0

