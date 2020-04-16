Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0AC21D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048280;
	bh=sVgUpE+KXFReodqryZSohrN8a0+20YziaW0oXuufrPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKNsqYI37B0E/A3VLrKUJgl5sgstJnrZHE0oYDp49J4eqCMSSayosegiaFUemsz6H
	 qr6B8uRG20SV2NHWU1doxYoRYfXSdrWA8TVxmO03fqX0UJdM5Gjnfhe0PzoeMc4SVW
	 pKH2k+pE6bs/tMnzgZD6L5q/6Tx/9AC/X8q4XyqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394607AbgDPOoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgDPN77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E4C2078B;
        Thu, 16 Apr 2020 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045598;
        bh=sVgUpE+KXFReodqryZSohrN8a0+20YziaW0oXuufrPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvJsUel2JGl1+yqz2L4i98ZUI91iMLKh5PmByf9gLJZuc59pZdpnnDiAW4MiZuvO4
         YYw64wLyC3vWA1Fcpe0bm2m+dzeEE3dMsAxz4mzRHNkmlcLJqjzDU/ZA/DAWC8z9ze
         hI7nVhxNcmiAU4TuK4CZoWDogVaMOMFAbx3ybYVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Torsten Duwe <duwe@lst.de>,
        Thierry Reding <treding@nvidia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5.6 201/254] drm/bridge: analogix-anx78xx: Fix drm_dp_link helper removal
Date:   Thu, 16 Apr 2020 15:24:50 +0200
Message-Id: <20200416131351.246133741@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@lst.de>

commit 3e138a63d6674a4567a018a31e467567c40b14d5 upstream.

drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide by
and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd[0]
and the multiply+divide alltogether.

Signed-off-by: Torsten Duwe <duwe@lst.de>
Fixes: ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
Cc: Thierry Reding <treding@nvidia.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: <stable@vger.kernel.org> # v5.5+
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20200218155744.9675368BE1@verein.lst.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -722,10 +722,9 @@ static int anx78xx_dp_link_training(stru
 	if (err)
 		return err;
 
-	dpcd[0] = drm_dp_max_link_rate(anx78xx->dpcd);
-	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
 	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0],
-			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
+			   SP_DP_MAIN_LINK_BW_SET_REG,
+			   anx78xx->dpcd[DP_MAX_LINK_RATE]);
 	if (err)
 		return err;
 


