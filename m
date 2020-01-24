Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C89C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BE62075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859766;
	bh=ZgCg7PwdWQQ51VpUPtQrqvjOkoDFiL+F8qHs3fwrhZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZvSdQRnYJNnXRqQybIaPDe3jBuk015LTlYnhI9jabxhhtrAcI4IEqcRj6RopD65uD
	 fONZIGkFNmPikVe6E7AW9rbdGTiXdTCYOcuHakpXpaKeOskzhSr/KZMJhmXURfSpLB
	 DgRADic4LkQ+eP9CASqoWjoI6QSS0XlJsQWPg9WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbgAXJ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbgAXJ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:56:04 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8040A20718;
        Fri, 24 Jan 2020 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859763;
        bh=ZgCg7PwdWQQ51VpUPtQrqvjOkoDFiL+F8qHs3fwrhZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLY4CAJidnsgwumtYMCTrilncvprKB3+9l6kH3M7B0SuK+4r/LQccEnCOR1ku1m7c
         IzSIbN9TgLFhI7wGIj6g1IBBE545GbBnufHgCGDPkavaifdQFpYgVLOstSrVmru92g
         zXfFmrQMa7HWfv/IoN+0MAP4XG2q030csJhAtTNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 155/343] media: tw5864: Fix possible NULL pointer dereference in tw5864_handle_frame
Date:   Fri, 24 Jan 2020 10:29:33 +0100
Message-Id: <20200124092940.367465716@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 2e7682ebfc750177a4944eeb56e97a3f05734528 ]

'vb' null check should be done before dereferencing it in
tw5864_handle_frame, otherwise a NULL pointer dereference
may occur.

Fixes: 34d1324edd31 ("[media] pci: Add tw5864 driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/tw5864/tw5864-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index e7bd2b8484e3d..ee1230440b397 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -1395,13 +1395,13 @@ static void tw5864_handle_frame(struct tw5864_h264_frame *frame)
 	input->vb = NULL;
 	spin_unlock_irqrestore(&input->slock, flags);
 
-	v4l2_buf = to_vb2_v4l2_buffer(&vb->vb.vb2_buf);
-
 	if (!vb) { /* Gone because of disabling */
 		dev_dbg(&dev->pci->dev, "vb is empty, dropping frame\n");
 		return;
 	}
 
+	v4l2_buf = to_vb2_v4l2_buffer(&vb->vb.vb2_buf);
+
 	/*
 	 * Check for space.
 	 * Mind the overhead of startcode emulation prevention.
-- 
2.20.1



