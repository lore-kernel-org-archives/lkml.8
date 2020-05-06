Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471B0C38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2642C2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bjDC6wB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgEFKWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:22:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgEFKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:22:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046ALfcT021056;
        Wed, 6 May 2020 12:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=i4Hd4EAWUocrXycHcVgsjB/bDOozgKzBj5z8AUSGs7A=;
 b=bjDC6wB0CMNU19s4A+H/Dm0QWT6yDa9j0sQyieftESVEZCxHZXwpXUtxM0mjdeG+8Q06
 5jwwLxIvi0WOZaPxIcFtU3XOVdgjGDDMSGI+vRkIiMfCnDDLULo1JCiDhi36TvYVl+Uj
 OpPtBo9l+qT45HPx6S4O00Qm/gk0SvE/W9TKm36q2K1dfmHgqIoocMF32APMwiG2S5xz
 hmRPrqGo74h5FId8VymeKnJTiwizJmmZSayQn8PEHXIORWU2/3XXpALB2TKHzv5mii/d
 oCGhp1h7y/w/6sWt5NpSLr0oONOlXHN9uZBORLyOH3nRbOHRHXqcXCLVd9uzmfq8opsy nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrjdgpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 12:22:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5834810002A;
        Wed,  6 May 2020 12:22:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46FAC2AD9E7;
        Wed,  6 May 2020 12:22:00 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 12:21:59 +0200
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <20200324205210.GE119913@minitux>
 <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com> <20200506025404.GA1302550@yoga>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <bee24b1f-c1af-c563-ebc6-ef1e9d899602@st.com>
Date:   Wed, 6 May 2020 12:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506025404.GA1302550@yoga>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_03:2020-05-05,2020-05-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/20 4:54 AM, Bjorn Andersson wrote:
> On Wed 25 Mar 09:57 PDT 2020, Arnaud POULIQUEN wrote:
> 
>> Hi Bjorn,
>>
>> On 3/24/20 9:52 PM, Bjorn Andersson wrote:
>>> On Tue 24 Mar 10:04 PDT 2020, Arnaud Pouliquen wrote:
>>> [..]
>>>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
>>>> index 020b1cd9294f..c2465e7ebc2a 100644
>>>> --- a/drivers/tty/Makefile
>>>> +++ b/drivers/tty/Makefile
>>>> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>>>>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>>>>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>>>>  obj-$(CONFIG_VCC)		+= vcc.o
>>>> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>>>>  
>>>>  obj-y += ipwireless/
>>>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>>> [..]
>>>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
>>>> +	{ .name	= TTY_CH_NAME_RAW },
>>>> +	{ .name	= TTY_CH_NAME_WITH_CTS},
>>>
>>> I still don't like the idea that the tty devices are tied to channels by
>>> fixed names.
>>
>> This point has been discussed with Xiang, he has the same kind of requirement. 
>> My proposal here is to do this in two steps. First a fixed name, then
>> in a second step we can extend the naming using the implementation proposed
>> by Mathieu Poirier:
>>
>> [1]https://lkml.org/lkml/2020/2/12/1083
>>
>> Is this patch could answer to your requirement?
>>
>> if requested i can I can integrate the Mathieu's patch in this patchset.
>>  
>>>
>>> This makes the driver unusable for communicating with any firmware out
>>> there that provides tty-like data over a channel with a different name -
>>> such as modems with channels providing an AT command interface (they are
>>> not named "rpmsg-tty-raw").
>>
>> I'm not fixed on the naming, any proposal is welcome.
>> If we use the patch [1], could be renamed 
>> "rpmsg-tty". then for AT command could be something like "rpmsg-tty-at"
>>
>> But here seems we are speaking about service over TTY and not over RPMsg.
>>
>>>
>>> I also fail to see how you would distinguish ttys when the firmware
>>> provides more than a single tty - e.g. say you have a modem-like device
>>> that provides an AT command channel and a NMEA stream.
>>
>> Today it is a limitation. In fact this limitation is the same for all RPMsg
>> devices with multi instance.
>> The patch [1] will allow to retrieve the instance by identifying
>> the service device name in /sys/class/tty/ttyRPMSG<X>/device/name
>>
>>>
>>>
>>> These are the reasons why drivers/rpmsg/rpmsg_char registers a "control
>>> device", from which you can spawn new char devices. As I've said before,
>>> I really think the same approach should be taken for ttys - perhaps by
>>> just extending the rpmsg_char to allow it to create tty devices in
>>> addition to the "packet based" char device?
>>>
>> I'm not very familiar with the rpmsg_char so please correct me if i'm wrong:
>>
>> The rpmsg_char exposes to userland an interface to manage rpmsg channels
>> (relying on a char device). This interface offers the  possibility to create
>> new channels/endpoints and send/received related messages. 
>>  
>> Thus, the application declares the RPMsg channels which is bound if they matches
>> with the remote processor channel (similar behavior than a kernel rpmsg driver).
>> There is no constrain on the service once same service is advertised by remote
>> firmware.
>>
>> In addition, a limitation of the rpmsg_char device is that it needs to be
>> associated with an existing device, as example the implementation in qcom_smd
>> driver.
>>
> 
> Correct, the rpmsg_char control device must be associated with a
> transport instance, e.g. a virtio rpmsg instance sitting on a
> remoteproc. This is necessary in order to be able to tie the dynamically
> created rpmsg_char endpoints (i.e. the thing that is similar to your tty
> devices) to a particular transport/remoteproc..
> 
> The reason why qcom_smd needs to be involved is because of the problem
> that I want the control device to appear without depending on particular
> channels being exposed by the firmware.
> 
>> If i try to figure out how to implement TTY using the rpmsg_char:
>> I should create a rpmsg_char dev in the rpmsg tty driver. Then application
>> will create channels related to its service. But in this case
>> how to ensure that channels created are related to the TTY service?  
>>
> 
> My proposal/wish is that 1) rpmsg_char is implemented for virtio/rpmsg,
> so that the control device is registered as virtio rpmsg is initiated
> and 2) that rpmsg_char is extended to allow creating tty devices in
> addition to the existing interface (if the existing read/write interface
> isn't enough).

So your proposal is to manage the tty devices throught the rpmsg_char. 

Look to me that we have two use cases here:
1) offer a standard tty device to allows application to communicate with
the remote firmware:
 - allow to use "standard application such as terminal tools,
 - keep application compatibility to communicate with an external processor
 through a serial link or with an co processor through rpmsg.
 - take benefice of the line discipline management uses by applications.
=> need an "auto" probe of the tty device

2) Expose the channels to the userland without devices. This would
be the role of the rpmsg_char probed by the virtio rpmsg.
=> application manages the channels using the char device.
=> only the application has the notion of the service associated to the channel.

Look to me that correlate both would be not flexible. 
I would keep rpmsg_char device channel service agnostic, and let application
manage the service.
In this case it would a design choice to support the service trough the TTY
interface or the rpmsg char device interface.

> 
>>
>> I would also expect to manage RPMsg TTY such as a generic TTY: without
>> extra interface and auto mounted as an USB TTY. this means that the
>> /dev/ttyRMPSGx are created automatically at remote firmware startup
>> (without any application action). For instance a generic application 
>> (e.g. minicom) could control an internal remote processor such as
>> an external processor through a TTY link. 
>>
> 
> And that's not possible using the two-stage approach rpmsg_char takes,
> instead I use udev rules to invoke the ioctl on the control device.
> 
> The benefit is that the design of the firmware is not tied to the design
> of the Linux system.
 
Agree, the rpmsg char device is very interesting for this. Today the alternative
is to implement RPMsg in userland using the OpenAMP library.

> 
>> Then we have also similar RPMsg driver for I2C and SPI virtual link. So extend
>> the rpmsg_char to support TTY seems not a good solution for long terms. 
>>
> 
> What do you mean with this? Are you saying that running tty over rpmsg
> over SPI is a bad idea?

No my point here is that we have also on shelves an rpmsg_i2c and an rpmsg_spi
drivers to manage in the same way a virtual i2c[1] and a virtual SPI with
the possibility to have Linux client drivers and/or userland interface.

So extend rpmsg_char to create a tty device in addition could be the first
step of the support of a lot of in-kernel and/or userland interfaces.

[1] https://github.com/arnopo?tab=projects

> 
>> For these reasons i would prefer to have a specific driver. And found a solution
>> to allow user to differentiate the TTY instances.
>>
>> Anyway I am very interesting in having more details of an implementation relying
>> on rpmsg_char if you still thinking that is the good approach here.
>>
> 
> I do think it's a good idea to decouple the system design on the Linux
> side from the naming of channels provided by the firmware.

IMO both have to be considered in parallel and should not be correlated as far as
possible. Extend the char device to decouple the system from the naming this seems to me a
good solution but another topic.

That said, I may not fully understand your approach. Please don't hesitate to correct me.

In any case, I cannot/will not go ahead with this implementation without your agreement.
So, please, could you tell me if an rpmsg_tty is acceptable from your point of view or if
you consider that it is mandatory to implement the tty device in rpmsg_char.

Thanks,
Arnaud

 
> 
> Regards,
> Bjorn
> 
>> Thanks for your comments, 
>> Arnaud
>>
>>> Regards,
>>> Bjorn
>>>
