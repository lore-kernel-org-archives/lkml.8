Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAFAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE962076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hbn8rC7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgDWJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDWJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:33:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E18C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:33:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so5998781wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fbsLxV6IFtdG2LNGT6zdYoqNQS370sKL9v/GEGQmQ/w=;
        b=hbn8rC7CPaSlyBy2AH47CanlFTLMexJyaletxkZVqBcVucwl8JY/FWy06vvZ91usqe
         quOVoT8earv00ZDJvLUGmmf1pi2VH07Avdj/IciIFs00XtsydigbxQO6LlpvYGTkk7Ja
         sN6Gb0mcDRrPHKehrS6NRZYRUCV5sTyy8AApc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbsLxV6IFtdG2LNGT6zdYoqNQS370sKL9v/GEGQmQ/w=;
        b=nHLWSanLH7WTG1+IrcTVj3gRHt74r6MoVDxY97Vrep3/bPLBaz2ViDTzP3pDcmgnP3
         FEav7Z/d1/uOYr3VQ58Lh2fNk1kXj7texF3hc7vImS4ya1fYO3FOHzxUsgtl5ZkMS3uN
         8Nr6Np/aam83GPp5FHcNl6suWC+ZrNADuvDlDJL4HKC56qYk4quC4xrj6s0sF/7rg2zU
         KdIej0D9DvECDYJb+/dTHMVjuCrw+0a5UWY2vXYOu2zuWniPtjXax+32GAqzTKtdUnUF
         yMyXpESH5kZbUH2F6xEcN6x3AwydChJx/CHrD8k016OFtCCFLUVt+pAVbHx+mzr+b4SR
         scyQ==
X-Gm-Message-State: AGi0PuZuNmxyhkGD3jy2jYPc8qkMnWkOR8Ws/bErJJinS0MCAAyI0hN1
        0vlVPXzopryOqt3jVX3hdV7amZ2VoiMwwQ==
X-Google-Smtp-Source: APiQypIlTuDZ6piEeJMK2z3Z3CMwSvww2D0Ql7Pogo8VDyO9+HIkqmRTtn/Kc1yX95GKcZLmUB2bNA==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr4092051wrw.207.1587634438291;
        Thu, 23 Apr 2020 02:33:58 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id l16sm2865951wrp.91.2020.04.23.02.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:33:57 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] kernel.h: Split out min()/max() et al helpers
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
 <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
 <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <94bec618-5e06-e72b-45a5-29318e09a29a@rasmusvillemoes.dk>
Date:   Thu, 23 Apr 2020 11:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 16.52, Joe Perches wrote:
> On Wed, 2020-04-22 at 15:51 +0300, Andy Shevchenko wrote:

>> At the same time convert users in header and lib folder to use new header.
>> Though for time being include new header back to kernel.h to avoid twisted
>> indirected includes for existing users.
> 
> Yeah, that's the difficult bit and it could make
> using precompiled headers very cumbersome.

You mentioned precompiled headers last time as well, but you haven't
demonstrated that using those is either feasible or advantageous - and
if at some distant future time it turns out that they are a good idea,
it's not really any more difficult at that time to do a
linux/kitchen_sink.h that includes whatever common set of headers seems
to provide a reasonable speedup.

Meanwhile, the sheer size of the headers that gets pulled into each and
every TU currently slows down the build:

https://wildmoose.dk/header-bloat/

so anything that reduces the size of common headers like kernel.h will
improve build times (the slowdown is "death by a thousand cuts", hence
so will any individual improvement be hard or impossible to measure by
itself - that doesn't mean it's not worth doing them). Of course, the
include of minmax.h (et al) from kernel.h must be removed, but that's
the kind of thing that can easily take a couple of cycles to get done,
unlike the damage that adding #include <linux/foo.h> to bar.h
immediately causes.

> I'd rather make #include <linux/kernel.h>" _more_
> common or even used as the mandatory first #include
> for all kernel .c files.

No. Please no.

> That would also ensure that common kernel facilities
> are not duplicated or have naming conflicts with other
> files.

What? People duplicate functionality because they're not aware it
already exists, forcing an #include of a declaration of some function
doesn't make any developer know about it.

Rasmus
