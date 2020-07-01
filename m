Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6544C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867392082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6IQJKRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgGAQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGAQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:26:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB049C08C5C1;
        Wed,  1 Jul 2020 09:26:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so11197589pfi.13;
        Wed, 01 Jul 2020 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yT3+3I94MiU2xeUkOjL4rOEnAvL7O8po2erGdDlU2vg=;
        b=L6IQJKRN5Bex+1ICxsS4GaJwhDeuRkGxEXJX6VSNkhmQjKz+8AdWdp484EmYfOyf+d
         q+aXdv+E0K36UZHn3JKPkzL/lrKfHyynHwrxa81/dJ5vOI5E332I0z3ADKyKyv2eNxjG
         T3L40pXnE1K2TiE2qQjvN5DiXk/fo0PyAchNNcLpUdiRtfld4CkXY0/6jNhKMPP/lyEl
         Qzfq89z8YHXz7ndsSS7b2rdEgHDVfY2pVQe9M7wnKwIKulekmMT/liu4/WLeaXUdBxXA
         pJP0A/s/dbrXWyEY7LtJiYu+I68sVnWxFOtgYyDpy+CaLwgL0PY6qjAL1rAivA1wRbzd
         IKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yT3+3I94MiU2xeUkOjL4rOEnAvL7O8po2erGdDlU2vg=;
        b=a8j3A+2DSHKp6ORuKdK4tvl605E/XDwcSYAolFm9bVB1LT/0UvqTokzVI5GMkMJadZ
         4OqHsWQxNmHHI9SugQ3Ubcz1iS+mr7gPGB5Oa0YmSnZDeYK/T/LXv3tUdo0Kogol+Pm9
         6BHcxH6XRPRXZA24kBKq+Zob+nkOakzCJr2XcM2D1IyQOH+Wazh/55xyY9+/lzPHGRpP
         /T7cVZXJlW7YPAwlo+7gOqkZ12M7UoNgWcCS33Uc3K3t2OPuOhU6wXFeeRWXXc9nto0f
         2IWCdm5Vwa+eu+W+4//Sk7aAvgjmmMS6WX2d070nVsBBfq6uOAqQyUl4QNX/ihTaog5k
         VKwg==
X-Gm-Message-State: AOAM5313n6Zs5dYz8UNOGARkDbS/86s0Coye3UxB8xsnaUPWS7zQrhKJ
        hMrPYK86VPUpVRD0MAsjo+w=
X-Google-Smtp-Source: ABdhPJwfF8cfwkOzhvhke+sEfQ+g8LKGAWYx7wcI+wwfhjBxFtPsxrEZ0E/jJm8Dv/w8k4h4FWiaRw==
X-Received: by 2002:a62:7c97:: with SMTP id x145mr24831837pfc.80.1593620807271;
        Wed, 01 Jul 2020 09:26:47 -0700 (PDT)
Received: from haowenchao-ubuntu.lan ([122.96.73.106])
        by smtp.gmail.com with ESMTPSA id m17sm5435784pfo.182.2020.07.01.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:26:46 -0700 (PDT)
From:   Wenchao Hao <haowenchao22@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] of/address: Fix variable name in comment of of_iomap
Date:   Thu,  2 Jul 2020 00:24:44 +0800
Message-Id: <20200701162444.9494-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first variable name of of_iomap is np while previous
comment write device here.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..381dc9be7b22 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -864,7 +864,7 @@ EXPORT_SYMBOL_GPL(of_address_to_resource);
 
 /**
  * of_iomap - Maps the memory mapped IO for a given device_node
- * @device:	the device whose io range will be mapped
+ * @np:		the device whose io range will be mapped
  * @index:	index of the io range
  *
  * Returns a pointer to the mapped memory
-- 
2.25.1

