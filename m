Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CCC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107521739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgA1WHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:07:04 -0500
Received: from foss.arm.com ([217.140.110.172]:35148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:07:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02AA81FB;
        Tue, 28 Jan 2020 14:07:03 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BAF13F68E;
        Tue, 28 Jan 2020 14:07:00 -0800 (PST)
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus> <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus> <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6a6ba7ff-7ed9-e573-63ca-66fca609075b@arm.com>
Date:   Tue, 28 Jan 2020 22:06:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-28 8:06 pm, Benjamin GAIGNARD wrote:
> 
> On 1/28/20 6:17 PM, Sudeep Holla wrote:
>> On Tue, Jan 28, 2020 at 04:46:41PM +0000, Benjamin GAIGNARD wrote:
>>> On 1/28/20 5:36 PM, Sudeep Holla wrote:
>>>> On Tue, Jan 28, 2020 at 04:37:59PM +0100, Benjamin Gaignard wrote:
>>>>> Bus firewall framework aims to provide a kernel API to set the configuration
>>>>> of the harware blocks in charge of busses access control.
>>>>>
>>>>> Framework architecture is inspirated by pinctrl framework:
>>>>> - a default configuration could be applied before bind the driver.
>>>>>      If a configuration could not be applied the driver is not bind
>>>>>      to avoid doing accesses on prohibited regions.
>>>>> - configurations could be apllied dynamically by drivers.
>>>>> - device node provides the bus firewall configurations.
>>>>>
>>>>> An example of bus firewall controller is STM32 ETZPC hardware block
>>>>> which got 3 possible configurations:
>>>>> - trust: hardware blocks are only accessible by software running on trust
>>>>>      zone (i.e op-tee firmware).
>>>>> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>>>>>      linux kernel).
>>>>> - coprocessor: hardware blocks are only accessible by the coprocessor.
>>>>> Up to 94 hardware blocks of the soc could be managed by ETZPC.
>>>>>
>>>> /me confused. Is ETZPC accessible from the non-secure kernel space to
>>>> begin with ? If so, is it allowed to configure hardware blocks as secure
>>>> or trusted ? I am failing to understand the overall design of a system
>>>> with ETZPC controller.
>>> Non-secure kernel could read the values set in ETZPC, if it doesn't match
>>> with what is required by the device node the driver won't be probed.
>>>
>> OK, but I was under the impression that it was made clear that Linux is
>> not firmware validation suite. The firmware need to ensure all the devices
>> that are not accessible in the Linux kernel are marked as disabled and
>> this needs to happen before entering the kernel. So if this is what this
>> patch series achieves, then there is no need for it. Please stop pursuing
>> this any further or provide any other reasons(if any) to have it. Until
>> you have other reasons, NACK for this series.
> 
> No it doesn't disable the nodes.
> 
> When the firmware disable a node before the kernel that means it change
> 
> the DTB and that is a problem when you want to sign it. With my proposal
> 
> the DTB remains the same.

???

:/

The DTB is used to pass the kernel command line, memory reservations, 
random seeds, and all manner of other things dynamically generated by 
firmware at boot-time. Apologies for being blunt but if "changing the 
DTB" is considered a problem then I can't help but think you're doing it 
wrong.

Robin.
