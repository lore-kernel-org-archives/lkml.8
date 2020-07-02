Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B4FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F26D206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYqkVV24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgGBOqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgGBOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so27108613wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+kkMZUiAX6to3IhikTDOCe6yGlOLBFelQGfEcxa7J0=;
        b=oYqkVV24P/d5VFn+vZ+xu7zEz2T3MyeSa9GQ7xEp2PIkR7HOZmXSWQOfkdMwfoCcHF
         ML71NeDp1hvfAL0OmhVnekBhkJTyf/UBwHCpBramw4Q753VTpYPN/yq6UN4vGUP6nUPA
         gy215GDrhK3vUkq/z0z6i8XYbjgER+KlYeuFAQld6Dfh8HOex73FM2icUOHaoXcYjQkO
         yinUBmWL3w38DB7AiNpJyvnFg01Nxe0ByKys8XaXwumSrB14MyGneKgiaWXOnTYSwx0+
         EyyRZhoCTLrVExgy08RIiE5WQ12iMr43K1LrkrW8+qvyFiOIcGcxrRQ+n6MJ3wo430/Y
         5zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+kkMZUiAX6to3IhikTDOCe6yGlOLBFelQGfEcxa7J0=;
        b=Bbz05KOqI/V1nOu2ZsDS3PwPubTX5OcL3yGSoAgJznfLknEQnBjJNa/3/4Qjja+yB2
         NXwiQ/0K5KzhlaByZTn1Fu1tWnS0VKoJAawAHjEu3o56SbFtiPADC2H0rPHJRjxkYl8f
         NDfryJhIILgs1f+nYE2B00VQwX1mhbSHJeWHuu2nKZhFhuLGoEYHGwYB23uiWlJd4OKe
         focSFnlppEmOaVRRK/jwtgcvQ/8pFeLm6ZQdM5AI6QD8kv8MEho2BvsayVeaZip7CuLO
         +FFfly3U1MnMgBCcxn2XqX8CeCEJtiVaxVaNqrSr1IoEAZs1RouOzkRebFzMmdgdII7l
         Zigw==
X-Gm-Message-State: AOAM533wWYE5cYOZ1OpyqBq6w2WcMifK9Y7p3X4PEAUwJCT7Dh29/xoS
        QnWjgCdfy1yCy9MXtFWbibV16w==
X-Google-Smtp-Source: ABdhPJy7iRwFbgv6eglAJpDWU4n/odEIBwNiUgvkoNtAwDcc/kbXS66Nd69xNj3S9P4CnYRcEag4EA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr23108453wmb.113.1593701199996;
        Thu, 02 Jul 2020 07:46:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 06/30] usb: dwc3: ulpi: File headers are not doc headers
Date:   Thu,  2 Jul 2020 15:46:01 +0100
Message-Id: <20200702144625.2533530-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote ulpi.c's file header to a standard comment block.

Fixes the following W=1 build warning:

 drivers/usb/dwc3/ulpi.c:18: warning: Function parameter or member 'a' not described in 'DWC3_ULPI_ADDR'

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
index f62b5f3c2d67d..e6e6176386a4b 100644
--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * ulpi.c - DesignWare USB3 Controller's ULPI PHY interface
  *
  * Copyright (C) 2015 Intel Corporation
-- 
2.25.1

