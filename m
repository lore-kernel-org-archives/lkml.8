Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D6421974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="Ef5BGNQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgFRKUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFRKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:20:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE2C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:20:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so4618585wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZDzS22ABd2kr6Q9N+iZeVVpuX4ohPjiFNCxXA+YL224=;
        b=Ef5BGNQS6PKmHdhwWTN+Ge5JUtxlUBRtnxbp1aS7NYEdRQ72nR7VdsWHWRmnmPS1Q7
         ZQMPNBp4pq4CcSfc+7p4qO9opYot/KLOEvPmJE2ei7g+6Uj79BRpQjD2ieWUBfHGuoLn
         CUISNvWDP/m/5+ablwzXSJcAn+AdMWgvXqcKRhjV9WKeqnSj1ZcQh1SFMZ7eaDdAz7TV
         FwwUZQVaVtVfaMneQcjwd2D7td800FXkoC9SDQGicfp/KsnxuAwNv0w/LzMPPOlYCUMG
         gg4pbB7jIRFwi/iF+JN67ib3eV4Z+U/19Jxv/9XclDPvtwS1uf4BQ+LDSEyQUdc3G6Zj
         EdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDzS22ABd2kr6Q9N+iZeVVpuX4ohPjiFNCxXA+YL224=;
        b=KgBWipxjjcipIvdbIDD/7TpY1BUEqC7GjeIuKB0yW9Bb+kzWzrekvnGD2pPhyzzAss
         uyQQinvhZCzBHTmGsqH5PBNKbTozrD6bfA3IUjrWM+GOuvOOjYeQPbFtx/TWtPRPqnFv
         VKtN7uhth0x/fQtw0hFVhSQ8H/BfV9S/IUcOc9+VYNcoAf/XgxJ2Met44PHzUzfwhWqu
         QS+Kf8FvxddHN+DaWsiFlxj9etJIeiZ3vvUmL8po4T81QTri9zOU7k7637b7gtxAmpM+
         QDQLeOLvM3ks0oF1Ckd8yST8WGF95qu823mjFVRzHbGgDfTwFbsdlaNDat05PQPJZRta
         2jsA==
X-Gm-Message-State: AOAM530AW9VqnZ/54PmzOJDa3jkNfzxaEkeUHernq9EvcYN151k5Xw7F
        I3JKvPt71j3m9znvQBI4/cBWFw==
X-Google-Smtp-Source: ABdhPJwwTnfV7bRfhIc9q9uf5O+5ALgdu5SAYXBjZl/zv6XL3RbYHaDXVITG/X1DIgpnQtI8C7JS/g==
X-Received: by 2002:a05:600c:4146:: with SMTP id h6mr3373407wmm.170.1592475605123;
        Thu, 18 Jun 2020 03:20:05 -0700 (PDT)
Received: from localhost ([51.19.80.112])
        by smtp.gmail.com with ESMTPSA id x8sm3170591wrs.43.2020.06.18.03.20.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 03:20:04 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "Kumar, Venkataramanan" <Venkataramanan.Kumar@amd.com>,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: [PATCH] x86/asm/64: Align start of __clear_user() loop to 16-bytes
Date:   Thu, 18 Jun 2020 11:20:02 +0100
Message-Id: <20200618102002.30034-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 CPUs can suffer severe performance drops if a tight loop, such as
the ones in __clear_user(), straddles a 16-byte instruction fetch
window, or worse, a 64-byte cacheline. This issues was discovered in the
SUSE kernel with the following commit,

  1153933703d9 ("x86/asm/64: Micro-optimize __clear_user() - Use immediate constants")

which increased the code object size from 10 bytes to 15 bytes and
caused the 8-byte copy loop in __clear_user() to be split across a
64-byte cacheline.

Aligning the start of the loop to 16-bytes makes this fit neatly inside
a single instruction fetch window again and restores the performance of
__clear_user() which is used heavily when reading from /dev/zero.

Here are some numbers from running libmicro's read_z* and pread_z*
microbenchmarks which read from /dev/zero:

  Zen 1 (Naples)

  libmicro-file
                                        5.7.0-rc6              5.7.0-rc6              5.7.0-rc6
                                                    revert-1153933703d9+               align16+
  Time mean95-pread_z100k       9.9195 (   0.00%)      5.9856 (  39.66%)      5.9938 (  39.58%)
  Time mean95-pread_z10k        1.1378 (   0.00%)      0.7450 (  34.52%)      0.7467 (  34.38%)
  Time mean95-pread_z1k         0.2623 (   0.00%)      0.2251 (  14.18%)      0.2252 (  14.15%)
  Time mean95-pread_zw100k      9.9974 (   0.00%)      6.0648 (  39.34%)      6.0756 (  39.23%)
  Time mean95-read_z100k        9.8940 (   0.00%)      5.9885 (  39.47%)      5.9994 (  39.36%)
  Time mean95-read_z10k         1.1394 (   0.00%)      0.7483 (  34.33%)      0.7482 (  34.33%)

Note that this doesn't affect Haswell or Broadwell microarchitectures
which seem to avoid the alignment issue by executing the loop straight
out of the Loop Stream Detector (verified using perf events).

Fixes: 1153933703d9 ("x86/asm/64: Micro-optimize __clear_user() - Use immediate constants")
Cc: "Grimm, Jon" <Jon.Grimm@amd.com>
Cc: "Kumar, Venkataramanan" <Venkataramanan.Kumar@amd.com>
CC: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
---
 arch/x86/lib/usercopy_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index fff28c6f73a2..b0dfac3d3df7 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -24,6 +24,7 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 	asm volatile(
 		"	testq  %[size8],%[size8]\n"
 		"	jz     4f\n"
+		"	.align 16\n"
 		"0:	movq $0,(%[dst])\n"
 		"	addq   $8,%[dst]\n"
 		"	decl %%ecx ; jnz   0b\n"
-- 
2.17.1

