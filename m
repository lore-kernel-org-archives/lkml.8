Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B96C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAFC2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/dhmjP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgF2Sxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgF2Sww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFCC02E2CB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so15495622wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMTCDVkmhrFSTaB8bx1bgREeHsoHTmBvamvepGv04mE=;
        b=S/dhmjP1Wds8RWIrdtgpp+KtZkHcSrMog/xRtGlSaf3iTckrCpwC/qb3qLOOKEADrl
         kZpxdApdfTy1KHnz6O6+jI7SbLRhTquBGADwdfSEIVjCa/Us7YMMK+rSrDigt9pKKqI0
         arAl5wsHoGHJdXZD9hM3hrNqoas6LfBWPIXFg2LiSBUriBEnR58FC9UGbKCTqPgRmE8/
         KJZtCDQD/bWeKePibICKhOVGetOraGmlTNY4Qmo+Wl4yjii80DNIgNBDngEU4Sg2WK3n
         8SCG0nA/cmzTOyeEVf+hiyaq0XJoRy4VTVyAFgB3iB0KTHqz43w+6Ea4riu19Pvm1t5q
         OUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMTCDVkmhrFSTaB8bx1bgREeHsoHTmBvamvepGv04mE=;
        b=V0em+pzxQ/ki3qk9D23QuMQ4zz98E/s9j3BD7SDkLIMEy3iwQdFISgjSMCryCY9DzS
         AqW9vr/V+cPSvl8Yn9wPz1nT1ltZATqad4pBo9X6P8RkFvSxZxvI3QFwNLEWrKg4UlMC
         K4nbCom3my+vCQFBSiK5CnyK9nq0Q8koehWpkeB7U76mSwGTn3cI6/3gs178cr7i1l6G
         3weJm6+jWSQVWtKiLhGLHD8V06fRPw6CEgQ2kaiooAsXnbSJ3lTNk64q/1scMSsBPvF3
         SGyiTzRbi7WrgY2ZPS4kOzp/FEEDSDl+PJmzsMsrDIbVkE+jq5W4gZ1NUmtessuxXDWE
         5D8A==
X-Gm-Message-State: AOAM533fNyStS+L4BeI7s5r9TeAa6Ee75WGJzdFkjzPijqLLlJa5Nrez
        1vuwzKZ6oUs0oKxPCBeiqKgAPg==
X-Google-Smtp-Source: ABdhPJxpFPRPZgqmcu4lCys19buO548MqP7hdlLxqhc4qChHB+Z5s1KZcLBS69vBLvmj0ivfeBVVlA==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr5381620wmf.78.1593439489644;
        Mon, 29 Jun 2020 07:04:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 03/20] misc: habanalabs: firmware_if: Add missing 'fw_name' and 'dst' entries to function header
Date:   Mon, 29 Jun 2020 15:04:25 +0100
Message-Id: <20200629140442.1043957-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though documentation for these function arguments have
been missing since the driver's inception last year.

Fixes the following W=1 kernel build warnings:

 drivers/misc/habanalabs/firmware_if.c:26: warning: Function parameter or member 'fw_name' not described in 'hl_fw_load_fw_to_device'
 drivers/misc/habanalabs/firmware_if.c:26: warning: Function parameter or member 'dst' not described in 'hl_fw_load_fw_to_device'

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/firmware_if.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index baf790cf4b787..15e0793da6554 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -15,7 +15,10 @@
 
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
+ *
  * @hdev: pointer to hl_device structure.
+ * @fw_name: the firmware image name
+ * @dst: IO memory mapped address space to copy firmware to
  *
  * Copy fw code from firmware file to device memory.
  *
-- 
2.25.1

