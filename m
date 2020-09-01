Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9135C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AED2206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973993;
	bh=Ttkps5pps/+L2vqi5gedAmzC0sp9bGqD8MQBJGpJzGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yzsZoSGqfS8ktaiYAN8fDHKvW0JEh/LwfWynB31+c23DG1N8kCNvjI5dyXPxVdpoZ
	 UJvCR3yuIApN/CI6mAlkKX65DX9wB/sSwy1os2nhpKjDy+m8lQFO14zg4I9mnRotkB
	 nxEP267Ty+WAoCAjSTBSQpbhy1ALmXtrPBLq9m6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgIAP0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbgIAPXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00071206FA;
        Tue,  1 Sep 2020 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973787;
        bh=Ttkps5pps/+L2vqi5gedAmzC0sp9bGqD8MQBJGpJzGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOleXKj9lXioQoi0Wr8VAJon0yczXVLPmVcBZBqHTByrxTO5VLUNYN4ZU6ewZdHp4
         DZHBSOXn6yrhUyDOcisZ7jTNUxQc9rFZaPha9sBQsVzbiuyrmq5lhrVZM/2rDDtoyY
         zKF13A/jN3gj49cOyvZqDpQmXLXru/EvhBAxqjKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/125] media: davinci: vpif_capture: fix potential double free
Date:   Tue,  1 Sep 2020 17:10:02 +0200
Message-Id: <20200901150936.857115610@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit 602649eadaa0c977e362e641f51ec306bc1d365d ]

In case of errors vpif_probe_complete() releases memory for vpif_obj.sd
and unregisters the V4L2 device. But then this is done again by
vpif_probe() itself. The patch removes the cleaning from
vpif_probe_complete().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpif_capture.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index a96f53ce80886..cf1d11e6dd8c4 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1489,8 +1489,6 @@ probe_out:
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
 	}
-	kfree(vpif_obj.sd);
-	v4l2_device_unregister(&vpif_obj.v4l2_dev);
 
 	return err;
 }
-- 
2.25.1



