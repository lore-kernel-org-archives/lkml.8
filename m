Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C17C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29684208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilvVvEzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgCJNYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36902 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgCJNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so1334641wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPirBuFJU2IYVL8LYQfFZ0eu4t+TRlVhuBDZMxGb9hU=;
        b=ilvVvEzjfLtJBvWUGSa3OnGTCfi86/vEFlqtbCm6NJiYoBhCRDZUapJo2dRIEiJkLa
         INNvpUexmx97rj5fT7DQdtfm73nwiz6z/E2oQoQGCJyUkoMimqaNTSOxkkMlGaPPUCRT
         HsN8aZhqw3UKYwtg8jL+yLh0FdVoHo2SoPaPx6vB6ZLsYrKL8FIFhtDLnFaVpEqpv20c
         kAlqj4FsRyYwMcRS4T43uF66T3dSKNH4w9isEYvXoKINICcDrnA+TfYDQj+ai3ecyteK
         OP4QKIlUPOT5p61ZFKvuc9d9rCtKnEW5yye4yYuJHZ5lMjppnHWAlQd+3I9RS7zsbgNz
         hj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPirBuFJU2IYVL8LYQfFZ0eu4t+TRlVhuBDZMxGb9hU=;
        b=iyTgNq6QSlUs6tJoX5zhkqzjYL51VEXszjDMXirvOmjggC6a+dkU5p40OfTLDVeF3g
         FErtG/+XN/WExm0fFq0WxmtRniH9U1t2RMzM4iHJJ+Cim73tOKth7gDfHUWOc/LR7psW
         7qDtG6unrg5UAeU3atTpxrXBsC7K0Q3aw3DABUmo9gNcqr/tdTTFjo8EAjbNUfZXRpi/
         N32/XDUmO7e885vt3bgQk0spGY94gUwiXSeOghO6GHkVmN085LcSCbdpeeaBMgQ3KK82
         DbIpXlfkOxzpAJCjuvpBJYa+6ZiG3l8hkqwZQIGJc1qvlbC5SU/TpsOMtItQAJBOwH7y
         Cmqg==
X-Gm-Message-State: ANhLgQ3T8Wr+wGbujLb5KYRt1I6zhFOyBmnGcvmnD47wJ7CgELvKKXWQ
        c0FosNj7FCoe59Oc3MiZQ85Wog==
X-Google-Smtp-Source: ADFU+vvLLR+6kVJHFUUSDE0Ws/C54RzxYBJ4WzqvAb95GnNd3dqtv0408agMrlqg3IxuLx6kPaLl6w==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr2254453wmi.20.1583846619369;
        Tue, 10 Mar 2020 06:23:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/14] nvmem: release the write-protect pin
Date:   Tue, 10 Mar 2020 13:22:50 +0000
Message-Id: <20200310132257.23358-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khouloud Touil <ktouil@baylibre.com>

Put the write-protect GPIO descriptor in nvmem_release() so that it can
be automatically released when the associated device's reference count
drops to 0.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
[Bartosz: tweak the commit message]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2758d90d63b7..c05c4f4a7b9e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -72,6 +72,7 @@ static void nvmem_release(struct device *dev)
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	ida_simple_remove(&nvmem_ida, nvmem->id);
+	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
 
-- 
2.21.0

