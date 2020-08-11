Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799D120756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHKK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:27:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728390AbgHKK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:27:12 -0400
X-UUID: 028b8adeaa6849d3902c6939c9c033fe-20200811
X-UUID: 028b8adeaa6849d3902c6939c9c033fe-20200811
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <empty.sender@empty.domain>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 50352739; Tue, 11 Aug 2020 18:27:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Aug 2020 18:27:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Aug 2020 18:27:03 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] net: untag pointer in sockptr_is_kernel
Date:   Tue, 11 Aug 2020 18:27:04 +0800
Message-ID: <20200811102704.17875-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3DA173CDEB2447180FA2BE185548711F099DA603572AA935798EFE93CDA72EE32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

sockptr_is_kernel() uses (sockptr.kernel >= TASK_SIZE) to tell
if the pointer is kernel space or user space. When user space uses
the "top byte ignored" feature such as HWAsan, we must untag
the pointer before checking against TASK_SIZE.

sockptr_is_kernel() will view a tagged user pointer as a kernel pointer
and use memcpy directly and causes a kernel crash.

static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
		size_t offset, size_t size)
{
	if (!sockptr_is_kernel(src))
		return copy_from_user(dst, src.user + offset, size);
	memcpy(dst, src.kernel + offset, size);
	return 0;
}

Crash log:
[   26.066275] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000007b410f6990
[   26.067640] Mem abort info:
[   26.068004]   ESR = 0x9600000f
[   26.068400]   EC = 0x25: DABT (current EL), IL = 32 bits
[   26.084406]   SET = 0, FnV = 0
[   26.084805]   EA = 0, S1PTW = 0
[   26.085310] Data abort info:
[   26.085686]   ISV = 0, ISS = 0x0000000f
[   26.086179]   CM = 0, WnR = 0
[   26.086565] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001feb7c000
[   26.087386] [0000007b410f6990] pgd=0000000201ac2003, p4d=0000000201ac2003, pud=0000000201ac2003, pmd=00000001fd58a003, pte=00e80001fca7bf53
[   26.089111] Internal error: Oops: 9600000f [#1] PREEMPT SMP
[   30.435941] pstate: 80400005 (Nzcv daif +PAN -UAO BTYPE=--)
[   30.435950] pc : __memcpy+0xbc/0x180
[   30.435956] lr : copy_from_sockptr_offset+0x120/0x298
[   30.435960] sp : ffffffc0179438d0
[   30.441225] x29: ffffffc0179438d0 x28: ffffff81bf579940
[   30.441898] x27: ffffffd24a752bc0 x26: ffffffc0179439b0
[   30.442572] x25: ffffffd24a75dd60 x24: 0000000000000002
[   30.443247] x23: ffffff81bf579940 x22: 0000000000000000
[   30.443919] x21: b400007a2e8749f0 x20: ffffffc0179439b0
[   30.444592] x19: 0000000000000060 x18: 0000000000000000
[   30.445264] x17: 0000000000000000 x16: 0000000000000000
[   30.445937] x15: 0000000000000552 x14: 00000000ba02a83b
[   30.446609] x13: 0000000045fb4ba9 x12: 00000000e5d1c812
[   30.447281] x11: 0000000000019cde x10: 0000000000000001
[   30.447952] x9 : 00000000fffff000 x8 : 0000008000000000
[   30.448625] x7 : ffffffd24932449c x6 : ffffffc0179439b0
[   30.449295] x5 : 0000000000000000 x4 : 0000000000000000
[   30.449967] x3 : 0000000000000060 x2 : ffffffffffffffe0
[   30.450639] x1 : b400007a2e8749f0 x0 : ffffffc0179439b0
[   30.451310] Call trace:
[   30.451628]  __memcpy+0xbc/0x180
[   30.452039]  do_ipt_set_ctl+0x88/0xa48
[   30.452520]  nf_setsockopt+0xc4/0x104
[   30.452988]  ip_setsockopt+0x128/0xfa8
[   30.453466]  raw_setsockopt+0x48/0x2c0
[   30.453944]  sock_common_setsockopt+0x18/0x20
[   30.454497]  __sys_setsockopt+0x144/0x1ec
[   30.455005]  __arm64_sys_setsockopt+0x24/0x30
[   30.455560]  el0_svc_common+0xa0/0x18c
[   30.456039]  do_el0_svc+0x78/0x80
[   30.456462]  el0_sync_handler+0xec/0x2b8
[   30.456960]  el0_sync+0x144/0x180
[   30.457386] Code: 380014c3 14000028 f1020042 5400024a (a8c12027)
[   30.458156] ---[ end trace a53f2349dbbd41cd ]---
[   30.465290] Kernel panic - not syncing: Fatal exception

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Fixes: 6d04fe15f78a ("net: optimize the sockptr_t for unified kernel/user address spaces")
---
 include/linux/sockptr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 96840def9d69..3febc4da1056 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -20,7 +20,7 @@ typedef union {
 
 static inline bool sockptr_is_kernel(sockptr_t sockptr)
 {
-	return (unsigned long)sockptr.kernel >= TASK_SIZE;
+	return (unsigned long)untagged_addr(sockptr.kernel) >= TASK_SIZE;
 }
 
 static inline sockptr_t KERNEL_SOCKPTR(void *p)
-- 
2.18.0

