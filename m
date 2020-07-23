Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD014C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9CD20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X/yMRbfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGWXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:22:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1491 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgGWXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595546553; x=1627082553;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=unRYGB3JD9VvX1/PIcQEqDOVGoOR6BJzAhuSTskpzt8=;
  b=X/yMRbfg6BPrnc3Jt3Gfgh+4A1G+YfssKfDoLtYwQIBiBybWTd6xCbAX
   xhqF2rnSDL3Jh3iu2MhU4Ek6gQaw9JmEwHuyjKDD+577VbCfbvCNrtBju
   lWk/QR0Nwk7GQT0YYPOpoy/vaqjMtrDhjSBqInoXsPFLFijdduHuMz80h
   qD7e3kO2miFxR3DI+JNYviCE/KvfIWpZPV50ZyMO6E3p3mMdrJUi1nLQy
   4mfcKKR5ClCARIad8Xzc92YqVkU7VttPgmQoLK5V7NGTO0oFogwv6EvpP
   mWuvhTwK3SkCK/mnRSVvfgafan522jJoZTVZAcgXOX1Oa3/6EChPiOM0S
   w==;
IronPort-SDR: lBenQvUOczxdl2dgCzJEJeYW9kIZGBE9ei0+1nXFTGiuP02Fd3SAM7ieS4SjiW60d7kDOuOfhi
 XF0o26CSEcFgGNEo/xe/pPu8Fnxp/Oh6MJXurKM1uP+YLQsgcp7gjW+0zD3lpOP10dEdcwrkto
 GdKTMiWAJrA4544rXfpzmSbNbC4m71S551zu74zVqzFxPAgvZ7p1O76tbFvuYLFOsQOAtaK02d
 Jms3Rv0+ykmxn8+BjA/Mk1YLQ2eiZPbC8aHu/6C+lh+A5tmfYKM+D6hYSSASIdoy9vjiN2Q6tt
 7E8=
X-IronPort-AV: E=Sophos;i="5.75,388,1589212800"; 
   d="scan'208";a="147549744"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 07:22:33 +0800
IronPort-SDR: 1qT7NVjvQagALM5k50Wy6mDtAtm8WRMPrJIOtNX0tZ/6FeMjkb2yIoOf/m1XL1lcozEzlYYzb6
 NCewQiF0dW2FEf+Ky1SjHJR6Qe3+7ed2A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:10:12 -0700
IronPort-SDR: kn1K8tzOhML+h1sFQtgcxeTtQDCepy93j2k8G6/vZ7GpGpOfzi9q/EmKzgYoOtRZ0w97z92dm4
 Z4SO0nqSzC0g==
WDCIronportException: Internal
Received: from unknown (HELO redsun52) ([10.149.66.28])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:22:32 -0700
Date:   Fri, 24 Jul 2020 00:22:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@wdc.com>
To:     linux-riscv@lists.infradead.org
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: ptrace: Improve the style in NT_PRFPREG regset
 handling
In-Reply-To: <alpine.LFD.2.21.2007232038170.24175@redsun52.ssa.fujisawa.hgst.com>
Message-ID: <alpine.DEB.2.20.2007232216420.4462@tpp.orcam.me.uk>
References: <alpine.LFD.2.21.2007232038170.24175@redsun52.ssa.fujisawa.hgst.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an auxiliary variable for the size taken by floating point general 
registers in `struct __riscv_d_ext_state' to improve the readability of 
code in the `riscv_fpr_get' and `riscv_fpr_set' handlers, by avoiding 
excessive line wrapping and extending beyond 80 columns.  Also shuffle 
local variables in the reverse Christmas tree order.  No functional 
change.

Signed-off-by: Maciej W. Rozycki <macro@wdc.com>
---
 arch/riscv/kernel/ptrace.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

linux-riscv-ptrace-fpr-style.diff
Index: linux-hv/arch/riscv/kernel/ptrace.c
===================================================================
--- linux-hv.orig/arch/riscv/kernel/ptrace.c
+++ linux-hv/arch/riscv/kernel/ptrace.c
@@ -58,18 +58,16 @@ static int riscv_fpr_get(struct task_str
 			 unsigned int pos, unsigned int count,
 			 void *kbuf, void __user *ubuf)
 {
-	int ret;
+	const size_t fgr_size = offsetof(struct __riscv_d_ext_state, fcsr);
 	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
+	int ret;
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fstate->f, 0,
-				  offsetof(struct __riscv_d_ext_state, fcsr));
+				  fgr_size);
 	if (!ret) {
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fstate->fcsr,
-					  offsetof(struct __riscv_d_ext_state,
-						   fcsr),
-					  offsetof(struct __riscv_d_ext_state, fcsr) +
-					  sizeof(fstate->fcsr));
+					  &fstate->fcsr, fgr_size,
+					  fgr_size + sizeof(fstate->fcsr));
 	}
 
 	return ret;
@@ -80,18 +78,16 @@ static int riscv_fpr_set(struct task_str
 			 unsigned int pos, unsigned int count,
 			 const void *kbuf, const void __user *ubuf)
 {
-	int ret;
+	const size_t fgr_size = offsetof(struct __riscv_d_ext_state, fcsr);
 	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
+	int ret;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fstate->f, 0,
-				 offsetof(struct __riscv_d_ext_state, fcsr));
+				 fgr_size);
 	if (!ret) {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					 &fstate->fcsr,
-					 offsetof(struct __riscv_d_ext_state,
-						  fcsr),
-					 offsetof(struct __riscv_d_ext_state, fcsr) +
-					 sizeof(fstate->fcsr));
+					 &fstate->fcsr, fgr_size,
+					 fgr_size + sizeof(fstate->fcsr));
 	}
 
 	return ret;
