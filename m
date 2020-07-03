Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C064A2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1VNV8Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGCRnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgGCRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:43:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E8C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:43:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so33554500wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvsQ2j2MIPqkZ3jkOQAkyhlMqXenxaz7Doasiynl+ug=;
        b=k1VNV8Cq6YZ7ALXAmL5SY7ZkZfumiTzDFOzauoO28aylJDHFQFNlPWaN6vTjNXCwp7
         8pA/rt/83pE8YtL+zcZUXuRVoFtqfnp7lThQHbVkywE49Yko32o288yP4Ap725xsFmNy
         u0AbX34iOhF9iVrTlF8M8O98Bhmq3RhZ3ArhLg8gNPwyg1MQHzEQ5ATD7+W4aHbxOjxR
         +IiPmILgTdIinpTc97X9LofUDKxr/mU/xEmv+I8GeMYxioHZvlDPcbe3YiTbDW9rluOS
         r9aQUCOhNZ2UIoi4q2atKUd2YUrddfAmU//sgzTcbNN2qn9sssku+0kCWIRhF7YoIcKS
         hZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvsQ2j2MIPqkZ3jkOQAkyhlMqXenxaz7Doasiynl+ug=;
        b=kWd+qmox0vs9YCbSgSYvMQJyUmIaTdyIYzYXzhSeO89f9aa6InQnQ9o+CnxyhKE2yb
         2GW4wiMd36iSlV7gvJQkym6vKMUVh/An32Suwa7XxIJUmw14T/VhHrNkUV6cF0T2K8GM
         uNanGQ4mlBrVzHg2o1ARdfA6rOcDKwGD0T6xiuHQxtQlpApgBbYEEsyLtpZmwnbIg8eG
         YMKYbg7wRTi+BOQXUthOE9MeNLBtSJ6icbGu/flRrYmj6IoKf93MmHyLkbUpfPcjLR+t
         zWBjRdUMTUJckg1mfc4MtWbXANDvzkzdVaT9em327SXUVhlTi2/dWYkw5+QSiu2pXiLj
         CWiA==
X-Gm-Message-State: AOAM531I0CiPFaE/Etzc8K7KLh9sRVUIZFM54hlNuIb0bHAcRhZy1kTi
        KQoeXXpBeSr5rTvxRPUQ8YEucw==
X-Google-Smtp-Source: ABdhPJz1kSkGpmf1AnLPdELh2Lnx7y6qmm+BDs31oGtdoZk4KTfJ9gMkrVTg58SfWr2MzMbZhcatcg==
X-Received: by 2002:adf:f203:: with SMTP id p3mr9397409wro.331.1593798180531;
        Fri, 03 Jul 2020 10:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Bin Liu <b-liu@ti.com>,
        Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 28/30] usb: musb: musb_dsps: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:46 +0100
Message-Id: <20200703174148.2749969-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/musb/musb_dsps.c:44: warning: cannot understand function prototype: 'struct dsps_musb_wrapper '
 drivers/usb/musb/musb_dsps.c:102: warning: cannot understand function prototype: 'struct dsps_glue '
 drivers/usb/musb/musb_dsps.c:169: warning: Function parameter or member 'musb' not described in 'dsps_musb_enable'
 drivers/usb/musb/musb_dsps.c:195: warning: Function parameter or member 'musb' not described in 'dsps_musb_disable'

Cc: Bin Liu <b-liu@ti.com>
Cc: Ravi B <ravibabu@ti.com>
Cc: Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/musb/musb_dsps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 88923175f71e5..71660491557f8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -36,7 +36,7 @@
 
 static const struct of_device_id musb_dsps_of_match[];
 
-/**
+/*
  * DSPS musb wrapper register offset.
  * FIXME: This should be expanded to have all the wrapper registers from TI DSPS
  * musb ips.
@@ -96,7 +96,7 @@ struct dsps_context {
 	u32 rx_mode;
 };
 
-/**
+/*
  * DSPS glue structure.
  */
 struct dsps_glue {
@@ -162,7 +162,7 @@ static void dsps_mod_timer_optional(struct dsps_glue *glue)
 
 #define USBSS_IRQ_PD_COMP	(1 << 2)
 
-/**
+/*
  * dsps_musb_enable - enable interrupts
  */
 static void dsps_musb_enable(struct musb *musb)
@@ -188,7 +188,7 @@ static void dsps_musb_enable(struct musb *musb)
 		dsps_mod_timer(glue, -1);
 }
 
-/**
+/*
  * dsps_musb_disable - disable HDRC and flush interrupts
  */
 static void dsps_musb_disable(struct musb *musb)
-- 
2.25.1

