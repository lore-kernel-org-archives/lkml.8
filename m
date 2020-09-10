Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520F5206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WHTQkR2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIJIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIJIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45172C061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u9so541349plk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oN+QKPnmXHJNU9Rt/XFHKzinb9hEvSmeD5zS4UVNEOw=;
        b=WHTQkR2GbWTY7ezVaVw6Q4mO7yq0QVy5lXuFl7+hMYu6bAW3RxsilKg9MV5PRHpDh7
         UcULnH8uS7Hj9ffXe+b0eQmzmGwuf2IPSGsfFPbwe/KybR3hPJZWe1+mP9nKO9rcKje2
         Dq6y45cQsRbXhQ+3JTGxhiHgfumIfttIAkSnwEeuJUpHLXXZcOBFLMqrDQ5dS89m9uGG
         YxJVP3ro+9ShSfCufDMdWIs2v002E/nMPyFs6GWS6uZJlM7EiOGIkSBDG3SN11LrjxVV
         hDpSKi4qKVguaKRYQtzzmI92CwkfoOdVO+5KhqS+oL9QA+e0Op8An0lD4+iWa/1Yd5eS
         s1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oN+QKPnmXHJNU9Rt/XFHKzinb9hEvSmeD5zS4UVNEOw=;
        b=PMNL+jZ5AdgyZJjELpGW/8zo6vMMeBqKLyC/DSzB3wNu4CAy6oaRQZXnfLDINmZurx
         rjaWH/Ct2hm7B/hTjFmHyWaYFujK3Wc4me5JU6kC20IqsItdI2xR4mmULaG4/vjC1tKq
         80epYDCu2nxUfD5vWLC+BgQrSQ1X1x/Ikus3a8fK/XcSZ1Fm74Ol+yD35fwKJiFQzDuP
         87VoHdLMEb+w7Cy6DlyEsEKYZniOchgyAZefOd1mY+Gnjy6av093YHhQbGDUnndEwj5r
         33gsPhFOutDnKF7zUM98a/nWOU/UrI2/W0F+9DuDCVwKl2TaHlFsjRKVC0af24RcUgmP
         xALw==
X-Gm-Message-State: AOAM533A4Ft8oW/AHZqfM9hCBe29ACsjL6kwP8CEjc70mgvxiRKctpQe
        xsDfq6A/xNQ/PoLxiCkyhbwovw==
X-Google-Smtp-Source: ABdhPJyILUD/Pd16VoEWMyh4tq4Ry3gJtYtjHqUZgAXE7gF0PXLHCvLqqu6UWWWIFZK8YkidXbA1eQ==
X-Received: by 2002:a17:90b:d86:: with SMTP id bg6mr4210178pjb.155.1599725577813;
        Thu, 10 Sep 2020 01:12:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:57 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Nick Knight <nick.knight@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC PATCH v7 10/21] riscv: Add task switch support for vector
Date:   Thu, 10 Sep 2020 16:12:05 +0800
Message-Id: <6fa7260145ee24442a5ff2173c507d92e400fc58.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds task switch support for vector. It supports partial lazy
save and restore mechanism. It also supports all lengths of vlen.

[guoren@linux.alibaba.com: First available porting to support vector
context switching]
[nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen and
code refine]
[vincent.chen@sifive.co: Fix the might_sleep issue in vstate_save,
vstate_restore]
Signed-off-by: Nick Knight <nick.knight@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 2afd0124701a..d33a86a48f0d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -87,6 +87,7 @@ static inline void vstate_save(struct task_struct *task,
 {
 	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
 		struct __riscv_v_state *vstate = &(task->thread.vstate);
+
 		__vstate_save(vstate, vstate->datap);
 		__vstate_clean(regs);
 	}
-- 
2.28.0

