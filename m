Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0FE206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TOAw6Ras"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFADzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgFADzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:55:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBFC08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:55:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so3695690plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w12OW+K+I9R5NQdCthivkvKzwtZ1OoRyTY2uq+lN4c=;
        b=TOAw6Ras8RSROXZrvTynbBHkwYdZDYCIQ0AF0pgOqIdmv68zyzPORgLOLu2ipxfTZ0
         7KX0GPPnSFhLHgqp/lzPw6hVkMtQY4pfn22MxWDJ6RGLqPIuPbTOk66wOO+AlJum85Mp
         JI+S5i8ll5ijMMQpZ26/hr/vfl4Xtic7s11vfc4BypLV9XZguFEnn3q1txXqPykVLwW8
         lffHmMtSBSS+LkZDt8A1D0MgyGlyhVNXGzQxiT2NjLHVZh3Z0LmNgnEZaYz3cyspfcKg
         nT6b/AmmkZLPVL4cKjwB2cz6JjbcPNQp2yKR6Hv/TKZ8tU2J0MJrzRhluua/M87DnM7I
         1IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w12OW+K+I9R5NQdCthivkvKzwtZ1OoRyTY2uq+lN4c=;
        b=GzGtk74mrI+fuPuMH0exF7O7UnrOrp4/0v7/tYGMSdLr5oZofU2njT9Q8Q0A9eie76
         65HP3lgBbujNC2luPddt5qi3R92eZkg0pyqK912FhDdrcjjVVB6CIlzgtHkb4uabHfSG
         XetEHQxhqfmencNx5xQr/xAhYtbJv8clIC0UpRZni6VZRAO9gwe5hPpPDAF4IeyTwApK
         R5aoOw3BF649dC0oVdxd+o9us5F5SK9zofLgs6qv9w0O/Iwr5Xk+tsdQDr7vr43r6hs6
         avN37+JEU2KyEj9ApmaileOazZwJe8rD7xxO/cdAvGFOtpGPDhxBVDLyArFWwfmFOMHL
         3h8Q==
X-Gm-Message-State: AOAM531R5dep1FcJP8g0tqJaX1mo3NVKe62pX+HOUcT1BSdRGxQvgOIy
        QK9RURhakH93Ahh8MmDH00H55w==
X-Google-Smtp-Source: ABdhPJwAX1BkjToVS00l+gu6Xb0uMQbR12tT9R4btFlIsvOg3TtBEMFsFfCFvcp7IC/LYh8Kh0Ot1g==
X-Received: by 2002:a17:90a:de97:: with SMTP id n23mr20754832pjv.164.1590983738977;
        Sun, 31 May 2020 20:55:38 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id x5sm13166841pfo.8.2020.05.31.20.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 20:55:38 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH] riscv: fix build warning of missing prototypes
Date:   Mon,  1 Jun 2020 11:55:32 +0800
Message-Id: <7acb6dcf9975bbf3aff4be3b01320fd1b5ba30c1.1590983619.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing header in file, it was losed in original implementation.

The warning message as follows:
 - no previous prototype for 'patch_text_nosync' [-Wmissing-prototypes]
 - no previous prototype for 'patch_text' [-Wmissing-prototypes]

Signed-off-by: Zong Li <zong.li@sifive.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 arch/riscv/kernel/patch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 5805791cd5b5..d4a64dfed342 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -11,6 +11,7 @@
 #include <asm/kprobes.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
+#include <asm/patch.h>
 
 struct patch_insn {
 	void *addr;
-- 
2.26.2

