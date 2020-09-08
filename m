Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9099C2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D8D2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgIHRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:40:44 -0400
Received: from mailoutvs45.siol.net ([185.57.226.236]:53937 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731649AbgIHQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D70145261C6;
        Tue,  8 Sep 2020 18:13:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ojy5au4NP2nS; Tue,  8 Sep 2020 18:13:55 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 97A1952625E;
        Tue,  8 Sep 2020 18:13:55 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 0B6EC5261C6;
        Tue,  8 Sep 2020 18:13:53 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>,
        Martin Cerveny <m.cerveny@computer.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sun4i: sun8i-csc: Secondary CSC register correction
Date:   Tue, 08 Sep 2020 18:13:53 +0200
Message-ID: <2725694.hAE4Gzk0mI@jernej-laptop>
In-Reply-To: <20200906162140.5584-2-m.cerveny@computer.org>
References: <20200906162140.5584-1-m.cerveny@computer.org> <20200906162140.5584-2-m.cerveny@computer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>"Allwinner V3s" has secondary video layer (VI).
>Decoded video is displayed in wrong colors until
>secondary CSC registers are programmed correctly.
>
>Signed-off-by: Martin Cerveny <m.cerveny@computer.org>

Following tag should be added:
Fixes: 883029390550 ("drm/sun4i: Add DE2 CSC library")

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


