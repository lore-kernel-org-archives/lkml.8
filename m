Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB016C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501B2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTpb8B/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgGAIbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgGAIb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AFC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so14820976wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQGzW5dI+CJY57UuhEAmK6g60SBrVTGRjgbtv0HdhAY=;
        b=QTpb8B/buegH+6omxpYaoAObszOPgF7xUMlbSW0UDKpIXPfAygnrp33VIpquVvoegv
         aCPep4Qoq3bIoi9jwJQDnYPbgoiXGWacaD/Argorz0Nekv0eUjpiao0Y3ypg52/zKql/
         Rnn2ZXLrfM4AEzfPwjJ9sccJ29ChmQIya6PRQn0C4/W7IWGFekPoKpcBfRkHPaHrovyD
         Z+/NmBf+8ZOk6vN15REkauAo5fuSoPCQ3LdXrYfDA2BRv0rGjWdCpXHbr9DN0hYjBzVA
         HlbTht0DY48QbaElngIUwGOaZfswS4EL3dOS6GiK6Lav+QQcCuo6duN4owle0LQLHC/a
         sXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQGzW5dI+CJY57UuhEAmK6g60SBrVTGRjgbtv0HdhAY=;
        b=daHeM6E2Ps9j0Cjlez+CqNqd/b/WA1sji6kXjt/VuWrcBEOvOJg9Dr6xMBIfBuIqNr
         HOskUB34bZlXengI+r55zMmxkz7Gd5O7MAEWls1tn4YskJo2wZy9T0kA6VYtWvZbuXY+
         pNFu22kPGLrggWRQRANK06uazCfL6ETISfMTub0GkiXhVxXMdVSMqGKNtj/uDfp0+Df2
         lp5csYxY+7mC8WC1yothBEqbYVzxYcTFTEuGOHbNQnKjKdwArIDYF3O1F3cLA73yIPwQ
         xITrTdhU8dKSNWaUnN+X2WnLUeQQrDCWsylqIPG1VtlXTMgBa6hTKrBoMmj/YNnLUE1U
         vehw==
X-Gm-Message-State: AOAM531pgA1UtmuPMNiTNecOOf7o3pLfzuB1PaUhJmmBN3IYGXTunHde
        Ylotco5gYnh1yf5RwwxZBz8e0w==
X-Google-Smtp-Source: ABdhPJx5r04ELeAmRfKOhnl+9IfC17CSfM9WTFiXGvrQFe/oCg5kSBRL0G1ibSvTibPuv85/+jv9Yg==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr25133148wrp.127.1593592288154;
        Wed, 01 Jul 2020 01:31:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH v2 03/30] misc: genwqe: card_debugfs: Demote file header from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:51 +0100
Message-Id: <20200701083118.45744-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc does not understand file headers.  There is therefor
no reason for them to use the syntax.

Fixes the following W=1 kernel build warnings:

 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 's' not described in 'dbg_uidn_show'
 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 'regs' not described in 'dbg_uidn_show'
 drivers/misc/genwqe/card_debugfs.c:30: warning: Function parameter or member 'entries' not described in 'dbg_uidn_show'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 1b5b82e652687..491fb4482da29 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
-- 
2.25.1

