Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40147C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE372074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503069AbgDNRxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:53:46 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:56900 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729303AbgDNRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:53:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7F40452394D;
        Tue, 14 Apr 2020 19:53:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zT-bx81lubdB; Tue, 14 Apr 2020 19:53:37 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 304EC52395E;
        Tue, 14 Apr 2020 19:53:37 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id D84D852394D;
        Tue, 14 Apr 2020 19:53:34 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: drm/bridge: anx6345: set correct BPC for display_info of connector
Date:   Tue, 14 Apr 2020 19:53:34 +0200
Message-ID: <12495893.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20200329222253.2941405-1-anarsoul@gmail.com>
References: <20200329222253.2941405-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 30. marec 2020 ob 00:22:53 CEST je Vasily Khoruzhick 
napisal(a):
> Some drivers (e.g. sun4i-drm) need this info to decide whether they
> need to enable dithering. Currently driver reports what panel supports
> and if panel supports 8 we don't get dithering enabled.
> 
> Hardcode BPC to 6 for now since that's the only BPC
> that driver supports.
> 
> Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied to drm-misc-fixes. Thanks!

Best regards,
Jernej


