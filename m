Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD364C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F11420737
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660719;
	bh=/rsiNZmJKMU7ImUM+XD8KQ6xKLVf5BpHcUfc7DiIKDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wNJfqVZ94Q9SM29QaV07VdhbOEh24ZKBUNOzKrrraRpmr9TY/yQWbhVVR3fDXKyQH
	 Ym3kJzRMlRYkM2V38iqc8xdrqAb8dipNLB2smXWjtdqg+avQPQfL9kd39zEkTTjTAe
	 fULvBPPlOLc+cHBgkS2mc8lDVUNazs8Jtp3hf85o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgFHX6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbgFHXXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:23:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A382A20899;
        Mon,  8 Jun 2020 23:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658591;
        bh=/rsiNZmJKMU7ImUM+XD8KQ6xKLVf5BpHcUfc7DiIKDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJB3TY+orpPhaXiEqle9dhpG4RxQqWii7/TV3KrxYwM2yEISIIkBnns9Dlv5Wedl6
         bqxlTUX1hT+EWhVZALi23BL9ppr/fO/b09aiADzPrdxzfq5VI5CnN5Ey3RQlFAXHpN
         ZiHUt9wiwMcRRUEA7EcX39O0HF5xKIBgC0Vbplxk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 025/106] batman-adv: Revert "disable ethtool link speed detection when auto negotiation off"
Date:   Mon,  8 Jun 2020 19:21:17 -0400
Message-Id: <20200608232238.3368589-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 9ad346c90509ebd983f60da7d082f261ad329507 ]

The commit 8c46fcd78308 ("batman-adv: disable ethtool link speed detection
when auto negotiation off") disabled the usage of ethtool's link_ksetting
when auto negotation was enabled due to invalid values when used with
tun/tap virtual net_devices. According to the patch, automatic measurements
should be used for these kind of interfaces.

But there are major flaws with this argumentation:

* automatic measurements are not implemented
* auto negotiation has nothing to do with the validity of the retrieved
  values

The first point has to be fixed by a longer patch series. The "validity"
part of the second point must be addressed in the same patch series by
dropping the usage of ethtool's link_ksetting (thus always doing automatic
measurements over ethernet).

Drop the patch again to have more default values for various net_device
types/configurations. The user can still overwrite them using the
batadv_hardif's BATADV_ATTR_THROUGHPUT_OVERRIDE.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 5da183b2f4c9..af3da6cdfc79 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -132,20 +132,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
-
-	/* Virtual interface drivers such as tun / tap interfaces, VLAN, etc
-	 * tend to initialize the interface throughput with some value for the
-	 * sake of having a throughput number to export via ethtool. This
-	 * exported throughput leaves batman-adv to conclude the interface
-	 * throughput is genuine (reflecting reality), thus no measurements
-	 * are necessary.
-	 *
-	 * Based on the observation that those interface types also tend to set
-	 * the link auto-negotiation to 'off', batman-adv shall check this
-	 * setting to differentiate between genuine link throughput information
-	 * and placeholders installed by virtual interfaces.
-	 */
-	if (ret == 0 && link_settings.base.autoneg == AUTONEG_ENABLE) {
+	if (ret == 0) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
 			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
-- 
2.25.1

