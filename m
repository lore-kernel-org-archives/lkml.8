Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BD120722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pllXLQyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCYLhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:37:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36553 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgCYLhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:37:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PBWt6f022868;
        Wed, 25 Mar 2020 12:34:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=qpNPvlICRkVgPeWTYBoktJJBxSND73AKILPbt6Wwf40=;
 b=pllXLQyQaFrqToI8T2B85Y0iDdFUf2n9Zc0CTIdrftXDTHeVKZZZxLwFjMjzPvRzZV1V
 QBEmo4KadlhsvMlxxcRKcnTkUIClIND7ZxZ+B/dfMvMiVEL9OyltdyQ37NwttDI0rX1R
 xz7KttJ9ORnZ+jnwYV8jDCm8aB7T5VNKfJqt8EFBZpiXdbDMSvTDTjknpI0cW4CdpGaY
 hWbbwGSnw/3B2sr1ZjP7wyFiYR5KQSekvSv3pz0VnSjbLa6LkroVeqOEhpxavF5R090J
 I8zw6fmTJWmZSio3HmVSxx/MRrQQnScQlMCc4l86XaXg88ENT7X+fmKf4Ksp94RbHuZZ qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw9k05c1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 12:34:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACE16100038;
        Wed, 25 Mar 2020 12:34:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FFDA2A787C;
        Wed, 25 Mar 2020 12:34:45 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.49) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 12:34:37 +0100
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <20200324171806.GB2522961@kroah.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <426f24cb-025b-f497-e9dc-9823181c4056@st.com>
Date:   Wed, 25 Mar 2020 12:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324171806.GB2522961@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_05:2020-03-24,2020-03-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 6:18 PM, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2020 at 06:04:07PM +0100, Arnaud Pouliquen wrote:
>> This driver exposes a standard TTY interface on top of the rpmsg
>> framework through a rpmsg service.
>>
>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>> per rpmsg endpoint.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  Documentation/serial/tty_rpmsg.rst |  45 ++++
>>  drivers/tty/Kconfig                |   9 +
>>  drivers/tty/Makefile               |   1 +
>>  drivers/tty/rpmsg_tty.c            | 417 +++++++++++++++++++++++++++++
>>  4 files changed, 472 insertions(+)
>>  create mode 100644 Documentation/serial/tty_rpmsg.rst
>>  create mode 100644 drivers/tty/rpmsg_tty.c
>>
>> diff --git a/Documentation/serial/tty_rpmsg.rst b/Documentation/serial/tty_rpmsg.rst
>> new file mode 100644
>> index 000000000000..fc1d3fba73c5
>> --- /dev/null
>> +++ b/Documentation/serial/tty_rpmsg.rst
>> @@ -0,0 +1,45 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============
>> +The rpmsg TTY
>> +=============
>> +
>> +The rpmsg tty driver implements serial communication on the RPMsg bus to makes possible for user-space programs to send and receive rpmsg messages as a standard tty protocol.
> 
> Can you wrap your lines properly for this file?

My apologize for this, I've been relying a little too much on the checkpatch tool here.

Thanks for the review,
Arnaud

> 
> thanks,
> 
> greg k-h
> 
