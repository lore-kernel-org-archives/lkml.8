Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80DC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3320730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sZY2I7SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgD1RA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:00:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11116 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbgD1RA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:00:57 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SGwWVg026814;
        Tue, 28 Apr 2020 19:00:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=OhXvZ6+5rWO/7/RQgV+XwsAJbQ/rHapO7GNXCSCc8CI=;
 b=sZY2I7SFG9WqqfQrKMW/xmRIGWjzeIXDu6g7sKN+S7MLyyibQdyy0DGqDWHHTKuZua/J
 swqplnQ+2mM92p3l4b4dCToOBTUz6Ug5FcId3FIEHkb316pysy1yC8WHNcIERDlQlhxy
 IJQWbEThKOpya70I0AHBzUjdVfx/GiTiED6bKT+ar3cMqNHhf2/z3LwVEOv7JL8GudCP
 IwhjK/B5wBlRWzY4SLnGowr0bYyAQJDLle+QHyU8BP4V6ozHlt1JID4taImMyXd4u5FS
 aC2cNU+NbFrHZczQUhZ7RFoE11IzQY7QJpultiCB+XovzYF+T510o8SQcMVgTLjTILvy AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhq617j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 19:00:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34C6C10002A;
        Tue, 28 Apr 2020 19:00:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21BD52B3BA2;
        Tue, 28 Apr 2020 19:00:48 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 19:00:47 +0200
Subject: Re: [PATCH v3 06/14] remoteproc: Refactor function
 rproc_trigger_auto_boot()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-7-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <4b20ea71-2787-c063-7ae0-dc44fed5252a@st.com>
Date:   Tue, 28 Apr 2020 19:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424200135.28825-7-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_12:2020-04-28,2020-04-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> Refactor function rproc_trigger_auto_boot() so that it can deal with
> scenarios where the remote processor is already running.  As such give
> it a new name to better represent the capabilities and add a call to
> rproc_boot() if instructed by the platform code to synchronise with the
> remote processor rather than boot it from scratch.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e90a21de9de1..9de0e2b7ca2b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1457,10 +1457,17 @@ static void rproc_auto_boot_callback(const struct firmware *fw, void *context)
>  	release_firmware(fw);
>  }
>  
> -static int rproc_trigger_auto_boot(struct rproc *rproc)
> +static int rproc_trigger_auto_initiate(struct rproc *rproc)
>  {
>  	int ret;
>  
> +	/*
> +	 * If the remote processor is already booted, all we need to do is
> +	 * synchronise it it.  No point in dealing with a firmware image.
typo: suppress double "it" and double space.

> +	 */
> +	if (rproc_needs_syncing(rproc))
> +		return rproc_boot(rproc);
> +
>  	/*
>  	 * We're initiating an asynchronous firmware loading, so we can
>  	 * be built-in kernel code, without hanging the boot process.
> @@ -1971,9 +1978,12 @@ int rproc_add(struct rproc *rproc)
>  	/* create debugfs entries */
>  	rproc_create_debug_dir(rproc);
>  
> -	/* if rproc is marked always-on, request it to boot */
> +	/*
> +	 * If the auto boot flag is set, request to boot the remote
> +	 * processor or synchronise with it.
> +	 */
>  	if (rproc->auto_boot) {
> -		ret = rproc_trigger_auto_boot(rproc);
> +		ret = rproc_trigger_auto_initiate(rproc);
>  		if (ret < 0)
>  			return ret;
>  	}
> 
