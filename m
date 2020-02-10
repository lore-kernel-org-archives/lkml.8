Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32563C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C18B20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338720;
	bh=rVtizd47pPRclKqUkCqje4zkgi1bBzaeodtlgmwOJag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j4v+byPWIEdtv+8PmVHJVFtmvGJYN1z8ATu1xkiE7LKDsO5ktU9+HFTqixJZopR6O
	 iDbtuBcGIReLO2BADkkWdPhJVII6HQt2Pl2/2g1JeGMFIh1mkHfukawg4ycbAtwJEg
	 W5sjOb5i6e1Yxzi6A5Ihn0YnxSdy62RmNN8MkjUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgBJMpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgBJMk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:59 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825342173E;
        Mon, 10 Feb 2020 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338458;
        bh=rVtizd47pPRclKqUkCqje4zkgi1bBzaeodtlgmwOJag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ohs6WUAXqnjCmPP4u1CohStUNKYu6RazGXiTn1SsRpTS21pMnsgxBWWuNPzpzJwCC
         MIQtEfGdRkFwBto5d8XsmCKNUovSHriK0Y/SgiIu8zXeT5+sOXF3j4Uex72jzS0qob
         GIVz0E6fAMgq9jBWa02/jmwtU8QvhKSQDFocDcXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 5.5 213/367] drm: atmel-hlcdc: enable clock before configuring timing engine
Date:   Mon, 10 Feb 2020 04:32:06 -0800
Message-Id: <20200210122443.945930070@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

commit 2c1fb9d86f6820abbfaa38a6836157c76ccb4e7b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -73,7 +73,11 @@ static void atmel_hlcdc_crtc_mode_set_no
 	unsigned long prate;
 	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
 	unsigned int cfg = 0;
-	int div;
+	int div, ret;
+
+	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	if (ret)
+		return;
 
 	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
 	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
@@ -147,6 +151,8 @@ static void atmel_hlcdc_crtc_mode_set_no
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
 			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
 			   cfg);
+
+	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 }
 
 static enum drm_mode_status


