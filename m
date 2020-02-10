Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966F92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341249;
	bh=T8sAqA4upVLNUrxAG8sQJk9Le/ePo3ZgUbOsKHbdoFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZb2S33DqNis8Hr8/sJ/E97VGpM2xAELFSwMrGIGp4Tok9yXHBJaen5nHIkESIB0R
	 o9vWHQKkbNr1KNP+yNTHpq9/w3IU4EhS7xA8HVUk3QvZEgM0bHwSPBpFlslbut56Yf
	 P79lp4sDe+DHR6tShaWcfrDFPCk8tpCsUPhdyBmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbgBJN12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgBJMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:35 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D253720733;
        Mon, 10 Feb 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338194;
        bh=T8sAqA4upVLNUrxAG8sQJk9Le/ePo3ZgUbOsKHbdoFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xluJs+1jKBaqnDY3MuyBANwUhTQQPmlSobW9lUORnj3wka71JTWJfZEJAz/8eNBT1
         g1PDX/tLSxcSr1F5JlPHZknX9OWta7pUBask72FoKY89bEqJ0BtVb3OAdz+QD9vzZh
         k0j2tJU+gXo21SAzNHa1/Lzv7mgjWLkkumrP9Qc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/195] drm: atmel-hlcdc: enable clock before configuring timing engine
Date:   Mon, 10 Feb 2020 04:33:57 -0800
Message-Id: <20200210122322.706135785@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 2c1fb9d86f6820abbfaa38a6836157c76ccb4e7b ]

Changing pixel clock source without having this clock source enabled
will block the timing engine and the next operations after (in this case
setting ATMEL_HLCDC_CFG(5) settings in atmel_hlcdc_crtc_mode_set_nofb()
will fail). It is recomended (although in datasheet this is not present)
to actually enabled pixel clock source before doing any changes on timing
enginge (only SAM9X60 datasheet specifies that the peripheral clock and
pixel clock must be enabled before using LCD controller).

Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: <stable@vger.kernel.org> # v4.0+
Link: https://patchwork.freedesktop.org/patch/msgid/1576672109-22707-3-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095faca..976109c20d493 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -79,7 +79,11 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	struct videomode vm;
 	unsigned long prate;
 	unsigned int cfg;
-	int div;
+	int div, ret;
+
+	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	if (ret)
+		return;
 
 	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
 	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
@@ -138,6 +142,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
 			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
 			   cfg);
+
+	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 }
 
 static enum drm_mode_status
-- 
2.20.1



