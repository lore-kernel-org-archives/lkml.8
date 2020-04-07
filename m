Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_FUTURE_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F3FC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9B20738
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDFDsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:48:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgDFDsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:48:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF2DCA56CD1823537BB0;
        Mon,  6 Apr 2020 11:47:54 +0800 (CST)
Received: from huawei.com (10.175.112.70) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 11:47:48 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] Staging: comedi: dt2815: remove set but not used variable 'hi'
Date:   Tue, 7 Apr 2020 08:59:32 -0400
Message-ID: <1586264372-15872-1-git-send-email-wanghai38@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/comedi/drivers/dt2815.c: In function dt2815_ao_insn:
drivers/staging/comedi/drivers/dt2815.c:91:19: warning: variable 'hi' set but not used [-Wunused-but-set-variable]

commit d6a929b7608a ("Staging: comedi: add dt2815 driver")
involved this, remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/staging/comedi/drivers/dt2815.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/staging/comedi/drivers/dt2815.c
index 83026ba..bcf85ec 100644
--- a/drivers/staging/comedi/drivers/dt2815.c
+++ b/drivers/staging/comedi/drivers/dt2815.c
@@ -88,12 +88,11 @@ static int dt2815_ao_insn(struct comedi_device *dev, struct comedi_subdevice *s,
 	struct dt2815_private *devpriv = dev->private;
 	int i;
 	int chan = CR_CHAN(insn->chanspec);
-	unsigned int lo, hi;
+	unsigned int lo;
 	int ret;
 
 	for (i = 0; i < insn->n; i++) {
 		lo = ((data[i] & 0x0f) << 4) | (chan << 1) | 0x01;
-		hi = (data[i] & 0xff0) >> 4;
 
 		ret = comedi_timeout(dev, s, insn, dt2815_ao_status, 0x00);
 		if (ret)
-- 
1.8.3.1

