Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3101C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13DC20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWtrvpy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgG3LsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgG3LsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:48:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E2C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:48:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so4365304plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cHwrga8ZPutMLta5h4WnSYiA2AgMvAU+ca3QAS5wzo=;
        b=QWtrvpy4RJfudzoUjH2QqEy08Xvj40eNCPL/Ic+sIFsBkTM4TMCOlkDdXPtK9kZEtU
         hCmO3pnfQ/VvcT2FP8sIxt98W6ENjthB9htB3vwJiGftoLFUzvRfRnKyHiaCopVi4by8
         zoDgRPe+KKd/mH/ydTuc7JcG11aeznCyMuSdZNLwlrYPIzyuOj+5oKjQS+qa0rIpiT5A
         hG0xYa9OTHKey/Q3TLOv+K/e9mWdciv+YMCN4x3/UtAmAFwqrZqIeetf3mfZw0KEwX2B
         6astATArVcpomNsB5Df37IFX2OCilPOS/8s6cL8zCwmiZ+tTgtpAnLC9E3TWy3K3rt6+
         9ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cHwrga8ZPutMLta5h4WnSYiA2AgMvAU+ca3QAS5wzo=;
        b=K9azvl6EBNQgolBOlbwopX0l0Fz6hdGeaBf4IJaDOgn/CeIXsX+KBGq+Zv0K0ybScA
         ZdaC2ovN2gDlRbgc5ayeDN0Z+ormF3WmwSOaEFdtspkViajR1vCZDTEthebLk4sCQTq6
         pLosqeW1clTBjB9zGiV+UkPx/g/wR7ni0/SOqp5+h9PmDutLyzL9WjkjJysLzBuLSnzq
         neK5Z1z48zT8AG/y4XBcujB5dPne0TzdPn/5ujf9M046EZ/sEJbH4JN+7EhjiLcwz5dI
         sV2AAB17uTPHVKDDmZXwezgJz0YMkqFqtDWorb+DoDUxdMbuBujtkefQPLXr8rvr7/U6
         tz/A==
X-Gm-Message-State: AOAM532q2APsSFdxmENHl49GasuLXpdJDaB8vkcMnowmlwXVpuhnZ0vf
        1j+asa9nuBQbJXGDuEDnXv8=
X-Google-Smtp-Source: ABdhPJxfzoSYziBFoqPbvBUoEyZdr6hDEwHo9TDernIxclCEWZ4L3L3ndnFzpdc6EnmbPUi6svPuWg==
X-Received: by 2002:a17:90a:ce8c:: with SMTP id g12mr2776741pju.23.1596109680368;
        Thu, 30 Jul 2020 04:48:00 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id f131sm6062451pgc.14.2020.07.30.04.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 04:47:59 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        james.morse@arm.com, peterx@redhat.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] arm64: mm: add message to die() in die_kernel_fault()
Date:   Thu, 30 Jul 2020 19:47:57 +0800
Message-Id: <20200730114757.13592-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Just to identify the kernel fault more clearly.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8afb238..3a753c7 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -289,7 +289,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	mem_abort_decode(esr);
 
 	show_pte(addr);
-	die("Oops", regs, esr);
+	die("Oops - Page fault", regs, esr);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
 }
-- 
1.9.1

