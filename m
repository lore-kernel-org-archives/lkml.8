Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6F6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD902071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs3AMM6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIAHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgIAHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598944808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYs5D15nDt7sh4xdYXRddb406m8WZQTGSZSNtOR5yPo=;
        b=Zs3AMM6qLfPmS9O8JWsa2CGAH3t/I99N47YuJC2Vc83LCnXsHbMEbnb5fYrHkXsIVKx6RM
        2nykPidbtiLP94ZIqye12c3s54LUq82LFu78Ie/yuVHszaRttuKbFF59aMSzproQYIlDXX
        8Ce0R4dD79CTLfTBpoabeIeBrYAWIeM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-WK4wJfeOOKuh9Ou0LRdU3Q-1; Tue, 01 Sep 2020 03:20:04 -0400
X-MC-Unique: WK4wJfeOOKuh9Ou0LRdU3Q-1
Received: by mail-ed1-f69.google.com with SMTP id c25so155382edx.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYs5D15nDt7sh4xdYXRddb406m8WZQTGSZSNtOR5yPo=;
        b=ABTSUywWzhpMcNZ1/uC6M4x4KCz+guMx5nexZceUo6PQqHlqZ8LxzFZQomPI5+NjHb
         KSQ1IOGHSDlLjhwr9NJrJrd3hWtJcu0WKV90juG6uup1yyR3CjU8G3tuakouGACxAk59
         FmDMGVLzDGhy7lzR78jP1/yAOMzFbhSO3FKALLkBYpO1fTTsnyUS0tfyWHHMJ6jKDCw9
         2IY207ygbPG7Dyc97u1ZaUwJbUAoJCetgIEuBkPi/dULI/42O+cCeqJHS5WNiHLrt6dU
         4xmIAccr1d5DoUbct18mZbg27222/sQwNNzysM9qrxVdlFAstDWO8APvrsGhvNDQDySk
         IGvw==
X-Gm-Message-State: AOAM530dpBLthfB9Z0RkNcN2HKybByiDNA/dyhf3gVz0i+rBKqk3HBrf
        Xx/8y8wCIebR+q2ZtS+t2wurtPU4i9cw68jriD+0CqBaO3Q96EJ1AJuFrahLY6sPFTxG/jTb8N5
        lYzysqdezbAFzNkIEOnKDIp6M
X-Received: by 2002:a17:906:4e4a:: with SMTP id g10mr291521ejw.274.1598944803550;
        Tue, 01 Sep 2020 00:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwPqsc4Oa96UwuF7zKI9yUPWtTpfnd4fIFJTiq2Tw5JhJmWMfK6h6yVx4wIY7+f+6KM4vtwQ==
X-Received: by 2002:a17:906:4e4a:: with SMTP id g10mr291503ejw.274.1598944803301;
        Tue, 01 Sep 2020 00:20:03 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id c5sm307852edk.63.2020.09.01.00.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 00:20:02 -0700 (PDT)
Subject: Re: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused
 'struct tcpm_altmode_ops'
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-9-lee.jones@linaro.org>
 <ca14707c-7d40-07ac-da1d-ca27a2e93dcd@redhat.com>
 <20200706142051.GA3500@dell>
 <65f27abc-69c8-3877-be5b-e5e478153af9@redhat.com>
 <20200714135456.GB1398296@dell>
 <CAPTae5L3cVYc+00-bPzDADXRjzFCOGPB5NnmSZ4_c=0D5Mxikg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5950abe7-b3cc-72db-3e24-167c87e5e264@redhat.com>
Date:   Tue, 1 Sep 2020 09:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPTae5L3cVYc+00-bPzDADXRjzFCOGPB5NnmSZ4_c=0D5Mxikg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/20 4:32 AM, Badhri Jagan Sridharan wrote:
> Hi Hans,
> 
> Kernel test robot is still reporting this issue. I have my repo synced
> to ToT usb-next:
> Output of git repo:
> 5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-next
> f75aef392f86 (tag: v5.9-rc3, origin/usb-linus, origin/main) Linux 5.9-rc3
> e43327c706f2 Merge branch 'linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> dcc5c6f013d8 Merge tag 'x86-urgent-2020-08-30' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> d2283cdc18d3 Merge tag 'irq-urgent-2020-08-30' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 0063a82de937 Merge tag 'sched-urgent-2020-08-30' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> Were you able to get your patch merged ?

The patch is in the review process. It looks like it needs one more
revision and then it should be on its way.

Regards,

Hans



> 
> Thanks,
> Badhri
> 
> 
> On Tue, Jul 14, 2020 at 6:55 AM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> On Tue, 14 Jul 2020, Hans de Goede wrote:
>>
>>> Hi,
>>>
>>> On 7/6/20 4:20 PM, Lee Jones wrote:
>>>> On Mon, 06 Jul 2020, Hans de Goede wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On 7/6/20 3:33 PM, Lee Jones wrote:
>>>>>> Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_config
>>>>>> configuration mechanism") pulled out the only use of 'tcpm_altmode_ops'
>>>>>> last year.  No need to keep it around.
>>>>>>
>>>>>> Fixes the following W=1 kernel build warning(s):
>>>>>>
>>>>>>     drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
>>>>>>     1551 | static const struct typec_altmode_ops tcpm_altmode_ops = {
>>>>>>     | ^~~~~~~~~~~~~~~~
>>>>>>
>>>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>>>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>>
>>>>> This is necessary for adding Display port over Type-C support
>>>>> on devices using the tcpm code, rather then firmware, to do
>>>>> the Type-C alt-mode negotiation.
>>>>>
>>>>> I have a local patch in my tree which adds support for this.
>>>>>
>>>>> But Heikki did not like my approach, so that patch
>>>>> (which needs the bits you are removing) never landed
>>>>> upstream:
>>>>>
>>>>> https://patchwork.kernel.org/patch/11199517/
>>>>>
>>>>> Which is somewhat old now.
>>>>
>>>> Yes, that's a just a little old now.
>>>>
>>>> If it drags on for much longer, perhaps consider taking it out for the
>>>> time being and adding it back when you start to make use of it again?
>>>
>>> Ok, I've just submitted a reworked patch-series upstream which
>>> actually uses this code. So please drop this patch from your
>>> patch-set.
>>
>> No problem.
>>
>> Thanks Hans.
>>
>> --
>> Lee Jones [李琼斯]
>> Senior Technical Lead - Developer Services
>> Linaro.org │ Open source software for Arm SoCs
>> Follow Linaro: Facebook | Twitter | Blog
> 

