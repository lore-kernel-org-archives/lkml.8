Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4166EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC5B206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462266;
	bh=JpFSUhI2aC9MhxzUpkJ11iGuBLjxS/NxXQiPYfC0n1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyDkCRxtGDF6QrbIwU+eF0Bv0hok2Acnbsl+doNRIBZVOKuNedXby+yCqlbLP/P0u
	 1U2KvJc0u9+lO+73/6AjLvNr4AEmKD7O95tYXD3cW7e2dzlQdHSFjrmRhb77ZQKcxm
	 MQXXfA+/ADkNbPmVALgdm1TkJClOCf4l9YFQreBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgF2UYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732550AbgF2TZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578D1253FA;
        Mon, 29 Jun 2020 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445345;
        bh=JpFSUhI2aC9MhxzUpkJ11iGuBLjxS/NxXQiPYfC0n1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbLr6OA6zb/e6gXQoxXEZfF9dmG9TjMfdp6vCprNx0wZN+y2yuNyMGNJpHT1fr7WB
         diLzQUcRCYKeqp6TiKLDDE87oBsLrV8ntd5/Tvpzy5d/NGFNK+0coIBjfkWO+OucMH
         jx5wG6pQ8LVOsl2hSr9oWplCbHyWbMY641nUvUcI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 103/191] media: stv0288: get rid of set_property boilerplate
Date:   Mon, 29 Jun 2020 11:38:39 -0400
Message-Id: <20200629154007.2495120-104-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 473e4b4c1cf3046fc6b3437be9a9f3c89c2e61ef upstream

This driver doesn't implement support for set_property(). Yet,
it implements a boilerplate for it. Get rid of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/stv0288.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0288.c b/drivers/media/dvb-frontends/stv0288.c
index c93d9a45f7f79..2b8c75f28d2e8 100644
--- a/drivers/media/dvb-frontends/stv0288.c
+++ b/drivers/media/dvb-frontends/stv0288.c
@@ -447,12 +447,6 @@ static int stv0288_read_ucblocks(struct dvb_frontend *fe, u32 *ucblocks)
 	return 0;
 }
 
-static int stv0288_set_property(struct dvb_frontend *fe, struct dtv_property *p)
-{
-	dprintk("%s(..)\n", __func__);
-	return 0;
-}
-
 static int stv0288_set_frontend(struct dvb_frontend *fe)
 {
 	struct stv0288_state *state = fe->demodulator_priv;
@@ -568,7 +562,6 @@ static struct dvb_frontend_ops stv0288_ops = {
 	.set_tone = stv0288_set_tone,
 	.set_voltage = stv0288_set_voltage,
 
-	.set_property = stv0288_set_property,
 	.set_frontend = stv0288_set_frontend,
 };
 
-- 
2.25.1

