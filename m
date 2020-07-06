Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC53A2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrBdfUXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgGFNfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgGFNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C2C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so42149534wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDXPXE1ejSNiTZPmJzCEijdYryKHjxn03JTJMf6IP7Q=;
        b=nrBdfUXO6LY8W3UqebH3OTR13trp34J0vuEI51RUElQ285ST0V0W0G2+PO4jsv+hxc
         iLQUwUgSA6VUbu9JTOnHYL/gAiz0ajtk6cAXF8AMBAsmzGLH6OCX7lVStmeEtWmNOokn
         aqQKVBO/ffzZ9ykuNxvhdS86TyGMm4i/2UFi+wW2xNk4ccagDL0o1j90UxuPFljjkjfI
         ZvywJxRPhH6jSNIidaJ1ghg7Mi8s1U56J14BPT8gLE+P9e0dXdBExlvcO33c1B9NM2Ht
         tquR7H/k+Mz3WARXMH1/ra6tRevWfrzSNRlIwGgwDOvIVGWMlhLrf5xgRhr+0xutyrWT
         fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDXPXE1ejSNiTZPmJzCEijdYryKHjxn03JTJMf6IP7Q=;
        b=fD5KIpLdE9gfNYvBzhHpCdXq5bBvCjsT3KngIVf3Ce2ceXVb/VkZbcobONuL0bCqjM
         mgR2PBZKJvuFLZBKexLXntFu3jBEOEICikacXasesdKFK44Vh1m9XTMK3shJrdGnIDnN
         ucCEhmJP4tPcCPW85fSflkXOeEoQj62WB0MGNzOoAbFJvQy+9P69dVu8Jl6h9w8j9lPV
         EGj9lUJfoKTLqL0xFkYY5ihkEy/wLNMARq3Fu1oHYh/B1PXWOuM+dNCfaPxV7OHOKYrq
         ePTEKIk6fhs234W3ce5jzUujuHvPkX67PEkahB/1DvpnrdWEwPqNfjCTt+/+6mExHbs9
         1e8Q==
X-Gm-Message-State: AOAM532j2JIcDEJYw2wSLQDGkFriRpvZb5BajANfREDWqk0JVI7D28rS
        0pQvteYsMNGeJNtDXBARvxIOpg==
X-Google-Smtp-Source: ABdhPJwIxV2zfyTQ46CXR54rzVA+3y6gCIKQuS9jzSbWYCHADjbdXTgdAvhaPHfM7G6AYqJMnSZhEw==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr49126433wmi.98.1594042449766;
        Mon, 06 Jul 2020 06:34:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>
Subject: [PATCH 21/32] usb: host: fotg210-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Mon,  6 Jul 2020 14:33:30 +0100
Message-Id: <20200706133341.476881-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 2 functions attempted to use kerneldoc in this massive file.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/fotg210-hcd.c: In function ‘fotg210_run’:
 drivers/usb/host/fotg210-hcd.c:5013:6: warning: variable ‘hcc_params’ set but not used [-Wunused-but-set-variable]
 drivers/usb/host/fotg210-hcd.c:5569: warning: Function parameter or member 'pdev' not described in 'fotg210_hcd_probe'
 drivers/usb/host/fotg210-hcd.c:5666: warning: Function parameter or member 'pdev' not described in 'fotg210_hcd_remove'
 drivers/usb/host/fotg210-hcd.c:5666: warning: Excess function parameter 'dev' description in 'fotg210_hcd_remove'

Cc: Yuan-Hsin Chen <yhchen@faraday-tech.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Po-Yu Chuang <ratbert.chuang@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/fotg210-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 51dbbb0e768bc..633df2e927bb3 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5557,7 +5557,7 @@ static void fotg210_init(struct fotg210_hcd *fotg210)
 	iowrite32(value, &fotg210->regs->otgcsr);
 }
 
-/**
+/*
  * fotg210_hcd_probe - initialize faraday FOTG210 HCDs
  *
  * Allocates basic resources for this USB host controller, and
@@ -5656,7 +5656,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 	return retval;
 }
 
-/**
+/*
  * fotg210_hcd_remove - shutdown processing for EHCI HCDs
  * @dev: USB Host Controller being removed
  *
-- 
2.25.1

