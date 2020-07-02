Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505622067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZH2/Rew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgGBOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbgGBOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4030FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so28803667wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sdX15PGQylOAZk6Sz4sNwGaJDX52Zxt56l3sZ9x1NU=;
        b=XZH2/RewojhBFAi5cKK2xZmeR3hWYf8Hb36/KsjUtAhLmQnFfTaP8Wuv9p5IH61VoV
         efJNPySFXVONCLPCM2T/ePyhmxItYP3DYGvzz56Zu+P7/aLhxohVyUz0Z92qbUD8YAcP
         gW1RAsBSibUcihwFOp5v9MRBxdxnZlGRnYCxvIYAygFHFHNwsHGzxhwlQKvU68cWjNID
         rpgAmudz5Jsxiq7nkwTC+fTuNVDcAZFoi949pT6WmfE6dk/I1ukGBVUuPhfxQCnNIBmJ
         TzfYksu+oqhcRipLU3ELFM2PoikYmCtcBcVAXafRSkgr2ryeMdAE2WNPAdWvHEJhnRQT
         jd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sdX15PGQylOAZk6Sz4sNwGaJDX52Zxt56l3sZ9x1NU=;
        b=k2a0A2ePgTEheFE4d7BBuEFyyaCHnmYU9V9S0T1IQlrPNNX37Ppvwg/RTV6pa1dAwd
         IHjny9cyf+Ot+WfNH1b/2VYrUlCQrMDCtpTYlviYyqiFJ4Dj6PiSV/cU2D8Tpx/R0m37
         T0AB4QwbU5Rg09Ywpk0aPtnUwmPnEcxgd03672AN/V4LsB3hY4bCr4/DVFAIKyvrOofP
         I3F5PZwajFIRT/7AXrIpveCzZB6JL5J7H3AaMsOcSjQl/ZBRrHxfDzNT4+BOmLQRhVzT
         xJVqEdVSi9hHeLspPyjasV5sKS2S1VzGNCYCYxXf3wDo0X2T0dIGKUMQ9IcYS0gAnKb6
         fqCg==
X-Gm-Message-State: AOAM531ZCABpTDSsmgBHZekTXGsXY3oYcKwXoJWGixZOpeBSUlWJg/Bv
        vyNdJiuRBrEmev/KhJpHu24akQ==
X-Google-Smtp-Source: ABdhPJxFyuUUxdUJtEHuZrAVsfrI1ui/9Xt+xD6a5gkFDyf/gPZpnDWYSne4ItkG8mpc4zEYwpC1gw==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr31648506wru.321.1593701195017;
        Thu, 02 Jul 2020 07:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/30] usb: common: debug: Demote comment blocks which are obviously not kerneldoc
Date:   Thu,  2 Jul 2020 15:45:58 +0100
Message-Id: <20200702144625.2533530-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File headers and simple comments are not kerneldoc worthy.

Fixes the following W=1 warnings:

 drivers/usb/common/debug.c:15: warning: Function parameter or member 'bRequestType' not described in 'usb_decode_get_status'
 drivers/usb/common/debug.c:15: warning: Function parameter or member 'wIndex' not described in 'usb_decode_get_status'
 drivers/usb/common/debug.c:15: warning: Function parameter or member 'wLength' not described in 'usb_decode_get_status'
 drivers/usb/common/debug.c:15: warning: Function parameter or member 'str' not described in 'usb_decode_get_status'
 drivers/usb/common/debug.c:15: warning: Function parameter or member 'size' not described in 'usb_decode_get_status'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'str' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'size' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'bRequestType' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'bRequest' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'wValue' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'wIndex' not described in 'usb_decode_ctrl'
 drivers/usb/common/debug.c:216: warning: Function parameter or member 'wLength' not described in 'usb_decode_ctrl'

Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/common/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 92a986aeaa5d6..092e179d5d5aa 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * Common USB debugging functions
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -207,7 +207,7 @@ static void usb_decode_set_isoch_delay(__u8 wValue, char *str, size_t size)
 	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", wValue);
 }
 
-/**
+/*
  * usb_decode_ctrl - returns a string representation of ctrl request
  */
 const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
-- 
2.25.1

