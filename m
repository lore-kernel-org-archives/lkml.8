Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337D9207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fdVcLj1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgETOtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:49:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbgETOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:49:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KEgDW0028385;
        Wed, 20 May 2020 16:49:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=mF9hCf7Xk61Z6neQPdNS3sUzpshBFvjsTt55Bt0GOQQ=;
 b=fdVcLj1oCPsKC4aG1U8RGJ2JWpTune9Ufd4VVsdOLuWtcqjiXMMKS0fKZIzKYiq/CriI
 aLf5UuEaoaw83BUhGH7z2p1D+TpgAJdKnxPHAEhw0vaoxiiRHdfY9FwniGxx1Pev7Rck
 0x+N1FZ3ztGI8ykbZLAGBH14VpBYdTGSG9mkIwvbK2Xo5UZxnuSJorfFmWy75I9V/pD8
 A3mvvUz0FDb73Qw8quPShJyOKC0ZRgXAsQehsjTIhIr99bVibEWzoKKzgYFJ/6BtB2mI
 AP/FAvy4LcgByRwBBsDOlgg8++LPqXnkzlq/+cQ7T0bBo+C8CikGr4OzB56ZjQz1HkUF zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31272h8phx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 16:49:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E289110002A;
        Wed, 20 May 2020 16:49:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D38652B7FD4;
        Wed, 20 May 2020 16:49:32 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 16:49:32 +0200
Subject: Re: [PATCH v6 0/3] rpmsg: core: Add support for name extension
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <ohad@wizery.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xiang Xiao <xiaoxiang@xiaomi.com>
References: <20200515205642.13529-1-mathieu.poirier@linaro.org>
 <20200515210914.GA408178@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <bbc97b0d-b36c-c088-a972-d1d10f7eed17@st.com>
Date:   Wed, 20 May 2020 16:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515210914.GA408178@builder.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_10:2020-05-20,2020-05-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/15/20 11:09 PM, Bjorn Andersson wrote:
> On Fri 15 May 13:56 PDT 2020, Mathieu Poirier wrote:
> 
>> This patchset adds the capability to supplement the base definition
>> published by an rpmsg_driver with a postfix description so that it
>> is easy to differentiate entities that use the same name service.
>>
>> Applies cleanly on rpmsg-next (4f05fc33bebd).
>>
> 
> Thanks Mathieu, this series does look good.
> 
> 
> But before merging this, can someone show me a real example where this
> is being/would be used? What are some real channel names and extensions?

On ST side, This is something we plan to integrate in the TTY over RPMSG support.
The use case is the support of multi-instances. We already provided to our
customer a TTY service supporting it but without name extension. 
Some feed-backs are: how can we know which TTY instances to use to communicate
to the expected remote application in case of multi-instance.
A concrete example would be one instance to control a remote processor
application, the other instance to get the remote system logs.

Then in rpmsg TTY proposed for upstream the extension could also been used to
differentiate the data from the control channels, as discussed with Mathieu
during reviews: https://lkml.org/lkml/2020/4/3/964. 
Means the service is the TTY, the sub-services are the data and the control.

An other usecase i have in mind is the management of the rpmsg flow control for
the QOS.
This could be reused to create a core flow control manager based on the
service extension, which could be quite smooth in term of legacy support.

Suman and Xiang(added in CC) have probably also some usecases as they 
proposed similar patches...

Regards,
Arnaud

> 
> Regards,
> Bjorn
> 
>> New for V6:
>> - Added example on how to use the new API.
>>
>> Thanks,
>> Mathieu
>>
>>
>> Mathieu Poirier (3):
>>   rpmsg: core: Add wildcard match for name service
>>   rpmsg: core: Add support to retrieve name extension
>>   sample/rpmsg: Print out RPMSG device name extension
>>
>>  drivers/rpmsg/rpmsg_core.c          | 115 +++++++++++++++++++++++++++-
>>  include/linux/rpmsg.h               |  13 ++++
>>  samples/rpmsg/rpmsg_client_sample.c |   5 ++
>>  3 files changed, 132 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.20.1
>>
