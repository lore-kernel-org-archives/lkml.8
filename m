Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF6BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9395922D70
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916697;
	bh=PDLp1CxscdXoVwsTM/35DSuWEbuY7TZmg6Yw/NaueCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7MS0yY7frpesx6NXA+ot2T7IEcGyzrBbPtLsGE6dAn8CFXEsh7fFZ42t027VGRMW
	 4msk4FcfciK0vTAM6AlZcbxBsveaGMsHjsVJsEd6gay24+nyEdEF6ur03rf/8w2LT6
	 PgkmHFr+LsSIvTYdTu5Q3adgWD3eao2sdyLeotMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHTJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgHTJm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B09A22BED;
        Thu, 20 Aug 2020 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916546;
        bh=PDLp1CxscdXoVwsTM/35DSuWEbuY7TZmg6Yw/NaueCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucfEI1ir2A2hkTl9YWaFIi1nps/IFM6lkVquSZuThYJ/mSJ2xbzOxSqCutao1fydT
         3HlMplx2ejp55yNwMD8KA14Rt9rPrxAhSEeLj5A2/Xvwy09M7c40H4KkXPNVvgsIbX
         x1LfsP5IIw8M2q2PbpMiYfcw8apc6BGHI7AYzEZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 167/204] vdpa: Fix pointer math bug in vdpasim_get_config()
Date:   Thu, 20 Aug 2020 11:21:04 +0200
Message-Id: <20200820091614.561085683@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cf16fe9243bfa2863491026fc727618c7c593c84 ]

If "offset" is non-zero then we end up copying from beyond the end of
the config because of pointer math.  We can fix this by casting the
struct to a u8 pointer.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200406144552.GF68494@mwanda
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 3554f8de00e64..4907c1cfe6671 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -521,7 +521,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &vdpasim->config + offset, len);
+		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-- 
2.25.1



