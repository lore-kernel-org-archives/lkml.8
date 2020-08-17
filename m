Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63484C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389A32078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLR2V20u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHQIOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:14:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A9C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:14:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so12488216wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zGAK9MYpIMYK7dsR6FZRmSk0GY2An22Am46kypmkj7E=;
        b=NLR2V20u2W2VMApwICVaXQJyg2ojDwSbi5i2AjCLzgHRNrp8blWSZg1lLF2zcJHBfO
         Gwqy6dJpCZZUampeYzWmuR5tshuUz8WdR4R78W2r+Hwvj8TnHsxUQMmGunKGeMHRFo/j
         QRs4CqWWsmvgL0BvSLDy8mzGgPobgrrynY7ZLdzcG8jo64Zz5MwI83022+Xnm6BCl7kM
         J9cLRc8VgYkxtK7fjnRPVMFtkQuS+kJAhX2UBVv5jAS8OQWaeVCbGz6atJwbK9Q3vHjM
         6j3eDgu+e8iZgO53OUHIKDGxlrQDbUiJmFNRLY2ExPDuanDDInYxFUm5eYgNLO4r+CJl
         mYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zGAK9MYpIMYK7dsR6FZRmSk0GY2An22Am46kypmkj7E=;
        b=uFjNfqLmd34V/t2N4noDpDQ+d4coaHVf45fL2fkqKl8XOHnxvZTP9WcB6fWWU1vPEU
         lgn3FSzrnRAxDwlIeZRVzTSFpADd1+tcvJyECkasZ2WxJrqU+pPCjCT/BANB77ow2ZPp
         sWaQmCTRkutr+QevQOPM2Ck/FwMoighDC8CGSFvrpKLiGJUA6COeOqirQMLKEpCw7yI+
         j9JtrIIVnBz9j+HaD0VgqPURa1dW9XTyeDA5XT4LlUwKdrVmDsiginFVQJ8aSnqAZXzY
         ylN+ygeslGBgG9LpTvK5y22R/wiE4NjY2pPrJuA8xFZGDKA+5B0eEWEU2f1OOJQxa4/s
         /j6w==
X-Gm-Message-State: AOAM531cAuCvJVk83Epq+UeyjcMAHoZ8I/2FxdrVXAGW8lD6FGoBNnT9
        +9EPQZRZ7lQ3y3B3cCk+VXt/GIlkfnCUVw==
X-Google-Smtp-Source: ABdhPJy0sZvHw65zzALFy/HYB8JRQVZtgjP5fsqH/JgMooJdqF9eKB9tPIpfmvIhT7NEf8Tw2oJKEA==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr14258647wml.106.1597652073949;
        Mon, 17 Aug 2020 01:14:33 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm26890770wmi.17.2020.08.17.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:14:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 09:14:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] MFD for v5.9
Message-ID: <20200817081431.GQ4354@dell>
References: <20200811074637.GG4411@dell>
 <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
 <20200813071949.GG4354@dell>
 <20200814144206.GL4354@dell>
 <CAHk-=whSXfOKSXeaSBP9MtgtYewZ_xpnAnTj96_4wKLndpzMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whSXfOKSXeaSBP9MtgtYewZ_xpnAnTj96_4wKLndpzMjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020, Linus Torvalds wrote:

> On Fri, Aug 14, 2020 at 7:42 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Here is the new pull request.  It has been tested; locally, by
> > TuxBuild and the Intel 'kernel test robot' [0].  Please consider this for
> > addition into v5.9.  All of these patches have also soak tested in
> > -next for a considerable amount of time.
> 
> I'm extremely annoyed by this all, but I've pulled this.
> 
> Please just *STOP* doing any W=1 fixes (and most definitely W=2 ones -
> many of those warnings are just plain garbage and indicate more about
> the compiler than they do about the code) if you can't then make damn
> sure that the warnings that actually matter are always *ALWAY* taken
> care of.
> 
> I absolutely abhor warnings in the default build, just because they
> only result in people ignoring them. Which is exactly what happened
> bvecause you then tried to care about the more-or-less worthless W=1
> ones.
> 
> So a clean build is really important to me. And developers who don't
> check and follow up on warnings in the normal build are something that
> pisses me off no end.
> 
> Now something like 25 commits are pointlessly rebased just because you
> didn't check warnings properly.

Your point is clear.

Allowing a W=0 warning into my pull-request was a genuine mistake
(most of us are only human after all).  It will be treated as a
learning point, safeguards will be put into place at my end and this
situation should not be repeated in the future.

I shall continue with my W=1 push (not going to touch W=2s however).
It's understandable that to you W=0s are paramount, but as long as
none are introduced then fixing up W=1s can only help to improve the
code-base (not withstanding 'type-limits' of course!) and ensure it's
more in sync/aligned with itself [thinking API documentation warnings
here]).

Thanks for pulling though.  It is appreciated.

Apologies again for the fuss.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
