Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A35C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85032068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uBWGUsor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgEDL6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:58:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57246 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:58:09 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044BrYgL016723;
        Mon, 4 May 2020 13:58:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=8H8qqunhCBpWTxFOyEWBAmW7PrCQ9yN+FPBj13gwF8Y=;
 b=uBWGUsorX8uHRJYRfFjzm6mv6vdbY5TeF48VLfybap6cPGHVhN2bl4dp2wwU5qTO3FR5
 jrlE8I1UMPt54jS069t1vJWV7+gR3Dk5CJQ/Qf55tL59JyTeoh24Tui0dr0BO5qCyvFl
 YE/ghckcjF1pRsGUErSyOENC4lBzkMQFcXBYqM/4+IhR3aKg4RXVTNHCjqGW90nEc5kk
 hgnhAEXFiYvaqPWeZHb/dAN37jrafkTwb7Gg0I471T9wPRkt6keIp/MNES/nhO2zpfoJ
 K7qnfk185N4wlz6avXnwtXylvbhcW2DdvylzgC2n9fuWVHMlFYk/RSSeiXX8aOE7cEsU 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrj1wbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 13:58:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCE8010002A;
        Mon,  4 May 2020 13:58:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C915A2BBABC;
        Mon,  4 May 2020 13:58:02 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 13:58:01 +0200
Subject: Re: [PATCH v3 12/14] remoteproc: Introducing function
 rproc_set_state_machine()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-13-mathieu.poirier@linaro.org>
 <d297aeab-4f7e-95e0-04c0-266e0f08b2d0@st.com> <20200430204233.GB18004@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <842d64d8-832a-cc4c-cbe1-dbd4654fcdd5@st.com>
Date:   Mon, 4 May 2020 13:57:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430204233.GB18004@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_07:2020-05-04,2020-05-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/20 10:42 PM, Mathieu Poirier wrote:
> On Wed, Apr 29, 2020 at 11:22:28AM +0200, Arnaud POULIQUEN wrote:
>>
>>
>> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
>>> Introducting function rproc_set_state_machine() to add
>>> operations and a set of flags to use when synchronising with
>>> a remote processor.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c     | 54 ++++++++++++++++++++++++
>>>  drivers/remoteproc/remoteproc_internal.h |  6 +++
>>>  include/linux/remoteproc.h               |  3 ++
>>>  3 files changed, 63 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index 48afa1f80a8f..5c48714e8702 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -2065,6 +2065,59 @@ int devm_rproc_add(struct device *dev, struct rproc *rproc)
>>>  }
>>>  EXPORT_SYMBOL(devm_rproc_add);
>>>  
>>> +/**
>>> + * rproc_set_state_machine() - Set a synchronisation ops and set of flags
>>> + *			       to use with a remote processor
>>> + * @rproc:	The remote processor to work with
>>> + * @sync_ops:	The operations to use when synchronising with a remote
>>> + *		processor
>>> + * @sync_flags:	The flags to use when deciding if the remoteproc core
>>> + *		should be synchronising with a remote processor
>>> + *
>>> + * Returns 0 on success, an error code otherwise.
>>> + */
>>> +int rproc_set_state_machine(struct rproc *rproc,
>>> +			    const struct rproc_ops *sync_ops,
>>> +			    struct rproc_sync_flags sync_flags)
>>
>> So this API should be called by platform driver only in case of synchronization
>> support, right?
> 
> Correct
> 
>> In this case i would rename it as there is also a state machine in "normal" boot
>> proposal: rproc_set_sync_machine or rproc_set_sync_state_machine
> 
> That is a valid observation - rproc_set_sync_state_machine() sounds descriptive
> enough for me.
> 
>>
>>> +{
>>> +	if (!rproc || !sync_ops)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * No point in going further if we never have to synchronise with
>>> +	 * the remote processor.
>>> +	 */
>>> +	if (!sync_flags.on_init &&
>>> +	    !sync_flags.after_stop && !sync_flags.after_crash)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Refuse to go further if remoteproc operations have been allocated
>>> +	 * but they will never be used.
>>> +	 */
>>> +	if (rproc->ops && sync_flags.on_init &&
>>> +	    sync_flags.after_stop && sync_flags.after_crash)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Don't allow users to set this more than once to avoid situations
>>> +	 * where the remote processor can't be recovered.
>>> +	 */
>>> +	if (rproc->sync_ops)
>>> +		return -EINVAL;
>>> +
>>> +	rproc->sync_ops = kmemdup(sync_ops, sizeof(*sync_ops), GFP_KERNEL);
>>> +	if (!rproc->sync_ops)
>>> +		return -ENOMEM;
>>> +
>>> +	rproc->sync_flags = sync_flags;
>>> +	/* Tell the core what to do when initialising */
>>> +	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_INIT);
>>
>> Is there a use case where sync_flags.on_init is false and other flags are true?
> 
> I haven't seen one yet, which doesn't mean it doesn't exist or won't in the
> future.  I wanted to make this as flexible as possible.  I started with the idea
> of making synchronisation at initialisation time implicit if
> rproc_set_state_machine() is called but I know it is only a matter of time
> before people come up with some exotic use case where .on_init is false.

So having on_init false but after_crash && after_stop true, means loading the
firmware on first start, and the synchronize with it, right?
Yes probably could be an exotic valid use case. :) 

> 
>>
>> Look like on_init is useless and should not be exposed to the platform driver.
>> Or comments are missing to explain the usage of it vs the other flags.
> 
> Comments added in remoteproc_internal.h and the new section in
> Documentation/remoteproc.txt aren't sufficient?  Can you give me a hint as to
> what you think is missing?

IMO something is quite confusing...
On one side on_init can be set to false.
But on the other side the flag is set  by call rproc_set_state_machine. 
In Documentation/remoteproc.txt rproc_set_state_machine description is:

"This function should be called for cases where the remote processor has
been started by another entity, be it a boot loader or trusted environment,
and the remoteproc core is to synchronise with the remote processor rather
then boot it."

So how on_init could be false if "the remote processor has
been started by another entity"?

Regards,
Arnaud

> 
>>
>> Regards,
>> Arnaud
>>  
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(rproc_set_state_machine);
>>> +
>>>  /**
>>>   * rproc_type_release() - release a remote processor instance
>>>   * @dev: the rproc's device
>>> @@ -2088,6 +2141,7 @@ static void rproc_type_release(struct device *dev)
>>>  	kfree_const(rproc->firmware);
>>>  	kfree_const(rproc->name);
>>>  	kfree(rproc->ops);
>>> +	kfree(rproc->sync_ops);
>>>  	kfree(rproc);
>>>  }
>>>  
>>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>>> index 7dcc0a26892b..c1a293a37c78 100644
>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>> @@ -27,6 +27,8 @@ struct rproc_debug_trace {
>>>  /*
>>>   * enum rproc_sync_states - remote processsor sync states
>>>   *
>>> + * @RPROC_SYNC_STATE_INIT	state to use when the remoteproc core
>>> + *				is initialising.
>>>   * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
>>>   *				has shutdown (rproc_shutdown()) the
>>>   *				remote processor.
>>> @@ -39,6 +41,7 @@ struct rproc_debug_trace {
>>>   * operation to use.
>>>   */
>>>  enum rproc_sync_states {
>>> +	RPROC_SYNC_STATE_INIT,
>>>  	RPROC_SYNC_STATE_SHUTDOWN,
>>>  	RPROC_SYNC_STATE_CRASHED,
>>>  };
>>> @@ -47,6 +50,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
>>>  				       enum rproc_sync_states state)
>>>  {
>>>  	switch (state) {
>>> +	case RPROC_SYNC_STATE_INIT:
>>> +		rproc->sync_with_rproc = rproc->sync_flags.on_init;
>>> +		break;
>>>  	case RPROC_SYNC_STATE_SHUTDOWN:
>>>  		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
>>>  		break;
>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> index ceb3b2bba824..a75ed92b3de6 100644
>>> --- a/include/linux/remoteproc.h
>>> +++ b/include/linux/remoteproc.h
>>> @@ -619,6 +619,9 @@ struct rproc *rproc_get_by_child(struct device *dev);
>>>  struct rproc *rproc_alloc(struct device *dev, const char *name,
>>>  			  const struct rproc_ops *ops,
>>>  			  const char *firmware, int len);
>>> +int rproc_set_state_machine(struct rproc *rproc,
>>> +			    const struct rproc_ops *sync_ops,
>>> +			    struct rproc_sync_flags sync_flags);
>>>  void rproc_put(struct rproc *rproc);
>>>  int rproc_add(struct rproc *rproc);
>>>  int rproc_del(struct rproc *rproc);
>>>
