Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75476C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D2206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615416;
	bh=5Ba3zmbe26PyiXUYcpJE1N44vRi1Et3FlZoBjwaufCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WtWm5+PLK2hcFEZ8NIeS+Nwk4u98HMspP9e1MxLIxXobpeajY3vSB93ZXzp8f9xC9
	 BYnkuC8popLYATFvBMVK6rpLomdwFQthlY7mCdGjqvcFfBOQ5WhpE8Ip4wScMqqo9b
	 XxBpdV//Z47ZdcHwJCA88Vf5K1VkNWsbK0U2mI7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgEDSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbgEDSDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6572B206B8;
        Mon,  4 May 2020 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615410;
        bh=5Ba3zmbe26PyiXUYcpJE1N44vRi1Et3FlZoBjwaufCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZS8JV2Mb+rFn1x8K1T2PZtixuNYfUcA1KnkAZ1wW6uPlWu4tzJfR9L9RDBSgoKps
         81O0Woq5tAqGO6h7HBCEaB3REdFjY3wPYe8UG/ZNAEUtiLkGk3BMus9upNqy4EzSQK
         kmxmVrE+EUCioZinZ/7wCy7G11to13ai4rVCJw+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5.4 04/57] drm/qxl: qxl_release leak in qxl_draw_dirty_fb()
Date:   Mon,  4 May 2020 19:57:08 +0200
Message-Id: <20200504165457.017181982@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit 85e9b88af1e6164f19ec71381efd5e2bcfc17620 upstream.

ret should be changed to release allocated struct qxl_release

Cc: stable@vger.kernel.org
Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Link: http://patchwork.freedesktop.org/patch/msgid/22cfd55f-07c8-95d0-a2f7-191b7153c3d4@virtuozzo.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_draw.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -209,9 +209,10 @@ void qxl_draw_dirty_fb(struct qxl_device
 		goto out_release_backoff;
 
 	rects = drawable_set_clipping(qdev, num_clips, clips_bo);
-	if (!rects)
+	if (!rects) {
+		ret = -EINVAL;
 		goto out_release_backoff;
-
+	}
 	drawable = (struct qxl_drawable *)qxl_release_map(qdev, release);
 
 	drawable->clip.type = SPICE_CLIP_TYPE_RECTS;


