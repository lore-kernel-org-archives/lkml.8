Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B7BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949F52184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2CIR5df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEBE3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:28:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF29C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 21:28:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so5533429pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QoY6NuAT/vtfmoytNr3fNpL4SjPDh/q4KrkvGuETEeI=;
        b=S2CIR5dfRAeMTD5/O6ohPQeT37++k1qHB9i2UXd+4z+L51Qfm150t7EABeAjA9uCap
         kFsyRBu0TBKuYULnhB1+YWEi4+mo2CA0gzafkKnnJxQ23DdTKvyzivTUFiqDR1SUVk7j
         CrUxvHl10pjKpWYcgF7vxg+p0tl96eFyxEZh4POPvQK5q6eYdMfa0/bt7khAGZQLphOn
         hhscCjyFvkmeG87zi5x1QyV8d/vUFE7NKuHSm/jKBwkKbmNTf22/OyULT82sLxr48U2Q
         zCJw2i66VFLSL8tgfmH9wmW+EyRo12SeNPUdNC08dh/N+7Gq603h0QBDduE+RIwsT0y4
         /1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QoY6NuAT/vtfmoytNr3fNpL4SjPDh/q4KrkvGuETEeI=;
        b=ShShrgAhxuEEbM7QMLzctbXoF5XV3kHGec7NbyS8FjXrUM5EPTZfmei5lDJPc/sFEQ
         xMRC9aBMTiV31qpse88+EP/BcrZ8srJtnbsaE5tIosKLzGNUyJn5/L7yjCry6Mllzsyq
         TyOi+rqs3B2WZ9HZ4OJF4XA+twJO/LmBR0cWONagiXVJ9ymyzVl+QE4QBoB276KdsK+C
         R2aEMLq45M2vn1leW1HbZj8IP0OSHEaGBGjJzIXYgWcJSvq++BfQnRzGrMRherfMS9IC
         xLiSDvUE8YevGi5B4IVyLaZ3nY/U07SFIgdCCt+JuomQmvMzK4JYE3b+jwXlUpAGNCNi
         qkjw==
X-Gm-Message-State: AGi0PuZq7ICGXFXTdXXyFLleC12WZbgGGv5izVROxNNDXhO+1wltzq45
        2b8Im6/qMxkRmGHtmMW4hhV+1dLP
X-Google-Smtp-Source: APiQypJMDaa8Hq/Ud0P/Mr/ErtBfUjYMXu+r/tWaElslWPw6CY0/HG+cTpaUWPuP+1ELtPgK93X6kw==
X-Received: by 2002:a63:1a16:: with SMTP id a22mr7397389pga.264.1588393739396;
        Fri, 01 May 2020 21:28:59 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id q14sm3130682pgq.60.2020.05.01.21.28.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 01 May 2020 21:28:58 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] powerpc: Drop CONFIG_MTD_M25P80 in 5xx-hw.config
Date:   Fri,  1 May 2020 21:28:54 -0700
Message-Id: <1588393734-31734-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Drop CONFIG_MTD_M25P80 that was removed in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/powerpc/configs/85xx-hw.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index b507df6..524db76 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -67,7 +67,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_RAW_NAND=y
-- 
2.7.4

