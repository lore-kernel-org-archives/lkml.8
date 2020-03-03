Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C4C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4320CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257958;
	bh=bZ2Uu/cSnvf3t5r8OxlUIbDTWKuGo8Tcba+NSC3tEd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7Jbk5Q/tdKqQcC4PWOPA89o4xXeaM0r7bWgZNICn1GsC6H9sT2OX5/JCteO2mBtG
	 L9a+QMKhT1Aad2CWUV6OG0uarPrTqpMPVOzob439sdPkHvBybiRwW53/vrEdTu/NHw
	 XN7cTKdGwxPzz7Z4lmTtHhwF1WHDyNOdOv13pJ4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgCCRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732178AbgCCRwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:52:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4177720728;
        Tue,  3 Mar 2020 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257953;
        bh=bZ2Uu/cSnvf3t5r8OxlUIbDTWKuGo8Tcba+NSC3tEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQ9Fdg/tbTWjomnJwD7yX/JVPeOruYburco7pv0Kzc73lVdkNUonrybDbN3V5asQT
         gr5EUkGdU4zCDWnvyzx1ZQsFA6amDND1MYW3GK/SNUH8WL5lCQHdolYHYIxaHZbheu
         oSxakTdmPlWTmNAPkIFczMQYxkYlh8G+RP60B+pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 008/152] net: sched: correct flower port blocking
Date:   Tue,  3 Mar 2020 18:41:46 +0100
Message-Id: <20200303174303.458698362@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
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
@@ -338,4 +339,12 @@ struct bpf_flow_dissector {
 	void			*data_end;
 };
 
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
@@ -303,6 +303,7 @@ static int fl_classify(struct sk_buff *s
 	struct cls_fl_filter *f;
 
 	list_for_each_entry_rcu(mask, &head->masks, list) {
+		flow_dissector_init_keys(&skb_key.control, &skb_key.basic);
 		fl_clear_masked_range(&skb_key, mask);
 
 		skb_flow_dissect_meta(skb, &mask->dissector, &skb_key);


