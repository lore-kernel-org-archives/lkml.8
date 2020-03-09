Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F3C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF8320848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WjKcO9RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCIIXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38988 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgCIIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so3946264pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seWJfto8ScXH/WTie1kGmp0AZpPcjTPuoxrfVsKEou8=;
        b=WjKcO9RUXrq2Owu6OwvIVyRHIjDygk6NNmdiZyD6x7GnB6m6Q6mEoRTwhDkr+ff9x4
         E224ttLqthCf/OCP8hsjeb4HH8gHCxdmkCv6MKP5U5L74ojmT7qf93HvaDX/f7uvoJu1
         zsXE6KEWswMvBYMTnX/otBAO1Cp5Oja5iyRG9lPJT4F09Wl3CdG7/ZeiC+sypc98OTOD
         Fc5I9vaOpNvg5xbikor6HIVDEpTmop/FCoiGSZs/Wa3Jdc5vGlBoXB0KPZXFhcstXA+e
         Nwt3BYhSeD88SsRSeY+Y1BSbuLYSBi3WlADGsEszCpTBDc55DgVSzxIdHX55r/TfRo3e
         Bbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seWJfto8ScXH/WTie1kGmp0AZpPcjTPuoxrfVsKEou8=;
        b=VFiU+4Nn4g9veh3HBwxdaIecgb/67CsCGJloB431nUuIzqMFr6kwhnnykUMKnbCzmn
         9NqokzayZ+pYOtlZe+Q/mfv7a0+0yTcwtPgHpMAwXOI1YDy7vBZPlaz31Rrz11qzDz1K
         VWHnHIaB0aFleF0wgSFg/I9Gs6NtyJpfL1d6wbF+hKz4jaFHb69JKTc/lcgukj+sEMu9
         zi2f/gscB36jcF0kNsJGjv6co98Ash5n2mYrFLMq2GLdUtvRgxwBMzy1h5Ycvbf0KRSu
         V10KbsGQkgcVhTN1AkNsAwu4iMCDL4iyxAD3sDF0mRJhbVd5gK3uH6DdRwG8cgiQI+W4
         HKeg==
X-Gm-Message-State: ANhLgQ1mQ+j0SL+eCgMWWakK4L2jr6ow1St4m9ZW1xsB+NrfJfYmoGa0
        ZLA0YybE7kkdWEy9OGry41bzq6xwaAg=
X-Google-Smtp-Source: ADFU+vsq0Ys1CvDxMRroE1tgaeaGQecNVeiwcD4kOHnsjkN23QBzakquwvKHGpIui1zLcaokU0myWA==
X-Received: by 2002:a63:f447:: with SMTP id p7mr15266733pgk.326.1583742175247;
        Mon, 09 Mar 2020 01:22:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:54 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 9/9] riscv: patch code by fixmap mapping
Date:   Mon,  9 Mar 2020 16:22:29 +0800
Message-Id: <4e0f705ad808e9e0ec2db346c548dd2c5522e109.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On strict kernel memory permission, the ftrace have to change the
permission of text for dynamic patching the intructions. Use
riscv_patch_text_nosync() to patch code instead of probe_kernel_write.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c40fdcdeb950..ce69b34ff55d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int ftrace_check_current_call(unsigned long hook_pos,
@@ -46,20 +47,14 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 {
 	unsigned int call[2];
 	unsigned int nops[2] = {NOP4, NOP4};
-	int ret = 0;
 
 	make_call(hook_pos, target, call);
 
-	/* replace the auipc-jalr pair at once */
-	ret = probe_kernel_write((void *)hook_pos, enable ? call : nops,
-				 MCOUNT_INSN_SIZE);
-	/* return must be -EPERM on write error */
-	if (ret)
+	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
+	if (riscv_patch_text_nosync
+	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
-	smp_mb();
-	flush_icache_range((void *)hook_pos, (void *)hook_pos + MCOUNT_INSN_SIZE);
-
 	return 0;
 }
 
-- 
2.25.1

