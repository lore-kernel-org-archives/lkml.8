Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C442070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7KtGYdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgGFNeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgGFNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F849C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so29668746wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPVZRZLDqwpPhO4RC/GUsbLkf95aQVfMZw3d44goLsA=;
        b=e7KtGYdjynUM1W1lVC4D+RIRR4fBD8poghJ6q+calXuw04pQafBm+5FCXwnEGJDTjX
         BDzvFqtTHsd9hwMREut6OdZzkcQHEC0l2dZjb9VdPRyWH2aZ5LABMONQ2vCB9wK9tp1E
         zEM6m4tqjYBKq8REuplcACGfj3pwaKAES50KYRAyjwak7AC03Z7nKSoYgGR4tClPuoiM
         +CxlNKfmQVhp8aKa3Hs4YubZpnJHKn5GFtivVZFBW6CY5w0GlhBeXoh2rigyRtBmRuKn
         ZF7+SX/Ys14HAbuDA36aa4fev+VbZ5zLdYDDq0g5UecpKwPDPbJBaNBfdLa8wx3hwrnU
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPVZRZLDqwpPhO4RC/GUsbLkf95aQVfMZw3d44goLsA=;
        b=dLpooMT4tsfy4BkLoIwkhGySD2Y1VhBb7KbTpxDkqMILCD+EMUrFUGvOi6VdGb/Uwh
         4Qvzxgm04zbEjos1/YtwahmXvGaLbq2MKOBAuI2Pttf7SI4QtwcOEG1fnQErCTEUXLhi
         dmXfHfzPn832G3zj83jX0QCZVeJMW2cDtJmalOhDTOoz91coQayKIuuyJ0Q4mL23Y/jk
         HJAgejooZGZfOH0qW/TilN8t2lodUzN+TDlV0RKFyd4xK5WhzV7VioTdATrEykj8EFoG
         0hLpb+v/6IU55i0B0eGYGDiZlpnvhJnNqQNvE/a3JGSshYKIku4vEmmNjay0hjHbXWl5
         1NGg==
X-Gm-Message-State: AOAM532Is2FSi9eLcoYuZ3mRcLQjUOF4xNfMgeqRV6PvjpHm2A8QK/XT
        oq5USzaiR7hQLEXWjrNFilMxWgAMWQk=
X-Google-Smtp-Source: ABdhPJyAcv25bdv6OoMfwgsx5XUgRwu6m6klXGx12+TUQBLMsDvexy8Kv11aX3pyM5ps2Xh49QyLrw==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr48983261wmb.158.1594042456784;
        Mon, 06 Jul 2020 06:34:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 27/32] usb: early: xhci-dbc: File headers are not good candidates for kerneldoc
Date:   Mon,  6 Jul 2020 14:33:36 +0100
Message-Id: <20200706133341.476881-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote xhci-dbc's file header to a standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/early/xhci-dbc.c:10: warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index a9932c1ff20f7..c0507767a8e34 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * xhci-dbc.c - xHCI debug capability early driver
  *
  * Copyright (C) 2016 Intel Corporation
-- 
2.25.1

