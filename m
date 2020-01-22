Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB373C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF3D2467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c0znPXb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAVQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgAVQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b27aDBY4y/7/Q6nm414arkj4keuFN7/ZdwTBl4SydLg=; b=c0znPXb8/MVKdiAmIXi2H2dtb
        VhINTEL9zM48Q+iEMmYPfSxCWAQWJhY1kfdLnAVX+t3i+gY09dDNwr/AF5HAQfGibXUcqZ7T01Ovg
        t/l2baN3AGIkuL4r/CtHKyTFnU7s16ASxTXK3Zob3nacfBhJhcP9Adk3/6orhtxk7Y4Wo39xt4RMx
        br5/iJJ+TR9MPWYsbis1lnE378k6hac7wi096v1molBwvcva2ztUUAUk8r4UdebYkr8L8VH7HD/xC
        Tx4ew3ySHhsbmQWo7GEVdIKiTP8N615mfPqU9y+jxOE41GNmfDQWmoZFLqnWVPCZaYX9LT23YPW79
        4/soRaf9g==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuIYX-0007T4-6F; Wed, 22 Jan 2020 16:08:37 +0000
Subject: Re: [PATCH v1 06/11] Documentation: pstore/blk: blkoops: create
 document for pstore_blk
To:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1579482233-2672-7-git-send-email-liaoweixiong@allwinnertech.com>
 <b9cd734b-8bb1-5e26-a7ed-fbc79ab2d958@infradead.org>
 <c87bdf3a-f129-a2a7-40b2-2220f79b505a@allwinnertech.com>
 <40d7f57a-119e-e51f-99a5-63e85ab5ab91@infradead.org>
 <3337f687-a668-c058-178b-a1438641c519@allwinnertech.com>
 <597e2b49-667a-490e-91b6-641ca25401d8@infradead.org>
 <6d94b9d5-abef-db5e-1c80-00ea8c1b0003@allwinnertech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <325251e8-79e6-ed07-f5e0-b8c149757766@infradead.org>
Date:   Wed, 22 Jan 2020 08:08:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6d94b9d5-abef-db5e-1c80-00ea8c1b0003@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 7:01 AM, liaoweixiong wrote:
> On 2020/1/21 下午11:34, Randy Dunlap wrote:
>> On 1/21/20 12:19 AM, liaoweixiong wrote:
>>> hi Randy Dunlap,
>>>
>>> On 2020/1/21 2:36 PM, Randy Dunlap wrote:
>>>> On 1/20/20 9:23 PM, liaoweixiong wrote:
>>>>> hi Randy Dunlap,
>>>>>
>>>>> On 2020/1/21 PM12:13, Randy Dunlap wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I have some documentation comments for you:
>>>>>>
>>>>>>
>>>>>> On 1/19/20 5:03 PM, WeiXiong Liao wrote:
>>>>>>> The document, at Documentation/admin-guide/pstore-block.rst, tells us
>>>>>>> how to use pstore/blk and blkoops.
>>>>>>>
>>>>>>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>>>>>>> ---
>>>>>>>    Documentation/admin-guide/pstore-block.rst | 278 +++++++++++++++++++++++++++++
>>>>>>>    MAINTAINERS                                |   1 +
>>>>>>>    fs/pstore/Kconfig                          |   2 +
>>>>>>>    3 files changed, 281 insertions(+)
>>>>>>>    create mode 100644 Documentation/admin-guide/pstore-block.rst
>>>>>>>
>>>>>>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..58418d429c55
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/admin-guide/pstore-block.rst

>>>>>>> +Compression and header
>>>>>>> +----------------------
>>>>>>> +
>>>>>>> +Block device is large enough for uncompressed dmesg data. Actually we do not
>>>>>>> +recommend data compression because pstore/blk will insert some information into
>>>>>>> +the first line of dmesg data. For example::
>>>>>>> +
>>>>>>> +        Panic: Total 16 times
>>>>>>> +
>>>>>>> +It means that it's the 16th times panic log since the first booting. Sometimes
>>>>>>
>>>>>>                                  time of a panic log since ...
>>>>>>
>>>>>
>>>>> Should it be like this?
>>>>> It means the time of a panic log since the first booting.
>>>>
>>>> That sounds like clock time, not the number of instances or occurrences.
>>>>
>>>
>>> It is an oops/panic counter too. How about this?
>>>
>>> It means that it's OOPS/PANIC for the 16th time since the first booting.
>>
>>                                                    since the last booting {or boot}.
>>
> 
> Not the last booting but the first booting. This is the number of
> triggers since the first time the system was installed.

OK, so it's a persistent counter.
Thanks for the clarification.

-- 
~Randy

