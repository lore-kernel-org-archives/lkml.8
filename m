Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65228208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520441;
	bh=njKcPTjoQBNCYX4BTTtw03AqYv4zf24tEVwE3YxaWT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nlCdxY15Ij1Afq4xKuu/WzBCC6tEbUdVuCBm9s1expT0coOG+hrkx635wXTVK2rHT
	 S4X+AK64QiMuD38zgiGGuCSZDlSWGAOQPdXmiojkP9OD/Zu0A+3a39HYHXKZi+GNnh
	 z/VhxcZ6HCWwHLtjtpiDwEjMrBP36eEAs+sSpplY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392023AbgEZTOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404338AbgEZTNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:13:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B504620E65;
        Tue, 26 May 2020 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520432;
        bh=njKcPTjoQBNCYX4BTTtw03AqYv4zf24tEVwE3YxaWT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZA6a6bh644QlPU8OaOyQDCvvH2qFibq84mB7tTqi41AGVSkeP+jNSGPMcv2aEDxY
         5MuX4bCVh47R3+nXV62dQnRqA3kLFByL9FnwZgr1DUmh2S4xzbUYgoLqlmAtDVc1Sx
         3ZHbVlUhDgyNvvCrn072/ZXouEfvpzwwK7TC9eLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.6 078/126] drm/etnaviv: Fix a leak in submit_pin_objects()
Date:   Tue, 26 May 2020 20:53:35 +0200
Message-Id: <20200526183944.710343541@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit ad99cb5e783bb03d512092db3387ead9504aad3d upstream.

If the mapping address is wrong then we have to release the reference to
it before returning -EINVAL.

Fixes: 088880ddc0b2 ("drm/etnaviv: implement softpin")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -238,8 +238,10 @@ static int submit_pin_objects(struct etn
 		}
 
 		if ((submit->flags & ETNA_SUBMIT_SOFTPIN) &&
-		     submit->bos[i].va != mapping->iova)
+		     submit->bos[i].va != mapping->iova) {
+			etnaviv_gem_mapping_unreference(mapping);
 			return -EINVAL;
+		}
 
 		atomic_inc(&etnaviv_obj->gpu_active);
 


