Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27795C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DF2206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I4XH/Ztw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgGaO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:59:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55216 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGaO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:59:27 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200731145926epoutp0112fdffa7ca94b4f1d1797009d1e22767~m3lMIaw9x1746317463epoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 14:59:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200731145926epoutp0112fdffa7ca94b4f1d1797009d1e22767~m3lMIaw9x1746317463epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596207566;
        bh=sLpkHF+HbDloaJa2ddUi7D2t35e//APwH4BKjk+HIRE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I4XH/ZtwtP8PeoIK385cZ6hyIsdzB0krZrhehubzIS/iBaE9CDKDkXnP9y07h/F3O
         BtRvU2SiROeTbQr0Jwo8eZAwO0L+IQdihg8hS/l/+jzm8gXfC3JzmPBVP8iopcULYX
         93HYQZFla8IrL4nD99KAY4HxUGyaou7qfiZWAP+4=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200731145925epcas5p456b95bd3e90f65d7afa4b3ecc784f737~m3lLTeH-P2676826768epcas5p4I;
        Fri, 31 Jul 2020 14:59:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.D7.40333.DC1342F5; Fri, 31 Jul 2020 23:59:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200731121259epcas5p11248853c0578f2e426ab828310c9e855~m1T3k9ZqS0430504305epcas5p1l;
        Fri, 31 Jul 2020 12:12:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200731121259epsmtrp24bcae872f75ce10d653fd8fbe609b410~m1T3kL2qN0293402934epsmtrp2_;
        Fri, 31 Jul 2020 12:12:59 +0000 (GMT)
X-AuditID: b6c32a4a-991ff70000019d8d-20-5f2431cd8851
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.DC.08382.BCA042F5; Fri, 31 Jul 2020 21:12:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200731121257epsmtip2b42fe9ba3335d636d8d1a656337a260d~m1T1UQ1Im3086430864epsmtip2X;
        Fri, 31 Jul 2020 12:12:57 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, akpm@linux-foundation.org
Cc:     Dave.Martin@arm.com, 0x7f454c46@gmail.com, peterz@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] arm64: use IRQ_STACK_SIZE instead of THREAD_SIZE for
 irq stack
Date:   Fri, 31 Jul 2020 17:19:50 +0530
Message-Id: <1596196190-14141-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhTS/esoUq8waLlHBYTpr1gsbi4O9Vi
        zvo1bBbvl/UwWjTN3cNocX/fciaLTY+vsVpc3jWHzeLw/DYWi6XXLzJZHO89wGRx6ORcRouW
        O6YOvB5r5q1h9Ng56y67x+YVWh6bVnWyeZyY8ZvFY/OSeo++LasYPT5vkgvgiOKySUnNySxL
        LdK3S+DKOHr5IEvBFPaK7Yc+sDYw/mHtYuTkkBAwkfhz8y5jFyMXh5DAbkaJ9/9mskM4nxgl
        Pu++yALhfGOU+PLgP5DDAday/2kERHwvo8TLPS1QRV8YJTa8uMMMMpdNQE9i1a49LCC2iECJ
        xI41U9hAipgFnjJKLPqyDaxIWCBUYvLtdjYQm0VAVaJz7gmwOK+Au8TO37tZIA6Ukzh5bDIr
        SLOEwEd2iYWdm6Aud5G4tXEKO4QtLPHq+BYoW0ri87u9bBANzYwSn/atZYRwpjBKLL34Earb
        XuJ1cwMTyEPMApoS63fpQ4RlJaaeWscEYjML8En0/n7CBBHnldgxD8ZWlWi5uQFqjLTE548f
        oeHiIbHvpixIWEggVuLA86PMExhlZyEsWMDIuIpRMrWgODc9tdi0wCgvtVyvODG3uDQvXS85
        P3cTIzidaHntYHz44IPeIUYmDsZDjBIczEoivH//KccL8aYkVlalFuXHF5XmpBYfYpTmYFES
        51X6cSZOSCA9sSQ1OzW1ILUIJsvEwSnVwCS6Lz+Y7c6uam5nV1+pl62Pgrjr+WOZtig1y4nv
        81v3r/vLl4Mv5guos/5jT+q75KMTkCl6LL7A5orQ0ynvJ2qv/Mgnayfm9nbdhzcH/0stl/vU
        mBnh/2D/vJeR2z21Hiy7uya07I2iq8jfnSdtJRgUf+epn9nhrBHq1Gly/GGabFX2F2ndjZ5P
        BD3Lf86ZXN0wX3XxVq3ZSid23Ji3o097eYhxW+TR47dX+tSdTZHTjC7g4eo6eC9qWwjzU0GJ
        wqi1P1ZYFrRFvtd3mTPlYpxkx7Sw58+u/mC7v6JP6N2F2dZia+ZeOnru7jWdjdwr+z+56Ct1
        P9R6dvLVH4YND/9meaS9SfGVnqO5ZOr11GAlluKMREMt5qLiRACgauBZlgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO5pLpV4g3Mr1S0mTHvBYnFxd6rF
        nPVr2CzeL+thtGiau4fR4v6+5UwWmx5fY7W4vGsOm8Xh+W0sFkuvX2SyON57gMni0Mm5jBYt
        d0wdeD3WzFvD6LFz1l12j80rtDw2repk8zgx4zeLx+Yl9R59W1YxenzeJBfAEcVlk5Kak1mW
        WqRvl8CVcfTyQZaCKewV2w99YG1g/MPaxcjBISFgIrH/aUQXIxeHkMBuRond3TeYuhg5geLS
        Ej//vWeBsIUlVv57zg5R9IlRYtKbt2wgCTYBPYlVu/aAFYkIVEk8XXeDEaSIWeAto8TcOS/B
        JgkLBEusudHNCGKzCKhKdM49wQxi8wq4S+z8vRtqg5zEyWOTWScw8ixgZFjFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iREcmFqaOxi3r/qgd4iRiYPxEKMEB7OSCO/ff8rxQrwpiZVV
        qUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTCZnN8WIPBY8dbvecyZ
        pVMCLqyw3PR5n2zT6uraCZvT3Wx1v9u9jKn5x+me8cTZuvaWKJPVd2m+x/s0dmz7s2y91wfF
        sl1G8yon/7E9z7DI6MLSjMsxZ398D/BOSQiJnDLnR96rw5c7u/NbqqcdWDdnhnzQK4Hk20Xf
        Dky6PifT0CpU6+E0ne+1519/ke1bVm/7YY0WD8fyXZyM5RePcwVeZG3PZCn22r3iBTP/v3M6
        jgxni4onClrd5pVrL/5UzORg+kPqxcEp3VxbTL8tyPe3P7DS/uvB+Reet+2efXndWyFmpi89
        KbzvZJa6BqjrMjuZPl3+b3/V1rb/H5odHPOEF0Sadl2/oSx+gqUoxsNHiaU4I9FQi7moOBEA
        P1tU4bsCAAA=
X-CMS-MailID: 20200731121259epcas5p11248853c0578f2e426ab828310c9e855
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200731121259epcas5p11248853c0578f2e426ab828310c9e855
References: <CGME20200731121259epcas5p11248853c0578f2e426ab828310c9e855@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_STACK_SIZE can be made different from THREAD_SIZE,
and as IRQ_STACK_SIZE is used while irq stack allocation,
same define should be used while printing information of irq stack.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 47f651d..13ebd5c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -855,7 +855,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 	pr_emerg("Task stack:     [0x%016lx..0x%016lx]\n",
 		 tsk_stk, tsk_stk + THREAD_SIZE);
 	pr_emerg("IRQ stack:      [0x%016lx..0x%016lx]\n",
-		 irq_stk, irq_stk + THREAD_SIZE);
+		 irq_stk, irq_stk + IRQ_STACK_SIZE);
 	pr_emerg("Overflow stack: [0x%016lx..0x%016lx]\n",
 		 ovf_stk, ovf_stk + OVERFLOW_STACK_SIZE);
 
-- 
1.9.1

