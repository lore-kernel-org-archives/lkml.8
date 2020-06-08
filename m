Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D776C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6FC2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mk+ePyfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFHVLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:11:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40498 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgFHVLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:11:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 058LBefU125806;
        Mon, 8 Jun 2020 16:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591650700;
        bh=M+WaWGG2NqQ7V6t1GUOCf5LP32ng4M9llsjHJUBv5cI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mk+ePyfblC64WAfzzzn5sw3BP2xBCGvvhUJ48xYuOkcjBt3zRBMkqvynGRnY30Np2
         jM7MKSItpbiSEHm9YtpUMTfdhXQ72BnK/PosfgG84kHa3yl/D0mJUJ/4gbbPP31Qvr
         xpsdGBYuEZ5UvjfVkGOSg4q+Zbo49EEVWU8jwZHU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 058LBemq031384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 16:11:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Jun
 2020 16:11:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Jun 2020 16:11:39 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 058LBdRG084701;
        Mon, 8 Jun 2020 16:11:39 -0500
Subject: Re: [PATCH v6 1/3] rpmsg: core: Add wildcard match for name service
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC:     <arnaud.pouliquen@st.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200515205642.13529-1-mathieu.poirier@linaro.org>
 <20200515205642.13529-2-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <835899d1-5ee8-bcbd-e1fa-eb1518e29726@ti.com>
Date:   Mon, 8 Jun 2020 16:11:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515205642.13529-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/20 3:56 PM, Mathieu Poirier wrote:
> Adding the capability to supplement the base definition published
> by an rpmsg_driver with a postfix description so that it is possible
> for several entity to use the same service.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Going back to my review and testing done back on v2,

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>   drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index a6361cad608b..5e01e8dede6b 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
>   static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
>   				  const struct rpmsg_device_id *id)
>   {
> -	return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
> +	size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
> +
> +	/*
> +	 * Allow for wildcard matches.  For example if rpmsg_driver::id_table
> +	 * is:
> +	 *
> +	 * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> +	 *      { .name = "rpmsg-client-sample" },
> +	 *      { },
> +	 * }
> +	 *
> +	 * Then it is possible to support "rpmsg-client-sample*", i.e:
> +	 *	rpmsg-client-sample
> +	 *	rpmsg-client-sample_instance0
> +	 *	rpmsg-client-sample_instance1
> +	 *	...
> +	 *	rpmsg-client-sample_instanceX
> +	 */
> +	return strncmp(id->name, rpdev->id.name, len) == 0;
>   }
>   
>   /* match rpmsg channel and rpmsg driver */
> 

