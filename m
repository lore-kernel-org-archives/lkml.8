Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17320C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D358520772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zbqieNq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCYQ6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:58:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgCYQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:58:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PGquT7027578;
        Wed, 25 Mar 2020 17:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=765SUSoYfp3NkYF15kCDHOpVCNo5Ahc9UvpYL/PCA/M=;
 b=zbqieNq2sJ+MTi1bySzVUNs74mUZsYfbjmdlLQiSYqxZV+MhSPgzhG1o3mYW2HgbC7HQ
 +epC4/SMzj9/qm+moIedwP6F3+I+PpQZplQ3QqED2Pj9V46qCJZd7GyHT6ZDkZ7pscP6
 Nea5jRdfpG9yq/x8g3HeEZjKPebeQ5okDQqQ+lmBk+D4M+6DyFDPLGWAyERiToCWu445
 SPsu+ohZqI7ATzaBKgOv6A0OkumloeCC51JF1EuybFteSvfwWpAtn0CZYNdEl6TWL92z
 t5Rh9Vz2DzYXd0FVx9aSs1g7RRWlgEqPbePIGmlwwGGOwPBQ811TS+M7Jf6XzycToS1y ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw9k06txh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 17:57:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 120B910002A;
        Wed, 25 Mar 2020 17:57:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F40222BEC4A;
        Wed, 25 Mar 2020 17:57:44 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 17:57:36 +0100
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
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <4f5e6dd0-5deb-8036-0a94-eb7055744f35@st.com>
Date:   Wed, 25 Mar 2020 17:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324205210.GE119913@minitux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_09:2020-03-24,2020-03-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/24/20 9:52 PM, Bjorn Andersson wrote:
> On Tue 24 Mar 10:04 PDT 2020, Arnaud Pouliquen wrote:
> [..]
>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
>> index 020b1cd9294f..c2465e7ebc2a 100644
>> --- a/drivers/tty/Makefile
>> +++ b/drivers/tty/Makefile
>> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>>  obj-$(CONFIG_VCC)		+= vcc.o
>> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>>  
>>  obj-y += ipwireless/
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> [..]
>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
>> +	{ .name	= TTY_CH_NAME_RAW },
>> +	{ .name	= TTY_CH_NAME_WITH_CTS},
> 
> I still don't like the idea that the tty devices are tied to channels by
> fixed names.

This point has been discussed with Xiang, he has the same kind of requirement. 
My proposal here is to do this in two steps. First a fixed name, then
in a second step we can extend the naming using the implementation proposed
by Mathieu Poirier:

[1]https://lkml.org/lkml/2020/2/12/1083

Is this patch could answer to your requirement?

if requested i can I can integrate the Mathieu's patch in this patchset.
 
> 
> This makes the driver unusable for communicating with any firmware out
> there that provides tty-like data over a channel with a different name -
> such as modems with channels providing an AT command interface (they are
> not named "rpmsg-tty-raw").

I'm not fixed on the naming, any proposal is welcome.
If we use the patch [1], could be renamed 
"rpmsg-tty". then for AT command could be something like "rpmsg-tty-at"

But here seems we are speaking about service over TTY and not over RPMsg.

> 
> I also fail to see how you would distinguish ttys when the firmware
> provides more than a single tty - e.g. say you have a modem-like device
> that provides an AT command channel and a NMEA stream.

Today it is a limitation. In fact this limitation is the same for all RPMsg
devices with multi instance.
The patch [1] will allow to retrieve the instance by identifying
the service device name in /sys/class/tty/ttyRPMSG<X>/device/name

> 
> 
> These are the reasons why drivers/rpmsg/rpmsg_char registers a "control
> device", from which you can spawn new char devices. As I've said before,
> I really think the same approach should be taken for ttys - perhaps by
> just extending the rpmsg_char to allow it to create tty devices in
> addition to the "packet based" char device?
> 
I'm not very familiar with the rpmsg_char so please correct me if i'm wrong:

The rpmsg_char exposes to userland an interface to manage rpmsg channels
(relying on a char device). This interface offers the  possibility to create
new channels/endpoints and send/received related messages. 
 
Thus, the application declares the RPMsg channels which is bound if they matches
with the remote processor channel (similar behavior than a kernel rpmsg driver).
There is no constrain on the service once same service is advertised by remote
firmware.

In addition, a limitation of the rpmsg_char device is that it needs to be
associated with an existing device, as example the implementation in qcom_smd
driver.

If i try to figure out how to implement TTY using the rpmsg_char:
I should create a rpmsg_char dev in the rpmsg tty driver. Then application
will create channels related to its service. But in this case
how to ensure that channels created are related to the TTY service?  


I would also expect to manage RPMsg TTY such as a generic TTY: without
extra interface and auto mounted as an USB TTY. this means that the
/dev/ttyRMPSGx are created automatically at remote firmware startup
(without any application action). For instance a generic application 
(e.g. minicom) could control an internal remote processor such as
an external processor through a TTY link. 

Then we have also similar RPMsg driver for I2C and SPI virtual link. So extend
the rpmsg_char to support TTY seems not a good solution for long terms. 

For these reasons i would prefer to have a specific driver. And found a solution
to allow user to differentiate the TTY instances.

Anyway I am very interesting in having more details of an implementation relying
on rpmsg_char if you still thinking that is the good approach here.

Thanks for your comments, 
Arnaud

> Regards,
> Bjorn
> 
