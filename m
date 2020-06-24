Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE89B206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHnjSn2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404231AbgFXPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbgFXPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so2852911wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtJAcvpHkuLRDrUsq1eY3z1bY+z7q8TiiXjibqyd6Ck=;
        b=ZHnjSn2WorVvPlhnsW05PjkW49hRNPgq84FENEFtuoQWoLFoS5Koxe/dFywbKRMHXL
         3TdXrKvSsAttDlfRMZtJGsuGsj/a+hJcx94EmcpOadjkOkkb+KaWqiOYgNy6L6Yx11WO
         +baxZJlc03ZWuHtQboIEUm9C0m3an2F/wAOR3zMqIO+0e0yZcoFn/dKH/AZytJKBvXIf
         kasqyP3fjB5JUNwQho/QWyRHJ3YJOyhWE3+Oe40vlAuTWYeoqbw7Ezbto0uUymTcO6fp
         rAU9JBU5tdSYDQHnIyQdY1pyBRF0zOeb8P/DzpPmVAGVbd1L9Mlm8deCmJcpHyEmu7Vk
         irqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtJAcvpHkuLRDrUsq1eY3z1bY+z7q8TiiXjibqyd6Ck=;
        b=A5rTjueJOqKZKJRabtKk9GWcB+B+HhPKfrxVOT5Rr7ywU78XI+IHiKCbPETarCY7Fa
         RI+XItVCJC0MQNQlGj8Ni0de5TkpAKX30ZtgT/4sSUVidC8YjRPjcbh/NsT+O64BXUrT
         7xkvXYoQuuVRXHMqBMhyxeYv6VuwNdh6r6Z2eivrkZ00IuNeLi0GQHZThz7kUtHQHxQM
         nipWKPgFjSiOqtJZ7r8VcZYxR62vyyZFYkoRNwScdUKf27M85IQwuasINY1UtCCEMJIR
         xfEeCMXQTI4Xg216WzXVE88P4WxOAYKGcVdd6WYniAydyvo2EjgjSZCkK+Cnzq7bazwS
         AHcw==
X-Gm-Message-State: AOAM530dYP9XJXz9c/AHiXhy/0pFli3eyVzY8YbRZFGia5rdxQav0+0e
        vANv6l1nV0uxnEL0MnYVC0gedg==
X-Google-Smtp-Source: ABdhPJxagKb1wXFKsg3BjteSAxqyibenBVKBU8QYTY4DNUpO9PPoz2ukw2LgHjBi8SkOZzRYlyySUA==
X-Received: by 2002:a1c:e303:: with SMTP id a3mr12187899wmh.26.1593011234076;
        Wed, 24 Jun 2020 08:07:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Kai Svahn <kai.svahn@nokia.com>, Syed Khasim <x0khasim@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 02/10] mfd: twl4030-irq: Fix cast to restricted __le32 warning
Date:   Wed, 24 Jun 2020 16:06:56 +0100
Message-Id: <20200624150704.2729736-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silences Sparse warning(s):

 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32
 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32
 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32
 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32
 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32
 drivers/mfd/twl4030-irq.c:573:40: warning: cast to restricted __le32

Cc: <stable@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kai Svahn <kai.svahn@nokia.com>
Cc: Syed Khasim <x0khasim@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/twl4030-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index d05bc74daba32..ab417438d1faa 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -561,7 +561,7 @@ static inline int sih_read_isr(const struct sih *sih)
 	int status;
 	union {
 		u8 bytes[4];
-		u32 word;
+		__le32 word;
 	} isr;
 
 	/* FIXME need retry-on-error ... */
-- 
2.25.1

