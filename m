Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D2020776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Jbwssv1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbgDALel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:34:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728485AbgDALek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:34:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031BWvg5017607;
        Wed, 1 Apr 2020 13:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=+2BMx26vkjwc3YK10hD0AM3GIY2oLTo87coBQTI8CTE=;
 b=Jbwssv1SpmhchSvsN155hoa3kKwPEoHGmXXX4Ol/V9PgLhuGLy1m8WP83rhjp1Tw4NWz
 CNGvLUfP2GbPT2IT0CW1Jb/X/7Ue8TmAprVWjmXvz96U1E6ZLn4imJKB9jdFIQ2rfiMV
 bBdM6fhZu+9EZ7MdiEK0KwqRk3PvVZU+82jWe8ropTeWQgLRhKfLB29Le26wEPaOwXd5
 ZPpPtQNzI1wd6lt3+dIPYmUK+oMzPYCXvEO/70+YWmsQ4N0llkp3waVtUo5MnrgSItS0
 dcn+At/ybi4v/wPpd9xTVoECLoJ4j5jTHldXf9ggIYS1+UZ5+fruY53HKe6pBiZfBVUU rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmmuq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 13:34:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7BAD10002A;
        Wed,  1 Apr 2020 13:34:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FFA92A620D;
        Wed,  1 Apr 2020 13:34:24 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 13:34:22 +0200
Subject: Re: [PATCH v7 1/2] rpmsg: core: add API to get MTU
To:     Jiri Slaby <jslaby@suse.cz>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-2-arnaud.pouliquen@st.com>
 <356fe539-6ec4-6000-1f68-23404fc5d373@suse.com>
 <9f302a19-e684-ffff-823a-02af7f90403c@suse.cz>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <1edf98cf-dfb6-0e66-a58d-abba5d2a65c4@st.com>
Date:   Wed, 1 Apr 2020 13:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9f302a19-e684-ffff-823a-02af7f90403c@suse.cz>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/20 8:29 AM, Jiri Slaby wrote:
> On 01. 04. 20, 8:28, Jiri Slaby wrote:
>> On 24. 03. 20, 18:04, Arnaud Pouliquen wrote:
>>> Return the rpmsg buffer MTU for sending message, so rpmsg users
>>> can split a long message in several sub rpmsg buffers.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> Acked-by: Suman Anna <s-anna@ti.com>
>>> ---
>>>  drivers/rpmsg/rpmsg_core.c       | 21 +++++++++++++++++++++
>>>  drivers/rpmsg/rpmsg_internal.h   |  2 ++
>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
>>>  include/linux/rpmsg.h            | 10 ++++++++++
>>>  4 files changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index e330ec4dfc33..a6ef54c4779a 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -283,6 +283,27 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>  }
>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>  
>>> +/**
>>> + * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>> + * @ept: the rpmsg endpoint
>>> + *
>>> + * This function returns maximum buffer size available for a single message.
>>> + *
>>> + * Return: the maximum transmission size on success and an appropriate error
>>> + * value on failure.
>>> + */
>>> +
>>> +ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>> +{
>>> +	if (WARN_ON(!ept))
>>> +		return -EINVAL;
>>> +	if (!ept->ops->get_mtu)
>>> +		return -ENOTSUPP;
>>
>> Hmm, I don't think all callers of tty_write_room() handle negative values...
>>
>> But some drivers also return negative values. There is some work to be
>> done, adding to TODO.
>>
>> For the time being, I suggest returning 0 instead.
> 
> Or better, convert the negative to 0 in rpmsg_tty_write_room for now.
> 
>> thanks,-- 

Right, seems that a negative return of tty_write_room seems not always handled
so i will force to 0 in rpmsg_tty in case of error returned. I will also
add a comment in code that explain the context.
  
Thanks,
Arnaud
