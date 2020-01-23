Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00B24655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAWLGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:06:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWLGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:06:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50A1531B;
        Thu, 23 Jan 2020 03:06:40 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7AB3F6C4;
        Thu, 23 Jan 2020 03:06:39 -0800 (PST)
Subject: Re: [PATCH V3] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>,
        jassisinghbrar@gmail.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4b74f1b6c1f9653241a1b5754525e230b3d76a3f.1579595093.git.viresh.kumar@linaro.org>
 <3a8836dd-99d3-faff-af05-2032d609f594@arm.com>
 <20200123023924.roqc2iyx4wmukk4p@vireshk-i7>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <d5d71818-e68f-7688-4378-64d96bea922d@arm.com>
Date:   Thu, 23 Jan 2020 11:06:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123023924.roqc2iyx4wmukk4p@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2020 02:39, Viresh Kumar wrote:
> On 22-01-20, 12:44, Cristian Marussi wrote:
>> On 21/01/2020 08:27, Viresh Kumar wrote:
>> commment is obsolete
> 
> Right, they need to be checked everywhere again. Sorry for missing
> that earlier.
> 
>>> +struct scmi_chan_info {
>>> +	struct scmi_info *info;
>>> +	struct device *dev;
>>> +	struct scmi_handle *handle;
>>> +	void *transport_info;
>>> +};
>>> +
>>> +/**
>>> + * struct scmi_transport_ops - Structure representing a SCMI transport ops
>>> + *
>>> + * @send_message: Callback to send a message
>>> + * @mark_txdone: Callback to mark tx as done
>>> + * @chan_setup: Callback to allocate and setup a channel
>>> + * @chan_free: Callback to free a channel
>>> + */
>> commment is obsolete but I would also ask: are all of these operations supposed to be mandatory supported
>> on any possible foreseeable transport ? (beside the obviously needed like send_message)
>>
>> I'm asking because they are all called straight away from the driver core without any NULL check
>> so that if a new transport should not need one of them it will be forced to anyway implement a dummy one
>> to comply, which it will be needlessly invoked every time.
> 
> They are kept as mandatory for now as we don't really know how it
> will look for other transport types. Lets make them optional only when
> someone don't need to define them. It would be a simple change anyway.

Ok, fine.
> 
>>>  /* Each compatible listed below must have descriptor associated with it */
>>>  static const struct of_device_id scmi_of_match[] = {
>>> -	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
>>> +	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
>>>  	{ /* Sentinel */ },
>>>  };
>>
>> minor thing: shouldn't the chosen transport being configurable at compile time with some
>> option like CONFIG_SCMI_TRANSPORT_MBOX ? or via DT ?
> 
> It is configurable via DT. The compatible should look different in
> that case, something like: "arm,scmi-<newtranport>".
> 

Ah ok, we're assuming mailbox transport as the default, being the only one existing as of now.
Fine for me, thanks for the explanation.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Regards

Cristian

