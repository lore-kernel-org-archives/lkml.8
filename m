Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE29CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C074A20C56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kh13Uagu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGCRny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgGCRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5026C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so32754328wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ic4rIp6i7w+ExunilNL5OmgeWajYHUPztrk1dypeX68=;
        b=Kh13UaguKQVWZFolCXDG/NLuzB1QO3j36+LCgHs0O7rS+7DqMoCuWWNcQ11blivh+9
         dmI7sC/uh/PeO3GdENZNw361HKDmGWW249ewSbEtsbmiKtrKmSGSA967yvwctkeGD2Da
         VQ1SEwKsnpSDkC/rvNDOTjd9yA5gsSNcV+5uECRNmdRpH60hkKMAvdMXpMUbCaZlUx9C
         ZwGVg4SIA/ENzxh+txpPPoOGa7sRuj2rJyJrywTxVAIHqAJeWZG72zTo4ATX+cVf5/jP
         sRPxQhFwld2UHWmSMu/iYzjgb9dHOG7zTYUMLIcDSGW/lq6c6c9jCPdi1G/4E97SPsN0
         8LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ic4rIp6i7w+ExunilNL5OmgeWajYHUPztrk1dypeX68=;
        b=WD78EnrePICeoriCbhM92GsolCFfz2UfQ+fS/BAj08Fwu64thLoBBf4m+dUYY5Q/5K
         HisTEkE/bJfcaME/Mmj0VXwKSyTP/Lw4PT4bGQStNKTqR7x4A4xMoZeNLF7fqAlb14HF
         rZVBRhauWDXkqZW1sCOJHEz8w6UlUhoKG2B0a+j04Z90ovlxtTCcUvZujFvLR41jEdmW
         WAaXN/M4KmeHkfRJobhp/JIK17taoOq78+cMncXWNBz3Jo1ad0gz376753kk0yWcSDvC
         4VauZRleCmn/ZUsW8h3rF7ZxgggocA2kC9y82SeuGs9oMz0wVUMKOG9SUDYBo4z6DN1L
         lPlA==
X-Gm-Message-State: AOAM532HDYfvuDYIPJX8BtxfI2oVU7cVdBm0qTwFFtrbFexs3aBCiGhk
        IHJE0uSadrtdkIY8M9YeIUm06A==
X-Google-Smtp-Source: ABdhPJyTuGeahpIZr9wBtU7PsnWawkpr7E89M9tw5DuGJg8R1ACU8WRWAMYfSi26BXhuCQn07ZcVLg==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr39576677wmf.133.1593798160504;
        Fri, 03 Jul 2020 10:42:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 16/30] usb: host: xhci-dbgtty: File headers are not good candidates for kerneldoc
Date:   Fri,  3 Jul 2020 18:41:34 +0100
Message-Id: <20200703174148.2749969-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote xhci-dbgtty's file header to a standard comment block.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci-dbgtty.c:19: warning: Function parameter or member 'port' not described in 'dbc_send_packet'
 drivers/usb/host/xhci-dbgtty.c:19: warning: Function parameter or member 'packet' not described in 'dbc_send_packet'
 drivers/usb/host/xhci-dbgtty.c:19: warning: Function parameter or member 'size' not described in 'dbc_send_packet'

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci-dbgtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index be726c791323a..9a1d384425782 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * xhci-dbgtty.c - tty glue for xHCI debug capability
  *
  * Copyright (C) 2017 Intel Corporation
-- 
2.25.1

