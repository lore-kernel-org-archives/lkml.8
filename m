Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1723C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790AF2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1AbrJMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCJNXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgCJNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so1385671wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akDdAt4p2dWoTZwYxw75tkvXAlxdneDQi+0B2o38Fws=;
        b=h1AbrJMApWyg4kNotGG5swk6LiG4J2pDGRiKJvSG0/7WZGe6VlS6P0OEtDc5Zw5FJj
         QDeMfUmosx2YlYnMM9eEtBrrfeQkt1hEq6SJEjptGQihtdwQva+r0RYNdWF051/CleG6
         wt6gyGo+K8jaKkFUaUoLovkFk05zVyqxlcw0S87rzhdVO9Lod95v48j69AK9Fs7RATCC
         7StM96w3Sg4ELeYl3vyO7ku9fyBPUam7ubFvFCQpvtVEoC/cQA8xLs9r4Af4b9ih/uP0
         iYzT8zDHdqthEcf7IAqbS/zt7CXyliDFALQmTk0EGklqT/gs1M9wnkmV8U/xFt4Ah04k
         nBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akDdAt4p2dWoTZwYxw75tkvXAlxdneDQi+0B2o38Fws=;
        b=AIFtUTvFMmu8gPrPxjyoJjwrFjTpL0LybuRBVXGMl9IeyNU+ZjeF6AgmxxMx4E0GDF
         AwggrDc9Pnam6Z9iZj8ZheQZbgEjvp5JAOhuP43LtqLbZa5trQUeU8zdWIydt5ST87F+
         YdZRxOHFPod0NSgaIbpFZ7E/GBmYZhF60FVVEv6ZVY5dccWjPmt55ftESAojAxpwsjNv
         oAeyBw2EyZxw8reySCQF2pccirtqzpXYEZrZFNHdYior9DntbqnRis7Qe1qtaQtu1NH0
         XAVkbItRyG1a1VfQSDApyMvg+2FeC/jYe2BHNSKmHoAewtRPZLv+sh7jl0csQXlYz38w
         YrdA==
X-Gm-Message-State: ANhLgQ2VBG5Zv223/aseyKRC1Z8KtGDBrWoFRj9Ux7GwJcKmaB/AJj1Y
        soteXmtFkLevtB8PU41aBEyXcUwFm6I=
X-Google-Smtp-Source: ADFU+vsXFQIe4HC64N/UgpZCNemZncS+enpSTHkmz9rIHzpNEJh+52u8oxdQkxRxmpMUHHQy2aQhTw==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr2219100wmf.88.1583846622078;
        Tue, 10 Mar 2020 06:23:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/14] nvmem: check for NULL reg_read and reg_write before dereferencing
Date:   Tue, 10 Mar 2020 13:22:52 +0000
Message-Id: <20200310132257.23358-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Return -EPERM if reg_read is NULL in bin_attr_nvmem_read() or if
reg_write is NULL in bin_attr_nvmem_write().

This prevents NULL dereferences such as the one described in
03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem file is
read")

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/nvmem-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 9e0c429cd08a..8759c4470012 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -56,6 +56,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_read)
+		return -EPERM;
+
 	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
 
 	if (rc)
@@ -90,6 +93,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_write)
+		return -EPERM;
+
 	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
 
 	if (rc)
-- 
2.21.0

