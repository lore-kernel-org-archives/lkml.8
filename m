Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B320637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCERVh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:21:37 -0500
Received: from mailoutvs55.siol.net ([185.57.226.246]:56836 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727604AbgCEROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 87E02521A71;
        Thu,  5 Mar 2020 18:14:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Uu7iizrBYcEZ; Thu,  5 Mar 2020 18:14:29 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 482BE5232A3;
        Thu,  5 Mar 2020 18:14:29 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 7D13B521A71;
        Thu,  5 Mar 2020 18:14:28 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: dw-hdmi: fix AVI frame colorimetry
Date:   Thu, 05 Mar 2020 18:14:27 +0100
Message-ID: <5332114.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20200304232512.51616-2-jernej.skrabec@siol.net>
References: <20200304232512.51616-1-jernej.skrabec@siol.net> <20200304232512.51616-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 05. marec 2020 ob 00:25:09 CET je Jernej Skrabec napisal(a):
> CTA-861-F explicitly states that for RGB colorspace colorimetry should
> be set to "none". Fix that.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Fixes: def23aa7e982 ("drm: bridge: dw-hdmi: Switch to V4L bus format and
> encodings") Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied to drm-next-fixes.

Best regards,
Jernej


