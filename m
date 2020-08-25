Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAA3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0641F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598379572;
	bh=TLtZJvxu2WVzSqUdCOxiJeqLAsuMs2+/a7emZZ6ygow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AE80ZQa+P+aAo4awQfqB5mBGiA2+NgoN81/3WeJ8we/AVrMf02eS4oETstHAFcaKz
	 HLlEwfaGnLQG4rNdaEzFxUwpdr2Yy7triD5V71dCkVYJWphTzSZtU/l5R/mZHVo2C0
	 97EZaPHg0DhbT47tw927w1Gc0UldDTR8xUUlzUzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYSTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:19:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:19:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so14903760ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46qyLntGhqFIKIx0vS5eQWqEfe+Vbu8cNj42GZZptzk=;
        b=h2PH6gWvLDikDkSDOxim22YnimrYTywDHULqdiPXEaMaBQAYKyE2JgwLEHMD0cD4se
         e7g8tMvGLg0XeiAL8MF68+nFKvRH/TYavRAA60RxCSDGxFg4j8ZBmpolbIskCTCCh+ia
         pbiUT9xGSqYDflwulqlmwftH6VgjNGCM9B3EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46qyLntGhqFIKIx0vS5eQWqEfe+Vbu8cNj42GZZptzk=;
        b=VlaCD6u7B9Bl/5RU5UUY1fdoUX6RgKqenzm5IevGhQRLmXMW8o0DU3DzvmN8PsW/Gr
         3HD4AiSbWH9E36y1JMwtdiFJ9vRf9TBt0zAFGgjfADHOW8/KxAZUrS6D5XHXcuWWUey3
         5d6utIBF/yzxn7bUClum5nlLAAf0MxEflj1v1cTjylnhJ0c1KhSDRazHw8Bl5Vf0Vba6
         9MTmrsIPVot6YbFHVtI8dbpP/BjMm4ym22+NYOtvRROTkiQyuEirBQ+FoXEaIuBv5JUD
         xKKnCGnfLfdOaqMWSFnS6+BNh2iNPULwx0Sb2NartzEc2EETfRwshhsNsCltxDa+RQcs
         L+Rg==
X-Gm-Message-State: AOAM532yf+vLYQpxHztTK20IVSQ0sIeFFuVh5XB9Lbc+xfKX/KWQe9/H
        IiLNBMBR8N4IiXz3DfLYGmUgwC1l8YF3iw==
X-Google-Smtp-Source: ABdhPJx9cquXYI/xg3BgrsLVg8yWgTJievefdMutH2JIVjT4Z1SzaQmmajaH0OWlju/OatG9iSnb+w==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr5068284ljy.399.1598379566357;
        Tue, 25 Aug 2020 11:19:26 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r8sm3163332lfm.42.2020.08.25.11.19.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 11:19:24 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v4so14958924ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:19:24 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr5206226lji.314.1598379564237;
 Tue, 25 Aug 2020 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
 <20200820092349.GA3792@amd> <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
 <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz> <87tuwr59te.fsf@intel.com> <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org>
In-Reply-To: <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Aug 2020 11:19:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
Message-ID: <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 9:32 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> > For posterity, I'm told the fix is [1].
> >
> > [1] https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/
>
> Doesn't fix it for me. As soon as I start XFCE, the mouse and keyboard
> freeezes. I can still ssh into the machine
>
> The three reverts (763fedd6a216, 7ac2d2536dfa and 9e0f9464e2ab) fixes
> the bug for me.

Do you get any oops or other indication of what ends up going wrong?
Since ssh works that should be fairly easy to see.

                Linus
