Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBEBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44222067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MPOeUPjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGII7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:59:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgGII7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:59:05 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0698sLp9016309;
        Thu, 9 Jul 2020 10:59:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=AuAHoXnzN38gS14zx/vXMvisoYUc+8Vj5hyXrhj6d/g=;
 b=MPOeUPjF5Md6YaMmnapkk5OeVe+0pzEd997W7tyLQNHT0BHDNBYRmR3Pm6oFC1vnbnut
 ehegrugm/ucow3A5cNkf24jR2fHekw7094kFVuI6YmZOt9S/kjPaTMvnNjspoYIaYoj+
 xS1gfaAQT+oLULuqR9UgkbHuk0JRd++b33wmgg+IqEP6bD1/CqcQ7UVkec+YskkuSYFP
 OO6fdYqP7/USUaLr4TFptU8rzVn6vh+mTEWKatIAw/yrwwZIUk9dVtpaYcLj/h5CXB2T
 UsFtDgIPKdcH3w/09eBSOASNuDwzqY9LlmKR8yyyphDkug7DJQ9BHGbMC9HJ6y5Dd+hK 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k403jjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:59:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDCEA10002A;
        Thu,  9 Jul 2020 10:58:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E09182AB504;
        Thu,  9 Jul 2020 10:58:56 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 10:58:56 +0200
Subject: Re: [PATCH v5 9/9] remoteproc: Properly handle firmware name when
 attaching
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
 <20200707210014.927691-10-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <4cf20bea-6a77-1a1f-b448-a9abad8f1179@st.com>
Date:   Thu, 9 Jul 2020 10:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707210014.927691-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_04:2020-07-08,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 11:00 PM, Mathieu Poirier wrote:
> This patch prevents the firmware image name from being displayed when
> the remoteproc core is attaching to a remote processor. This is needed
> needed since there is no guarantee about the nature of the firmware
> image that is loaded by the external entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

> ---
>  drivers/remoteproc/remoteproc_core.c  | 18 ++++++++++++++++++
>  drivers/remoteproc/remoteproc_sysfs.c | 16 ++++++++++++++--
>  include/linux/remoteproc.h            |  2 ++
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6b6e4ec8cf3a..099c76ab198f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1624,6 +1624,14 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  
>  	rproc->state = RPROC_OFFLINE;
>  
> +	/*
> +	 * The remote processor has been stopped and is now offline, which means
> +	 * that the next time it is brought back online the remoteproc core will
> +	 * be responsible to load its firmware.  As such it is no longer
> +	 * autonomous.
> +	 */
> +	rproc->autonomous = false;
> +
>  	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>  
>  	return 0;
> @@ -2142,6 +2150,16 @@ int rproc_add(struct rproc *rproc)
>  	/* create debugfs entries */
>  	rproc_create_debug_dir(rproc);
>  
> +	/*
> +	 * Remind ourselves the remote processor has been attached to rather
> +	 * than booted by the remoteproc core.  This is important because the
> +	 * RPROC_DETACHED state will be lost as soon as the remote processor
> +	 * has been attached to.  Used in firmware_show() and reset in
> +	 * rproc_stop().
> +	 */
> +	if (rproc->state == RPROC_DETACHED)
> +		rproc->autonomous = true;
> +
>  	/* if rproc is marked always-on, request it to boot */
>  	if (rproc->auto_boot) {
>  		ret = rproc_trigger_auto_boot(rproc);
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 264759713934..eea514cec50e 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -15,8 +15,20 @@ static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct rproc *rproc = to_rproc(dev);
> -
> -	return sprintf(buf, "%s\n", rproc->firmware);
> +	const char *firmware = rproc->firmware;
> +
> +	/*
> +	 * If the remote processor has been started by an external
> +	 * entity we have no idea of what image it is running.  As such
> +	 * simply display a generic string rather then rproc->firmware.
> +	 *
> +	 * Here we rely on the autonomous flag because a remote processor
> +	 * may have been attached to and currently in a running state.
> +	 */
> +	if (rproc->autonomous)
> +		firmware = "unknown";
> +
> +	return sprintf(buf, "%s\n", firmware);
>  }
>  
>  /* Change firmware name via sysfs */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index bf6a310ba870..cf5e31556780 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -491,6 +491,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @autonomous: true if an external entity has booted the remote processor
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   */
> @@ -524,6 +525,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool autonomous;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> 
