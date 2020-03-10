Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68816C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F196208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0O1LvJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgCJNXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39954 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbgCJNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so1322419wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okCxADSi/XY9CnlYiTmN0nDKDcnaKRsPlFnUGxBGBDw=;
        b=K0O1LvJXX9y5ExHZJUF2jvnWozFa1b4OyIMifbq/EthW/7dhvlCuMcELgEznc9xX+n
         fmVFj64B7NG61nTIe5w28Cx/CMjsT2SYERLM7RM08vA1MCpItKg9VqZpAPTQb1Bl+YM8
         PhLtYEQcVs0mBGdxEy7zkwwTUz5J+Jfl2rGwsMEjFbLkDlTo/u90Z4jq3+QTYU6Vhkxf
         WwocC7Gk9YVobNDQAI673rtZIbsH6Sq/dmwFJ1+L8PErywBOXBu2cShgAokMYV4IVoIF
         i2Zib2XZwNylddY57+vgv2vBA3CzBOy7JAA5peYrcldoWq4Bj3gM9bVR5UPvVOLbrPW+
         sN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okCxADSi/XY9CnlYiTmN0nDKDcnaKRsPlFnUGxBGBDw=;
        b=T4Fy4VpYvpiJVfoDpG+67Cayf9sPKkI3HgaCryfpwSlz9K+r/ubT4r5DFaBGhZig7P
         XASUOsu865UisoLhcbKiMbJDc5EH2xq+3tNi82G4PuvOdObzyg8dvueUv/xFfkqIf/PI
         mFiUzm/btML07BuxcUXo/exUVqeOFzYfVA65XyhwGUl9gW7kpcoBA7T1SYrAmAuWn+JO
         UanlW3bDBfpAf8trnmyCeY/+7dKdyw5jeS+4xInAVW7dFKEXK5FGYZufnxrfbjrWv1L0
         4NSp2JNeuY4une4/GrEh/q7k19enBvvzR5deuCxBKCBR81UdYEnOVMl3IDmKJBXyYELU
         3u+Q==
X-Gm-Message-State: ANhLgQ16D59fPWSHPJWKvMCpmk/TFudbiuiWAoZZnr04CLGaN9JhRkfu
        aaNdYvXuIWtoxIuUS+yRMqVtyg==
X-Google-Smtp-Source: ADFU+vtFCLoGYmDlAXXA55PpemqKxAdjTNnLmBuvP0pziZ8lOfz5Ewp6b85h3dxefvTQMiJa4wH97Q==
X-Received: by 2002:a1c:25c1:: with SMTP id l184mr2198473wml.122.1583846620784;
        Tue, 10 Mar 2020 06:23:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/14] nvmem: core: validate nvmem config before parsing
Date:   Tue, 10 Mar 2020 13:22:51 +0000
Message-Id: <20200310132257.23358-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem provider has to provide either reg_read/write, add a check
to enforce this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c05c4f4a7b9e..77d890d3623d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -339,6 +339,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!config->dev)
 		return ERR_PTR(-EINVAL);
 
+	if (!config->reg_read && !config->reg_write)
+		return ERR_PTR(-EINVAL);
+
 	nvmem = kzalloc(sizeof(*nvmem), GFP_KERNEL);
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
-- 
2.21.0

