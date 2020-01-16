Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FCFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C7C2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200235;
	bh=9XJwnazhiYQY51xsLb0uEpUbjiC6C81qKHxL79F1hS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bmpTpetsRTVZA0/45RoQiqEfY+PzP92YPxjBjKDYwxgKvmAg+croNnadvwuIOodRo
	 gjcvzdT3qIGVlrzt8VyryEwLpsdo44AnAOV9N3H7yU+GrqsRuHKqbU8jGvtbGfE3Tf
	 /4fQBmM39pnusmhmqBC2LHCB4zX3/OI7pUTxa2N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbgAPSny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389453AbgAPRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EB024697;
        Thu, 16 Jan 2020 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194666;
        bh=9XJwnazhiYQY51xsLb0uEpUbjiC6C81qKHxL79F1hS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcTCt1YcP12eiPcxbG8cN3VAkne/KisMHB47hJC99qDc+iYR90ZCerUJrlQC3iqiX
         zNdHbO7p5FkkhKrUVk/epZyILI+u0lcOpfAG4Ipo7CZNCvS9F7xW9UkyYUo6AObqRP
         5JJxfcMT11WfCepIANX2kveezS/NBtJ6O6qlrNjI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Leandro Dorileo <leandro.maciel.dorileo@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 515/671] net/sched: cbs: Set default link speed to 10 Mbps in cbs_set_port_rate
Date:   Thu, 16 Jan 2020 12:02:33 -0500
Message-Id: <20200116170509.12787-252-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit 1c6c09a0ae62fa3ea8f8ead2ac3920e6fff2de64 ]

The discussion to be made is absolutely the same as in the case of
previous patch ("taprio: Set default link speed to 10 Mbps in
taprio_set_picos_per_byte"). Nothing is lost when setting a default.

Cc: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index b3c8d04929df..289f66b9238d 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -185,11 +185,6 @@ static struct sk_buff *cbs_dequeue_soft(struct Qdisc *sch)
 	s64 credits;
 	int len;
 
-	if (atomic64_read(&q->port_rate) == -1) {
-		WARN_ONCE(1, "cbs: dequeue() called with unknown port rate.");
-		return NULL;
-	}
-
 	if (q->credits < 0) {
 		credits = timediff_to_credits(now - q->last, q->idleslope);
 
@@ -307,11 +302,19 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
 static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
+	int speed = SPEED_10;
 	int port_rate = -1;
+	int err;
+
+	err = __ethtool_get_link_ksettings(dev, &ecmd);
+	if (err < 0)
+		goto skip;
+
+	if (ecmd.base.speed != SPEED_UNKNOWN)
+		speed = ecmd.base.speed;
 
-	if (!__ethtool_get_link_ksettings(dev, &ecmd) &&
-	    ecmd.base.speed != SPEED_UNKNOWN)
-		port_rate = ecmd.base.speed * 1000 * BYTES_PER_KBIT;
+skip:
+	port_rate = speed * 1000 * BYTES_PER_KBIT;
 
 	atomic64_set(&q->port_rate, port_rate);
 	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",
-- 
2.20.1

