Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E09C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33FD2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHCNgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:36:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbgHCNgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:36:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00FFFD14CE8144C6A7DE;
        Mon,  3 Aug 2020 21:36:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 21:36:28 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <gregkh@linuxfoundation.org>, <saiprakash.ranjan@codeaurora.org>,
        <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] coresight: etm4x: Add Support for HiSilicon ETM device
Date:   Mon, 3 Aug 2020 21:35:40 +0800
Message-ID: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
contains ETMv4.2 device and Hip09 contains ETMv4.5 device.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 0c35cd5e..4a4f0bd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1561,6 +1561,8 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 };

 static const struct amba_id etm4_ids[] = {
+	CS_AMBA_ID(0x000b6d02),			/* HiSilicon-Hip09 */
+	CS_AMBA_ID(0x000b6d01),			/* HiSilicon-Hip08 */
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
 	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
--
2.8.1

