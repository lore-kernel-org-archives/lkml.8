Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE840206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgIIPyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:54:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730627AbgIIPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F16DD5670B8A6110164;
        Wed,  9 Sep 2020 21:49:36 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:49:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 09/19] ALSA: pci/asihpi: Remove unused function hpi_stream_group_get_map()
Date:   Wed, 9 Sep 2020 21:49:27 +0800
Message-ID: <20200909134927.33964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/asihpi/asihpi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 35e76480306e..8bacd4f47540 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -258,15 +258,6 @@ static inline u16 hpi_stream_group_reset(u32 h_stream)
 		return hpi_instream_group_reset(h_stream);
 }
 
-static inline u16 hpi_stream_group_get_map(
-				u32 h_stream, u32 *mo, u32 *mi)
-{
-	if (hpi_handle_object(h_stream) ==  HPI_OBJ_OSTREAM)
-		return hpi_outstream_group_get_map(h_stream, mo, mi);
-	else
-		return hpi_instream_group_get_map(h_stream, mo, mi);
-}
-
 static u16 handle_error(u16 err, int line, char *filename)
 {
 	if (err)
-- 
2.17.1


