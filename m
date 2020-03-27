Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C99C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A620675
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Bt39e9FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0Kzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:55:46 -0400
Received: from www381.your-server.de ([78.46.137.84]:35086 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0Kzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rz/WKkoxuszzmxuFpVkEjaDif17o+9Qu8/N8bZ72T+I=; b=Bt39e9FSUl+Xx0yVsK1tsY63UK
        kDB/7WLJCzLJ2bPZWP8GpFLoAcsNbwcfocrTKAWLzLBnRY0ncTDcqlGsnlgnUGzHyM5b5W7kv2EY+
        rxrbeM63udGhTpmwy5QoTpFlCBRko9iGW+EvJ2UqeTKibj/7SkSlVEGB18FP4YJp30jM89JBxBwZN
        ZCRkWedc5fmy9COUVLBGhntOkR4zzYYtBdX4A6BXbxICeZhZpFz0LQ+YV7dKFr+Er0rHgyJs4Ob4/
        tRE1fm0aMDUiJO1zL4MtMWV+UYJaBTdo7Wp6pXK/UIPH/VcmM9VTtCfx+wU7qm7GVK9hfkC8q2WtO
        RKXllsOg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jHmeN-0006Xy-BR; Fri, 27 Mar 2020 11:55:43 +0100
Received: from [82.135.64.145] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jHmeN-0000aD-1S; Fri, 27 Mar 2020 11:55:43 +0100
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     alexandru.Ardelean@analog.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de>
 <f746cc1f-b5e2-af0a-d946-edce634c46c3@metafoo.de>
 <20200327104352.GF27849@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c2bbd132-c482-21c4-232d-2786021759cf@metafoo.de>
Date:   Fri, 27 Mar 2020 11:55:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327104352.GF27849@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25763/Thu Mar 26 14:07:34 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 11:43 AM, Michael Grzeschik wrote:
> On Fri, Mar 27, 2020 at 10:14:10AM +0100, Lars-Peter Clausen wrote:
>> On 3/27/20 9:43 AM, Michael Grzeschik wrote:
>>> dwc3_gadget_ep_disable gets called before the last request gets
>>> dequeued.
>>>
>>> In __dwc3_gadget_ep_disable all started, pending and cancelled
>>> lists for this endpoint will call dwc3_gadget_giveback in
>>> dwc3_remove_requests.
>>>
>>> After that no list containing the afterwards dequed request,
>>> therefor it is not necessary to run the dequeue routine.
>>>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> ---
>>> @Lars-Peter Clausen:
>>>
>>> This patch addresses the case that not queued requests get dequeued.
>>> The only case that this happens seems on disabling the gadget.
>>
>> I don't believe it does. Calling usb_ep_dequeue() is not limited to be
>> called after the endpoint has been disabled. It is part of the API and can
>> be called at any time. E.g. with function_fs you can abort a queued transfer
>> from userspace at any time.
> OK, can you give me an Userspace example how to simply trigger the
> issue. I tried to figure your mentioned function stack but it would
> be much easier if it could be reproduced.
>
> The patch on the other hand can stand on itself, as it then
> fixes another code path that is much more common.

Hi,

I don't have a standalone example. But the issue occurs if you submit a 
request when using function_fs through the AIO API and then call 
io_cancel() to abort it. At the same time there must be traffic on the 
USB bus so that the URB has a chance to complete.

This is a race condition between the IRQ handler running on one CPU and 
the usb_ep_dequeue() running on another CPU. As such it might take a 
while of stress testing before it is triggered. The more CPUs your 
system has the higher the chance of trigger the issue.

You can find the code which triggers the issue below.

Submission of the request:

https://github.com/analogdevicesinc/libiio/blob/master/iiod/ops.c#L139-L156

Canceling it:

https://github.com/analogdevicesinc/libiio/blob/master/iiod/ops.c#L193

