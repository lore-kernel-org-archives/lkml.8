Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D1C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1F20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ieZFcEs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCYLhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:37:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16628 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbgCYLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:37:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PBWwFf022906;
        Wed, 25 Mar 2020 12:36:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=RjGEbFFJr8rNl19hjksDzi2Iu6GfxyBcu1ZvANyO+rI=;
 b=ieZFcEs2iS3Zh1G4DU6jFqefwRi5v31BvNxybHTgOH2i5mp+FhOu1DX24Mat4rwZmLSQ
 jGTT+wGAJisDVzfOy8TIjhiRX1K74Q2n4gmEvmLdE2ILODJy2cyPnXu/dZa3wdyEmC8t
 Bxzu5Elg23QiJMQv9JuM0ex29wgl32BtF+bcjrcgL2A1QD6cGR5jVYcABEEcMyb/tiqJ
 nQE6tqL1j/T++s97x6yJCoilG5qxT2zs+9X0odO28pXtVeVNOu2A+BX516c9ZXOe3qvj
 iJMvoFu/WWW4ggSVGNL4pEjBVJKyCB3oCZtUurBbnrT2tTaaDjewVksDGyJH9rD3EWX4 Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw9k05cb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 12:36:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81B01100039;
        Wed, 25 Mar 2020 12:36:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 71D202A787D;
        Wed, 25 Mar 2020 12:36:49 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 12:36:40 +0100
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Joe Perches <joe@perches.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <1dff1b277e5d2c95ce100a2daff4967f98d074ba.camel@perches.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <66fe1087-1a6d-1a96-a043-8013bfb6f2c1@st.com>
Date:   Wed, 25 Mar 2020 12:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1dff1b277e5d2c95ce100a2daff4967f98d074ba.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_05:2020-03-24,2020-03-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 6:23 PM, Joe Perches wrote:
> On Tue, 2020-03-24 at 18:04 +0100, Arnaud Pouliquen wrote:
>> This driver exposes a standard TTY interface on top of the rpmsg
>> framework through a rpmsg service.
>>
>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>> per rpmsg endpoint.
> 
> trivial notes:
> 
>> diff --git a/Documentation/serial/tty_rpmsg.rst b/Documentation/serial/tty_rpmsg.rst
> []
>> +The rpmsg tty driver implements serial communication on the RPMsg bus to makes possible for user-space programs to send and receive rpmsg messages as a standard tty protocol.
> 
> Very long text lines missing newlines?
> 
> []
>> +To be compliant with this driver, the remote firmware must create its data end point associated with the "rpmsg-tty-raw" service.
> []
>> +To be compatible with this driver, the remote firmware must create or use its end point associated with "rpmsg-tty-ctrl" service, plus a second endpoint for the data flow.
>> +On Linux rpmsg_tty probes, the data endpoint address and the CTS (set to disable)
> 
> []
> 
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> []
>> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
>> +				  u32);
> 
> unused typedef?

yes i will clean it.

> 
> []
> 
>> +static int __init rpmsg_tty_init(void)
>> +{
> []
>> +	err = tty_register_driver(rpmsg_tty_driver);
>> +	if (err < 0) {
>> +		pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
>> +		goto error_put;
>> +	}
> 
> Might use vsprintf extension %pe
> 
> 		pr_err("Couldn't install rpmsg tty driver: %pe\n", ERR_PTR(err));

Seems not possible here as err is an integer value and not a pointer cast to an integer,
or I missed something?


Thanks for the review,
Arnaud
> 
>> +	err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
>> +	if (err < 0) {
>> +		pr_err("Couldn't register rpmsg tty driver: err %d\n", err);
> 
> etc.
> 
> 
