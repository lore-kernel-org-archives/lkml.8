Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD104C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8662121569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o/Sq7l33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBLQBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:01:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34882 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgBLQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:01:48 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CFwZ55001528;
        Wed, 12 Feb 2020 17:01:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=tCuQbEUwxiErUzebwFMT+runU/jX1hB4lUAevsJyGe4=;
 b=o/Sq7l33bVTTqc7pvfeXJh04FwU5vJ0UYsPzz/eBRg/sAOdQgpRwGBxPVSGl7E8ka73Z
 9aV0tADXKLZwFj4/BBs/70tnPLxbtEDclrIxa7wu2v6FwAzDktjAXLRZLfmRcy230xV7
 HZx6chi0iRwo8HNplX6d7ehHGXQdQV1vHanmuDieTqsSQlDnOH/t7bdnqLY+0FgJCM4f
 A3nkZFCuE9bd+npJkb7vx9sZ+wlN0xE4lfl2cRYg2rD4jTK9JfjGi+SBV7Kbgu+499U4
 Y3YAYRuCpa3+hseB93iA7IhzosjIsnafcwD8VHr6fWVob5a2gEzyGOC1yv4gKRH3CrRy Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9yc5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 17:01:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03EA910002A;
        Wed, 12 Feb 2020 17:01:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0326F2BD40B;
        Wed, 12 Feb 2020 17:01:30 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 17:01:29 +0100
Subject: Re: [PATCH] remoteproc: fix kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200212093211.15270-1-arnaud.pouliquen@st.com>
 <c912fe7e-601d-6d07-c368-109fecd11a7a@infradead.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <b6a7e733-f63f-431c-3b0e-9aeb3de43bb3@st.com>
Date:   Wed, 12 Feb 2020 17:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c912fe7e-601d-6d07-c368-109fecd11a7a@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-11,2020-02-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy

On 2/12/20 4:54 PM, Randy Dunlap wrote:
> Hi,
> 
> kernel-doc supports "..." as a function argument for varargs.
> See Documentation/doc-guide/kernel-doc.rst:
> 
> "If a function has a variable number of arguments, its description should
> be written in kernel-doc notation as::
> 
>       * @...: description"
I missed it, thanks for pointing it out!

Regards
Arnaud
> 
> 
> So the below could be done as:
> 
> On 2/12/20 1:32 AM, Arnaud Pouliquen wrote:
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 097f33e4f1f3..5f9a5812505c 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -224,7 +224,7 @@ EXPORT_SYMBOL(rproc_da_to_va);
>>  /**
>>   * rproc_find_carveout_by_name() - lookup the carveout region by a name
>>   * @rproc: handle of a remote processor
>> - * @name,..: carveout name to find (standard printf format)
>> + * @name: carveout name to find (standard printf format)
> 
>  * @name: carveout name to find
>  * @...: standard printf format of args to search for carveout name
> 
> although I'm not so sure about the descriptions there.
> 
>>   *
>>   * Platform driver has the capability to register some pre-allacoted carveout
>>   * (physically contiguous memory regions) before rproc firmware loading and
> 
> 
> thanks for the kernel-doc update.
> 
