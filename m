Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E434C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7112D206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgAaSZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:25:14 -0500
Received: from foss.arm.com ([217.140.110.172]:38206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAaSZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:25:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E97FEC;
        Fri, 31 Jan 2020 10:25:12 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB963F68E;
        Fri, 31 Jan 2020 10:25:10 -0800 (PST)
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
 <6a6ba7ff-7ed9-e573-63ca-66fca609075b@arm.com>
 <c4d5c46a-7f90-ff2b-9496-26102114c5e6@st.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3624ec3e-b06a-907d-ebfa-8516b14cb306@arm.com>
Date:   Fri, 31 Jan 2020 18:25:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4d5c46a-7f90-ff2b-9496-26102114c5e6@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2020 1:40 pm, Benjamin GAIGNARD wrote:
> 
> On 1/28/20 11:06 PM, Robin Murphy wrote:
>> On 2020-01-28 8:06 pm, Benjamin GAIGNARD wrote:
>>>
>>> On 1/28/20 6:17 PM, Sudeep Holla wrote:
>>>> On Tue, Jan 28, 2020 at 04:46:41PM +0000, Benjamin GAIGNARD wrote:
>>>>> On 1/28/20 5:36 PM, Sudeep Holla wrote:
>>>>>> On Tue, Jan 28, 2020 at 04:37:59PM +0100, Benjamin Gaignard wrote:
>>>>>>> Bus firewall framework aims to provide a kernel API to set the
>>>>>>> configuration
>>>>>>> of the harware blocks in charge of busses access control.
>>>>>>>
>>>>>>> Framework architecture is inspirated by pinctrl framework:
>>>>>>> - a default configuration could be applied before bind the driver.
>>>>>>>       If a configuration could not be applied the driver is not bind
>>>>>>>       to avoid doing accesses on prohibited regions.
>>>>>>> - configurations could be apllied dynamically by drivers.
>>>>>>> - device node provides the bus firewall configurations.
>>>>>>>
>>>>>>> An example of bus firewall controller is STM32 ETZPC hardware block
>>>>>>> which got 3 possible configurations:
>>>>>>> - trust: hardware blocks are only accessible by software running
>>>>>>> on trust
>>>>>>>       zone (i.e op-tee firmware).
>>>>>>> - non-secure: hardware blocks are accessible by non-secure
>>>>>>> software (i.e.
>>>>>>>       linux kernel).
>>>>>>> - coprocessor: hardware blocks are only accessible by the
>>>>>>> coprocessor.
>>>>>>> Up to 94 hardware blocks of the soc could be managed by ETZPC.
>>>>>>>
>>>>>> /me confused. Is ETZPC accessible from the non-secure kernel space to
>>>>>> begin with ? If so, is it allowed to configure hardware blocks as
>>>>>> secure
>>>>>> or trusted ? I am failing to understand the overall design of a
>>>>>> system
>>>>>> with ETZPC controller.
>>>>> Non-secure kernel could read the values set in ETZPC, if it doesn't
>>>>> match
>>>>> with what is required by the device node the driver won't be probed.
>>>>>
>>>> OK, but I was under the impression that it was made clear that Linux is
>>>> not firmware validation suite. The firmware need to ensure all the
>>>> devices
>>>> that are not accessible in the Linux kernel are marked as disabled and
>>>> this needs to happen before entering the kernel. So if this is what
>>>> this
>>>> patch series achieves, then there is no need for it. Please stop
>>>> pursuing
>>>> this any further or provide any other reasons(if any) to have it. Until
>>>> you have other reasons, NACK for this series.
>>>
>>> No it doesn't disable the nodes.
>>>
>>> When the firmware disable a node before the kernel that means it change
>>>
>>> the DTB and that is a problem when you want to sign it. With my proposal
>>>
>>> the DTB remains the same.
>>
>> ???
>>
>> :/
>>
>> The DTB is used to pass the kernel command line, memory reservations,
>> random seeds, and all manner of other things dynamically generated by
>> firmware at boot-time. Apologies for being blunt but if "changing the
>> DTB" is considered a problem then I can't help but think you're doing
>> it wrong.
> 
> Yes but I would like to limit the number of cases where a firmware has
> to change the DTB.

Sure, but unless you can limit that number to strictly zero, then 
presumably the firmware must have the general capability to verify, 
modify, and re-sign a DTB. At that point having it also tweak the status 
of nodes that it wants for itself doesn't seem like a particularly big ask.

> With this proposal nodes remain the same and embedded the firewall
> configuration(s).
> 
> Until now firewall configuration is "static", the firmware disable (or
> remove) the nodes not accessible from Linux.
> 
> If Linux can rely on node's firewall information it could allow switch
> dynamically an hardware block from Linux to a coprocessor.
> 
> For example Linux could manage the display pipe configuration and when
> going to suspend handover the display hardware block to a coprocessor in
> charge a refreshing only some pixels.

And like I'm sure I said before, the interface between Linux and the 
Secure environment to ultimately achieve that will almost certainly make 
inspecting a passive status bit in a register redundant anyway.

In the interest of being productive, though, there is another way of 
looking at this. If we drop the pretence that it's in any way generic or 
ever going to be relevant beyond certain configurations of certain 
STMicro SoCs, then in plain terms it's just some block of MMIO registers 
that have *something* to do with various other devices. At that point, 
the answer is just to treat it as a syscon and make the relevant drivers 
for those SoCs aware of it. I'm most familiar with the "General Register 
File" on Rockchip SoCs as a prime example of "bunch of registers that 
relate to the integration of various IP blocks", which manages to be 
supported just fine without invasive hooks in the driver core.

Robin.
