Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A69C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9363920873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339646;
	bh=IUxzkbV4y8t9RmxGGJIIkdoyBSZBfGfzwVwqW44vYy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wp8ARtGC29H/as2DHvoDg6ddkIshqjCO38JYwOEviU6BE+RRIRiuAiSxhMLrtZtOW
	 Mhl0JUKpCikpu3mEK1ItXlEsin84NNyIuvZFFtKzaZSH3MvBUnORtp5HN3dOKE3BVv
	 2Z45p6oWlunBBAKR72jMMNu2lT4sAfD4gPVZ98eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgBJNAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgBJMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:58 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040E320842;
        Mon, 10 Feb 2020 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338458;
        bh=IUxzkbV4y8t9RmxGGJIIkdoyBSZBfGfzwVwqW44vYy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEXMgB2Deg5rJcd+3dlvapR4kymziqUy0W8x5VGbxKKTJWCgti2S8K4HaGRMg9C+V
         a3JztG+YRIL1YsLTkMYpBCIu+eC2zQ0E7+9tsMNLJV4yOY2HqYWwB+bpVcTKVcvKXj
         RgoFsW9LHk/Qezs+JzBTieJpvkw1nr9nA89HbMk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 5.5 212/367] drm: atmel-hlcdc: use double rate for pixel clock only if supported
Date:   Mon, 10 Feb 2020 04:32:05 -0800
Message-Id: <20200210122443.877035490@linuxfoundation.org>
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

commit 07acf4bafe81dd37eff3fbcfbbdbc48084bc202b upstream.

Doubled system clock should be used as pixel cock source only if this
is supported. This is emphasized by the value of
atmel_hlcdc_crtc::dc::desc::fixed_clksrc.

Fixes: a6eca2abdd42 ("drm: atmel-hlcdc: add config option for clock selection")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <stable@vger.kernel.org> # v5.3+
Link: https://patchwork.freedesktop.org/patch/msgid/1576672109-22707-2-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -95,14 +95,14 @@ static void atmel_hlcdc_crtc_mode_set_no
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
+	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	mode_rate = adj->crtc_clock * 1000;
 	if (!crtc->dc->desc->fixed_clksrc) {
+		prate *= 2;
 		cfg |= ATMEL_HLCDC_CLKSEL;
 		mask |= ATMEL_HLCDC_CLKSEL;
 	}
 
-	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
-	mode_rate = adj->crtc_clock * 1000;
-
 	div = DIV_ROUND_UP(prate, mode_rate);
 	if (div < 2) {
 		div = 2;


