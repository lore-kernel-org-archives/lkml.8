Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8468B206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWfrC2CT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgGFNd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgGFNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6631C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so40948787wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1uVBpjaOD4IpY3ZVlXbRV81yiri13+tuf6A/llAK/Q=;
        b=bWfrC2CT864d48e8sCwLNN6S649Z7RUI6pO1r+dF7OQw0XBZ0w+YwQQRCgFTULa6lO
         pUTSNHqHo5MEMTKVVgMIK7+bkfHfqxXFMNgjUdN4S6S7nnMVygMuDMWlbsNhPfyl68jD
         avi2zqxlw+3PRHuC+6tM753fGejds5lVDT+akNypUQ2JCcQvMzLNJF+A2Xe6mKVZPj7x
         ZLRC8d3qGcXfT5kgnn66HLzFcO6h8g/DsDcpAsMjN5bQHWZPSbai4i1du/j4Cmeb9Ml5
         5lJ4DfLAuw09P70HDlLAaeKYQp/cHK5Eh+xJMsB+5p8ptypyUIV1/p+NtWybWXuYyrVB
         AiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1uVBpjaOD4IpY3ZVlXbRV81yiri13+tuf6A/llAK/Q=;
        b=mzLyKwJ16LGePMbyk0n/x/HcnR72SyFXLabZdRP04Dn0S6sooys/a88zw4T9ysTZAW
         WEO4yYnopU8rQ+fW/GScTQ73wzIxrC8lE/SZ1Od+oQlPRPL2iLb9osPXpeIhY9Owb2u3
         zppfA241gdLPnHegsV+NmhPikK/kM1wudvmsz8rTXUGf2T8hfMzCgFdJY8eKsIPcTpm2
         amwt1Ff3AZDCb5tdH1vGAxFQgV65IDPd5lDaLkby78yw4pNvUlvg4XLr4kBRkPQP4ugJ
         TRQmfaDgnrKbI+3LdbuoHhGA58Pz94PYBN3dA40+UXSGk9vy6cT9cIPHoAZ00XXUEe0R
         arzg==
X-Gm-Message-State: AOAM531FnMjl1eBaKrTTtLFB5p0YjUXQeqV2To5kzMr98UDm218iJjPI
        SIAqOZYv4GRHCfKOdSMKGoo7wg==
X-Google-Smtp-Source: ABdhPJwkx0wriCmaCekhauRjWoIcIVTFPWenfRaZ3yayXF3PWVnJO9SnWMwPmaPvsVmH1dWjO20j+Q==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr50991135wrq.101.1594042430666;
        Mon, 06 Jul 2020 06:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 05/32] usb: gadget: function: u_ether:  Downgrade kerneldoc headers which to not make the mark
Date:   Mon,  6 Jul 2020 14:33:14 +0100
Message-Id: <20200706133341.476881-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects all function arguments to be documented.  If any
are missed it will complain.  Downgrade one header with 3 missing
argument descriptions and one which makes no attempt.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/function/u_ether.c:750: warning: Function parameter or member 'dev_addr' not described in 'gether_setup_name'
 drivers/usb/gadget/function/u_ether.c:750: warning: Function parameter or member 'host_addr' not described in 'gether_setup_name'
 drivers/usb/gadget/function/u_ether.c:750: warning: Function parameter or member 'qmult' not described in 'gether_setup_name'
 drivers/usb/gadget/function/u_ether.c:1022: warning: Function parameter or member 'dev' not described in 'gether_cleanup'

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index fbe96ef1ac7a4..f01e3e21ecf21 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -730,7 +730,7 @@ static struct device_type gadget_type = {
 	.name	= "gadget",
 };
 
-/**
+/*
  * gether_setup_name - initialize one ethernet-over-usb link
  * @g: gadget to associated with these links
  * @ethaddr: NULL, or a buffer in which the ethernet address of the
@@ -1012,7 +1012,7 @@ int gether_get_ifname(struct net_device *net, char *name, int len)
 }
 EXPORT_SYMBOL_GPL(gether_get_ifname);
 
-/**
+/*
  * gether_cleanup - remove Ethernet-over-USB device
  * Context: may sleep
  *
-- 
2.25.1

