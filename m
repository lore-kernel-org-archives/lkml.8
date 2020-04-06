Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D3C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A667C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QttZ/kCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgDFOTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:19:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6906 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728566AbgDFOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:19:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036E46gw019312;
        Mon, 6 Apr 2020 16:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=MDWrPWm65LgQvAsdXgU1HJgPbeJd38r+v9dG901gsDI=;
 b=QttZ/kCDnJiSM+aueKiZpnGgUtpdJCJ1Fxktvc5ugQWnSg5UAknfcTXlGsLFB0MIjXtb
 fWCEf6BnzAyJdD9GNtfEOkq5Q036AMS/6AQxljl/nKoUAs72k1VEYBMyhcaCREpWTa1Y
 nFUmfcAJPPDExsevSHrJTNACHy7HRm3IJYTc5AXH9jrovHX4KAnEkWjhQWGtZfjxonow
 iN6hr/dMiYUSMkwFXlQqbx9D2pRskjswwLBfs+KKjB2wbHb+qF/z6raO6feD8G8IPX+F
 s21mFizapfSZ0EPJIUKJLLG8+KhEiTzMmfjCHaskyl557PHkvV78/wyznkaBOvBR6xXF 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 306fc9th31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 16:19:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E290100034;
        Mon,  6 Apr 2020 16:19:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3958F220A2E;
        Mon,  6 Apr 2020 16:19:00 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 16:18:59 +0200
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
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
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <20200324205210.GE119913@minitux>
 <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com>
Message-ID: <c0eed724-78b7-f8b6-cab4-de06e426d7d1@st.com>
Date:   Mon, 6 Apr 2020 16:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/25/20 5:57 PM, Arnaud POULIQUEN wrote:
> Hi Bjorn,
> 
> On 3/24/20 9:52 PM, Bjorn Andersson wrote:
>> On Tue 24 Mar 10:04 PDT 2020, Arnaud Pouliquen wrote:
>> [..]
>>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
>>> index 020b1cd9294f..c2465e7ebc2a 100644
>>> --- a/drivers/tty/Makefile
>>> +++ b/drivers/tty/Makefile
>>> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>>>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>>>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>>>  obj-$(CONFIG_VCC)		+= vcc.o
>>> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>>>  
>>>  obj-y += ipwireless/
>>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
>> [..]
>>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
>>> +	{ .name	= TTY_CH_NAME_RAW },
>>> +	{ .name	= TTY_CH_NAME_WITH_CTS},
>>
>> I still don't like the idea that the tty devices are tied to channels by
>> fixed names.
> 
> This point has been discussed with Xiang, he has the same kind of requirement. 
> My proposal here is to do this in two steps. First a fixed name, then
> in a second step we can extend the naming using the implementation proposed
> by Mathieu Poirier:
> 
> [1]https://lkml.org/lkml/2020/2/12/1083
> 
> Is this patch could answer to your requirement?
> 
> if requested i can I can integrate the Mathieu's patch in this patchset.
>  
>>
>> This makes the driver unusable for communicating with any firmware out
>> there that provides tty-like data over a channel with a different name -
>> such as modems with channels providing an AT command interface (they are
>> not named "rpmsg-tty-raw").
> 
> I'm not fixed on the naming, any proposal is welcome.
> If we use the patch [1], could be renamed 
> "rpmsg-tty". then for AT command could be something like "rpmsg-tty-at"
> 
> But here seems we are speaking about service over TTY and not over RPMsg.
> 
>>
>> I also fail to see how you would distinguish ttys when the firmware
>> provides more than a single tty - e.g. say you have a modem-like device
>> that provides an AT command channel and a NMEA stream.
> 
> Today it is a limitation. In fact this limitation is the same for all RPMsg
> devices with multi instance.
> The patch [1] will allow to retrieve the instance by identifying
> the service device name in /sys/class/tty/ttyRPMSG<X>/device/name
> 
>>
>>
>> These are the reasons why drivers/rpmsg/rpmsg_char registers a "control
>> device", from which you can spawn new char devices. As I've said before,
>> I really think the same approach should be taken for ttys - perhaps by
>> just extending the rpmsg_char to allow it to create tty devices in
>> addition to the "packet based" char device?
>>
> I'm not very familiar with the rpmsg_char so please correct me if i'm wrong:
> 
> The rpmsg_char exposes to userland an interface to manage rpmsg channels
> (relying on a char device). This interface offers the  possibility to create
> new channels/endpoints and send/received related messages. 
>  
> Thus, the application declares the RPMsg channels which is bound if they matches
> with the remote processor channel (similar behavior than a kernel rpmsg driver).
> There is no constrain on the service once same service is advertised by remote
> firmware.
> 
> In addition, a limitation of the rpmsg_char device is that it needs to be
> associated with an existing device, as example the implementation in qcom_smd
> driver.
> 
> If i try to figure out how to implement TTY using the rpmsg_char:
> I should create a rpmsg_char dev in the rpmsg tty driver. Then application
> will create channels related to its service. But in this case
> how to ensure that channels created are related to the TTY service?  
> 
> 
> I would also expect to manage RPMsg TTY such as a generic TTY: without
> extra interface and auto mounted as an USB TTY. this means that the
> /dev/ttyRMPSGx are created automatically at remote firmware startup
> (without any application action). For instance a generic application 
> (e.g. minicom) could control an internal remote processor such as
> an external processor through a TTY link. 
> 
> Then we have also similar RPMsg driver for I2C and SPI virtual link. So extend
> the rpmsg_char to support TTY seems not a good solution for long terms. 
> 
> For these reasons i would prefer to have a specific driver. And found a solution
> to allow user to differentiate the TTY instances.
> 
> Anyway I am very interesting in having more details of an implementation relying
> on rpmsg_char if you still thinking that is the good approach here.

Do you think you would find time to move forward with this discussion?
I would like to prepare a v8 to fix issue reported on v7, but as your comments
challenges the driver itself, i would prefer that we first find solutions
that address your concerns.

Thanks,
Arnaud

> 
> Thanks for your comments, 
> Arnaud
> 
>> Regards,
>> Bjorn
>>
