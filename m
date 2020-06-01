Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68448C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3225B2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FjlX1hn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFAHLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:11:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:11:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so451816pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKjq7JVQi9c3OduMp9FZVvm0r35l1D6YKepPhBnED00=;
        b=FjlX1hn9EWuUswEHSwe6ZYYboeXGzLPmsPPvER9nDXPbgjk20RUrOVHP9JfQTe6Tyj
         G59pNp33ESW01PrIqES4+XZWq0p/dTQomuutAx8jayGl9iBQiLxmBO0Dg7zIIyTWR5qY
         AZJm29QVk1kivuvJI9dBKjr3an4oE1haIvhP5FvfAST/TKDgaQD/e4cTCzRzeSsQ5ERf
         aAPaSus6xx5HpvGFuZ50s/E/m9z33CSHtgpKmtRCmmaMIfJqSjj/C9AW7FZ3RTcWR4qv
         s3/SLBL6WuWfkNhmGxplhdGkot6RupLBCjHi5retEK202lSPTAezVNJqG0cOOUH3plZI
         tjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKjq7JVQi9c3OduMp9FZVvm0r35l1D6YKepPhBnED00=;
        b=U0Fo8QEyyt0X4SqGwW9SMAG4DiOEFb+/Sd7ziUp6yDN2tYqFTnKCbs32FUvyrTQ12K
         qERwjpfAhPcFj8MOVoWz4ZhtejsXSDA7SJR0BDeCnfhcUh39NuqAE3lSC8WQgNqeWO4M
         HKXEJ1uHaNXDvCLYr5P4ZHsd4d3vjHd7A/IogLTXhVxP9BlfQY7nhoJBx8xc8+pFF4nC
         3aITUrxpa80KthfS1gNBnM2JOXWribxm2dzd8AjeeS0WySGKro+8+z81MPcS2U5mEwkh
         hTWQUGaPY0MOFEx6PMi1gNQ3q19UjMwJW+xp4fwHsapkz/8taBBi6bB13Vt9uefG4Z8r
         NHZg==
X-Gm-Message-State: AOAM533fnj3JKj1VSQq4GfHYuvpNNwWy/9toYrpH1IAye95ERdaOicFY
        ezu5JMwl+3V+uSEUGhkPBdNqPw==
X-Google-Smtp-Source: ABdhPJzsJ4Hzy3IdeHseSpUPWtiXruOiOYWXnjlmGwrUc1ACKSCLnc2ryE7yAWbXh+0VcijcszGCDw==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr3981773pll.43.1590995462096;
        Mon, 01 Jun 2020 00:11:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 3sm3035593pfe.85.2020.06.01.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:11:01 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] riscv: fix build warning of missing prototypes
Date:   Mon,  1 Jun 2020 15:10:58 +0800
Message-Id: <29cb3d8c72db7fe36507f487a71224b812805197.1590994864.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing header in file, it was lost in original implementation.

The warning message as follows:
 - no previous prototype for 'patch_text_nosync' [-Wmissing-prototypes]
 - no previous prototype for 'patch_text' [-Wmissing-prototypes]

Changed in v2:
 - Correct the typo of commit message.

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

