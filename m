Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26231C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB499208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgGaPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:23:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:4011 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgGaPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:23:59 -0400
IronPort-SDR: ieHzjBUvwhR+MmwCJ53Tj8TeGi1axH9txbeq/9/sQ3wGvWQItlj6pvngUJmyNW/vWWtuVdpVZM
 IQfRCuBtisrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139776760"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="139776760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 08:23:58 -0700
IronPort-SDR: bSb6tvJsAMoUmHEgucZC11pIyRmfpRA9zMhvYeL+rzLp6S00sj16uBLvwgPPAbnNwMQJhlSFhv
 8md9gp1s7X2w==
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="321423421"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 08:23:56 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 1F4F720722; Fri, 31 Jul 2020 18:23:54 +0300 (EEST)
Date:   Fri, 31 Jul 2020 18:23:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: ov5640: Add support for BT656 mode
Message-ID: <20200731152353.GS13316@paasikivi.fi.intel.com>
References: <1596187487-31403-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1596187487-31403-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596187487-31403-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jul 31, 2020 at 10:24:47AM +0100, Lad Prabhakar wrote:
> @@ -2875,8 +2891,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>  
>  		if (sensor->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
>  			ret = ov5640_set_stream_mipi(sensor, enable);
> -		else
> +		else if (sensor->ep.bus_type == V4L2_MBUS_PARALLEL)
>  			ret = ov5640_set_stream_dvp(sensor, enable);
> +		else
> +			ret = ov5640_set_stream_bt656(sensor, enable);

I'd also check for the Bt.656 mode here, rather than assuming it. 

Could you also update the DT bindings, given that the sensor appears to
support Bt.656 as well? I believe this requires the bus-type property, too.

>  
>  		if (!ret)
>  			sensor->streaming = enable;

-- 
Kind regards,

Sakari Ailus
