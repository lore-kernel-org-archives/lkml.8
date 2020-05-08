Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6FCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321C920708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEHLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:55:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4353 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgEHLzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:55:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B627BD4A694D61ED3C96;
        Fri,  8 May 2020 19:54:59 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 19:54:51 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <olteanv@gmail.com>, <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] net: dsa: sja1105: remove set but not used variable 'prev_time'
Date:   Fri, 8 May 2020 20:00:55 +0800
Message-ID: <1588939255-58038-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/dsa/sja1105/sja1105_vl.c:468:6: warning: variable ‘prev_time’ set but not used [-Wunused-but-set-variable]
  u32 prev_time = 0;
      ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/net/dsa/sja1105/sja1105_vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_vl.c b/drivers/net/dsa/sja1105/sja1105_vl.c
index b52f1af..aa9b0b9 100644
--- a/drivers/net/dsa/sja1105/sja1105_vl.c
+++ b/drivers/net/dsa/sja1105/sja1105_vl.c
@@ -465,7 +465,6 @@ sja1105_gating_cfg_time_to_interval(struct sja1105_gating_config *gating_cfg,
 	struct sja1105_gate_entry *last_e;
 	struct sja1105_gate_entry *e;
 	struct list_head *prev;
-	u32 prev_time = 0;
 
 	list_for_each_entry(e, &gating_cfg->entries, list) {
 		struct sja1105_gate_entry *p;
@@ -476,7 +475,6 @@ sja1105_gating_cfg_time_to_interval(struct sja1105_gating_config *gating_cfg,
 			continue;
 
 		p = list_entry(prev, struct sja1105_gate_entry, list);
-		prev_time = e->interval;
 		p->interval = e->interval - p->interval;
 	}
 	last_e = list_last_entry(&gating_cfg->entries,
-- 
2.6.2

