Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C6C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE83724958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942492;
	bh=PQO2qszkR2ZOJGdXJ9WPdFL9T2v4oNVLb9SEfQ0GBfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFcsR2lYZe9kGKPZDfz58rlaDXr42iGm/0CkGausShaU0yy1D72k5/qo6g0WEMO9s
	 +K5bxuIEnWQqQCl1qp0NPZ9I3078S6g8JIJvq7/Jp7zwMHuHllF2MOO2zuFhk5t9TB
	 2juNJ/roDUv6uyKxotbp1TjpMDvGjdVZn62cij3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgEHMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbgEHMyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:54:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED3F24958;
        Fri,  8 May 2020 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942485;
        bh=PQO2qszkR2ZOJGdXJ9WPdFL9T2v4oNVLb9SEfQ0GBfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTLP+aKCoq2ixzV82lsLXtbszTcuMtmKmXofgO3Vk/dZh7ACOBlPPntScxpRnFhe/
         Jdiyf7t26W8hMKBe3Ru9mMXnkWpwblbO4o6MwV/reo5yXldKh/z4mYF9fIsZ4XFskw
         U+VZuuxv0rXmdn3ZUmYDgVaB0elG2liFaKVi3CD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 14/49] drm/bridge: anx6345: set correct BPC for display_info of connector
Date:   Fri,  8 May 2020 14:35:31 +0200
Message-Id: <20200508123045.031009475@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

[ Upstream commit 1e8a6ce9186dbf342eebc07cf14cae5e82164e03 ]

Some drivers (e.g. sun4i-drm) need this info to decide whether they
need to enable dithering. Currently driver reports what panel supports
and if panel supports 8 we don't get dithering enabled.

Hardcode BPC to 6 for now since that's the only BPC
that driver supports.

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20200329222253.2941405-1-anarsoul@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 526507102c1ea..8d32fea84c75e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -485,6 +485,9 @@ static int anx6345_get_modes(struct drm_connector *connector)
 
 	num_modes += drm_add_edid_modes(connector, anx6345->edid);
 
+	/* Driver currently supports only 6bpc */
+	connector->display_info.bpc = 6;
+
 unlock:
 	if (power_off)
 		anx6345_poweroff(anx6345);
-- 
2.20.1



