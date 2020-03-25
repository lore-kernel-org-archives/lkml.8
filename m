Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFBAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84CB2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frbmyxSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCYKBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:01:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCYKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:01:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so2070964wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=frbmyxSV/jiO0ZGpQOXZmg2YOaPgJ1gZiI4l3sktC7+8QJQAC0C15NCfBgkl42nyz4
         DZp+iWEzdlCwOy4Iu7LNmKCsNgLD14TPODiCHOdFt7u8Mq5TlSvOJMMsDmROK9mDo7W8
         RsTv4T+MUo5LLO0vxV4ZqBLTptMF81QOfCdwywWlsAvEyiGCGjRSNXBrDxKkKixQSDeH
         RmNhGjvkiqeBqxJmX42O7ZOsa6pcDDJrMW9BxD2zVbL9jw5j1+UGF/450md4vhDqqHX3
         yBLlO3fvTEhwHU3UpBT8htMjvx1Bc2ia0/k1psDBljgADCcfUqiMc7jwOxTbj8LwU7Rz
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=nmTBBykJAP1D0+CZ/RM31a3lWTGGMxUihDjt0CrUPX0g/kmIGK2CvYiHRZtkOMm2Ai
         jEkt1YbQ3XPpyLlpfoyqSkI6pfEM4K1CZy5dmOj/HopDOLy81RRtKrDYqsuiZJE6BJ5R
         rGZ1rrmn1RoSqgtHYCk7b+lviGv96iKPx2mRqgD6YcnEbaFWMrSvGpE7bN9BV+/g0E3N
         lNPUkd27oUFpoNLZXmCXAqQkedvfAxfk/zYZPRfqw46qOM4P2xrs70LuaHe9PYRTPWtL
         KaIHTcIBNMrRcolFWdmxunN0qLudrcjATSHdgOMSqZE9oa/rqNf2i4JFkGgZbJze0wy8
         +XkQ==
X-Gm-Message-State: ANhLgQ2OxNZMOjQKen+kYibSsNDD0a2l2ayZL1ec93u9RfzpFGrKGu5y
        NOLb15PxA1IpAzfZZmk0cyomMVsV8kY=
X-Google-Smtp-Source: ADFU+vtn0USpEf7qV+wbidy8lrjG98Ywz+m5ne19cOUFrAOvGReJj5ngalQboOW+Wu/k8b0nKbHUyA==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr2398572wrs.44.1585130502800;
        Wed, 25 Mar 2020 03:01:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k9sm34489672wrd.74.2020.03.25.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:01:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] nvmem: core: add root_only member to nvmem device struct
Date:   Wed, 25 Mar 2020 10:01:37 +0000
Message-Id: <20200325100138.17854-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
References: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
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

