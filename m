Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEAC221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHFUBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:01:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbgHFUBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:01:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8893FBF263BE271FF394;
        Thu,  6 Aug 2020 19:48:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 19:48:13 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <pabeni@redhat.com>, <willemb@google.com>,
        <fw@strlen.de>, <pablo@netfilter.org>, <edumazet@google.com>,
        <steffen.klassert@secunet.com>, <Jason@zx2c4.com>,
        <rdunlap@infradead.org>, <decui@microsoft.com>,
        <jakub@cloudflare.com>, <jeremy@azazel.net>, <mashirle@us.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/5] net: Fix potential deadloop in skb_copy_ubufs()
Date:   Thu, 6 Aug 2020 19:50:42 +0800
Message-ID: <1596714642-25183-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

We could be trapped in deadloop when we try to copy userspace skb frags
buffers to kernel with a cloned skb:

[kbox] catch panic event, panic reason:kernel stack overflow
[kbox] catch panic event, start logging.
CPU: 3 PID: 4083 Comm: insmod Kdump: loaded Tainted: G       OE  4.19 #6
Hardware name: linux,dummy-virt (DT)
Call trace:
	dump_backtrace+0x0/0x198
	show_stack+0x24/0x30
	dump_stack+0xa4/0xcc
	kbox_panic_notifier_callback+0x1d0/0x310 [kbox]
	notifier_call_chain+0x5c/0xa0
	atomic_notifier_call_chain+0x3c/0x50
	panic+0x164/0x314
	__stack_chk_fail+0x0/0x28
	handle_bad_stack+0xfc/0x108
	__bad_stack+0x90/0x94
	pskb_expand_head+0x0/0x2c8
	pskb_expand_head+0x290/0x2c8
	skb_copy_ubufs+0x3cc/0x520
	pskb_expand_head+0x290/0x2c8
	skb_copy_ubufs+0x3cc/0x520
	pskb_expand_head+0x290/0x2c8
	skb_copy_ubufs+0x3cc/0x520
	pskb_expand_head+0x290/0x2c8
	skb_copy_ubufs+0x3cc/0x520
	...
	pskb_expand_head+0x290/0x2c8
	skb_copy_ubufs+0x3cc/0x520
	...

Reproduce code snippet:
	skb = alloc_skb(UBUF_DATA_LEN, GFP_ATOMIC);
	clone = skb_clone(skb, GFP_ATOMIC);
	skb_zcopy_set_nouarg(clone, NULL);
	pskb_expand_head(skb, 0, 0, GFP_ATOMIC);

Catch this unexpected case and return -EINVAL in skb_orphan_frags() before
we call skb_copy_ubufs() to fix it.

Fixes: a6686f2f382b ("skbuff: skb supports zero-copy buffers")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/skbuff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0c0377fc00c2..167c8f4cb6e3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2753,6 +2753,9 @@ static inline int skb_orphan_frags(struct sk_buff *skb, gfp_t gfp_mask)
 	if (!skb_zcopy_is_nouarg(skb) &&
 	    skb_uarg(skb)->callback == sock_zerocopy_callback)
 		return 0;
+	/* If the skb is cloned, return error here or we will be trapped in deadloop. */
+	if (unlikely(skb_cloned(skb)))
+		return -EINVAL;
 	return skb_copy_ubufs(skb, gfp_mask);
 }
 
-- 
2.19.1

