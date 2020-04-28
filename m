Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF0C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F1C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o5xNUOnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgD1QTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:19:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19090 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728035AbgD1QTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:19:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SGITG3027589;
        Tue, 28 Apr 2020 18:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=bTVST/vGOCmW9bqsQcFABvpaPEN0vNzqWpWCEdlwQXI=;
 b=o5xNUOnnP+HFLIMHhJf+r0D+yWKLgEeTptyByrWCw8QKDKw598JlqNeLWDC2Lm+aaUha
 XXMOO3HsED0yZyDyRNjzkqTywML48r/AjC3fEtZPIposCqm5gn2lYY59JHirmiq0OSU/
 g+iGDZAV4cjw2k1QbacNG8M6OGj1nQfTbVFODeFVlLtoufNujKGhFxE4mp9s/d6EIMoh
 v3aEbGkRniNXFC1xzAj7SbQRWRu34cdjXScHKJPl2bJqroG1kmUEUfmLUFXKkdWnveTt
 9mFuJaXJltxdNfj8ol8vMFxrNSLkKPvMjiBJV3wpx7TnHFRHN8fbRNz4D8cguBfn/Dc1 rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j5w465-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 18:19:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27FE510002A;
        Tue, 28 Apr 2020 18:19:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 102C02BF9CE;
        Tue, 28 Apr 2020 18:19:02 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 18:19:00 +0200
Subject: Re: [PATCH v3 01/14] remoteproc: Make core operations optional
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-2-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <ff9254d9-6a17-cae5-9f41-2c60303a38ec@st.com>
Date:   Tue, 28 Apr 2020 18:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424200135.28825-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_11:2020-04-28,2020-04-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> When synchronizing with a remote processor, it is entirely possible that
> the remoteproc core is not the life cycle manager.  In such a case core
> operations don't exist and should not be called.

What about ops in remote_core.c?
Applying the series, seems that at least rproc->ops->panic rproc->ops->da_to_va 
can be called tested with undefined ops structure.

Regards, 

Arnaud

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_internal.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index b389dc79da81..59fc871743c7 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -67,7 +67,7 @@ rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> -	if (rproc->ops->sanity_check)
> +	if (rproc->ops && rproc->ops->sanity_check)
>  		return rproc->ops->sanity_check(rproc, fw);
>  
>  	return 0;
> @@ -76,7 +76,7 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  static inline
>  u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>  {
> -	if (rproc->ops->get_boot_addr)
> +	if (rproc->ops && rproc->ops->get_boot_addr)
>  		return rproc->ops->get_boot_addr(rproc, fw);
>  
>  	return 0;
> @@ -85,7 +85,7 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>  static inline
>  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>  {
> -	if (rproc->ops->load)
> +	if (rproc->ops && rproc->ops->load)
>  		return rproc->ops->load(rproc, fw);
>  
>  	return -EINVAL;
> @@ -93,7 +93,7 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>  
>  static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
> -	if (rproc->ops->parse_fw)
> +	if (rproc->ops && rproc->ops->parse_fw)
>  		return rproc->ops->parse_fw(rproc, fw);
>  
>  	return 0;
> @@ -103,7 +103,7 @@ static inline
>  int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
>  		     int avail)
>  {
> -	if (rproc->ops->handle_rsc)
> +	if (rproc->ops && rproc->ops->handle_rsc)
>  		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
>  					      avail);
>  
> @@ -114,7 +114,7 @@ static inline
>  struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  						   const struct firmware *fw)
>  {
> -	if (rproc->ops->find_loaded_rsc_table)
> +	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
>  		return rproc->ops->find_loaded_rsc_table(rproc, fw);
>  
>  	return NULL;
> 
