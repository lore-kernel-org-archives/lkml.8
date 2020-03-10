Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27280C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F173C222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6sE/WJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgCJNXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52969 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbgCJNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so1071652wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2NAnH3PcKyKib6cfUNqyPz8mjS1Ijy7ACA3TdZSiC0=;
        b=c6sE/WJCqiYz2U1VVC6z3EFAymtrpIv5qB1nwk4MdgSEvrKIBLcMhVHen6sZQqHySv
         xX0dYqcsw4zEMuKdJoOS9LLfeZNozsi0IJbzSYt8tzHVT64wanMms9+Eio5z5jd0uOnS
         rCZY1EKFAeJPFjuskFH5IsWfiSnDsYBDvmy/QoZgRKTI2MOs8Esv2a65mDvrX+xHVUs2
         ITqGSfJp4KdS8KHVt4cTDBG7jBwhZ7jWTb4UbDbXaIQNZ0mv6O/JyFRovLGd4bJqo079
         aaLaUb8zqBhcqSHLB4ImpPGkdSoF7Uwl2W/CazxFku+Y7xBCfw8IOMdJOyDcq1u/vTOp
         t+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2NAnH3PcKyKib6cfUNqyPz8mjS1Ijy7ACA3TdZSiC0=;
        b=JaKDuUmYY/lsvtrcxfxMI9ul3CC+qg9y1ZiFu91CggRQwH8QlPai2b1OV0WZLVYyZo
         gBoleNkJk4EVegzfpLMzWuGTusjVgoe9ey0+5d//9JZ96sizH8Cqk8KU9ot8eV3j/BEB
         NZR0q7xYOEmP0EHfdxY1QD+XkyIyYpYFoVt3i9g9pFlPcjNpg/pmbOsyIfo23595zhDE
         0FT6HoowRgO2ZgkcTBoNMkW188wrLc0+Vy7F2TsrIVb8A1IyiskmWkuuR0ssNgG//+YH
         5cs0UcZw/iL/iBe8UMDGMg+k67EeNWJfx067zawVLDlZGrs33aj3vCpicMkTL9b6EkRD
         ebBA==
X-Gm-Message-State: ANhLgQ1C1S0pC+Vj8rTNxl7Q2bD+cRgtcLbIF6PWsqenpj+Y2HLfdNDI
        lFxWPW2tlgX2lYcTTpsaL82lhg==
X-Google-Smtp-Source: ADFU+vuK3Hyz/lEyEUqXoX/ntNXr/jDkKlqQMkxOGqXp01L2zbe3zQ9PArAmmkLzP2LBd2zeQm30vQ==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr2088858wme.115.1583846618163;
        Tue, 10 Mar 2020 06:23:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/14] nvmem: fix memory leak in error path
Date:   Tue, 10 Mar 2020 13:22:49 +0000
Message-Id: <20200310132257.23358-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to free the ida mapping and nvmem struct if the write-protect
GPIO lookup fails.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 503da67dde06..2758d90d63b7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,8 +353,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(nvmem->wp_gpio))
-		return ERR_CAST(nvmem->wp_gpio);
+	if (IS_ERR(nvmem->wp_gpio)) {
+		ida_simple_remove(&nvmem_ida, nvmem->id);
+		rval = PTR_ERR(nvmem->wp_gpio);
+		kfree(nvmem);
+		return ERR_PTR(rval);
+	}
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
-- 
2.21.0

