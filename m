Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2685C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04532051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199115;
	bh=g2pj0gi9Ui3WUZYUpszQBhEQoL3MST3QvZu9kt67wxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J36NwpgK8OSYtIkYgFL2vneJ+oBwRv0Vk+aRn9FE3mgf8+b3Ou4djCG0HtoJwKJfk
	 YEV/Iz4XmutekAWiI3VvNpG4Lz+hQc8lGGRy/+gBTnapqxzskxay/5rPzP/vpTnSnG
	 vFrbdz1F3AGEos3+JtQw3vRBOw0/156CMUplhcQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436658AbgAPSZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392384AbgAPR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649C1246D5;
        Thu, 16 Jan 2020 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195622;
        bh=g2pj0gi9Ui3WUZYUpszQBhEQoL3MST3QvZu9kt67wxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=er5rndEdXXH+NEYeuKoalZfr9rAIuDojICj8jd4P+lblFECNMP7dbM9U/JrLjcb5t
         dMGrmn6Qvhk39OaQCc0W2OBAERPoVD6FIypyyNejU1Akn+GMU2vPYvCh1QOEvxArp3
         hlkTekS8q+fUOaS2jLAFkMwrFTFuzGn/LhcQxOnY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 193/371] media: omap_vout: potential buffer overflow in vidioc_dqbuf()
Date:   Thu, 16 Jan 2020 12:21:05 -0500
Message-Id: <20200116172403.18149-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit dd6e2a981bfe83aa4a493143fd8cf1edcda6c091 ]

The "b->index" is a u32 the comes from the user in the ioctl.  It hasn't
been checked.  We aren't supposed to use it but we're instead supposed
to use the value that gets written to it when we call videobuf_dqbuf().

The videobuf_dqbuf() first memsets it to zero and then re-initializes it
inside the videobuf_status() function.  It's this final value which we
want.

Hans Verkuil pointed out that we need to check the return from
videobuf_dqbuf().  I ended up doing a little cleanup related to that as
well.

Fixes: 72915e851da9 ("[media] V4L2: OMAP: VOUT: dma map and unmap v4l2 buffers in qbuf and dqbuf")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/omap/omap_vout.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 4d29860d27b4..18604b608ab2 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1527,23 +1527,20 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 	unsigned long size;
 	struct videobuf_buffer *vb;
 
-	vb = q->bufs[b->index];
-
 	if (!vout->streaming)
 		return -EINVAL;
 
-	if (file->f_flags & O_NONBLOCK)
-		/* Call videobuf_dqbuf for non blocking mode */
-		ret = videobuf_dqbuf(q, (struct v4l2_buffer *)b, 1);
-	else
-		/* Call videobuf_dqbuf for  blocking mode */
-		ret = videobuf_dqbuf(q, (struct v4l2_buffer *)b, 0);
+	ret = videobuf_dqbuf(q, b, !!(file->f_flags & O_NONBLOCK));
+	if (ret)
+		return ret;
+
+	vb = q->bufs[b->index];
 
 	addr = (unsigned long) vout->buf_phy_addr[vb->i];
 	size = (unsigned long) vb->size;
 	dma_unmap_single(vout->vid_dev->v4l2_dev.dev,  addr,
 				size, DMA_TO_DEVICE);
-	return ret;
+	return 0;
 }
 
 static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
-- 
2.20.1

