Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9993A20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029853;
	bh=w+CCad3qJGbJT8Ndl3AfagyrBeavJyGH/yTjj8xmuA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LP6B585YQSSbX9RXVuC8Ffc+zrznEEIFDBlaPI76lqLMgF1/9jLFwcxsYZ+OmkNNO
	 ofZgf7+u8KiLSXIjFRS/nXgnKa9EJ+Q5PDeA+d8ZfuY+W3uiUrOKu4wu6MA4g6Tpzq
	 AEqMtByWGsX2JkEZ3XcY4f/+qtyumQ6DnNr/Rtqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgHURKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgHUQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA9722B49;
        Fri, 21 Aug 2020 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026637;
        bh=w+CCad3qJGbJT8Ndl3AfagyrBeavJyGH/yTjj8xmuA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EioTLsnTivm5z9MQjP+fZyPQXevX2TJlN3Fw6SegYQWWzVAZUcWbXAMHG8in+fqbZ
         yHK3lx+4krL5cKK1eOvRJSPZ+X6Q2ikn3hJdNuuJoyBJieko1OllHod03CMRc373nF
         PAE6twhJa2Pi9UA4X1+jCuyl4YMw94nDDwkrEh18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 10/48] powerpc/xive: Ignore kmemleak false positives
Date:   Fri, 21 Aug 2020 12:16:26 -0400
Message-Id: <20200821161704.348164-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit f0993c839e95dd6c7f054a1015e693c87e33e4fb ]

xive_native_provision_pages() allocates memory and passes the pointer to
OPAL so kmemleak cannot find the pointer usage in the kernel memory and
produces a false positive report (below) (even if the kernel did scan
OPAL memory, it is unable to deal with __pa() addresses anyway).

This silences the warning.

unreferenced object 0xc000200350c40000 (size 65536):
  comm "qemu-system-ppc", pid 2725, jiffies 4294946414 (age 70776.530s)
  hex dump (first 32 bytes):
    02 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00  ....P...........
    01 00 08 07 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000081ff046c>] xive_native_alloc_vp_block+0x120/0x250
    [<00000000d555d524>] kvmppc_xive_compute_vp_id+0x248/0x350 [kvm]
    [<00000000d69b9c9f>] kvmppc_xive_connect_vcpu+0xc0/0x520 [kvm]
    [<000000006acbc81c>] kvm_arch_vcpu_ioctl+0x308/0x580 [kvm]
    [<0000000089c69580>] kvm_vcpu_ioctl+0x19c/0xae0 [kvm]
    [<00000000902ae91e>] ksys_ioctl+0x184/0x1b0
    [<00000000f3e68bd7>] sys_ioctl+0x48/0xb0
    [<0000000001b2c127>] system_call_exception+0x124/0x1f0
    [<00000000d2b2ee40>] system_call_common+0xe8/0x214

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200612043303.84894-1-aik@ozlabs.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xive/native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 50e1a8e02497d..3fd086533dcfc 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -646,6 +647,7 @@ static bool xive_native_provision_pages(void)
 			pr_err("Failed to allocate provisioning page\n");
 			return false;
 		}
+		kmemleak_ignore(p);
 		opal_xive_donate_page(chip, __pa(p));
 	}
 	return true;
-- 
2.25.1

