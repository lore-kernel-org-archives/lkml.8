Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B9C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198D72083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JwUMktf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD2Orb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:47:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57307 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgD2Ora (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:47:30 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TEkRih027849;
        Wed, 29 Apr 2020 16:47:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=JrIPiTkgDLXSrRQnzVSRty80wJa9TRbjQJelaiwRij0=;
 b=JwUMktf48FF2PsljXEuCR2xkw9mjJjeopDNAzqIeJL97nifniD7adyIsogQB3N1ND0no
 +oynYWeBUAMTnwhqPPRJHeb7OyBwQAhypgu/YsEUYa8w5742NlVpUIwNNL2jhc903xSZ
 cxwUJraOoL5JZ79h+079PzHbMpgKRqOzfoTzouKt6qKEjXLLAh+AEzZ9KGTCUKoMsKYt
 vkTj/cvwlUug+xyunlSIeBd1aRd6F1izLa1EuGFixG1iYGLhr0G+FmRLb9F7NrDO/3WT
 rr7Pg28i1yclIfr3Eu/EIDsnGCAeCtlaRXe5O9tMY5jTJIPdxGPsjLQp6iIxL0Fg56w3 Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhcc6yhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 16:47:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07D5910002A;
        Wed, 29 Apr 2020 16:47:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAFEE2AAF65;
        Wed, 29 Apr 2020 16:47:21 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr
 2020 16:47:20 +0200
Subject: Re: [PATCH v2 12/12] remoteproc: stm32: Set synchronisation state
 machine if needed
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <loic.pallardy@st.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-13-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <defc59b2-4d64-a108-2e5e-ecc579f70a8b@st.com>
Date:   Wed, 29 Apr 2020 16:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424202505.29562-13-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_07:2020-04-29,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 10:25 PM, Mathieu Poirier wrote:
> Set the flags and operations to use if the M4 has been started
> by another entity than the remoteproc core.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/stm32_rproc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index dcae6103e3df..02dad3f51c7a 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -598,13 +598,20 @@ static struct rproc_ops st_rproc_ops = {
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
> -static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
> +static struct rproc_ops st_rproc_sync_ops = {
>  	.start		= stm32_rproc_sync_start,
>  	.stop		= stm32_rproc_stop,
> +	.kick		= stm32_rproc_kick,

Seems independent of the path.

>  	.parse_fw       = stm32_rproc_sync_parse_fw,
>  	.find_loaded_rsc_table = stm32_rproc_sync_elf_find_loaded_rsc_table,
>  };
>  
> +static struct rproc_sync_flags st_sync_flags = {
> +	.on_init = true, /* sync with MCU when the kernel boots */
> +	.after_stop = false, /* don't resync with MCU if stopped from sysfs */
> +	.after_crash = false, /* don't resync with MCU after a crash */
> +};
> +
could be const

>  static const struct of_device_id stm32_rproc_match[] = {
>  	{ .compatible = "st,stm32mp1-m4" },
>  	{},
> @@ -803,6 +810,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	struct stm32_rproc *ddata;
>  	struct device_node *np = dev->of_node;
>  	struct rproc *rproc;
> +	struct rproc_sync_flags sync_flags = {0};
>  	unsigned int state;
>  	bool auto_boot = false;
>  	int ret;
> @@ -837,11 +845,17 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (state == M4_STATE_CRUN) {
> +		auto_boot = true;
> +		sync_flags = st_sync_flags;

seems an useless copy 

Regards,
Arnaud

>  		ret = stm32_rproc_get_loaded_rsc_table(pdev, ddata);
>  		if (ret)
>  			goto free_rproc;
>  	}
>  
> +	ret = rproc_set_state_machine(rproc, &st_rproc_sync_ops, sync_flags);
> +	if (ret)
> +		goto free_rproc;
> +
>  	rproc->auto_boot = auto_boot;
>  	rproc->has_iommu = false;
>  	ddata->workqueue = create_workqueue(dev_name(dev));
> 
