Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24AC433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3A20729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbAzfFVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGVKIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbgGVKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B61C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so1330476wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cu4LuhlpDSlOofMxjxPFDlq0CYY7PcSEJrvgG99XiXI=;
        b=LbAzfFVwG/XsAHQVg8oeOO4psiqnVJNvkQHUAgJEXWxkIpgsE/xDov9QiJVRqjYaxF
         ufJFFMOWxrDOq4w5m5HIMyCuWBvO3WAfJ/shYa8ntf6AcFMRZnkJrdYlcZpm+Fkagxz/
         3hW9Sx1r74abqiW7IO3OwEHpFGWCyi6t4wDzWxOug1cisMpXEa+0aq48FjD7Wsi6tcbQ
         42POuqiLwtKsO3NySJl6lN80KnYr3eKr1EynkoBvwTIoBGR0UF3eQgxr6kNY1ZzzbrhC
         lfUUGTKazDwfuA7SHl4PeDwT9xSYljzqE+/otNVj35ytFTz08kiKIwtpD+pUhtNBeh/K
         wShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cu4LuhlpDSlOofMxjxPFDlq0CYY7PcSEJrvgG99XiXI=;
        b=j36ZOe6DIixcMEc2Fni8CIGK1MdTwhTa/BqP6gLGmLie7+cXqGrSIBANAZ7yxTEBGP
         RodQCAfcc2oEAd1/ZzNHsFUDOp1af6yKWyZBAaru/Qb2yPBb48vg5qDEkWQZ3Q/XidtK
         ZwIKI2NYYfPcPqtBlxLv35NpKURY8ET4aVr6ofebc0HcD7b1pgehA/4ft1EQVZAn+wcn
         HiapyV/+pwV1DYc7CySB8GXQtYx1qYsY5CQlEp2AejcgsQZBdOIjikE36uGWbSqjyeMA
         Ybrj+8QYGM76PeIqB5Wx76RAUDOChzPsItnubQ9yjJECqSfmBQ6OYkgrhf+fTHvQP/gQ
         nzqw==
X-Gm-Message-State: AOAM532ekzC/Q1QLYpXx/A1i5f7RmqXz1JKSGN6Qa4EafVgZ3TEK9Mgz
        7H95ZYj+0PmrIpwUqhuXE2i9EQ==
X-Google-Smtp-Source: ABdhPJxvTlEfPd/pLtSnllPeSFiUbCsUIeP+kIhePDLcvtH7uxUJ7uII40gwpw8PiVo9izQJq3j02A==
X-Received: by 2002:adf:94c3:: with SMTP id 61mr19611860wrr.289.1595412493892;
        Wed, 22 Jul 2020 03:08:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/14] nvmem: Enforce nvmem stride in the sysfs interface
Date:   Wed, 22 Jul 2020 11:06:54 +0100
Message-Id: <20200722100705.7772-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The 'struct nvmem_config' has a stride attribute that specifies the
needed alignment for accesses into the nvmem.  This is used in
nvmem_cell_info_to_nvmem_cell() but not in the sysfs read/write
functions.  If the alignment is important in one place it's important
everywhere, so let's add enforcement.

For now we'll consider it totally invalid to access with the wrong
alignment.  We could relax this in the read case where we could just
read some extra bytes and throw them away.  Relaxing it in the write
case seems harder (and less safe?) since we'd have to read some data
first and then write it back.  To keep it symmetric we'll just
disallow it in both cases.

Reported-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Tested-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 927eb5f6003f..fc480d636be2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -135,6 +135,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return 0;
 
+	if (!IS_ALIGNED(pos, nvmem->stride))
+		return -EINVAL;
+
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
@@ -172,6 +175,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return -EFBIG;
 
+	if (!IS_ALIGNED(pos, nvmem->stride))
+		return -EINVAL;
+
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-- 
2.21.0

