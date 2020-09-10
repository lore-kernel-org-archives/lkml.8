Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3CD20732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SWh+7q5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgIJIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgIJINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B438C0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so3835822pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAb0icg43EEa3jdEmSsHOW+v+kMmzAcNslMsiamSuwU=;
        b=SWh+7q5aZXA0UA+wMOe0IWNOyXf9cW6ZIzJhmPlpZt/8LYchDMHJ4E55UeeWCPQeRE
         pcZF/LWx+YGCqdj+7EI0Ka6+O1d/uB/jFtq1kUPtL92l+R8h3TlQSU9Ltmp+rlWZrwHB
         zheA09+GSA0EHOcOuraz6sHIHvL5nVlfLXw419ukf+ldTgzoa99s5rtc//A1W+IV9xkI
         uqizFwfAjpbkuVgENv4UOIF/nf6YHq1rR/a269ZQ9SeN+dpW35gl+ul9CjXv9MWkcqLu
         K58Pxa/rYaEYqonO/QPemK7twHr4d+sfX9T2JZ7PyzZxWkFNvUCmXBzhrmxLYuX3TMTB
         hGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAb0icg43EEa3jdEmSsHOW+v+kMmzAcNslMsiamSuwU=;
        b=gLK7jpsLGvyMBMVlIJQN+r8srooq/kEe4E3JPvauBR89+lJVdny4VJ8HuzaM4QwWwf
         EfzXjwNXNuAH2ree0IqcQoMKcm2yhpzb1wQOcralZLrwTFFeHRO7GpGHVcEXTNLTPKr7
         sbzdkqMlnnikFhLpcREIQLwemSl4cyZJRqEJ+arvqDnfZ7SOMSSkg1H42m+xVY5Rf5p3
         3JAa/SDwcVn92LbfBLZMxuZYhBUUkyu10FTdQHdBsN6OiGwm8tdS+Yc+dxPZg1jEERV9
         TTFranl5ClnBvrL0mjH548EDxlKyixIGujc6DxJWZDTYfypurd/SHwGkBAWEatk207j1
         pYvg==
X-Gm-Message-State: AOAM531HQUIZdLlSu1Z1SmtWhzU35Lcn4MHnVcTJIns7Yr6pKsCwDHX8
        vhG/XepSPLYQnuyDlAL3zVVUlK5Cc3c+lq7s
X-Google-Smtp-Source: ABdhPJwrj9Nc4rf0Ljpa5qH1u74Pr3vrzXhhTgEsS/NeaIisyiAEHis0bWt55UfGjrgVmtqXKOLyUg==
X-Received: by 2002:a62:8806:0:b029:13c:d37c:5e47 with SMTP id l6-20020a6288060000b029013cd37c5e47mr4423007pfd.13.1599725598631;
        Thu, 10 Sep 2020 01:13:18 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:18 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC PATCH v7 20/21] riscv: Allocate space for vector registers in start_thread()
Date:   Thu, 10 Sep 2020 16:12:15 +0800
Message-Id: <1b09427788749bf7b5e35c771657661bd7165348.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allocates memory space for vector registers in start_thread() instead of
allocating in vstate_restore() in this patch. We can allocate memory here
so that it will be more readable.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 7 +------
 arch/riscv/kernel/process.c        | 8 ++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index d33a86a48f0d..58898d33bf28 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -98,12 +98,6 @@ static inline void vstate_restore(struct task_struct *task,
 {
 	if ((regs->status & SR_VS) != SR_VS_OFF) {
 		struct __riscv_v_state *vstate = &(task->thread.vstate);
-
-		/* Allocate space for vector registers. */
-		if (!vstate->datap) {
-			vstate->datap = kzalloc(riscv_vsize, GFP_ATOMIC);
-			vstate->size = riscv_vsize;
-		}
 		__vstate_restore(vstate, vstate->datap);
 		__vstate_clean(regs);
 	}
@@ -122,6 +116,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
 
 #else
 #define has_vector false
+#define riscv_vsize (0)
 #define vstate_save(task, regs) do { } while (0)
 #define vstate_restore(task, regs) do { } while (0)
 #define __switch_to_vector(__prev, __next) do { } while (0)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index fb485c9bceee..009ab4849fce 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -84,7 +84,15 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 
 	if (has_vector) {
+		struct __riscv_v_state *vstate = &(current->thread.vstate);
+
+		/* Enable vector and allocate memory for vector registers. */
+		vstate->datap = kzalloc(riscv_vsize, GFP_KERNEL);
+		if (WARN_ON(!vstate->datap))
+			return;
+		vstate->size = riscv_vsize;
 		regs->status |= SR_VS_INITIAL;
+
 		/*
 		 * Restore the initial value to the vector register
 		 * before starting the user program.
-- 
2.28.0

