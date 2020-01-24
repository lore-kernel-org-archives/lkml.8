Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007FFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04C020663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864161;
	bh=UaEYRrOoQzEpKhJZlEPag8xkffPbpJE5+D8b6xKTf9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vBFDBbl9nJH2cZ70KsRDcFNc6CXMyKkip6DKUvwMeGp+tlkqG7Ksffht4ioO9P8w0
	 ZP2UdmdBjZKfSAx/QaFIPeN7zLjb62t5I3H5NfH6utIvo/9ZzCaeMKTA38hyOw1Ixt
	 ZHFncvShCp7qtMgoWOPXqDORpzoFhNjB6Yk/ySRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgAXLJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389758AbgAXLJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:09:16 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A60820663;
        Fri, 24 Jan 2020 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864156;
        bh=UaEYRrOoQzEpKhJZlEPag8xkffPbpJE5+D8b6xKTf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqKNxE90lxOrNIMM3DHWVEqb2Dd8k5j0zKyucERpsdd+3KS+lDgeHKwtPPfwAcPmk
         /YBswVxlH2xVzHBGHMWjSlAJhl98B/RpLXbc02+Lig2ltX3TGrTyHjvwMizFZSGAgW
         WtOHllkamygowMwbkklewaIwfa+BUwu/j6qNaFDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 187/639] drm/etnaviv: potential NULL dereference
Date:   Fri, 24 Jan 2020 10:25:57 +0100
Message-Id: <20200124093110.546875636@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9e05352340d3a3e68c144136db9810b26ebb88c3 ]

The etnaviv_gem_prime_get_sg_table() is supposed to return error
pointers.  Otherwise it can lead to a NULL dereference when it's called
from drm_gem_map_dma_buf().

Fixes: 5f4a4a73f437 ("drm/etnaviv: fix gem_prime_get_sg_table to return new SG table")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 0566171f8df22..f21529e635e3d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -15,7 +15,7 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	int npages = obj->size >> PAGE_SHIFT;
 
 	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return drm_prime_pages_to_sg(etnaviv_obj->pages, npages);
 }
-- 
2.20.1



