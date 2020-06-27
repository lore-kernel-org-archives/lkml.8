Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA15C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881F420773
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LAoVozES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgF0CZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 22:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgF0CZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 22:25:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE090C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:25:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so5777996pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhkZLuZObi8zavAGC6FM3sZjX28XBVMWrEcExx5l178=;
        b=LAoVozESfeYoIEIRrxzaIfG7DHejZkoeqXCdPXMX2td7HeSTTubdnaSztqfkoP3+2H
         SHVE2oT/tajrNXYaDUhHQuAG1d7L1sqeVBeZ0nQuN5qhBbajVXXdWVF8+B39LTQYCO8D
         VfqgynPbkRKXBa0GWyz9HwVmp/f/p0XwxhgsgTqHZQS4V3lL1f+JUDGpyDhZVhZCY6/8
         1jo1MoB86ug91uVHOGln/MD9jSxDTWOHXbmSLYY7vPBlF1g/RaLLBT5XFGNMn63B768K
         wYYTtLmcgrKN0V9VPnJE6wRoro38EmcjaY3lybBeHbKEAGuRLIwXeS0GdXHN+zvi8PTc
         HRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhkZLuZObi8zavAGC6FM3sZjX28XBVMWrEcExx5l178=;
        b=AXy0tiL1p3TyveZHU7FIZoX7T+SFdSxNNc+1u/ObTWRvaXsOP1+flAJf4c5Hu3HeOQ
         MgbCUOwrCHlpLRJyHMDXV/LNluxEu0myFJhj+7mLV0mq/JMLrnNI+f2WkHZCuGwBnfQF
         /cRbywN/HRUEcd3gI+MyxM1ELIe8mHSjH8L4SG93EVXMfgBqdtp4W8Mo9xCZ7VNxSiJi
         XeVXEUPrs94t+zT4kKx8/ty8LLJhRY7jwaYXn2x31BEN7mkb9YEOfspn8+IVEEVeyVOg
         PcGD/3S3vUXQH6StVwR+dYXYXvJDiLz/HI9ZRdYYeI6nDCjw9qsdvO+VPoZp3kKM3MU5
         HKgA==
X-Gm-Message-State: AOAM533KwklLAEbVk/rx/NTXcz3z8QQjWPPzHFXrBuN59i/mypcBPas2
        XBB+eHKrPzxc3zMxWrbxsQL7YQ==
X-Google-Smtp-Source: ABdhPJwGRIIjy5Q6jCNsVauhqNGYF/RFyiqmf+/zsyyVaY2vG6+wnwHD/CVeLw0bq/S0fnIof5y99A==
X-Received: by 2002:a63:3c2:: with SMTP id 185mr1554777pgd.46.1593224733279;
        Fri, 26 Jun 2020 19:25:33 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u19sm28762225pfk.98.2020.06.26.19.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 19:25:32 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200627090740.683308fd@canb.auug.org.au>
 <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
 <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <425cdd05-4123-c1ec-ad82-990eceae0b5a@kernel.dk>
Date:   Fri, 26 Jun 2020 20:25:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 7:56 PM, Konstantin Ryabitsev wrote:
> On Fri, Jun 26, 2020 at 07:32:15PM -0600, Jens Axboe wrote:
>> On 6/26/20 5:07 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> In commit
>>>
>>>   cd664b0e35cb ("io_uring: fix hanging iopoll in case of -EAGAIN")
>>>
>>> Fixes tag
>>>
>>>   Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
>>>
>>> has these problem(s):
>>>
>>>   - Subject has leading but no trailing parentheses
>>>   - Subject has leading but no trailing quotes
>>>
>>> Please do not split Fixes tags over more than one line.
>>
>> Gah, that's b4 messing it up. I've actually seen this before, but
>> I caught it. If you look at the actual commit, this is what the b4
>> output ends up being for the fixes line:
>>
>> [snip]
>> io_kiocb's result and iopoll_completed")
>>
>> Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
>>
>> even though it's correct in the email. I'm guessing some issue having to
>> do with the longer line?
> 
> Yeah, I'll try to see if there's something I can do here, but it's going 
> to be largely guesswork. Here's the original email:
> 
> https://lore.kernel.org/lkml/22111b29e298f5f606130fcf4307bda99dbec089.1593077359.git.asml.silence@gmail.com/raw
> 
> The Fixes: footer really does get split into two. It's not that hard to 
> add logic just for the Fixes tag (since it conveniently follows a set 
> pattern), but finding a universal fix for split footers will be more 
> difficult.

Right, but that's what git format-patch does when the line is long. Do
we have other tags where that's a concern? If not, then the fix should
be solid I think.

> I'll see what I can do.

Thanks!

-- 
Jens Axboe

