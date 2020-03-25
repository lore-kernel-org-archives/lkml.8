Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8603C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA62077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmCIY5Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCYMV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:21:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33005 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgCYMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:21:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id w25so1998644wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=mmCIY5WoEY45thwf0Sdd1ahfhr6K46m1SaC3IGR6iwZsWVLmM+lvqPr/5z1oz6JKZn
         RVZy0GtK/mgQTMlsFkDfxVS/N/mzVKOHpl/bJJwGRdpinfRA67a7JcXRHz5Ub2LA5jjJ
         jaCoZG0wgSzXyNcPDZfUZcl4LYhCz/tgiNhMAS8HX1pK/fqwD0XyEiOw81Nw52OLHJLX
         S5cJbm+PVTTg1i3RMr51LRldqzrOK+mhSkChEeSjOEwBIaRinFr6TzHw4iw1HxR4+oyY
         MSgqnrfv4IoznO5UDBubALbqzLAStK8mgeOCxSYpipf7Ftd+9GaLcJnZwhqbZzEQpjSQ
         Koxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIHNfLP97i+iXHu3Xs3oiPWqbaiyFrdjyqDTxXvHYmc=;
        b=nuRJC2HobYyHlnh+iK4kKdbeEZ/WWTNfDk07807LZS8zM2F0Yx7LIUy/eb2YUK8EXi
         N45e3ssaLd/9LSpfD9NU2ghV0Do1wV2FLrS9Hj9Mr2Qsfw2eBCWWJIwVDiAy7q1AM958
         zHCo47qdRV1JbA2RC61j8hZ4uP7Iaaquem1z3XfAlCIl/4yeOS1rC16CtELqrpSUL8hJ
         na/kcxl4aQu5BYV7u1mpvAJmdAW1+0s8caYMgdGEaekryiDiw8ihMtE90AjFxJgMpgBo
         GuCRrhzkrceuwNIKinHnnWFeKjECMG1/Iek0BTjZF9wtZj9/+2bptTelsYLuJMAR5826
         0Nag==
X-Gm-Message-State: ANhLgQ2oBLsaEc3myWSdjxTP1PqBLL/kC2K2tCdMrA4mj3Kvw0NWWRL1
        Q33QwyL8NtUuOFHz0KHdl+MuDg==
X-Google-Smtp-Source: ADFU+vvgPPmggfcScyyCXKbZYgPj9cOg/9MetIhK9UfD0RfRAEQYy/lRCBAiIyDtJyYZudOtWH8RtQ==
X-Received: by 2002:a1c:ab54:: with SMTP id u81mr3080672wme.166.1585138883026;
        Wed, 25 Mar 2020 05:21:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n1sm33620159wrj.77.2020.03.25.05.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:21:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/2] nvmem: core: add root_only member to nvmem device struct
Date:   Wed, 25 Mar 2020 12:21:15 +0000
Message-Id: <20200325122116.15096-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325122116.15096-1-srinivas.kandagatla@linaro.org>
References: <20200325122116.15096-1-srinivas.kandagatla@linaro.org>
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

