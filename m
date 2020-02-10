Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9DB20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338500;
	bh=vf9KklpbgLZ4lTL2iM6rhbETdK/InDMro2YjI76wTv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LgEknCAfzbr8ck4L5tNn9iGT4MmkUbUZKiNNupbS55TBc4CdtxcC535Dy4Z06B/xy
	 6QGogHUdDPLM99gBq7ZlAnKPcs8YRM8gB+S8G9FPNKp94oZpiLdGw3amvmKwiS2mWL
	 ApFF62lY26/4cr4btCZjSeUpU5eLFWTB4msC0lV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgBJMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgBJMix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:53 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA9324676;
        Mon, 10 Feb 2020 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338332;
        bh=vf9KklpbgLZ4lTL2iM6rhbETdK/InDMro2YjI76wTv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evba6Ac/ZseE65Agx4N7JoPYvoAfZBr2jAQX1ecdhkL/YpLafHB5PgKH9yiu57svS
         slhTWhGd3PH18wmXmqXrH7i9q9gwZ7DJ9A3iWhFD2gkmGeXgMh634llTdfPg2d4z6u
         4SNPMtjQF6fl0av+KijIjJ3T1U91BIaQchtb/6pI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Po Liu <po.liu@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 277/309] taprio: Fix enabling offload with wrong number of traffic classes
Date:   Mon, 10 Feb 2020 04:33:53 -0800
Message-Id: <20200210122433.254055073@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 5652e63df3303c2a702bac25fbf710b9cb64dfba ]

If the driver implementing taprio offloading depends on the value of
the network device number of traffic classes (dev->num_tc) for
whatever reason, it was going to receive the value zero. The value was
only set after the offloading function is called.

So, moving setting the number of traffic classes to before the
offloading function is called fixes this issue. This is safe because
this only happens when taprio is instantiated (we don't allow this
configuration to be changed without first removing taprio).

Fixes: 9c66d1564676 ("taprio: Add support for hardware offloading")
Reported-by: Po Liu <po.liu@nxp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1444,6 +1444,19 @@ static int taprio_change(struct Qdisc *s
 
 	taprio_set_picos_per_byte(dev, q);
 
+	if (mqprio) {
+		netdev_set_num_tc(dev, mqprio->num_tc);
+		for (i = 0; i < mqprio->num_tc; i++)
+			netdev_set_tc_queue(dev, i,
+					    mqprio->count[i],
+					    mqprio->offset[i]);
+
+		/* Always use supplied priority mappings */
+		for (i = 0; i <= TC_BITMASK; i++)
+			netdev_set_prio_tc_map(dev, i,
+					       mqprio->prio_tc_map[i]);
+	}
+
 	if (FULL_OFFLOAD_IS_ENABLED(taprio_flags))
 		err = taprio_enable_offload(dev, mqprio, q, new_admin, extack);
 	else
@@ -1471,19 +1484,6 @@ static int taprio_change(struct Qdisc *s
 		q->advance_timer.function = advance_sched;
 	}
 
-	if (mqprio) {
-		netdev_set_num_tc(dev, mqprio->num_tc);
-		for (i = 0; i < mqprio->num_tc; i++)
-			netdev_set_tc_queue(dev, i,
-					    mqprio->count[i],
-					    mqprio->offset[i]);
-
-		/* Always use supplied priority mappings */
-		for (i = 0; i <= TC_BITMASK; i++)
-			netdev_set_prio_tc_map(dev, i,
-					       mqprio->prio_tc_map[i]);
-	}
-
 	if (FULL_OFFLOAD_IS_ENABLED(taprio_flags)) {
 		q->dequeue = taprio_dequeue_offload;
 		q->peek = taprio_peek_offload;


