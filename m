Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E977C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3A20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2cdWY/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgG3OoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:44:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgG3OoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsId+rhdX5PqVP541hzQk5NPr2OWjjymtpyXFAnC+IY=;
        b=H2cdWY/F0e73tuE9bPZ1jw444q71yElpftlSYli6g7mokDCE+sef9XVig8J3OuZdKrJI+/
        oiwWAwA+uBQUlQm6TwxRGwZ6hZSHUyoWQgNM65z/LsAXt9dIFpu3ahn9WE7QVwuIgtnjr/
        B64WiBY6lyVxiDn6j3I1BsRwDPMt26c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Yad0818VOFa-Zy-ZgYrTCw-1; Thu, 30 Jul 2020 10:44:18 -0400
X-MC-Unique: Yad0818VOFa-Zy-ZgYrTCw-1
Received: by mail-wr1-f71.google.com with SMTP id z7so7490588wrw.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsId+rhdX5PqVP541hzQk5NPr2OWjjymtpyXFAnC+IY=;
        b=uEpygcknm0yPlygDCYraKXdv8Hzcd+BrYPFiaEoOUg1W7+cHAATqqWyS0dk0obn50Y
         L2eS36ylccBpEEvHB4OEfatpPNkchl693rNyp6ntkT4D5D0lrTQJYuLqj6s2QoJEQnAf
         LSFeklGu8oZ1Owiqiw1lbECYHusAhNVed7klnicVEObFZd91rDuM8o9Cg+2lbZ+SSYJy
         juhoPv6Nj/J6s23yCBmGg+wcpM5fU4ypWYHJiRbp2flMEhdmYb5IcAbef3xnNN3Px5HN
         Od1ieqdGhK2WftCaZEkRtXxsj7JlgQSReVq2Cau7+/7W6qBoJH7sdvHUpmRWl9Wo1gU0
         AiUQ==
X-Gm-Message-State: AOAM531iPi340yWkEgmMz0NKIII0mh+P1eszNea3bhqVQfES4VW3QR6I
        joP5H2lYhRe2Vs1iKQ8fL+W2vFcBFksIaqptDc8OYgmRDXKAVjwFODi66BMn5Z/tBaPx0qj69Jw
        NvGf/Z6PM5n1lVa8hiGrXcz20
X-Received: by 2002:adf:f486:: with SMTP id l6mr30125492wro.265.1596120257909;
        Thu, 30 Jul 2020 07:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsRebcqtb2r3HVBYpqFGPr7WRNjDET5HjTMzOb5f4QSejj6Gg+McR8fz7pgNh7OIZu/Pq74A==
X-Received: by 2002:adf:f486:: with SMTP id l6mr30125480wro.265.1596120257713;
        Thu, 30 Jul 2020 07:44:17 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u6sm2457529wrn.95.2020.07.30.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 07:44:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
 <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
 <20200730132237.GM2655@hirez.programming.kicks-ass.net>
 <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com>
 <20200730141526.lr33zv4ffa3rdygp@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <7f7a7196-8b28-cd55-0685-799766bb6d4c@redhat.com>
Date:   Thu, 30 Jul 2020 15:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730141526.lr33zv4ffa3rdygp@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 3:15 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 02:29:20PM +0100, Julien Thierry wrote:
>>
>>
>> On 7/30/20 2:22 PM, peterz@infradead.org wrote:
>>> On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
>>>>
>>>>
>>>> On 7/30/20 10:57 AM, peterz@infradead.org wrote:
>>>>> On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
>>>>>> +		if (file->elf->changed)
>>>>>> +			return elf_write(file->elf);
>>>>>> +		else
>>>>>> +			return 0;
>>>>>>     	}
>>>>>
>>>>> I think we can do without that else :-)
>>>>>
>>>>
>>>> I did wonder and was not 100% confident about it, but the orc gen will
>>>> always change the file, correct?
>>>
>>> Not if it already has orc, iirc.
>>>
>>> But what I was trying to say is that:
>>>
>>> 	if (file->elf->changed)
>>> 		return elf_write(file->elf)
>>>
>>> 	return 0;
>>>
>>> is identical code and, IMO, easier to read.
>>>
>>
>> Much easier yes, I'll change it.
> 
> But I think file->elf->changed can be assumed at this point anyway, so
> it could just be an unconditional
> 
> 	return elf_write(file->elf);
> 

I'll triple check whether that's the case and remove the if if possible.

-- 
Julien Thierry

