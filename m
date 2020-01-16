Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3053C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98BE2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217132;
	bh=nihXBOFluQniosqvBT9Ave0NS8Z6fso164nYyKINBoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ntj9EzksBjGeMZmQKFS1nL34oaDktPBalISmATyXSI+MpZc/OTMeQXPBOZuZU2/w5
	 dW5TKbbIH9jiZOZZq428+rWPpyhiNP8Bi47Y/mH60ikT33prFx2e6VVsYIgL6pHI22
	 iBkZpIpq90p4fWZqffFpoXPZR2XCdStj+TWyGZoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgAPXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733020AbgAPXZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:25:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5BC2072B;
        Thu, 16 Jan 2020 23:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217115;
        bh=nihXBOFluQniosqvBT9Ave0NS8Z6fso164nYyKINBoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbJ9JiAyFx6K0kBqel2Q/n5vFMhD0lil5PijPU4boqif99pLLn6sDZicfmWreSyMy
         ISrLoRGfFsKv689kvH9NbaYgvzsWLr3pupgRjgv7wwtq6UHyYXntBfeA09/bwTei8s
         ojjRMhYCJjLbhzg1qTct6+bVA6jFWqpjzb0r0UKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.4 154/203] media: coda: fix deadlock between decoder picture run and start command
Date:   Fri, 17 Jan 2020 00:17:51 +0100
Message-Id: <20200116231758.296412614@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

commit a3fd80198de6ab98a205cf7fb148d88e9e1c44bb upstream.

The BIT decoder picture run temporarily locks the bitstream mutex while
the coda device mutex is locked, to refill the bitstream ring buffer.
Consequently, the decoder start command, which locks both mutexes when
flushing the bitstream ring buffer, must lock the coda device mutex
first as well, to avoid an ABBA deadlock.

Fixes: e7fd95849b3c ("media: coda: flush bitstream ring buffer on decoder restart")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/coda/coda-common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1084,16 +1084,16 @@ static int coda_decoder_cmd(struct file
 
 	switch (dc->cmd) {
 	case V4L2_DEC_CMD_START:
-		mutex_lock(&ctx->bitstream_mutex);
 		mutex_lock(&dev->coda_mutex);
+		mutex_lock(&ctx->bitstream_mutex);
 		coda_bitstream_flush(ctx);
-		mutex_unlock(&dev->coda_mutex);
 		dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 					 V4L2_BUF_TYPE_VIDEO_CAPTURE);
 		vb2_clear_last_buffer_dequeued(dst_vq);
 		ctx->bit_stream_param &= ~CODA_BIT_STREAM_END_FLAG;
 		coda_fill_bitstream(ctx, NULL);
 		mutex_unlock(&ctx->bitstream_mutex);
+		mutex_unlock(&dev->coda_mutex);
 		break;
 	case V4L2_DEC_CMD_STOP:
 		stream_end = false;


