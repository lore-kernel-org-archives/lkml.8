Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E54C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FFF2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845608;
	bh=sM82G4kYr9KdBjXCKP43/pRLLLrB+mJe9ieCgn41Mwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjZQats5V0mHxjs+PF3fZdgQGV/37otAT1i5lymcxcS69Qc4eKulbhxEqbH/VL/Fz
	 0bu4cya1AC0/mDSRZ25miwWRNw4RtJi2tf+qalCiKdbp5+IMceDdkiqutVV7JOnS3p
	 Dou24SKa+mHvOL+7JA5Zr6Bzq5NjSjAR6nJX5gFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgCJNGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgCJNGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64D12071B;
        Tue, 10 Mar 2020 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845600;
        bh=sM82G4kYr9KdBjXCKP43/pRLLLrB+mJe9ieCgn41Mwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSf/og521zLFJrm1E9vC0NcZyPa4fGl1vybz046VvxxIOX3l5UTaEm8ob+hLrTyRW
         ml9sJ8ow8he4/dCKXPf0o3yuhyDVi+hOn38k/+Ur/2cB7Td7KMY7d37Qs+Hg5OPYrU
         +BZaDcq/97f/kHMXS/J12ubjk0BdUAUXvYyH3Mwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 033/126] net: sched: correct flower port blocking
Date:   Tue, 10 Mar 2020 13:40:54 +0100
Message-Id: <20200310124206.526633885@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

[ Upstream commit 8a9093c79863b58cc2f9874d7ae788f0d622a596 ]

tc flower rules that are based on src or dst port blocking are sometimes
ineffective due to uninitialized stack data. __skb_flow_dissect() extracts
ports from the skb for tc flower to match against. However, the port
dissection is not done when when the FLOW_DIS_IS_FRAGMENT bit is set in
key_control->flags. All callers of __skb_flow_dissect(), zero-out the
key_control field except for fl_classify() as used by the flower
classifier. Thus, the FLOW_DIS_IS_FRAGMENT may be set on entry to
__skb_flow_dissect(), since key_control is allocated on the stack
and may not be initialized.

Since key_basic and key_control are present for all flow keys, let's
make sure they are initialized.

Fixes: 62230715fd24 ("flow_dissector: do not dissect l4 ports for fragments")
Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/flow_dissector.h |    9 +++++++++
 net/sched/cls_flower.c       |    1 +
 2 files changed, 10 insertions(+)

--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/in6.h>
 #include <linux/siphash.h>
+#include <linux/string.h>
 #include <uapi/linux/if_ether.h>
 
 /**
@@ -282,4 +283,12 @@ static inline void *skb_flow_dissector_t
 	return ((char *)target_container) + flow_dissector->offset[key_id];
 }
 
+static inline void
+flow_dissector_init_keys(struct flow_dissector_key_control *key_control,
+			 struct flow_dissector_key_basic *key_basic)
+{
+	memset(key_control, 0, sizeof(*key_control));
+	memset(key_basic, 0, sizeof(*key_basic));
+}
+
 #endif
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -160,6 +160,7 @@ static int fl_classify(struct sk_buff *s
 	if (!atomic_read(&head->ht.nelems))
 		return -1;
 
+	flow_dissector_init_keys(&skb_key.control, &skb_key.basic);
 	fl_clear_masked_range(&skb_key, &head->mask);
 
 	info = skb_tunnel_info(skb);


