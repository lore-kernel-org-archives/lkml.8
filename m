Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8272CC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8472078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973855;
	bh=KrcBd/6LpA4iv8XxvMRPtEawAdKWKLWE9cltbnUxAz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nFZDdbC9VrfIyEYArmcmeKBvYLnsg6DJ3OgCVv+3KNHUyADY57gRqZKB74c0ZSe5+
	 fOo2uCLYaQJqXepzO9jo+Di3Gsde/e1nzaqcOR9NrLmE8iRJsmQY5Gm47SvsFzBimC
	 HbJpAfoYKiVHIwKTLZV6WMvZcn78GcWC1CNQiFTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgIAPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgIAPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:21:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E9720BED;
        Tue,  1 Sep 2020 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973707;
        bh=KrcBd/6LpA4iv8XxvMRPtEawAdKWKLWE9cltbnUxAz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0uTGK5Cl/97gzKNwDE4y3TrAzbU7vmkBJAjB5QnDJIoTjqzLWLTEcypd4ISatAgt
         xs3mw1Bgq76yc51aFd6h2k/gvLsN//5e2VMTDfRCOl7tfBd7g6xuiKWLLkBQw/bXiI
         jiRh5SkeEcSixOQPd36+C16PlVJPvxRqoUPkuYKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/125] powerpc/xive: Ignore kmemleak false positives
Date:   Tue,  1 Sep 2020 17:09:30 +0200
Message-Id: <20200901150935.315281292@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index cb1f51ad48e40..411f785cdfb51 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -627,6 +628,7 @@ static bool xive_native_provision_pages(void)
 			pr_err("Failed to allocate provisioning page\n");
 			return false;
 		}
+		kmemleak_ignore(p);
 		opal_xive_donate_page(chip, __pa(p));
 	}
 	return true;
-- 
2.25.1



