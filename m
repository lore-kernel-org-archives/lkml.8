Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37328C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE08214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOS8eLGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBJIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:50:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33512 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgBJIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:50:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8mFd7028710;
        Mon, 10 Feb 2020 08:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vEZnDveUj8OeSkV53Xrm676LVu2Y2vr8d6WdzvPvr/U=;
 b=hOS8eLGJj19RP4GWP28UNG3EEcKI0KSmuBo7nYMmefFb6/uxO8MphaH9KJWAebyIVnEN
 JwfPzPxqI+nW4zKn9qeWZveCx/E/UNE7vbQqlcvbeLhNi/bp6e1OGu6TZDnYJQVuEOa/
 OpOIbGpFXx7F1e7FH/XmFoUqRKn70y28S+AVYBeah0b/9yvCkQ/Unk68SYLQ6+Qud5ua
 /KdNHAb1RmpfQnUjetEmEsCQT7UBzRfHAkFUwl2Pijo9rjTqMO3UBcNtV4mvWXAqH5vz
 A6icY/QcDAJQckY4NDx1eI9j4pKZvCqcSPRsp6K3sllXZGqBctA3X5ArwIvHGEWj63tD jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k87tgt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:50:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8m4U2121050;
        Mon, 10 Feb 2020 08:50:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y26hsj31f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:50:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01A8o55V012776;
        Mon, 10 Feb 2020 08:50:05 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 00:50:04 -0800
Date:   Mon, 10 Feb 2020 11:49:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: mrfld: return error codes when an error
 occurs
Message-ID: <20200210084955.GY1778@kadam>
References: <20200208220720.36657-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208220720.36657-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 10:07:20PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently function sst_platform_get_resources always returns zero and
> error return codes set by the function are never returned. Fix this
> by returning the error return code in variable ret rather than the
> hard coded zero.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/intel/atom/sst/sst_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
> index d952719bc098..5862fe968083 100644
> --- a/sound/soc/intel/atom/sst/sst_pci.c
> +++ b/sound/soc/intel/atom/sst/sst_pci.c
> @@ -99,7 +99,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>  	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
>  do_release_regions:
>  	pci_release_regions(pci);

It's weird that we release the regions on the success path.

regards,
dan carpenter

> -	return 0;
> +	return ret;
>  }

