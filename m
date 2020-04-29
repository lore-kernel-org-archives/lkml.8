Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8DB206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="i5qIPMCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgD2HoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:44:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2HoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:44:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T7cPXB007566;
        Wed, 29 Apr 2020 09:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=swIqQ4vbYZQqA2Q1t8s/GzJMhKq3YLoYM29QkeGfje8=;
 b=i5qIPMCK5FQ2WZuZWEsbrJUBaE6iDTAYsRCp06lQpumNgiId1DE+zNLQZ43zXW1urF2Q
 O1osbvqMdSuVYpOJ98UnNmo8tY+b/r5d4iYXDIqrExex2DlXJtQQyGdTqC0tI0XnFoMf
 pIRmnSpx47CCOInF8tDUv970h/jmjRCNrrKFNPgxLNWVQ/X6EywE+GJrOhYihrcbVfP7
 lvHC8fCNBm/yiKhp5w+nS+IUXEMAck0TJ0/xMeFSqqMMDlWr76CgTzYLRlcOhVo1PiXO
 tyUnRjr3TeUVeXgzCSRQUBlxEKdesjCPO1zzoehaVf79AyI4ORXdbdAvbNM/Z+MzqG/G /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjwvsvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:44:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17AB410002A;
        Wed, 29 Apr 2020 09:44:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03DF4205D20;
        Wed, 29 Apr 2020 09:44:04 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr
 2020 09:44:02 +0200
Subject: Re: [PATCH v3 09/14] remoteproc: Deal with synchronisation when
 crashing
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-10-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <d9df5905-ad8b-881c-5950-481722bd0f3b@st.com>
Date:   Wed, 29 Apr 2020 09:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424200135.28825-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> Refactor function rproc_trigger_recovery() in order to avoid
> reloading the firmware image when synchronising with a remote
> processor rather than booting it.  Also part of the process,
> properly set the synchronisation flag in order to properly
> recover the system.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 23 ++++++++++++++------
>  drivers/remoteproc/remoteproc_internal.h | 27 ++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ef88d3e84bfb..3a84a38ba37b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1697,7 +1697,7 @@ static void rproc_coredump(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
> +	const struct firmware *firmware_p = NULL;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1718,14 +1718,16 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	/* generate coredump */
>  	rproc_coredump(rproc);
>  
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> +	/* load firmware if need be */
> +	if (!rproc_needs_syncing(rproc)) {
> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_firmware failed: %d\n", ret);
> +			goto unlock_mutex;
> +		}

If we started in syncing mode then rpoc->firmware is null
rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_CRASHED) can make rproc_needs_syncing(rproc)
false. 
In this case here we fail the recovery an leave in RPROC_STOP state.
As you proposed in Loic RFC[1], what about adding a more explicit message to inform that the recovery
failed. 

[1]https://lkml.org/lkml/2020/3/11/402

Regards,
Arnaud
>  	}
>  
> -	/* boot the remote processor up again */
> +	/* boot up or synchronise with the remote processor again */
>  	ret = rproc_start(rproc, firmware_p);
>  
>  	release_firmware(firmware_p);
> @@ -1761,6 +1763,13 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  	dev_err(dev, "handling crash #%u in %s\n", ++rproc->crash_cnt,
>  		rproc->name);
>  
> +	/*
> +	 * The remote processor has crashed - tell the core what operation
> +	 * to use from hereon, i.e whether an external entity will reboot
> +	 * the MCU or it is now the remoteproc core's responsability.
> +	 */
> +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_CRASHED);
> +
>  	mutex_unlock(&rproc->lock);
>  
>  	if (!rproc->recovery_disabled)
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 3985c084b184..61500981155c 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,33 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +/*
> + * enum rproc_sync_states - remote processsor sync states
> + *
> + * @RPROC_SYNC_STATE_CRASHED	state to use after the remote processor
> + *				has crashed but has not been recovered by
> + *				the remoteproc core yet.
> + *
> + * Keeping these separate from the enum rproc_state in order to avoid
> + * introducing coupling between the state of the MCU and the synchronisation
> + * operation to use.
> + */
> +enum rproc_sync_states {
> +	RPROC_SYNC_STATE_CRASHED,
> +};
> +
> +static inline void rproc_set_sync_flag(struct rproc *rproc,
> +				       enum rproc_sync_states state)
> +{
> +	switch (state) {
> +	case RPROC_SYNC_STATE_CRASHED:
> +		rproc->sync_with_rproc = rproc->sync_flags.after_crash;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> 
