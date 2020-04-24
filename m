Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4292C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5720728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgDXMK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:10:56 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46FFC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:10:55 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:8134:2f28:3a79:6257])
        by laurent.telenet-ops.be with bizsmtp
        id WcAs2200D3LKRvX01cAsFr; Fri, 24 Apr 2020 14:10:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jRxAS-0005xQ-CC; Fri, 24 Apr 2020 14:10:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jRxAS-0001KK-9Z; Fri, 24 Apr 2020 14:10:52 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: openvswitch: use do_div() for 64-by-32 divisions:
Date:   Fri, 24 Apr 2020 14:10:51 +0200
Message-Id: <20200424121051.5056-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures (e.g. m68k):

    ERROR: modpost: "__udivdi3" [net/openvswitch/openvswitch.ko] undefined!
    ERROR: modpost: "__divdi3" [net/openvswitch/openvswitch.ko] undefined!

Fixes: e57358873bb5d6ca ("net: openvswitch: use u64 for meter bucket")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/openvswitch/meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index 915f31123f235c03..3498a5ab092ab2b8 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -393,7 +393,7 @@ static struct dp_meter *dp_meter_create(struct nlattr **a)
 		 * Start with a full bucket.
 		 */
 		band->bucket = (band->burst_size + band->rate) * 1000ULL;
-		band_max_delta_t = band->bucket / band->rate;
+		band_max_delta_t = do_div(band->bucket, band->rate);
 		if (band_max_delta_t > meter->max_delta_t)
 			meter->max_delta_t = band_max_delta_t;
 		band++;
-- 
2.17.1

