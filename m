Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C576C20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgE0NDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:03:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729834AbgE0NDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:03:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D8D22B47129997C92BD;
        Wed, 27 May 2020 21:03:01 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 21:02:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <nchatrad@amd.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <yuehaibing@huawei.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hwmon: (amd_energy) Fix build error
Date:   Wed, 27 May 2020 21:02:41 +0800
Message-ID: <20200527130241.58468-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_NEED_MULTIPLE_NODES is n, building fails:

drivers/hwmon/amd_energy.c: In function ‘amd_energy_read’:
./include/asm-generic/topology.h:51:36: error: void value not ignored as it ought to be
     #define cpumask_of_node(node) ((void)node, cpu_online_mask)
./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                        ^~~~~
drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
      cpumask_of_node
      ^~~~~~~~~~~~~~~
./include/asm-generic/topology.h:51:46: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     #define cpumask_of_node(node) ((void)node, cpu_online_mask)
                                              ^
./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                        ^~~~~
drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
      cpumask_of_node
      ^~~~~~~~~~~~~~~

Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwmon/amd_energy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/amd_energy.c b/drivers/hwmon/amd_energy.c
index bc8b643a37d5..9d5cd3057866 100644
--- a/drivers/hwmon/amd_energy.c
+++ b/drivers/hwmon/amd_energy.c
@@ -192,7 +192,7 @@ static int amd_energy_read(struct device *dev,
 	if (channel >= data->nr_cpus) {
 		cpu = cpumask_first_and(cpu_online_mask,
 					cpumask_of_node
-					(channel - data->nr_cpus));
+					((channel - data->nr_cpus)));
 		amd_add_delta(data, channel, cpu, val, false);
 	} else {
 		cpu = channel;
-- 
2.17.1


