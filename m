Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F8C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802FD20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgD0Sx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:53:28 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:42656 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgD0Sx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:53:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 806EE20026;
        Mon, 27 Apr 2020 20:53:21 +0200 (CEST)
Date:   Mon, 27 Apr 2020 20:53:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sheng Pan <span@analogixsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 0/2] Add initial support for slimport anx7625
Message-ID: <20200427185320.GB15880@ravnborg.org>
References: <cover.1587880280.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587880280.git.xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=4VXvCluUGrq-ykwb4MwA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin Ji

On Mon, Apr 27, 2020 at 02:16:49PM +0800, Xin Ji wrote:
> Hi all,
> 
> The following series add support for the Slimport ANX7625 transmitter, a
> ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable device.
> 
> This is the v8 version, any mistakes, please let me know, I will fix it in
> the next series. This series fix several coding format and description.


It would be great if you can add a summary of changes like this:

v8:
  - fix several coding format
  - update description

v7:
  - Bla bla

I see no reason to dig out the old changelog, but start from now on.
The cover letter (this mail) should give a general intro to the changes.
The individual patches the detailed changelog.
For each entry is is also a good practice to tell who gave the feedback
that triggered the changes.

There are many ways to handle this, take a look at a few submissions 
to dri-devel to be inspired.

	Sam

> 
> Thanks,
> Xin
> 
> 
> 
> Xin Ji (2):
>   dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
>   drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP bridge driver
> 
>  .../bindings/display/bridge/anx7625.yaml           |   91 +
>  drivers/gpu/drm/bridge/Makefile                    |    2 +-
>  drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c          | 2158 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h          |  410 ++++
>  6 files changed, 2667 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
