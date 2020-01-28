Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16DE2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA1TNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:13:13 -0500
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:41667 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgA1TNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:13:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 297A01801D7D4;
        Tue, 28 Jan 2020 19:13:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kiss45_72c9af011f710
X-Filterd-Recvd-Size: 1472
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jan 2020 19:13:08 +0000 (UTC)
Message-ID: <8f13c6144a9bd42a1bc5e281d77fb4bc53043e96.camel@perches.com>
Subject: [PATCH] sch_choke: Use kvcalloc
From:   Joe Perches <joe@perches.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jan 2020 11:12:03 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the use of kvmalloc_array with __GFP_ZERO to
the equivalent kvcalloc.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/sched/sch_choke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index dba7037..a36974e 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -377,7 +377,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 	if (mask != q->tab_mask) {
 		struct sk_buff **ntab;
 
-		ntab = kvmalloc_array((mask + 1), sizeof(struct sk_buff *), GFP_KERNEL | __GFP_ZERO);
+		ntab = kvcalloc(mask + 1, sizeof(struct sk_buff *), GFP_KERNEL);
 		if (!ntab)
 			return -ENOMEM;
 

