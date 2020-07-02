Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755CF2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPNUrNZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgGBOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgGBOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7085C08C5E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so28297107wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juN4hSvL5XQNXRrfZcj7AlUDUYFoERtc/+nkEi7x4Ng=;
        b=DPNUrNZDKr8bIOqrg9aAd2AwHmX5d8s358yRYd2Z9zSwoUay0njHdD3Z9FyOJYfXnq
         yuXJR5zm+WMALudvtSdSf7QrU+aX32ihed4eNdWS3+J6iP4PSp0ApUSc13R6lbaytViu
         2nEXlLP1OTu1qHSAY5bLLe/AzWbxhs2PXgYldAEI3RW1XRKzFipV79YLuUQiSTLjSP8g
         /v0zUB/rvMW2lVRRVbnVMjr3LCCeiKd0qPq+6o6Y03pAOpmHuNjRYSmtp8eFBBlpTz6c
         NANPF2k9ZT//OiBoJTGMU6zxAubsmu61/54CaN7OGPIFUzM4MueSjt15ktnQ4bWU6wPP
         Nuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juN4hSvL5XQNXRrfZcj7AlUDUYFoERtc/+nkEi7x4Ng=;
        b=czjVwiHJEHF/C76xRB9PO4op0/LFTz7RqCj4RAYp2IUnr7YknqZFraxn3r1BqFAmL8
         TX/pz/UA6NGKVrRSeUYSyEYgLEpSDNPpBmBVxCxXcBNgYCt88yOWk372ts/x1SF0BfjY
         G9Gxt1e13pCH/JCHk2bg1trNHipfDJBt75BWvHuY8AEwghaXer9ri8UPevgZiptiQkwd
         WKRw4J9ctJReq6CtR7Bt2RuXWMc+d48Z7SPEHKV6FiAaTguJbCn+pWYlb1Ql2INIuX6I
         vt7KngPQ18IPv1HId4h1xC3T6SIa8xOOv91SRwEOM0UamCWHncM6zxXM0/CIzK+WWGcw
         zTaQ==
X-Gm-Message-State: AOAM53285zKzE0Gvashvlp7mSe811INlZGY0pD0lEc2nyjqLEGO9qII8
        RGfdC4NQrNrQYvjw9WB6oRxLGg==
X-Google-Smtp-Source: ABdhPJwZjQU/P4mU/ND53GM/MjXCWI6l4mYnK8RuPiwY1UjcwaxyYVsB/ikr+y30GGMSdRhl2uBtAA==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr30736308wmc.145.1593701227467;
        Thu, 02 Jul 2020 07:47:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:47:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 29/30] usb: class: usbtmc: File headers are not good candidates for kerneldoc
Date:   Thu,  2 Jul 2020 15:46:24 +0100
Message-Id: <20200702144625.2533530-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote usbtmc's file header to a standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/class/usbtmc.c:11: warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/class/usbtmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index ffc9c6fdd7e1d..4b52758d3a38f 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * drivers/usb/class/usbtmc.c - USB Test & Measurement class driver
  *
  * Copyright (C) 2007 Stefan Kopp, Gechingen, Germany
-- 
2.25.1

