Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00556C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96932083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658338;
	bh=cL658tjAUDKGMd9q07eE3Ieo9f+l6YZLd8BqvCF2ifA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QJcRZttNLsQsb7g7/FJR3x2l0YES09/YmQI8qSsR4v+lua/FrihUYvy+x7umE0Jrd
	 4khlbzhMzQk46ZiyXiytAwqtqi74e+FPauQuU13N7RmX9BzjPw2skRsBy2MEs0x1m/
	 WjW+UJ/9HWsiQN+h5Wb7GadFhtKQLEt6PGrgKwGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgFHXS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgFHXPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526592078B;
        Mon,  8 Jun 2020 23:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658120;
        bh=cL658tjAUDKGMd9q07eE3Ieo9f+l6YZLd8BqvCF2ifA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeIeOvUhOHKShqMN7CJgxTZf0E2IBBtI3OnmMcZO3TPtpbAMPaqTJrr45BA6sT2E3
         JuCG2ev7Za6MsNK7/x9EwhQb0onUfYm/7ivJWpSqKPxjBtSOBw0oUR2FYRtDfyP5An
         UoP9p3KiYZa5s7UM4mNNX9/4zTI2r4ELF9Gnx2MY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 157/606] drm/etnaviv: Fix a leak in submit_pin_objects()
Date:   Mon,  8 Jun 2020 19:04:42 -0400
Message-Id: <20200608231211.3363633-157-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 3b0afa156d92..54def341c1db 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -238,8 +238,10 @@ static int submit_pin_objects(struct etnaviv_gem_submit *submit)
 		}
 
 		if ((submit->flags & ETNA_SUBMIT_SOFTPIN) &&
-		     submit->bos[i].va != mapping->iova)
+		     submit->bos[i].va != mapping->iova) {
+			etnaviv_gem_mapping_unreference(mapping);
 			return -EINVAL;
+		}
 
 		atomic_inc(&etnaviv_obj->gpu_active);
 
-- 
2.25.1

