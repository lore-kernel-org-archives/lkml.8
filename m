Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34434C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181F420714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgH3IJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:09:22 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:53676 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgH3IIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:08:43 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2020 04:08:36 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 07U7nJ6X027387;
        Sun, 30 Aug 2020 10:49:19 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 9127C639D3; Sun, 30 Aug 2020 10:49:19 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     kunyi@google.com, xqiu@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au, tmaimon77@gmail.com,
        wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v1] i2c: npcm7xx: bug fix timeout (usec instead of msec)
Date:   Sun, 30 Aug 2020 10:49:03 +0300
Message-Id: <20200830074903.176871-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c: npcm7xx: bug fix timeout (usec instead of msec)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 75f07138a6fa..c118f93a2610 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2094,7 +2094,7 @@ static int npcm_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	}
 
 	/* Adaptive TimeOut: astimated time in usec + 100% margin */
-	timeout_usec = (2 * 10000 / bus->bus_freq) * (2 + nread + nwrite);
+	timeout_usec = (2 * 10000000 / bus->bus_freq) * (2 + nread + nwrite);
 	timeout = max(msecs_to_jiffies(35), usecs_to_jiffies(timeout_usec));
 	if (nwrite >= 32 * 1024 || nread >= 32 * 1024) {
 		dev_err(bus->dev, "i2c%d buffer too big\n", bus->num);

base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
-- 
2.22.0

