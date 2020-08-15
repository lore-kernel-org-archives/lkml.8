Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8477620657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgHOWY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:24:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50980 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHOWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:24:55 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E0DC280538;
        Sat, 15 Aug 2020 14:55:45 +0200 (CEST)
Date:   Sat, 15 Aug 2020 14:55:44 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200815125544.GA1153358@ravnborg.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <0a7539135cc46eec5636ca89f52695f4a1197841.1597412076.git.agx@sigxcpu.org>
 <20200815100230.GA1002374@ravnborg.org>
 <20200815104022.GA5641@bogon.m.sigxcpu.org>
 <20200815104651.GA1005928@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815104651.GA1005928@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=bbTEvi9DXXvUDvUqyWQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

> > In fact I did decided against it since i was told that missing dev_* and
> > DRM_* logging shouldn't be done. So is that o.k. nowadays?
> s/missing/mixing/
> 
> I often request that logging is consistent - so I recognize the
> argument.
> 
> For panel/* I have not made up my mind what I think is the best
> approach. The DRM_DEV_* and DRM_* logging do not add much value.
> So I have been tempted several times to convert all logging in
> panel/ to dev_* and pr_* (when no struct device * is available).
> That would also avoid that we mix up logging.
> 
> We have drm_* logging - but they require a valid drm_device * which we
> do not have in the the panel drivers. So they are ruled out here.
> 
> Do you have any opinions/comments on this?
I went ahead and dropped the DRM_ logging in drm/panel, you are copied
on the patchset. Feedback on the patches would be nice.

	Sam
