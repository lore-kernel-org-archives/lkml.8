Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A88C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C3F20714
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0KZ+dqt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHVPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHVPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:48:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CEEC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 08:48:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so2431006pgm.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbL90IDwtnRtnzlD0xDGTdZ6FaQmNJQAGy53EB9XAHk=;
        b=0KZ+dqt5XN5ztFcChm8+ZeUl+GW8fXsEiliNI5SKcfdWype1tzUD3q0c4KCTXtTOWU
         jPdbj4EvlAV56xq5aGtoLWg72Lzki+lOYu5f2Dm2iO7hp2ipTTvWMfQ2DzwmGhOVTZmk
         tCnjKLnK3sU8J0nFYAJFV8EJrXyQuNj8nh9PwJ/h2SZBxKRJOcNaoKmSKlabujAeVLFy
         R1y+0QXCzY/yaBUIsAqVctnVCzCJ9d1s0ruzhX9nsDJwUd1to8WQXxgHh4AZrIPcR7lB
         GMY8IIx3nkVE0iyeqWc3ko//t77f0KAmDvW+XD37zLzd7hDX1clRQgikLtsDjrsHFNmP
         ZCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbL90IDwtnRtnzlD0xDGTdZ6FaQmNJQAGy53EB9XAHk=;
        b=iiHE72n+6+tf7Weyd5vwQUjdtgjc+Q7JeyWmDQTmRg2S4sB7hMhp6OA9Nwg8j1U2+1
         u8FNVvCOxRF1jATYL08vg1Qg46Jo9NUtAkYip6CnQgck78Ib8cmPPjMh1y93VJA9OdG/
         uze9kkCsdmmfpf+QIoS47jZYTIkeIB0HCRndEPK9Bt5N+0M0fzdac4byfFj4oqIBVsQO
         8zhq3lj459Ay5bGNGuFYiLG/YgmyBEiAgsRlJCaHTc3BnWCW3NdRwMiej8fvSKkX2ntg
         mbTW22ZaWZUYtyyY9Cc/upJYLXQVOwIhkOjSoYp5U/FQEl5m4BAYwcxx2jxcIiKI/rLU
         g9BQ==
X-Gm-Message-State: AOAM532/ntbmOenGfRxkYQwU5SEoosHxcGedgmlMc3SVd9FZY1J5E1x7
        9bpBYu9bc2GJJjMMhSGepN+Xr3TjYNSrgETo
X-Google-Smtp-Source: ABdhPJzHdhcG1OaTI4+z9SJEQ0YHL8LOWl5oPUh0GXHf9JvYJ0cQemZTDm7DiSpV3t68o+75tLmz2A==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr6380356pfq.182.1598111320508;
        Sat, 22 Aug 2020 08:48:40 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b10sm721269pjd.51.2020.08.22.08.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 08:48:39 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
Date:   Sat, 22 Aug 2020 09:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822143326.GC199705@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>> please consider this one for 5.9. Thanks!
>>>>
>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>> missing something?  It's on my queue to send to Linus once I get my
>>>> (late) ext4 primary pull request for 5.9.
>>>
>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>
>> Didn't see it in the queue that just sent in, is it still queued up?
> 
> It wasn't in the queue which I queued up because that was based on
> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
> that's totally on me.
> 
> He has said that he's going to start ignoring pull requests that
> aren't fixes only if this becomes a pattern, so while I can send him
> another pull request which will just have that one change, there are
> no guarantees he's going to take it at this late date.
> 
> Sorry, when you sent me the commit saying that the changes that were
> needed were already upstream on August 3rd, I thought that meant that
> they were aready in Linus's tree.  I should have checked and noticed
> that that in fact "ext4: flag as supporting buffered async reads"
> wasn't compiling against Linus's upstream tree, so I didn't realize
> this needed to be handled as a special case during the merge window.

Well to be honest, this kind of sucks. I've been posting it since May,
and the ideal approach would have been to just ack it and I could have
carried it in my tree. That's what we did for btrfs and XFS, both of
which have it.

The required patches *were* upstreamed on August 3rd, which is why I
mentioned that. But yes, not in 5.8 or earlier, of course.

So I suggest that you either include it for the next pull request for
Linus, or that I put it in with your ack. Either is fine with me. I'd
consider this a "dropping the ball" kind of thing, it's not like the
patch hasn't been in linux-next or hasn't been ready for months. This
isn't some "oh I wrote this feature after the merge window" event. It'd
be a real shame to ship 5.9 and ext4 not have support for the more
efficient async buffered reads, imho, especially since the two other
major local file systems already have it.

Let me know what you think.

-- 
Jens Axboe

