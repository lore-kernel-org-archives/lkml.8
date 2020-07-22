Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D2C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1735D206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7aq8fvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbgGVKIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbgGVKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA3C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so1435235wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kjUkHtDcCcK6X3lcdp0oDE4kEaghLGwxjbrp0zS7eY=;
        b=Y7aq8fvcH9bhDdTABlkI4ELEdXAIfElmNMzzN/s61XRscYSH/8SNUVUrPyB/APFOlf
         DvMl7rIhjZcfc9+DUGvfqYCQBZlzRZVjowpwFikPY+U0uqTGuq/KLY1BooEjuRO2OU++
         75utPbkL5U4MsASmnHeOk5T9UdbdDmlffvtVZen3AIfcmXUasMHm+kSD94xcLnxsGdhF
         LHGcUc356FNrmwk88HWt4toaPcwxL9PEFuDwoqlptuCgxpphvPPJJe7GoBwbT0WVvpMC
         Ju4Mk3hzmIOEhmS4USlvmrpHBpdsGDTQbkUjCqt5NMp6HLcoSDc/qsJMzNP7e88HS5+7
         GiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kjUkHtDcCcK6X3lcdp0oDE4kEaghLGwxjbrp0zS7eY=;
        b=VDHz3obUiULXCPV/wKK61z/9hj7MTwzqjxlcUhjTgg5L3K320/nla0ZD0qSe2OfeG9
         +sWI9IDTDZpWojACgwuP9rYRT/Cu237rivInuItxBuxUxLtO0Kz2bJuB5U4sYZPEAEV5
         cquI5BsptAruX6KP25fk24m8Jpx1JCCV6CpSEbY6Cjsq5LwrjQZJXjlut+v2i9lDzoQB
         e+4T4aOCNsb0MxOblxN6SszMoKy55nChdEBTgI1WhlMvM/W55ocyCo12XQQYYUjGK2+M
         jOiaMx1XomU5CvzBm/CCIyG9ftVwIpdanZTiFr6ODAJQj8mavvrbyTpQs0xxTKLLznId
         NFxw==
X-Gm-Message-State: AOAM531E1jzUY9t/Tb2SiAhoEsOoNp6zehWg7tx7i7oAUF47ZyLp0sxd
        ldd/KVbyXR+DJ2D3nfOXO6GHtg==
X-Google-Smtp-Source: ABdhPJyRJS1EXlgp9SO660JvJMJ79TtJnubvVy7v++KqKCA+ymu3Xqf5R5xc25GPFRgoEbxM4hGE8g==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr8196001wmc.45.1595412504184;
        Wed, 22 Jul 2020 03:08:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/14] nvmem: update Kconfig description
Date:   Wed, 22 Jul 2020 11:07:03 +0100
Message-Id: <20200722100705.7772-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

nvmem can't be built as module anymore, update its Kconfig description.

Fixes: 2a37ce25d9f2 ("nvmem: disallow modular CONFIG_NVMEM")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d7b7f6d688e7..954d3b4a52ab 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -7,9 +7,6 @@ menuconfig NVMEM
 	  This framework is designed to provide a generic interface to NVMEM
 	  from both the Linux Kernel and the userspace.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_core.
-
 	  If unsure, say no.
 
 if NVMEM
-- 
2.21.0

