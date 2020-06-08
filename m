Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1878DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0522076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bFOVC8pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFHWeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:34:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35646 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgFHWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:34:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 058MXudN101255;
        Mon, 8 Jun 2020 17:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591655636;
        bh=lAyhCBNaGQYm278MIRt5ZmjiT68iOueitLUE79ZwYq4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bFOVC8piI+wBpQPZQz3BeOkztfr7bnQsSYLXS6poId8jIgisQm4/YZuahqGchFl81
         /WylEcBnzTMarKfJeUp/2F5+lp0Da8pS/CCiWw1XSUNVeusAxB3H/WYI5Y8hTBMI3I
         2hFUYo2xVBfmgwIBtGyZQd+xjmDjwSCMbjeYpNBQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 058MXu7d020647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 17:33:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Jun
 2020 17:33:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Jun 2020 17:33:55 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 058MXt9T110942;
        Mon, 8 Jun 2020 17:33:55 -0500
Subject: Re: [PATCH v6 0/3] rpmsg: core: Add support for name extension
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <ohad@wizery.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Xiang Xiao <xiaoxiang@xiaomi.com>
References: <20200515205642.13529-1-mathieu.poirier@linaro.org>
 <20200515210914.GA408178@builder.lan>
 <bbc97b0d-b36c-c088-a972-d1d10f7eed17@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <8e69229b-ece2-18b8-aa8c-01c105aa38bb@ti.com>
Date:   Mon, 8 Jun 2020 17:33:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bbc97b0d-b36c-c088-a972-d1d10f7eed17@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 9:49 AM, Arnaud POULIQUEN wrote:
> Hi Bjorn,
> 
> On 5/15/20 11:09 PM, Bjorn Andersson wrote:
>> On Fri 15 May 13:56 PDT 2020, Mathieu Poirier wrote:
>>
>>> This patchset adds the capability to supplement the base definition
>>> published by an rpmsg_driver with a postfix description so that it
>>> is easy to differentiate entities that use the same name service.
>>>
>>> Applies cleanly on rpmsg-next (4f05fc33bebd).
>>>
>>
>> Thanks Mathieu, this series does look good.
>>
>>
>> But before merging this, can someone show me a real example where this
>> is being/would be used? What are some real channel names and extensions?
> 
> On ST side, This is something we plan to integrate in the TTY over RPMSG support.
> The use case is the support of multi-instances. We already provided to our
> customer a TTY service supporting it but without name extension.
> Some feed-backs are: how can we know which TTY instances to use to communicate
> to the expected remote application in case of multi-instance.
> A concrete example would be one instance to control a remote processor
> application, the other instance to get the remote system logs.
> 
> Then in rpmsg TTY proposed for upstream the extension could also been used to
> differentiate the data from the control channels, as discussed with Mathieu
> during reviews: https://lkml.org/lkml/2020/4/3/964.
> Means the service is the TTY, the sub-services are the data and the control.
> 
> An other usecase i have in mind is the management of the rpmsg flow control for
> the QOS.
> This could be reused to create a core flow control manager based on the
> service extension, which could be quite smooth in term of legacy support.
> 
> Suman and Xiang(added in CC) have probably also some usecases as they
> proposed similar patches...

Yeah, this series is a result of the discussion on those prior patches, 
and maintaining compatibility for both the current in-kernel usage and 
the OpenAMP usage.

My original usecase was with an out-of-tree driver and is explained as 
part of review of those prior solution,
https://patchwork.kernel.org/comment/22850003/

I am also looking at this for future usage with the rpmsg-chrdev driver.

regards
Suman


> 
> Regards,
> Arnaud
> 
>>
>> Regards,
>> Bjorn
>>
>>> New for V6:
>>> - Added example on how to use the new API.
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>
>>> Mathieu Poirier (3):
>>>    rpmsg: core: Add wildcard match for name service
>>>    rpmsg: core: Add support to retrieve name extension
>>>    sample/rpmsg: Print out RPMSG device name extension
>>>
>>>   drivers/rpmsg/rpmsg_core.c          | 115 +++++++++++++++++++++++++++-
>>>   include/linux/rpmsg.h               |  13 ++++
>>>   samples/rpmsg/rpmsg_client_sample.c |   5 ++
>>>   3 files changed, 132 insertions(+), 1 deletion(-)
>>>
>>> -- 
>>> 2.20.1
>>>

