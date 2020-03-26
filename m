Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AB20748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="g/eaBwl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgCZLlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:41:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbgCZLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:41:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QBc4YE012834;
        Thu, 26 Mar 2020 12:41:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iO8rUEhZkJ/c/0UaQBy7t2zAod6oV5H9Qli02UGoU+E=;
 b=g/eaBwl6+MlRla5l+HJZdr8HpTH5Lyx6cyojtzaVlY+iPWHg4oz63jc0Lt121EI4JjQE
 oc0O4GAYmPVKo3PLcvs8Nl5WM6aLNb1un8Jkfa5qaZ3gk6P6kBRwk5fwEL8fW+3N0kVt
 n0ywUtAQc2Mp3hlSrpePiyVWcIvwRFQOGo6xa9sNz875fn7yUZW4xieWS/WeVVcS14W4
 zCvzZs5SVbujX3AWihVVEAUSpTPv2wAByM8EwG2UDSdh65MCEx6n2Hgu+t9yqJSRkdX9
 y7he6wQ+iaW1dqTsOnumsGotRzLx8MqpFIg8iHRFoDhuozGYWCN6mJVW8TKNkzD/qulf WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ywappbc6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 12:41:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 121FC100038;
        Thu, 26 Mar 2020 12:41:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEBD9210894;
        Thu, 26 Mar 2020 12:40:59 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 12:40:48 +0100
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
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
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
 <1e4ce821-dd9b-bb04-774b-58a255834cf5@st.com>
 <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <2512639d-424f-9647-4dbd-3b3459465888@st.com>
Date:   Thu, 26 Mar 2020 12:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_02:2020-03-26,2020-03-26 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/20 2:31 PM, Jiri Slaby wrote:
> On 25. 03. 20, 14:15, Arnaud POULIQUEN wrote:
>>>> +		if (copied != len)
>>>> +			dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
>>>> +				copied);
>>>> +		tty_flip_buffer_push(&cport->port);
>>>> +	} else {
>>>> +		/* control message */
>>>> +		struct rpmsg_tty_ctrl *msg = data;
>>>> +
>>>> +		if (len != sizeof(*msg))
>>>> +			return -EINVAL;
>>>> +
>>>> +		cport->data_dst = msg->d_ept_addr;
>>>> +
>>>> +		/* Update remote cts state */
>>>> +		cport->cts = msg->cts ? 1 : 0;
>>>
>>> Number to bool implicit conversion needs no magic, just do:
>>> cport->cts = msg->cts;
>>
>> In this case i would prefer  cport->cts = (msg->cts != 1);
>> for the conversion
> 
> That still looks confusing. In the ternary operator above, you used
> msg->cts as a bool implicitly and now you are trying to artificially
> create one :)?
> 
> IOW in a bool context, "msg->cts ? 1 : 0" is the same as "msg->cts".
> Look like the better solution would be to not use bool at all here...
 
>>>> +	/*
>>>> +	 * Try to send the message to remote processor, if failed return 0 as
>>>> +	 * no data sent
>>>> +	 */
>>>> +	ret = rpmsg_trysendto(cport->d_ept, tmpbuf, msg_size, cport->data_dst);
>>>
>>> data of rpmsg_trysendto is not const. OK, you seem you need to change
>>> that first, I see no blocker for that.
>>
>> I created a temporary buffer to ensure that buffer to sent does not exceed the 
>> MTU size.
>> But perhaps this is an useless protection as the rpmsg_tty_write_room already
>> return the MTU value, and so the 'len' variable can not be higher that value
>> returned by the write_room?
> 
> You still can limit it by msg_size without cloning the buffer, right?
you are right, but in this case i need to cast the buff to suppress compilation
warning on const and I don't know if all compilers will accept this...
 
pbuf = (u8 *)buf;
ret = rpmsg_trysendto(cport->d_ept, pbuf, msg_size, cport->data_dst);

> 
>>>> +static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_struct *tty)
>>>> +{
>>>> +	p->low_latency = (p->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
>>>> +
>>>> +	/* Allocate the buffer we use for writing data */
>>>
>>> Where exactly -- am I missing something?
>>
>> in tty_port_alloc_xmit_buf. it's a copy past from mips_ejtag_fdc.c,
>> I will clean this line if it's confusing.
> 
> No, I mean where do you use the allocated buffer? mips_ejtag_fdc.c uses it.
Seems i misunderstood the usage of the xmit buffer, need to have look in.

> 
>>>> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
>>>> +{
>>>> +	struct rpmsg_tty_port *cport;
>>>> +	struct device *dev = &rpdev->dev;
>>>> +	struct rpmsg_channel_info chinfo;
>>>> +	struct device *tty_dev;
>>>> +	int ret;
>>>> +
>>>> +	cport = rpmsg_tty_alloc_cport();
>>>> +	if (IS_ERR(cport)) {
>>>> +		dev_err(dev, "failed to alloc tty port\n");
>>>> +		return PTR_ERR(cport);
>>>> +	}
>>>> +
>>>> +	if (!strncmp(rpdev->id.name, TTY_CH_NAME_WITH_CTS,
>>>> +		     sizeof(TTY_CH_NAME_WITH_CTS))) {
>>>
>>> sizeof of a string feels unnatural, but will work in this case. Can a
>>> compiler optimize strlen of a static string?
>>
>> I don't know if a compiler can do this...
>> what about replacing sizeof by strlen function? 
>> i saw some code example that use strlen with static string...
>> (e.g  https://elixir.bootlin.com/linux/latest/source/drivers/edac/edac_mc.c#L1193)
> 
> The question was exactly about that: can a compiler optimize it to a
> bare number or will strlen call remain there?
> 
i answered in Joe's mail for this point

Thanks!
Arnaud

> thanks,
> 

