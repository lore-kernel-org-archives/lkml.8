Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F167C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F9120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="t6aqzxcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEDLPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:15:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20816 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbgEDLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:15:13 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044BD8fs010450;
        Mon, 4 May 2020 13:15:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=1o8XQCu8OW2AUgdUU0IPhcblOWYyXxE1+tgWhHaQc3I=;
 b=t6aqzxcxwzYWTeYpGABYNG0E4mkJYYIFBzzV0vwU0zz0KN6Q+s0I0fwSA5/HDxIxAlwg
 pblfvSqOlbR/cbkS4rs0IRDT11FIsfeHnDvIa+DjNqx/FuFrCHpOgzBKdwhw/asLRrHd
 UBF+O+NrJyLPRkYdclJbVicgAAutUWBZdZs1ePVKitnOM1fN50zaOMHyBHf2rNYx+4f/
 EqlJFd4t+thcWTKK5zhq8Hws7FYsCXuRGpzXySTjwJnFIxPqPEXIv0pbA8LiCRTAeuFG
 wfsnWAHlbdwdOL5CsUo2IJ2QoBHMkqa7z6sEwTGoPa2UHowALfeFRX6F+SQNeDbMTqXD 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxmv9r7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 13:15:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B53F10002A;
        Mon,  4 May 2020 13:15:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2939D2D3786;
        Mon,  4 May 2020 13:15:02 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 13:15:00 +0200
Subject: Re: [PATCH v3 08/14] remoteproc: Call core functions based on
 synchronisation flag
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-9-mathieu.poirier@linaro.org>
 <a17d871a-3b3f-a462-9b2c-f9183f80a533@st.com> <20200430195749.GC17031@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <6f85f227-e244-8136-b0f4-0b6ab167d852@st.com>
Date:   Mon, 4 May 2020 13:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430195749.GC17031@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_05:2020-05-04,2020-05-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Mathieu,

On 4/30/20 9:57 PM, Mathieu Poirier wrote:
> On Tue, Apr 28, 2020 at 07:27:27PM +0200, Arnaud POULIQUEN wrote:
>>
>>
>> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
>>> Call the right core function based on whether we should synchronise
>>> with a remote processor or boot it from scratch.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>  drivers/remoteproc/remoteproc_internal.h | 50 ++++++++++++++++++++++++
>>>  1 file changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>>> index dda7044c4b3e..3985c084b184 100644
>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>> @@ -72,6 +72,12 @@ static inline bool rproc_needs_syncing(struct rproc *rproc)
>>>  static inline
>>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->sanity_check)
>>> +			return rproc->sync_ops->sanity_check(rproc, fw);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->sanity_check)
>>>  		return rproc->ops->sanity_check(rproc, fw);
>>
>> Regarding this patch I'm trying to determine whether it makes sense to have ops or
>> sync_ops set to null. Your[v3 01/14]  patch commit explains that ops can be null in case of
>> synchronisation.
>> But it seems deprecated with the sync_ops introduction...
> 
> Your comment made me go over the logic again...  If rproc_needs_syncing() is
> true then we necessarily have a sync_ops.  If rproc_needs_syncing() is false,
> there too we automatically have an ops.  As such and as you point out, checking
> for rproc->sync_ops and rproc-ops is probably useless.
An Additional test in rproc_set_state_machine should be sufficient, something like that: 
 /* rproc->ops struct is mandatory if at least one sync flag is false */
 if (!rproc->ops && !(sync_flags.on_init &&
	    sync_flags.after_stop && sync_flags.after_crash))
		return -EINVAL;

> 
>>
>> And if sync_ops is null, is it still necessary to define a remoteproc device?
> 
> Not sure I understand your point here but with the reasonning from above it
> is probably moot anyway. 
Just to mention that a platform device with ops and ops_sync null seems like nonsense 

Regards,
Arnaud
> 
>>
>> Regards
>> Arnad
>>
>>>  
>>> @@ -81,6 +87,12 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>>  static inline
>>>  u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->get_boot_addr)
>>> +			return rproc->sync_ops->get_boot_addr(rproc, fw);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->get_boot_addr)
>>>  		return rproc->ops->get_boot_addr(rproc, fw);
>>>  
>>> @@ -90,6 +102,12 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>>>  static inline
>>>  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->load)
>>> +			return rproc->sync_ops->load(rproc, fw);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->load)
>>>  		return rproc->ops->load(rproc, fw);
>>>  
>>> @@ -98,6 +116,12 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>>>  
>>>  static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->parse_fw)
>>> +			return rproc->sync_ops->parse_fw(rproc, fw);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->parse_fw)
>>>  		return rproc->ops->parse_fw(rproc, fw);
>>>  
>>> @@ -108,6 +132,13 @@ static inline
>>>  int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
>>>  		     int avail)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->handle_rsc)
>>> +			return rproc->sync_ops->handle_rsc(rproc, rsc_type,
>>> +							   rsc, offset, avail);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->handle_rsc)
>>>  		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
>>>  					      avail);
>>> @@ -119,6 +150,13 @@ static inline
>>>  struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>>>  						   const struct firmware *fw)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->find_loaded_rsc_table)
>>> +			return rproc->sync_ops->find_loaded_rsc_table(rproc,
>>> +								      fw);
>>> +		return NULL;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
>>>  		return rproc->ops->find_loaded_rsc_table(rproc, fw);
>>>  
>>> @@ -127,6 +165,12 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>>>  
>>>  static inline int rproc_start_device(struct rproc *rproc)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->start)
>>> +			return rproc->sync_ops->start(rproc);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->start)
>>>  		return rproc->ops->start(rproc);
>>>  
>>> @@ -135,6 +179,12 @@ static inline int rproc_start_device(struct rproc *rproc)
>>>  
>>>  static inline int rproc_stop_device(struct rproc *rproc)
>>>  {
>>> +	if (rproc_needs_syncing(rproc)) {
>>> +		if (rproc->sync_ops && rproc->sync_ops->stop)
>>> +			return rproc->sync_ops->stop(rproc);
>>> +		return 0;
>>> +	}
>>> +
>>>  	if (rproc->ops && rproc->ops->stop)
>>>  		return rproc->ops->stop(rproc);
>>>  
>>>
