Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6DC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651442075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pJhf4HaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHZBus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:49:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:49:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b17so174341wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4z/80YMT7r/2XPt+q1H560KQo/33xQgEXp21sNkmO4=;
        b=pJhf4HaYxbpq0Az8ZRTtZewR7KRrnMlpRJJoVod4OUsQFPPO6h94qY2T7lCXbJnc2J
         rOc9KDyeB5iL735kUZS7QLrwf2/gjG6msLAUUOsGFDmcayGsXM+3En+n++2Er7TUdozq
         pjztsU65wqrb7nPJGhk8yJINiN+yF+ygjNSUgwXe0292sGzHwsKhhJaxFFkIxVwTGbpg
         zyKGGrPADDRZUr88pEKElho+Zk+F7chW+zFHVQKG6jsQHIZhom1X/t++zZkWF99rLdMQ
         98Aw6iziI/KubH6D91LkfdGDT0FzsZiSv3H7O+idoIAWIL5dNz4c8QmAouazotBBITtb
         zU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4z/80YMT7r/2XPt+q1H560KQo/33xQgEXp21sNkmO4=;
        b=O1cFuOl6VD4SkzoBXg36Q+u1dbWQdiFnivZz/nJJ3Vm0UB2gA9GoOrCav3aq12hL67
         cImBsOQcfPWGmONFT1+SH4cJ5T/hwJ8ErFRq7yUhMZmcfz1sBc4xuwU3V/YyJJ84YY4O
         VHNmLL/0B2GjA8g+ipk6VM7JpQzL/bTjI7Watw6HQBVxQBq6+tjqcmjmu/ARxwWfSiyg
         RyajbZ0W744RAnqHN7s/ddpPw5q8DGfvi+ddrNs2KnND5tpOa8jY+xT/tGAPgX3VqieH
         042UrI44wqYan3572RRyI3NhtOXyeRQa9G/Y5mv1xISWLHCs/g3ysOumbz44caPq4VKd
         0JdA==
X-Gm-Message-State: AOAM531G2WnEIQNcnGD5qn8EM1MFzfZ1PbIAFfbfHAAR7KKCE3jKQlB/
        sxntKI3yCiQ110KLXOoABw75ByJa0Z9SuVyOCUk=
X-Google-Smtp-Source: ABdhPJwLo0u0fGc8+tWN58LJlQ1Cdd8blAm5no4gadCnQY3WbtMGLn97rB4tU1ljN5J2HQQYr6DiuQ==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr12277714wrf.190.1598406594695;
        Tue, 25 Aug 2020 18:49:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c10sm1263661wmk.30.2020.08.25.18.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 18:49:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 3/6] netlink/compat: Append NLMSG_DONE/extack to frag_list
Date:   Wed, 26 Aug 2020 02:49:46 +0100
Message-Id: <20200826014949.644441-4-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200826014949.644441-1-dima@arista.com>
References: <20200826014949.644441-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modules those use netlink may supply a 2nd skb, (via frag_list)
that contains an alternative data set meant for applications
using 32bit compatibility mode.

In such a case, netlink_recvmsg will use this 2nd skb instead of the
original one.

Without this patch, such compat applications will retrieve
all netlink dump data, but will then get an unexpected EOF.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/netlink/af_netlink.c | 48 ++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b5f30d7d30d0..b096f2b4a50d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2186,13 +2186,36 @@ EXPORT_SYMBOL(__nlmsg_put);
  * It would be better to create kernel thread.
  */
 
+static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
+			     struct netlink_callback *cb,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put_answer(skb, cb, NLMSG_DONE, sizeof(nlk->dump_done_errno),
+			       NLM_F_MULTI | cb->answer_flags);
+	if (WARN_ON(!nlh))
+		return -ENOBUFS;
+
+	nl_dump_check_consistent(cb, nlh);
+	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno,
+			sizeof(nlk->dump_done_errno));
+
+	if (extack->_msg && nlk->flags & NETLINK_F_EXT_ACK) {
+		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
+		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
+			nlmsg_end(skb, nlh);
+	}
+
+	return 0;
+}
+
 static int netlink_dump(struct sock *sk)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
-	struct nlmsghdr *nlh;
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
@@ -2258,22 +2281,19 @@ static int netlink_dump(struct sock *sk)
 		return 0;
 	}
 
-	nlh = nlmsg_put_answer(skb, cb, NLMSG_DONE,
-			       sizeof(nlk->dump_done_errno),
-			       NLM_F_MULTI | cb->answer_flags);
-	if (WARN_ON(!nlh))
+	if (netlink_dump_done(nlk, skb, cb, &extack))
 		goto errout_skb;
 
-	nl_dump_check_consistent(cb, nlh);
-
-	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno,
-	       sizeof(nlk->dump_done_errno));
-
-	if (extack._msg && nlk->flags & NETLINK_F_EXT_ACK) {
-		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
-		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack._msg))
-			nlmsg_end(skb, nlh);
+#ifdef CONFIG_COMPAT_NETLINK_MESSAGES
+	/* frag_list skb's data is used for compat tasks
+	 * and the regular skb's data for normal (non-compat) tasks.
+	 * See netlink_recvmsg().
+	 */
+	if (unlikely(skb_shinfo(skb)->frag_list)) {
+		if (netlink_dump_done(nlk, skb_shinfo(skb)->frag_list, cb, &extack))
+			goto errout_skb;
 	}
+#endif
 
 	if (sk_filter(sk, skb))
 		kfree_skb(skb);
-- 
2.27.0

