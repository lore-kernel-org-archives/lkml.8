Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C991C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404F4206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGAJCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:02:46 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50270 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGAJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:02:45 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 82B8680503;
        Wed,  1 Jul 2020 11:02:41 +0200 (CEST)
Date:   Wed, 1 Jul 2020 11:02:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] Silence missing-graph error for DRM bridges
Message-ID: <20200701090240.GA22218@ravnborg.org>
References: <20200701074232.13632-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701074232.13632-1-digetx@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=voM4FWlXAAAA:8 a=laVpB__SBT07bHWVBRQA:9
        a=CjuIK1q_8ugA:10 a=IC2XNlieTeVoXbcui8wp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry
On Wed, Jul 01, 2020 at 10:42:30AM +0300, Dmitry Osipenko wrote:
> Hi!
> 
> This small series improves DRM bridges code by silencing a noisy error
> coming from of-graph code for the device-trees that are missing a
> display bridge graph.
> 
>   graph: no port node found in ...
> 
> One example where this error happens is an older bridge-less DTB used
> in conjunction with a newer kernel which has a display controller driver
> that supports DRM bridges.
> 
> Changelog:
> 
> v10:- Corrected doc-comment, unbroke the of_graph_get_next_endpoint() and
>       improved commit's message in the "add of_graph_is_present()" patch.
>       Thanks to Laurent Pinchart for spotting the problems!
> 
> v9: - These two patches are factored out from [1] in order to ease applying
>       of the patches.
> 
>     - The of_graph_presents() is renamed to of_graph_is_present() like it
>       was requested by Rob Herring in the review comment to [1].
> 
>     - Added Rob's r-b.
> 
>     [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=184102
> 
> Dmitry Osipenko (2):
>   of_graph: add of_graph_is_present()
>   drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence

Thanks for your patience with these - applied to drm-misc-next now.

	Sam

> 
>  drivers/gpu/drm/drm_of.c |  9 +++++++++
>  drivers/of/property.c    | 23 +++++++++++++++++++++++
>  include/linux/of_graph.h |  6 ++++++
>  3 files changed, 38 insertions(+)
> 
> -- 
> 2.26.0
