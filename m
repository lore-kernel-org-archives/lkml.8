Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6275B206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D272CbLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgGBOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgGBOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so27118183wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqDEsV0Ck+FNcXivlLFCVSGlGxhukzNkii5C/yRAQ+E=;
        b=D272CbLlqYE9XwhTGGNkOy3kKTQob4ZwxsVME5EGX5gMkHXxZcrMA1pMr8s9YEl6MV
         PGGJD1O6CzfIreM5GJPlte1v7+CCoZ6DW5if1ZQjQbLpw0NMcNcxUqFggpHYGovppt05
         Cwx8Zkwsbkpf35qf8zMBgrMa4evocB4C6NwHMM/guVMeL+4hjxo+Xg+EXB3bMjlt3l6j
         QE14ppYiN/fYozy+KORlSqwt2sa3qJRfhpq5gSM91UDZ0cP+tWUmsa/CuiQ3k/uaGsd+
         FLaClHPAo2mrk9SSnnR1xL8UXMJp+fTT5P2nNXpna2sBIAUz6nMX8ImmgM8fZBOW6cyG
         BYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqDEsV0Ck+FNcXivlLFCVSGlGxhukzNkii5C/yRAQ+E=;
        b=qJN4z7cutDpmmOQ3OvwKlu79cGEFi00NNY706srQfO0/ZZUSsQCFHLTMRr3nwzJalh
         Ev5f3JP3YGHNFKH2ZRzNSla2XNObDkXm3tjEV5kiNMpYddGBfUwA9kuGRTJOulHHMPho
         ak5d7WTzSkZgCRia7kVIt+F12IMm/GXs7/HpKGbt0DY5B0UQZsRWAivv8gA0uiZiYgPB
         rvLzezKpUyz0E55Yob+M4TkAmYOuStdVUo7jzz+H5Vja4ONHuU+vQ73EbR2ay7WX+KJF
         xa9DYgumOEQNi4SLbizMe4hPNzsZp9oQleU02JcX5mHCKQdID1zArpg+1TikrWcGP917
         cqqw==
X-Gm-Message-State: AOAM530ueWVHMabHJlWY5GfI95avbzrGbFeqwJ7WuwbcWgKK9jz7GuiQ
        zT7tkA9oCul7oYPX+JVUgwyBLF+eFgU=
X-Google-Smtp-Source: ABdhPJzVNf36Ya/k9DJuBz/EJ9+MpHowcfEHl6qa1yClZCcdX++IxMz5yyGSGjVqzQDKr0VxrpsqQA==
X-Received: by 2002:a1c:81c1:: with SMTP id c184mr6925584wmd.120.1593701207158;
        Thu, 02 Jul 2020 07:46:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vikram Pandita <vikram.pandita@ti.com>,
        Anand Gadiyar <gadiyar@ti.com>,
        Keshava Munegowda <keshava_mgowda@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@nokia.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 12/30] usb: host: ehci-omap: Provide documentation for ehci_hcd_omap_probe()'s arg 'pdev'
Date:   Thu,  2 Jul 2020 15:46:07 +0100
Message-Id: <20200702144625.2533530-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description for 'pdev' argument was missing from the function header.

Fixes the following W=1 warning:

 drivers/usb/host/ehci-omap.c:87: warning: Function parameter or member 'pdev' not described in 'ehci_hcd_omap_probe'

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/ehci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index fc125b3d06e7d..2ec686e28582a 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -78,6 +78,7 @@ static const struct ehci_driver_overrides ehci_omap_overrides __initconst = {
 
 /**
  * ehci_hcd_omap_probe - initialize TI-based HCDs
+ * @pdev: Pointer to this platform device's information
  *
  * Allocates basic resources for this USB host controller, and
  * then invokes the start() method for the HCD associated with it
-- 
2.25.1

