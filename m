Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA64C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C3F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XU2xAeGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgDXUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:11:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A592C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:11:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h69so5133991pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qs6+14MYm0RtJWJZAe/BTNaI2oDLYoEFf/uXYdJz3a0=;
        b=XU2xAeGdDX45+4hPCNU7IxLVo0JZZ6Bx6tMCnyn5VNjeTQcV0hREf6tVJNhEyb1MHx
         XtaWGYr8Id7oq5vvNYSjXNUdufUpL8bTzHx/ymbMxwEZ/6jup09FCj98l/jdyhvm6kWa
         c488yO0xUAyRbw2sO5yNirqXuHh1j1/+2+qUxOke8A2Eqtuy/tVWezlyagZlvXjkJe6l
         F86mkR2cjnS2tZoFyMfUBRVyYEf+mMuSw18w2WTKB4VcCBjAdWiwHncYG/vofBsLkIoR
         OSiUbG/V+TnRK+HvYrBpHGkBlVPREOCOwoApU6YTmxbHWPCV0zBFGO5k1vJOiR0sgWPX
         7cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qs6+14MYm0RtJWJZAe/BTNaI2oDLYoEFf/uXYdJz3a0=;
        b=Jfd2wWiuX2eTlvV+b60QkfGWEM2sjc7F9jJ5Kn9xtVLc7GM8k/sxlCOstEUYt/GVQh
         fsAYzBfOMioDszpqXD9pvaoQ5OvBcMB+9i4IQkHuH+H0qh8H0kR2aE+EsqXRizywv57/
         aRvQRHl1Ucdg+x50jDgPiMW6zjSlIzVINUDcSrxJ4K8NxBcqGaEnQPv2IlccL2aLIBiG
         B2nUg15nZT8dRPJEzOiYoccBGK5Y+UcJvXNfbQO29zwPwp2orEwdAXulaFa9soBbqr4C
         RqygI4wvFeoLk1/nq0QDp4P6GHzY5GaA3MW82OlhLQyCWHrrOVk/JJUFEZvI92PFRJGI
         zc6w==
X-Gm-Message-State: AGi0PubApAgg55zxFdhNUxjqMpFLInjte8d1A8RdLxEjYB8VHRu/2XGi
        dk3nCO8skYenL1s76NEc3X+rqymrJKirrA==
X-Google-Smtp-Source: APiQypLsgNm7rYon6RX6CqXnAiAXgIQ1GDutJAoov7v4Yd5o9nw33xgmZ4tXHbUXS340sLyqa9/YXQ==
X-Received: by 2002:a62:3044:: with SMTP id w65mr11522316pfw.270.1587759116875;
        Fri, 24 Apr 2020 13:11:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u9sm6007215pfn.197.2020.04.24.13.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:11:56 -0700 (PDT)
Subject: Re: [GIT PULL] io_uring fix for 5.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <156f8353-5841-39ad-3bc2-af9cadac3c71@kernel.dk>
 <CAHk-=wibcCGvPy=PjevdSzEtzrYPWJnLo+t=S3zy3AQ5+NNeEg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f903c9de-cec8-0a3e-efae-a3d37b6db4ad@kernel.dk>
Date:   Fri, 24 Apr 2020 14:11:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wibcCGvPy=PjevdSzEtzrYPWJnLo+t=S3zy3AQ5+NNeEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 2:03 PM, Linus Torvalds wrote:
> On Fri, Apr 24, 2020 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Single fixup for a change that went into -rc2, please pull.
> 
> I'd like to point out that this was exactly the code that I pointed to
> as being badly written and hard to understand:
> 
>  "That whole apoll thing is disgusting.
> 
>   I cannot convince myself it is right. How do you convince yourself?"
> 
> And you at that time claimed it was all fairly simple and clear.

I know, and I was pretty much expecting you to bring that up...

> I repeat: that whole apoll thing is disgusting. It wasn't simple and
> clear and only a few obvious cases that had issues.
> 
> In fact, now it's even less clear, with an even more complicated check
> for when to restore things,
> 
> I think that whole approach needs re-thinking. Is the union really worth it?
> 
> Can you guarantee and explain why _this_ time it is right?

To be fair, this place is really the only place that is a bit tricky, since
it's where we restore things. The rest is clear, since we know exactly
which poll (&req->poll, or req->apoll) that is being used. The fix from
last week ended up somewhat conflicting with the cancellation part, which
is part of the reason it slipped.

But I do hear your point. If we run into anything like this again, I'll
bite the bullet and un-unionize this thing. I just care pretty deeply
about keeping the footprint of a single io_uring request down to as
little as we can, as we can be doing millions of these (per core). We've
still got some room in terms of not spilling into the next cacheline.

-- 
Jens Axboe

