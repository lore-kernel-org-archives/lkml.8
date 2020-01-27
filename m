Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE671C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F8720702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMW+SJTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgA0Ivw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:51:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA0Ivv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:51:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8mxPl073248;
        Mon, 27 Jan 2020 08:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EjgunAGAbGnRzLPzrFIjiPQwtH1I6BaUWmJslVz/G4o=;
 b=AMW+SJTq3GJ2scQrQ8MGPgpSkdSqmbLykg1tkah+lgAkm3cpCivb5Km3GHMpALaVl8+g
 HLTbXu+tlzFFDzUrPOrOmzqHAhjFa9qaFiMxc08/onM0cb0lMEWPKu3jra+a8LNV4INi
 qJFvc2IBVCEu2KZUPmcV1Ufy8nnjycv9e0kZObyqtsqEYtF/xor74Y+9mYPZx/jiLHI7
 Dtv/0XgnkqYAIuUwk3MYD1cbzDt+BlFheP6fyt3411bHRVTqXDrX255A4uScf6M3cHaV
 gri57OFOCzrAPhZ7QeC6EeoRzp7TVmYGr0orJyBbt1pr5goN5c2TtX30/HAAEQ4B89QI +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3twvmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:51:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8nMks180819;
        Mon, 27 Jan 2020 08:51:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xryu8x27f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:51:07 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00R8p6bO002946;
        Mon, 27 Jan 2020 08:51:06 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 00:51:06 -0800
Date:   Mon, 27 Jan 2020 11:50:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-audio: fix warning of no space is
 necessary
Message-ID: <20200127084321.GV1847@kadam>
References: <20200126173758.GA28897@home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126173758.GA28897@home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 07:37:58PM +0200, Valery Ivanov wrote:
> This patch fixes "No space is necessary after a cast".
> Issue found by checkpatch.pl
> 
> Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index 33485184a98a..997ce88c67c4 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -237,7 +237,7 @@ static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
> -	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
> +	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);

There is no need for the cast to begin with.

regards,
dan carpenter

