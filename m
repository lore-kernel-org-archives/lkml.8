Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902BDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B4420734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGQHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:10:24 -0400
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:23832
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726166AbgGQHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:10:23 -0400
Received: from localhost.localdomain (unknown [218.77.105.7])
        by c1app1 (Coremail) with SMTP id AQINCgDnhpnKThFfx6ivAQ--.31076S2;
        Fri, 17 Jul 2020 15:10:03 +0800 (CST)
From:   Qiu Wenbo <qiuwenbo@phytium.com.cn>
To:     Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chen Wandun <chenwandun@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, yu kuai <yukuai3@huawei.com>,
        Eric Huang <JinHuiEric.Huang@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix a crash when overclocking Vega M
Date:   Fri, 17 Jul 2020 15:09:57 +0800
Message-Id: <20200717070958.41489-1-qiuwenbo@phytium.com.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQINCgDnhpnKThFfx6ivAQ--.31076S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47Cw1UZF48WFWUJFyxKrg_yoW8CFWrpF
        93GrZ0vw15JFZrAFyxAF4rWFn7ZwnrZa4rKryUG390vw12qrW09FyDAFySgrW8Ga97Jr43
        Kw47Z345JFsakrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjE1v3UUUUU==
X-Originating-IP: [218.77.105.7]
X-CM-SenderInfo: 5tlx4vhqerq15k1wx33pof0zgofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid kernel crash when vddci_control is SMU7_VOLTAGE_CONTROL_NONE and
vddci_voltage_table is empty. It has been tested on Intel Hades Canyon
(i7-8809G).

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208489
Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 3da71a088b92..0ecc18b55ffb 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -644,9 +644,6 @@ static int vegam_get_dependency_volt_by_clk(struct pp_hwmgr *hwmgr,
 
 	/* sclk is bigger than max sclk in the dependence table */
 	*voltage |= (dep_table->entries[i - 1].vddc * VOLTAGE_SCALE) << VDDC_SHIFT;
-	vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
-			(dep_table->entries[i - 1].vddc -
-					(uint16_t)VDDC_VDDCI_DELTA));
 
 	if (SMU7_VOLTAGE_CONTROL_NONE == data->vddci_control)
 		*voltage |= (data->vbios_boot_state.vddci_bootup_value *
@@ -654,8 +651,13 @@ static int vegam_get_dependency_volt_by_clk(struct pp_hwmgr *hwmgr,
 	else if (dep_table->entries[i - 1].vddci)
 		*voltage |= (dep_table->entries[i - 1].vddci *
 				VOLTAGE_SCALE) << VDDC_SHIFT;
-	else
+	else {
+		vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
+				(dep_table->entries[i - 1].vddc -
+						(uint16_t)VDDC_VDDCI_DELTA));
+
 		*voltage |= (vddci * VOLTAGE_SCALE) << VDDCI_SHIFT;
+	}
 
 	if (SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control)
 		*mvdd = data->vbios_boot_state.mvdd_bootup_value * VOLTAGE_SCALE;
-- 
2.27.0

