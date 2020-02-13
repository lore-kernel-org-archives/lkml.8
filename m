Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04D4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AF820848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Uz9Sd+XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgBMN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:56:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729971AbgBMN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:56:25 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDmnk7003299;
        Thu, 13 Feb 2020 14:56:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=YJPJ2VtB5Pf6F+A52rBi6qL7Kcr6n5x21hJ8PjtmHNA=;
 b=Uz9Sd+XZF94QJ2oVs5YxjmqhBWrHfugXDGOU5B66/3I/Cjd4DnCCWhoqIL8fpRYgD/ZG
 JEwWTDwANHfm9pbndKgDhMmi32TMd27o+yNG3Unts0S9/cmFDRnXkR08syaI+EqQBNeQ
 Zb3+6w7SEUyYafT1wrdx8E1Pl3FKpS9yCzY+TfXCtpQmx5Ux6TUIHv9+dkpXBzQgEMNJ
 +AyLlz/Ae1hoZw6N4fH2OEn6AO3D3Nt//X6zA3Mwe82Qe/eabpkzTxOiYcKFSSvOhsC4
 DQRz6f9+WHg89wKUpWDvNf41O+IgK2MJPzUN/R9nA2FXxGDjk07gwVahUvTc7mJotKm3 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufhnkex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 14:56:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F324E10003B;
        Thu, 13 Feb 2020 14:56:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E52982B8517;
        Thu, 13 Feb 2020 14:56:11 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 14:56:11 +0100
Subject: Re: [PATCH 1/1] rpmsg: core: Add wildcard match for name service
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <s-anna@ti.com>, <xiaoxiang@xiaomi.com>, <t-kristo@ti.com>,
        <loic.pallardy@st.com>, <remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200212211251.32091-1-mathieu.poirier@linaro.org>
 <20200212211251.32091-2-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <034dcb0b-e305-aab9-f52b-5f725856480f@st.com>
Date:   Thu, 13 Feb 2020 14:56:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212211251.32091-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Simple and elegant :)
I tested it with my rpmsg_tty client which defines several IDs: work fine.
  
Just a question regarding the comment else
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
 

On 2/12/20 10:12 PM, Mathieu Poirier wrote:
> Adding the capability to supplement the base definition published
> by an rpmsg_driver with a postfix description so that it is possible
> for several entity to use the same service.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e330ec4dfc33..bfd25978fa35 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
>  				  const struct rpmsg_device_id *id)
>  {
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
What about adding this as function documentation? i don't know if it makes sense
for a static volatile function...

Regards
Arnaud

> +	return strncmp(id->name, rpdev->id.name, len) == 0;
>  }
>  
>  /* match rpmsg channel and rpmsg driver */
> 
