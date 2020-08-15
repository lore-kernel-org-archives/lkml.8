Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B22C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB05D204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528343;
	bh=FIg4MFBZiep/jAQGOcYBQwI2JuTIQqFEdeGO5Ww3Og4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t29ypiTnMMkXFu3K6MJaZXlmxuuFTtZfF74zVCSCXHj8NC10DB+xVFIBZ3amFFjDn
	 AqJXSqMPukR2DZOhMfFspbBG+1nf6KymirhOOWs9tZhet1H2ONP6UfxEL7PQeuGFXN
	 wr9dw5WM61VNf5b00K6RtxfIFm18P44M+0oQqqbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgHOVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgHOVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730EEC09B043
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:16:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so12934233ljk.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWS1UfTo6/I4oWmfdKg6iiTETVmAa38HIWL5UnAebrY=;
        b=ZACdl9Kp+vjCU+JQefZOdu/mgGBY3aES+fEHb4Pa20mACC5CeZ2Uw+RSrGKgTGUTcv
         6VCtEn3sAjWTRbAedIjbm3VzQlF31lk1JBfqS8ISlHuBAr3BONOpOIe8Mlpf2cZdNN8A
         PwCUVpap+I02/2yXFMKhN4QhcXxDSoJ8dnMnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWS1UfTo6/I4oWmfdKg6iiTETVmAa38HIWL5UnAebrY=;
        b=oE+OKeuS3bPH0FO+8S5XTjPlxMndh3G5x1eigurdlBwNTb1FnSqzWQpyzXVBAgz6EY
         k8Oeg80XkPJ5Pr5wS0T93Vjz4R7a8+erAqtNi9MN0WPeX5b7hVQfuYA/Nkqb/mGCJhn4
         JXyJaENYnXUABhhS4Q2FLkJM+aYyRreFHodDJxLnw4Ttdj1+RNgvxU5HVfnVnT95RBCS
         wUhJ6uftQpNnCDBcRTox7u9A9d4XT9HPZroqtrDHueSRQOPUDyN7JLsDr1ynvf8XoXgk
         sdgZRfE/AjtT6SVBw3abk+rvcSyZyVJE2IF1xNEWvBe7K7g7vlQDKHtgFpMF0HlziKVK
         AvDw==
X-Gm-Message-State: AOAM530ZrCTfQDXwQuuvebMuSUxXDQ9xjz8iBX32FeyH9o7dfLQAywFv
        qlWLLYOJi79obBIVNKuX/9uNEwT1eqEqWw==
X-Google-Smtp-Source: ABdhPJxjj78owgWPum1V2OVSQ5sok07dX6ZSQH5J/5/XUlaeSuTa+/jIVBacwPtFnI+1+Hld0bee6Q==
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr3291880ljo.431.1597504597541;
        Sat, 15 Aug 2020 08:16:37 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d15sm2455414ljl.32.2020.08.15.08.16.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 08:16:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t6so12890602ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 08:16:36 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3407423lji.314.1597504596231;
 Sat, 15 Aug 2020 08:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200811074637.GG4411@dell> <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
 <20200813071949.GG4354@dell> <20200814144206.GL4354@dell>
In-Reply-To: <20200814144206.GL4354@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 Aug 2020 08:16:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSXfOKSXeaSBP9MtgtYewZ_xpnAnTj96_4wKLndpzMjA@mail.gmail.com>
Message-ID: <CAHk-=whSXfOKSXeaSBP9MtgtYewZ_xpnAnTj96_4wKLndpzMjA@mail.gmail.com>
Subject: Re: [GIT PULL v2] MFD for v5.9
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:42 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Here is the new pull request.  It has been tested; locally, by
> TuxBuild and the Intel 'kernel test robot' [0].  Please consider this for
> addition into v5.9.  All of these patches have also soak tested in
> -next for a considerable amount of time.

I'm extremely annoyed by this all, but I've pulled this.

Please just *STOP* doing any W=1 fixes (and most definitely W=2 ones -
many of those warnings are just plain garbage and indicate more about
the compiler than they do about the code) if you can't then make damn
sure that the warnings that actually matter are always *ALWAY* taken
care of.

I absolutely abhor warnings in the default build, just because they
only result in people ignoring them. Which is exactly what happened
bvecause you then tried to care about the more-or-less worthless W=1
ones.

So a clean build is really important to me. And developers who don't
check and follow up on warnings in the normal build are something that
pisses me off no end.

Now something like 25 commits are pointlessly rebased just because you
didn't check warnings properly.

                     Linus
