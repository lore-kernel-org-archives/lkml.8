Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12836C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92BE207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593657059;
	bh=jSWDvlt6hvwFnrlyQ0W0ASnRXYjicDOjJfEj9Nvl8DQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xE5Wrn8E62Xu4sr8kDmsL5BRifEBvWZjslWXY4+1HapvXG7niTR1HTrknhLNQA0w8
	 M35AiX1vVGE9XjguXI/fPe5EpgEpCs8xDoe9aRuDrDevfGjqyESDWIyb7tKW6qezRR
	 oHg2lmQx6sqJ9hcPElWhFYh0CwfSsTYH51wZ/M8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGBCa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGBCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:30:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:30:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q7so16430477ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXHqUJJpqKSjt9xGNqXs8qu9p2K7cIVXL2GeW+5CcEc=;
        b=Bn49y2fx16Vt8RAWv2KM+GyvSoWbOi6Ui1f63lfNOCMy4XNhNb38J5f0IU/WRw2yHS
         NMHSt1cyPnwuQWK4D/n42S5mwlvL7j8RSbUeFxFxm+A+TpKC7ZFuRJpJRrbLjfsFp+rY
         OeBdvzvfAeLy+ykaYlvF8rDeZ4DxESTxzsdPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXHqUJJpqKSjt9xGNqXs8qu9p2K7cIVXL2GeW+5CcEc=;
        b=he4J40Ft+dBxSv4hOcS19+W7yqZFCclnfEyZi+mSz2rw5Au0Ald8kaOQDpg0+b7Bx3
         8DgyJgLyW6eFw6VkO/fALXIjzYhysf3DR5+9iapUfvpu5IgjUOvyfPLaTbPkhcVDmBjG
         mpWEBiTqzxQ/ZVHRUlCo5t/d4CUyV2rZXbR6hXQYirloYx/AnGmY6imGPoNZsRHvV91n
         TeD/QiS59rAjUVjwTD1Wbr+/1lEjfZhxUI+uriG1LimLr7wCBkBbAROZ8uHAAKfJdaCB
         SZjaYQeK0mFehu5L7Ss45euzNvZC8KPKnpIMng87FN2Kc7NStrXMORwgkr4VYhN2m6l2
         95oQ==
X-Gm-Message-State: AOAM532GkEUT0m41hKM4nxKz+cgBiaApZwvdU/ErQuKJLezzRA1vqbkC
        im6/nmFr7E/+nrg/nEll+vq1+0YmxU8=
X-Google-Smtp-Source: ABdhPJxTaKoIk8Sv5oaUtwX/XYBbSQlbV8FR5tH7bLlEu7dMNBtm2juYzF95psDO22eRKlst7/sc0Q==
X-Received: by 2002:a2e:8184:: with SMTP id e4mr15677197ljg.334.1593657053356;
        Wed, 01 Jul 2020 19:30:53 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w15sm2768790lff.25.2020.07.01.19.30.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:30:52 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id y18so14943403lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:30:51 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr17040357lfn.30.1593657051528;
 Wed, 01 Jul 2020 19:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net> <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
 <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com>
In-Reply-To: <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 19:30:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
Message-ID: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:48 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> You inspired me to mock it up.

Ahh, you want to just use the jump folding of gcc to avoid the problem.

I guess we could do that. Are there cases where this actually helps?

                 Linus
