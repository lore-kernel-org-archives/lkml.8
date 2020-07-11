Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C52A207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594475754;
	bh=wvdNBvU3F1zN+u0G9fC/OHdlGjB9UUukKaget+WBTsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g4Fjbv/cmaL9d2RvvmJhzkZEn1U7RRfcdpvGJqPnNOyyDH2w4fK1Tgy+NacBdUA7E
	 jeGtCmQ3ZzCZiLpBAMerp7tqUXvrPTRT5QZtO0omwfoDfSsPcvyhAFgZJH1G0LRLM4
	 SAWlLY/vxk7rsqrYxNHhPen9YLxy9wGsdqyGw65Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgGKNzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKNzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:55:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3552075F;
        Sat, 11 Jul 2020 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594475751;
        bh=wvdNBvU3F1zN+u0G9fC/OHdlGjB9UUukKaget+WBTsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tql6Q3H/S88FHlbQy2nUNhuIMxMI1C4Oa9rHcbOeZuCVthai4Hd+FSrOPwcs+jYO8
         HlmwEaVK/HVWWa55/DCswFB7SvEObMAvr6NB+QC3bgl8daGGf5q+U+alonk7hDNmL6
         FhHzWwFFIBeuNiVagxIIWoCizXjoJv7q2Zz4snG0=
Date:   Sat, 11 Jul 2020 21:55:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, meenakshi.aggarwal@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] dts: arm64: lx2160a-rdb: fix shunt-resistor
Message-ID: <20200711135544.GF21277@dragon>
References: <20200619084607.16637-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619084607.16637-1-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:46:07PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Fix value of shunt-resistor property
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

'arm64: dts: ...' as subject prefix please.

Also can you improve commit log to better describe the problem the patch
is fixing?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index e266d8a170ea..dce79018d397 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -141,7 +141,7 @@
>  			power-monitor@40 {
>  				compatible = "ti,ina220";
>  				reg = <0x40>;
> -				shunt-resistor = <1000>;
> +				shunt-resistor = <500>;
>  			};
>  		};
>  
> -- 
> 2.17.1
> 
