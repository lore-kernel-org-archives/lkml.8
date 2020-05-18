Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B2BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8F520849
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823813;
	bh=fGBROYDxdQQozDWu/J6DkYIQUBAR/xN0ABEzDiLWZuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+OaWWs19eBk8OPVM+oUOArZ/ax3XnzrQNkfPB9iIy6G87r3JrQR4wQxUrGxRxrDO
	 EfV+k1Mjrx/2JcpwoG115Tdd6b55TPrdx17wejskZ5t3PI1BX6gAu4lFT7VhEYgc+j
	 9cGUpDm/sdR2cVgwAAZPyvBTvEZiQ65H6FYfWqUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgERRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbgERRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:43:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387FE20657;
        Mon, 18 May 2020 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823808;
        bh=fGBROYDxdQQozDWu/J6DkYIQUBAR/xN0ABEzDiLWZuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+tpmqBlkDoMgXfVIkrym8vLlfduqDyFNbEkUZJlTgqMJSh0/Z87hsfqcfkOJ8DYL
         7Nqm4Qqc3yCRlLDW0CTIytwUceVIZ2KZGF1WI4h9Q+Nzp+wMku73rmdHkaNoq9RFhm
         Z4pL4AKm1u5mTc3S+BK/1EFoIzbRX6QdoDFf2jAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/90] drop_monitor: work around gcc-10 stringop-overflow warning
Date:   Mon, 18 May 2020 19:36:22 +0200
Message-Id: <20200518173500.248110788@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit dc30b4059f6e2abf3712ab537c8718562b21c45d ]

The current gcc-10 snapshot produces a false-positive warning:

net/core/drop_monitor.c: In function 'trace_drop_common.constprop':
cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
In file included from net/core/drop_monitor.c:23:
include/uapi/linux/net_dropmon.h:36:8: note: at offset 0 to object 'entries' with size 4 declared here
   36 |  __u32 entries;
      |        ^~~~~~~

I reported this in the gcc bugzilla, but in case it does not get
fixed in the release, work around it by using a temporary variable.

Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94881
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/drop_monitor.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index ca2c9c8b9a3e9..6d7ff117f3792 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -159,6 +159,7 @@ static void sched_send_work(unsigned long _data)
 static void trace_drop_common(struct sk_buff *skb, void *location)
 {
 	struct net_dm_alert_msg *msg;
+	struct net_dm_drop_point *point;
 	struct nlmsghdr *nlh;
 	struct nlattr *nla;
 	int i;
@@ -177,11 +178,13 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 	nlh = (struct nlmsghdr *)dskb->data;
 	nla = genlmsg_data(nlmsg_data(nlh));
 	msg = nla_data(nla);
+	point = msg->points;
 	for (i = 0; i < msg->entries; i++) {
-		if (!memcmp(&location, msg->points[i].pc, sizeof(void *))) {
-			msg->points[i].count++;
+		if (!memcmp(&location, &point->pc, sizeof(void *))) {
+			point->count++;
 			goto out;
 		}
+		point++;
 	}
 	if (msg->entries == dm_hit_limit)
 		goto out;
@@ -190,8 +193,8 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 	 */
 	__nla_reserve_nohdr(dskb, sizeof(struct net_dm_drop_point));
 	nla->nla_len += NLA_ALIGN(sizeof(struct net_dm_drop_point));
-	memcpy(msg->points[msg->entries].pc, &location, sizeof(void *));
-	msg->points[msg->entries].count = 1;
+	memcpy(point->pc, &location, sizeof(void *));
+	point->count = 1;
 	msg->entries++;
 
 	if (!timer_pending(&data->send_timer)) {
-- 
2.20.1



