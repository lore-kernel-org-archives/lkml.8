Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA00C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84C720752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FGLfEE19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgEDLe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:34:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28530 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728772AbgEDLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:34:56 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044BX3KE023647;
        Mon, 4 May 2020 13:34:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=mDjERu7ZrDuEr48yREnU3S3loqh+bWTzk4haAKd7vIA=;
 b=FGLfEE1959XKXsHX+7yP0ttZYtOUz/ih7s2oG9eTAeJITSb1dKFbDPdoLcC6dIaDtco4
 hajFqqOfq8Z+ess0c8ZPvim5ls9s7Ny0KT65cQznhkTMOXZbLSnZfBn8wm+zDWygq3ta
 khSnB4d2apt91Q9N6AmCYuY5BKp4UvyxMlJNPXazngKKnIgbkZxbL3jmWZVQA/H8Hjt1
 4GMiaNzU4mFC1CE22OEuoFh5RAmlEZ+eL+E6UwK30gWISVwBfIPeYZRzKJ6KWTa4dOPo
 mSyEG7OftVqOoEdrRPoKLR1He+UjtE88pjhoTVzItf0YiksqdG8qsjGOkvS8FBRQ6NUT VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rx08a4ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 13:34:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD57D10002A;
        Mon,  4 May 2020 13:34:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C639B2BE223;
        Mon,  4 May 2020 13:34:45 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 13:34:44 +0200
Subject: Re: [PATCH v3 10/14] remoteproc: Deal with synchronisation when
 shutting down
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-11-mathieu.poirier@linaro.org>
 <d2eeb480-6ba1-de12-53ba-cdf9c61b94b0@st.com> <20200430202312.GE17031@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <04b8f860-2b01-7e4f-cdea-08a3cf8af26c@st.com>
Date:   Mon, 4 May 2020 13:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430202312.GE17031@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_06:2020-05-04,2020-05-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/20 10:23 PM, Mathieu Poirier wrote:
> On Wed, Apr 29, 2020 at 10:19:49AM +0200, Arnaud POULIQUEN wrote:
>>
>>
>> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
>>> The remoteproc core must not allow function rproc_shutdown() to
>>> proceed if currently synchronising with a remote processor and
>>> the synchronisation operations of that remote processor does not
>>> support it.  Also part of the process is to set the synchronisation
>>> flag so that the remoteproc core can make the right decisions when
>>> restarting the system.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
>>>  drivers/remoteproc/remoteproc_internal.h |  7 ++++++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index 3a84a38ba37b..48afa1f80a8f 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -1849,6 +1849,27 @@ int rproc_boot(struct rproc *rproc)
>>>  }
>>>  EXPORT_SYMBOL(rproc_boot);
>>>  
>>> +static bool rproc_can_shutdown(struct rproc *rproc)
>>> +{
>>> +	/*
>>> +	 * The remoteproc core is the lifecycle manager, no problem
>>> +	 * calling for a shutdown.
>>> +	 */
>>> +	if (!rproc_needs_syncing(rproc))
>>> +		return true;
>>> +
>>> +	/*
>>> +	 * The remoteproc has been loaded by another entity (as per above
>>> +	 * condition) and the platform code has given us the capability
>>> +	 * of stopping it.
>>> +	 */
>>> +	if (rproc->sync_ops->stop)
>>> +		return true;
>>
>> This means that if rproc->sync_ops->stop is null rproc_stop_subdevices will not
>> be called? seems not symmetric with the start sequence.
> 
> If rproc->sync_ops->stop is not provided then the remoteproc core can't stop the
> remote processor at all after it has synchronised with it.  If a usecase
> requires some kind of soft reset then a stop() function that uses a mailbox
> notification or some other mechanism can be provided to tell the remote
> processor to put itself back in startup mode again.
> 
> Is this fine with you or there is still something I don't get?

My point here is more around the subdevices. But perhaps i missed something...

In rproc_start rproc_start_subdevices is called, even if sync_start is null.
But in rproc_shutdown rproc_stop is not called, if sync_ops->stop is null.
So rproc_stop_subdevices is not called in this case.
Then if sync_flags.after_stop is false, it looks like that something will go wrong
at next start.

> 
>> Probably not useful to test it here as condition is already handled in rproc_stop_device...
>>
>> Regards
>> Arnaud
>>> +
>>> +	/* Any other condition should not be allowed */
>>> +	return false;
>>> +}
>>> +
>>>  /**
>>>   * rproc_shutdown() - power off the remote processor
>>>   * @rproc: the remote processor
>>> @@ -1879,6 +1900,9 @@ void rproc_shutdown(struct rproc *rproc)
>>>  		return;
>>>  	}
>>>  
>>> +	if (!rproc_can_shutdown(rproc))
>>> +		goto out;
>>> +
>>>  	/* if the remote proc is still needed, bail out */
>>>  	if (!atomic_dec_and_test(&rproc->power))
>>>  		goto out;
>>> @@ -1898,6 +1922,14 @@ void rproc_shutdown(struct rproc *rproc)
>>>  	kfree(rproc->cached_table);
>>>  	rproc->cached_table = NULL;
>>>  	rproc->table_ptr = NULL;
>>> +
>>> +	/*
>>> +	 * The remote processor has been switched off - tell the core what
>>> +	 * operation to use from hereon, i.e whether an external entity will
>>> +	 * reboot the remote processor or it is now the remoteproc core's
>>> +	 * responsability.
>>> +	 */
>>> +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_SHUTDOWN);
>>>  out:
>>>  	mutex_unlock(&rproc->lock);
>>>  }
>>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>>> index 61500981155c..7dcc0a26892b 100644
>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>> @@ -27,6 +27,9 @@ struct rproc_debug_trace {
>>>  /*
>>>   * enum rproc_sync_states - remote processsor sync states
>>>   *
>>> + * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
>>> + *				has shutdown (rproc_shutdown()) the
>>> + *				remote processor.
>>>   * @RPROC_SYNC_STATE_CRASHED	state to use after the remote processor
>>>   *				has crashed but has not been recovered by
>>>   *				the remoteproc core yet.
>>> @@ -36,6 +39,7 @@ struct rproc_debug_trace {
>>>   * operation to use.
>>>   */
>>>  enum rproc_sync_states {
>>> +	RPROC_SYNC_STATE_SHUTDOWN,
>>>  	RPROC_SYNC_STATE_CRASHED,
>>>  };
>>>  
>>> @@ -43,6 +47,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
>>>  				       enum rproc_sync_states state)
>>>  {
>>>  	switch (state) {
>>> +	case RPROC_SYNC_STATE_SHUTDOWN:
>>> +		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
>>> +		break;
>>>  	case RPROC_SYNC_STATE_CRASHED:
>>>  		rproc->sync_with_rproc = rproc->sync_flags.after_crash;
>>>  		break;
>>>
