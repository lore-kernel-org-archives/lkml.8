Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C9620771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592905967;
	bh=hLBY3T7nrxUU7besxQDrdAZvKz6an4ijUXrWT9hqieo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jd50Nk4+2sDRZlXNanHVSkB1fmupoBeY+HW3fgls7Fr/tlv10syETNm1Q5imttoeD
	 H6ub//RDBahgRVGSC7QyBziWakdbWCizPc7GBQ3dfkjo0uWycLqpTo/05nd/3EYepG
	 zzimewC0HIgeUjg5cruTsP/mDL+43dsSKAODusmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgFWJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbgFWJwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:52:46 -0400
Received: from localhost.localdomain (unknown [42.120.72.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8BC20738;
        Tue, 23 Jun 2020 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905965;
        bh=hLBY3T7nrxUU7besxQDrdAZvKz6an4ijUXrWT9hqieo=;
        h=From:To:Cc:Subject:Date:From;
        b=sDk1DoOI/7VYDn3LkluIEPHS44P568ZPmgO9GIGU81n+V4QvnBRRlgJ6KoGZ8np/1
         nchuto7hxk3NglxADUoAeGQnS5USTefTWSgKHd1x/Q4tcAfSAsIqrH9xKhcbY7OoFt
         gn+uynw8qwuyAqZLgExUUjh6+CjdddSVnBOzuQPw=
From:   guoren@kernel.org
To:     vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alan Kao <alankao@andestech.com>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH] riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
Date:   Tue, 23 Jun 2020 09:50:54 +0000
Message-Id: <1592905854-60833-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

For linux-5.8-rc1, enable ftrace of riscv will cause boot panic:

[    2.388980] Run /sbin/init as init process
[    2.529938] init[39]: unhandled signal 4 code 0x1 at 0x0000003ff449e000
[    2.531078] CPU: 0 PID: 39 Comm: init Not tainted 5.8.0-rc1-dirty #13
[    2.532719] epc: 0000003ff449e000 ra : 0000003ff449e954 sp : 0000003fffedb900
[    2.534005]  gp : 00000000000e8528 tp : 0000003ff449d800 t0 : 000000000000001e
[    2.534965]  t1 : 000000000000000a t2 : 0000003fffedb89e s0 : 0000003fffedb920
[    2.536279]  s1 : 0000003fffedb940 a0 : 0000003ff43d4b2c a1 : 0000000000000000
[    2.537334]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : fffffffffbad8000
[    2.538466]  a5 : 0000003ff449e93a a6 : 0000000000000000 a7 : 0000000000000000
[    2.539511]  s2 : 0000000000000000 s3 : 0000003ff448412c s4 : 0000000000000010
[    2.541260]  s5 : 0000000000000016 s6 : 00000000000d0a30 s7 : 0000003fffedba70
[    2.542152]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000003fffedb960
[    2.543335]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000003fffedb8a0
[    2.544471]  t5 : 0000000000000000 t6 : 0000000000000000
[    2.545730] status: 0000000000004020 badaddr: 00000000464c457f cause: 0000000000000002
[    2.549867] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[    2.551267] CPU: 0 PID: 1 Comm: init Not tainted 5.8.0-rc1-dirty #13
[    2.552061] Call Trace:
[    2.552626] [<ffffffe00020374a>] walk_stackframe+0x0/0xc4
[    2.553486] [<ffffffe0002039f4>] show_stack+0x40/0x4c
[    2.553995] [<ffffffe00054a6ae>] dump_stack+0x7a/0x98
[    2.554615] [<ffffffe00020b9b8>] panic+0x114/0x2f4
[    2.555395] [<ffffffe00020ebd6>] do_exit+0x89c/0x8c2
[    2.555949] [<ffffffe00020f930>] do_group_exit+0x3a/0x90
[    2.556715] [<ffffffe000219e08>] get_signal+0xe2/0x6e6
[    2.557388] [<ffffffe000202d72>] do_notify_resume+0x6a/0x37a
[    2.558089] [<ffffffe000201c16>] ret_from_exception+0x0/0xc

"ra:0x3ff449e954" is the return address of "call _mcount" in the
prologue of __vdso_gettimeofday(). Without proper relocate, pc jmp
to 0x0000003ff449e000 (vdso map base) with a illegal instruction
trap.

The solution comes from arch/arm64/kernel/vdso/Makefile:

CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)

 - CC_FLAGS_SCS is ShadowCallStack feature in Clang and only
   implemented for arm64, no use for riscv.

The bug comes from the following commit:

ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
---
 arch/riscv/kernel/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 38ba55b..3079935 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -27,6 +27,9 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 obj-y += vdso.o vdso-syms.o
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
+# Disable -pg to prevent insert call site
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.7.4

