Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B763206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sq1LZKKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgHKSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597172079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fInOYw3oYFGypGBJ4zylH0Up62AYKcuG7tGEScNZDMo=;
        b=Sq1LZKKkMkirbLWRlCc0VbyOkRP3k2I9IEzzErz6+LyndIatuiNF/GtQz7T/8bRntT9unR
        UHFiUu8TO+CPy9stvksTKhOxSWvL0juaKw+9/C6+ijHPG4XGTCtnc5fdi1r0And21vzTdA
        +o7fFS8Fihl1KUhDvWEInEFdFvMqEt0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-7oxVF1X_NTqobXwxYl-Vdg-1; Tue, 11 Aug 2020 14:54:31 -0400
X-MC-Unique: 7oxVF1X_NTqobXwxYl-Vdg-1
Received: by mail-qv1-f72.google.com with SMTP id d1so10234395qvs.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fInOYw3oYFGypGBJ4zylH0Up62AYKcuG7tGEScNZDMo=;
        b=oJTnMpA+pNVKaqQbjkvdbOIfZ3R0fLhSXUlRMsGbLI8RPRnHmVsnLHpA5FO9iK8RJA
         A7pobelcwRhr6zRDhWA1gOWCJmjqoMN70MLAX6LwprTUxsFoDEWCuLUveOOxqP6g/pRL
         sS64QFrf4kLF0ea0BjnlD+tUL2w43g7JFun5pQ5Do5UsBdYATZ0a0ubl2+27+u8o1B4O
         /Tb0+aJ8l6s7aTBYJMflHTaK6fkyu56qcoLAKty5fYtzEOK6/uob5gHmQ1nTv17JMc+q
         BlIgqkJz/UszzbujlzX4iL69d6hXJmOOd6gBZdmjhbouhCTCIahVBEDf3Upqlxb614+P
         1ngw==
X-Gm-Message-State: AOAM530aJjHWevFXoG1KJP+i5SMfbnXEDKKTE38iu2y3NzJgTMBijjmj
        HoCK0qyeg3PQ3+HA6ExGLIcQBiYfaF7Rsla0yYGXmgj+o/sKQ4zYrHbddsbs2WJxVnJU8wLBct1
        VLs8wj1J2uefZbuKVbk7XtQGg
X-Received: by 2002:a05:6214:d6c:: with SMTP id 12mr2778612qvs.208.1597172070775;
        Tue, 11 Aug 2020 11:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhIdf3k/kiqgEvNEVm+MbxhAR7X0h2rtExMsl83/gNaJZj3HZEL8fQ0t9ZdB7nf4VU7BF+AA==
X-Received: by 2002:a05:6214:d6c:: with SMTP id 12mr2778599qvs.208.1597172070556;
        Tue, 11 Aug 2020 11:54:30 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l29sm8661915qtu.88.2020.08.11.11.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:54:30 -0700 (PDT)
Subject: Re: [PATCH] USB: realtek_cr: fix return check for dma functions
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, acozzette@cs.hmc.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
References: <20200811151505.12222-1-trix@redhat.com>
 <20200811160348.GD335280@rowland.harvard.edu>
 <1f7d5a64-f264-4fed-bf90-b64e2693652d@redhat.com>
 <20200811175338.GB339805@rowland.harvard.edu>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c48fec19-fe2c-65c6-917b-8b8ba40e4c7e@redhat.com>
Date:   Tue, 11 Aug 2020 11:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200811175338.GB339805@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/20 10:53 AM, Alan Stern wrote:
> On Tue, Aug 11, 2020 at 10:29:29AM -0700, Tom Rix wrote:
>> On 8/11/20 9:03 AM, Alan Stern wrote:
>>> On Tue, Aug 11, 2020 at 08:15:05AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> clang static analysis reports this representative problem
>>>>
>>>> realtek_cr.c:639:3: warning: The left expression of the compound
>>>>   assignment is an uninitialized value. The computed value will
>>>>   also be garbage
>>>>     SET_BIT(value, 2);
>>>>     ^~~~~~~~~~~~~~~~~
>>>>
>>>> value is set by a successful call to rts51x_read_mem()
>>>>
>>>> 	retval = rts51x_read_mem(us, 0xFE77, &value, 1);
>>>> 	if (retval < 0)
>>>> 		return -EIO;
>>>>
>>>> A successful call to rts51x_read_mem returns 0, failure can
>>>> return positive and negative values.  This check is wrong
>>>> for a number of functions.  Fix the retval check.
>>>>
>>>> Fixes: 065e60964e29 ("ums_realtek: do not use stack memory for DMA")
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>  drivers/usb/storage/realtek_cr.c | 36 ++++++++++++++++----------------
>>>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
>>>> index 3789698d9d3c..b983753e2368 100644
>>>> --- a/drivers/usb/storage/realtek_cr.c
>>>> +++ b/drivers/usb/storage/realtek_cr.c
>>>> @@ -481,16 +481,16 @@ static int enable_oscillator(struct us_data *us)
>>>>  	u8 value;
>>>>  
>>>>  	retval = rts51x_read_mem(us, 0xFE77, &value, 1);
>>>> -	if (retval < 0)
>>>> +	if (retval != STATUS_SUCCESS)
>>>>  		return -EIO;
>>> Instead of changing all these call sites, wouldn't it be a lot easier 
>>> just to change rts51x_read_mem() to make it always return a negative 
>>> value (such as -EIO) when there's an error?
>>>
>>> Alan Stern
>> I thought about that but there was already existing (retval != 
>> STATUS_SUCCESS) checks for these calls.
> The only values that routine currently returns are 
> USB_STOR_TRANSPORT_ERROR, -EIO, and 0.  None of the callers distinguish 
> between the first two values, so you can just change the first to the 
> second.
>
> Note that STATUS_SUCCESS is simply 0.

Yes, i noted all of these already. My change is consistent with the existing correct checks.  consistency is important.  returning a neg value to reuse the exiting check should mean the STATUS_SUCCESS != 0 checks are changed to neg check.  i can do this larger change if required.

Tom

>
> Alan Stern
>

