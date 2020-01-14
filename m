Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B38C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC222187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANGwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:52:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbgANGwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:52:33 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DCB5CAEB169531A42777
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 14:52:30 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 14:52:24 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <perex@perex.cz>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH] core: remove set but not used variable 'checksum'
Date:   Tue, 14 Jan 2020 14:50:28 +0800
Message-ID: <20200114065028.616-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pnp/isapnp/core.c: In function ‘isapnp_build_device_list’:
drivers/pnp/isapnp/core.c:777:27: warning: variable ‘checksum’
set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/pnp/isapnp/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 179b737280e1..e39d49bceae0 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -774,7 +774,7 @@ static unsigned char __init isapnp_checksum(unsigned char *data)
 static int __init isapnp_build_device_list(void)
 {
 	int csn;
-	unsigned char header[9], checksum;
+	unsigned char header[9];
 	struct pnp_card *card;
 	u32 eisa_id;
 	char id[8];
@@ -784,7 +784,6 @@ static int __init isapnp_build_device_list(void)
 	for (csn = 1; csn <= isapnp_csn_count; csn++) {
 		isapnp_wake(csn);
 		isapnp_peek(header, 9);
-		checksum = isapnp_checksum(header);
 		eisa_id = header[0] | header[1] << 8 |
 			  header[2] << 16 | header[3] << 24;
 		pnp_eisa_id_to_string(eisa_id, id);
-- 
2.17.2

