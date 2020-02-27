Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D5C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F7A246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Oh64htQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgB0Uz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:55:56 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.35]:30209 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbgB0Uzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:55:55 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3BDC2281E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:55:54 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7QCIjcS9OSl8q7QCIjGeQB; Thu, 27 Feb 2020 14:55:54 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MJVDWhNS0EA1OFOvhs7NhRz+ei3OwBXs0MRwTBoRDU4=; b=Oh64htQAJlmzOqavF6aI+lLuQJ
        yi2B+nKcpQZfFWrZv5idvV/Q/+hXpQZTxNa9KjVtZ+NVIcSPHAkQPeVPoJzgaNpOn8oOBRl/yJpNI
        6IXWFhyg0UV2A9SKm3l/FfvLLH5moAfzOnMjkeSkASwzKcWnB2p+LA/n8As+H3cSDp58G1mR6l2tW
        Y9JPYyCFF8pdl/rM3LkT94GzUsj7XzMd9ecaG/iPC7nK8ZQNZUyhjfKjAnjlGJeeG1AYUgM95vQav
        Hhiq7LtryQNNXCR0mb0Q1t5pki/ZLmSF6etUd0tNwjKghmm8r5Se+qW+y3X9RO7RsrbBTrlsSNIQ7
        C9UM2cNg==;
Received: from [201.162.169.69] (port=8222 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7QCF-000kyF-UD; Thu, 27 Feb 2020 14:55:52 -0600
Date:   Thu, 27 Feb 2020 14:58:44 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net: sched: Replace zero-length array with
 flexible-array member
Message-ID: <20200227205844.GA18578@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.169.69
X-Source-L: No
X-Exim-ID: 1j7QCF-000kyF-UD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.169.69]:8222
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/net/pkt_sched.h | 2 +-
 net/sched/em_ipt.c      | 2 +-
 net/sched/em_nbyte.c    | 2 +-
 net/sched/sch_atm.c     | 2 +-
 net/sched/sch_netem.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 6a70845bd9ab..20d2c6419612 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -181,7 +181,7 @@ struct tc_taprio_qopt_offload {
 	u64 cycle_time_extension;
 
 	size_t num_entries;
-	struct tc_taprio_sched_entry entries[0];
+	struct tc_taprio_sched_entry entries[];
 };
 
 /* Reference counting */
diff --git a/net/sched/em_ipt.c b/net/sched/em_ipt.c
index 9fff6480acc6..eecfe072c508 100644
--- a/net/sched/em_ipt.c
+++ b/net/sched/em_ipt.c
@@ -22,7 +22,7 @@ struct em_ipt_match {
 	const struct xt_match *match;
 	u32 hook;
 	u8 nfproto;
-	u8 match_data[0] __aligned(8);
+	u8 match_data[] __aligned(8);
 };
 
 struct em_ipt_xt_match {
diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
index 88c7ce42df7e..2c1192a2ee5e 100644
--- a/net/sched/em_nbyte.c
+++ b/net/sched/em_nbyte.c
@@ -16,7 +16,7 @@
 
 struct nbyte_data {
 	struct tcf_em_nbyte	hdr;
-	char			pattern[0];
+	char			pattern[];
 };
 
 static int em_nbyte_change(struct net *net, void *data, int data_len,
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index f4f9b8cdbffb..ee12ca9f55b4 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -58,7 +58,7 @@ struct atm_flow_data {
 	struct atm_flow_data	*excess;	/* flow for excess traffic;
 						   NULL to set CLP instead */
 	int			hdr_len;
-	unsigned char		hdr[0];		/* header data; MUST BE LAST */
+	unsigned char		hdr[];		/* header data; MUST BE LAST */
 };
 
 struct atm_qdisc_data {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 42e557d48e4e..84f82771cdf5 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -66,7 +66,7 @@
 
 struct disttable {
 	u32  size;
-	s16 table[0];
+	s16 table[];
 };
 
 struct netem_sched_data {
-- 
2.25.0

