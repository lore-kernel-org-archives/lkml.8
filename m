Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72120C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618F208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="COg2K37p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBJIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:36:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51604 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:36:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8YGnZ142881;
        Mon, 10 Feb 2020 08:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BzJOwVoSVSbqmZIowabb92HL+/K1HTWJattJHrcbaPg=;
 b=COg2K37pX1O6datKCOcl6f/EX5FHVZqbGC9kq0+I088NunsQnq18biM2a1CBeYVPW4O3
 dEYPx90qxMyhGsBbBgANXV4+g+QmvtRfCTNxaOX1i5a9hHHjHcTlyaN+XC5ZU1hSe6wg
 gTeVTCojfIEP7ExQwwpbqX+NrDReTkfY2mJwCfTd69XilplIyvAIAyszPRJTJW1xrwv0
 eqg2nhdsLNCtk+MH3orZtQdxDBP4yC9G9/kWUGNzs7UW1xqDTNSvsFdzFAdZ5qLo4Lya
 V6vrx2NLXHgq686BkgMluN/UeorFDmJNz6bwTlnp1Q/rOO3B2Z36i7Mfiq9998OExrKz Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx5tfp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:35:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8W7GW065509;
        Mon, 10 Feb 2020 08:35:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y26hshc0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:35:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01A8ZLCd002344;
        Mon, 10 Feb 2020 08:35:21 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 00:35:20 -0800
Date:   Mon, 10 Feb 2020 11:35:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: remove redundant assignment to
 variable ret
Message-ID: <20200210083513.GX1778@kadam>
References: <20200208215523.36094-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208215523.36094-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 09:55:23PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment to ret is redundant as it is not used in the error
> return path and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index e1e937eb1dc1..450c394b2882 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1764,10 +1764,8 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
>  	} else if (match) {
>  		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
>  				     GFP_KERNEL);
> -		if (!pdata) {
> -			ret = -ENOMEM;
> +		if (!pdata)
>  			return pdata;

Use a literal NULL for readability.  "return NULL;".

regards,
dan carpenter

