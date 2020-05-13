Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2512CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E237720657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="i2BmTeKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbgEMNlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgEMNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:40:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D43CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:40:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so655151qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIL0Xa30eWe4pB9L70dZk7zOy9oguvU9qefI9I02W/c=;
        b=i2BmTeKd6lucjvyoSCAFMWyWiKtK5PqHOl8WxIU7LwH2Vzirg7cKvwtklgHFjs9XYL
         gKWcWITZYNWJq6Kz3QN810QJuIZMKG2gZAmtnmk/XazYBWLXY588/FsRg4B8e/cTube4
         XCeidULijY2gMsBEBBArZLUC+YUCtFi+L+loMPlhmVVCwZdUvXPoabDzIgMthLHDRrO8
         DTCbLPaQOz242IQtcKjGdm8i7E3NiiiuvFXf0NIJ5lH333lM6UrUA+c97oaqewkON1pA
         6CatSmJ5gSSHFce1ZfZjkyA3EbIvPqJ6uBLSLH6VE5VOJHENMMhoa8EQ/N9XeyEsIhcn
         oNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIL0Xa30eWe4pB9L70dZk7zOy9oguvU9qefI9I02W/c=;
        b=OiqnY+nvZ7dZz+v73CjPpmdIcGluglKoLLn5zLmfuvnzbOhSd1JxRyq4mwsbCKFMGx
         Vp3KOZsYJ8P+b/qEpY/pnoPbjCssMG3LUbi+z7BQ9mQcAMW3rncmP1kx5Wf1QDO8bi7R
         qWGqbAEFaDeO0Ub+IlcmKCscWvi3+MGFBlgl/qT7Hq3BL4oYRcf0hfMjBPNYC7B4gc+B
         doMFjbP3jmS4PCiuoBORTHrhOeD6o/5tu0G3TU9SQDcGiDPfeWrDjIsFPVbwDfjLHRSx
         zY5c//ngGm74w6lCn2VyvOeid/FWgeJ30fg5EMgBMEVFDF6od0RskbOthpYjUZ30bbAH
         7+8g==
X-Gm-Message-State: AGi0PuaBbZ6V/5EvaxT/c84hoDiJkwfcIYg8ZS24QQOzMsrKRTG2EfKc
        cX6Tfoym6+WbIIhWgOHPhNhWRQ==
X-Google-Smtp-Source: APiQypKCVvq9COXXOzbdahy5qMUwb2p2BOsLwmIYeCXGLbETKpuNWBa45a/FrKEP87HhfdxrFYdT4A==
X-Received: by 2002:a37:7302:: with SMTP id o2mr26009358qkc.474.1589377258319;
        Wed, 13 May 2020 06:40:58 -0700 (PDT)
Received: from ovpn-66-156.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q2sm14044106qkn.116.2020.05.13.06.40.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 06:40:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        catalin.marinas@arm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/xive: silence kmemleak false positives
Date:   Wed, 13 May 2020 09:40:46 -0400
Message-Id: <20200513134046.1089-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

opal_xive_donate_page() will reference the newly allocated memory using
__pa(). Since kmemleak is unable to track the physical memory resulting
in false positives, silence those by using kmemleak_ignore().

unreferenced object 0xc000201b53e90000 (size 65536):
 comm "qemu-kvm", pid 124557, jiffies 4295650285 (age 364.370s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<00000000acc2fb77>] xive_native_alloc_vp_block+0x168/0x210
   xive_native_provision_pages at arch/powerpc/sysdev/xive/native.c:645
   (inlined by) xive_native_alloc_vp_block at arch/powerpc/sysdev/xive/native.c:674
   [<000000004d5c7964>] kvmppc_xive_compute_vp_id+0x20c/0x3b0 [kvm]
   [<0000000055317cd2>] kvmppc_xive_connect_vcpu+0xa4/0x4a0 [kvm]
   [<0000000093dfc014>] kvm_arch_vcpu_ioctl+0x388/0x508 [kvm]
   [<00000000d25aea0f>] kvm_vcpu_ioctl+0x15c/0x950 [kvm]
   [<0000000048155cd6>] ksys_ioctl+0xd8/0x130
   [<0000000041ffeaa7>] sys_ioctl+0x28/0x40
   [<000000004afc4310>] system_call_exception+0x114/0x1e0
   [<00000000fb70a873>] system_call_common+0xf0/0x278

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/sysdev/xive/native.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 5218fdc4b29a..2d19f28967a6 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -647,6 +648,9 @@ static bool xive_native_provision_pages(void)
 			pr_err("Failed to allocate provisioning page\n");
 			return false;
 		}
+		/* Kmemleak is unable to track the physical address. */
+		kmemleak_ignore(p);
+
 		opal_xive_donate_page(chip, __pa(p));
 	}
 	return true;
-- 
2.21.0 (Apple Git-122.2)

