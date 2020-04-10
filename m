Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04A32082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491385;
	bh=UNXYY5nHx1oKv7D1DvC75seHCoQHrTodEf3J7c6UTf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q6EsciNtj363Zx/r3yYIZIW1GqBw0kl/vhmmE1Cu4/iqmMOfApyTcg2/hInup0R8Y
	 XUCHua0ov63ZWIC7P7zEiCgNNoW2pKrO1ipoqRen/3HoB10ZNjigUNJ9dP4i49N9tw
	 u/vAfObrYG9wx58K7dUMvqG1QRW27B9b9X89KlO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDJDqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgDJDqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D9520936;
        Fri, 10 Apr 2020 03:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490405;
        bh=UNXYY5nHx1oKv7D1DvC75seHCoQHrTodEf3J7c6UTf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfiUtdNunFDH6nqVmAUADcOH9PDrmjdsqm1HJ7RJv8iwp0WBjARR+9f7Ff0LwHe2D
         jTJ2bwqd9sRPRfqxC91hXZl89xhwDmkVcqhtgIFImJHCJFChCJ++UHV7xbgA0Nq8Cw
         rSWxYMjwhhkv4Mg1wXILTlPJAPh65JeR0ef+snPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Wojciech Zabolotny <wzab01@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.6 08/68] media: staging: rkisp1: isp: do not set invalid mbus code for pad
Date:   Thu,  9 Apr 2020 23:45:33 -0400
Message-Id: <20200410034634.7731-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 100f720aabab3d5f58f67c508186041b3c797a9b ]

When setting source pad, check if the given mbus code is indeed valid
for source pad, if not, then set the default code.
Same for sink pad.

Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
Reported-by: Wojciech Zabolotny <wzab01@gmail.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkisp1/rkisp1-isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-isp.c b/drivers/staging/media/rkisp1/rkisp1-isp.c
index 328c7ea609717..db892620a5675 100644
--- a/drivers/staging/media/rkisp1/rkisp1-isp.c
+++ b/drivers/staging/media/rkisp1/rkisp1-isp.c
@@ -683,7 +683,7 @@ static void rkisp1_isp_set_src_fmt(struct rkisp1_isp *isp,
 
 	src_fmt->code = format->code;
 	mbus_info = rkisp1_isp_mbus_info_get(src_fmt->code);
-	if (!mbus_info) {
+	if (!mbus_info || !(mbus_info->direction & RKISP1_DIR_SRC)) {
 		src_fmt->code = RKISP1_DEF_SRC_PAD_FMT;
 		mbus_info = rkisp1_isp_mbus_info_get(src_fmt->code);
 	}
@@ -767,7 +767,7 @@ static void rkisp1_isp_set_sink_fmt(struct rkisp1_isp *isp,
 					  which);
 	sink_fmt->code = format->code;
 	mbus_info = rkisp1_isp_mbus_info_get(sink_fmt->code);
-	if (!mbus_info) {
+	if (!mbus_info || !(mbus_info->direction & RKISP1_DIR_SINK)) {
 		sink_fmt->code = RKISP1_DEF_SINK_PAD_FMT;
 		mbus_info = rkisp1_isp_mbus_info_get(sink_fmt->code);
 	}
-- 
2.20.1

