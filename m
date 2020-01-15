Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C3C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04002467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NvUYpJrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAOHFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:05:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41839 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOHFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:05:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so8060455pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pheYEBYXRUydN40/wbI1ZvK+bBwX3RUetQibpSJmnJY=;
        b=NvUYpJrRAEoLYVNWDLCyIXnqBtZhu5T9juwnWlnFdYlwfcQphlEPKzzircApS3ZF7B
         9b9OmmpCr4epEqhH1CboKmQk+p4BrJPEpmeM7FmdagTbPka3w94DHbv+VO+zxsOGzmaK
         OMH3E8BaI0WET4G/4ilVhXU1z7AP3936MaP2rhruDZpKMTctBJenJU3FZAXtEQFpJjaU
         EB/e2yjsxHhCJiKxYsGiOp4mG9+w0dhPih1uUFcfvx0dbN/FJe4bysTIlCwH4MkjINgC
         rAtCnkzRvAZw0PewWyeRegxwzI0sgSPtJ3HbFO9xXCZxC3x3jiX5dXO7mJQAeCblPuc4
         /YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pheYEBYXRUydN40/wbI1ZvK+bBwX3RUetQibpSJmnJY=;
        b=LMCUBPJcdGUdVrGkBBEJidAdNo4tT9PqPZEROqG9FDBle2zmIvWviIQB9LmzijRTaw
         Ukksg1n1jX/91/e1XoAFp1GxdKHU72EIvyg5WG9nSFjSzNw5O8WLYLsY+T7uQlaPo485
         wDIcRAl7rEUujUs3XzxWx/oUIpxFXSipce970817QPSPf65wVY3r5zPl/c5GGE+X18HW
         aZzsfQdZK/lMqft1EC8HleN5gp9p3wOq/qnnB7+Lc6YHXRlVOH8oa92V32Me1QsAAMVE
         8pWaOXImCgej4y9httbOjAauWW/+QwNAsUMr/ZCp8p5joegRSoqToeTz65tZuIHECFda
         sF3Q==
X-Gm-Message-State: APjAAAXXrHaXUTU4L7QPDPmz6zdHlyN/xB0fvwQAIVPWrejnLDWXV/PD
        NZcbiQlzEpkogy3oF7HPZ2I4CA==
X-Google-Smtp-Source: APXvYqzVGND6xq6LG8bdDE07pm1yXFpJeW17HC9m0rxajMfZLCEWDJc0iFO258V6fVljx91mfxMv/A==
X-Received: by 2002:a65:4d46:: with SMTP id j6mr32352377pgt.63.1579071937402;
        Tue, 14 Jan 2020 23:05:37 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id a2sm19196023pgv.64.2020.01.14.23.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 23:05:36 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, schwab@suse.de, anup@brainfault.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH v4] riscv: make sure the cores stay looping in .Lsecondary_park
Date:   Wed, 15 Jan 2020 14:54:36 +0800
Message-Id: <20200115065436.7702-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in secondary_park is currently placed in the .init section. The
kernel reclaims and clears this code when it finishes booting. That
causes the cores parked in it to go to somewhere unpredictable, so we
move this function out of init to make sure the cores stay looping there.

The instruction bgeu a0, t0, .Lsecondary_park may have "a relocation
truncated to fit" issue during linking time. It is because that sections
are too far to jump. Let's use tail to jump to the .Lsecondary_park.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/head.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f8f996916c5b..d7820764122c 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -88,7 +88,9 @@ _start_kernel:
 
 #ifdef CONFIG_SMP
 	li t0, CONFIG_NR_CPUS
-	bgeu a0, t0, .Lsecondary_park
+	blt a0, t0, .Lgood_cores
+	tail .Lsecondary_park
+.Lgood_cores:
 #endif
 
 	/* Pick one hart to run the main boot sequence */
@@ -217,11 +219,6 @@ relocate:
 	tail smp_callin
 #endif
 
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
 END(_start)
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -303,6 +300,13 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
+.section ".text", "ax",@progbits
+.align 2
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
-- 
2.17.1

