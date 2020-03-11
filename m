Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC59FC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29CA21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgCKNWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:22:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:27848 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgCKNWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:22:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 06:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="415562123"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2020 06:22:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jC1JK-008k1r-PI; Wed, 11 Mar 2020 15:22:10 +0200
Date:   Wed, 11 Mar 2020 15:22:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phong LE <ple@baylibre.com>
Cc:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: add it66121 HDMI bridge driver entry
Message-ID: <20200311132210.GP1922688@smile.fi.intel.com>
References: <20200311125135.30832-1-ple@baylibre.com>
 <20200311125135.30832-5-ple@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125135.30832-5-ple@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:51:35PM +0100, Phong LE wrote:
> Add Neil Armstrong and myself as maintainers

Run parse-maintainers.pl to fix issues.

> Signed-off-by: Phong LE <ple@baylibre.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37c2963226d4..3d722d723686 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8977,6 +8977,14 @@ T:	git git://linuxtv.org/anttip/media_tree.git
>  S:	Maintained
>  F:	drivers/media/tuners/it913x*
>  
> +ITE IT66121 HDMI BRIDGE DRIVER
> +M:	Phong LE <ple@baylibre.com>
> +M:	Neil Armstrong <narmstrong@baylibre.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/bridge/ite-it66121.c
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> +
>  IVTV VIDEO4LINUX DRIVER
>  M:	Andy Walls <awalls@md.metrocast.net>
>  L:	linux-media@vger.kernel.org
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


