Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA6C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5932083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858935;
	bh=hb73mPjW7aVbKLsg8JZT+XC20KzbazBLqYgGJO10gww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBtS3P/Eg0P1SNYcPcgMLGg8JoW6ubrXhwjC4Vu9v3zXA7vsvvRlvleG24NdXqfYg
	 uuFtSs7aJrI9z+7c/kRjo+OsdSDFKPALVoAKYyNvNYSWYLn5tbaWfDyOEZV5dnQtho
	 XU2xLn1Z5oHy6EsDaeXBxcTz4RyxixYDuxPh+qr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgG0OIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbgG0OIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:08:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D382073E;
        Mon, 27 Jul 2020 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858930;
        bh=hb73mPjW7aVbKLsg8JZT+XC20KzbazBLqYgGJO10gww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppjSW5SJ2TGWw00VRZVF1bfv46zDVWjFXNd002lcpuJuLUZ/aO4q4k8PEjgFMf10Y
         ZgP689s/fo3MRupUIhP1sUyff/PWz18GO2D/q+KD1tnrKtZYYp0CgP7eqIdTv2wNSE
         al60BKYj8Y5clr21/GmMXoNVhIm5G9hphwITpc6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Mans Rullgard <mans@mansr.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/64] drm: sun4i: hdmi: Fix inverted HPD result
Date:   Mon, 27 Jul 2020 16:04:04 +0200
Message-Id: <20200727134912.397758711@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit baa1841eb797eadce6c907bdaed7cd6f01815404 ]

When the extra HPD polling in sun4i_hdmi was removed, the result of
HPD was accidentally inverted.

Fix this by inverting the check.

Fixes: bda8eaa6dee7 ("drm: sun4i: hdmi: Remove extra HPD polling")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200711011030.21997-1-wens@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 82cb939351889..c9f1a8cd5f2ac 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -215,7 +215,7 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	unsigned long reg;
 
 	reg = readl(hdmi->base + SUN4I_HDMI_HPD_REG);
-	if (reg & SUN4I_HDMI_HPD_HIGH) {
+	if (!(reg & SUN4I_HDMI_HPD_HIGH)) {
 		cec_phys_addr_invalidate(hdmi->cec_adap);
 		return connector_status_disconnected;
 	}
-- 
2.25.1



