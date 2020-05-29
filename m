Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2700C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD30208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590785879;
	bh=h0SqLi+xBFWQEmb4/Rl36hRoBrcqcjYMRAqOeU1+XiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I/ZqSZipG+GTj5j9Rhh+VuNG/M3/OY6DpKokyna9eafOp5iapsd9P81ecgjbcnHqu
	 SoUiQPHSffWLOc7Pdr4TNmulZMVnTHl6GTuwtF0pQSdEPZiKzYnnjOuE9CcDmKnVKk
	 aO+cp194+QOsjWkbhgavI7CrEnEA2e01UVSUJ9MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgE2U57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:57:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19535C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:57:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so885221ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMYB1DtpdiIUC5Hq3/MKsg9W34brhT1SCCn+MooLpt8=;
        b=WOJNDSngSwvWbLC2sXGabc4EsYy/SY5WCyG2Wcz4ga+pMjXDofuGha/vYFN9lzucI/
         nJ5ARc+8aqxDiqUOr0euKYd9U3Oe8PMKryjwX6vi0gvtIqx6Hr/BTyDvR/9dLvYzMajO
         qg5gVi+OH0yIvezUJoOvXcjcwZOZR02jRQ5Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMYB1DtpdiIUC5Hq3/MKsg9W34brhT1SCCn+MooLpt8=;
        b=VKKw6WB3LrSToJRWrclDxRc5anfKSa2aSemH2Td8kGxrOspW84HxA1ZKGYRBRrYyZp
         A/nVFY8IzzHN/y7xELNnjn/Oif1fPWXveetdqpGln5aoF2B7SQA9euBT7dkMAL4/QWC9
         sSwp6rJr86GimtoqYG3XesvHpip+v1OtY05zz3Ve5e60f2betYJ+NPNApBj2+H0xahwW
         VwZbbtF/LxHOqcBDTDmQp4gwen0c7AYxQN6mzYbhDdI1rA+67kzT61eCDa8mxGNVYdzI
         x2vBr6zHnFI00t1m6i4Ewz09LsxYY1VJvZmz75qHajCxXZ6Nuu+uivA72BTP1xYeiiAa
         ZyOQ==
X-Gm-Message-State: AOAM531/H2pC8h7tliQmqFm/keOEp0FQcO4MkDr9wtFwhFKwGSRe5f8h
        KbrJmSPgPWudsKK+4bAThGW8ZhRxyEA=
X-Google-Smtp-Source: ABdhPJzk/w/rSnciro6NAmQNv3WhPsFOPyCCgI08v4qmVQGEN+dL7m9gTPJZkenIWC6AfNjakegdFg==
X-Received: by 2002:a2e:5451:: with SMTP id y17mr1968021ljd.223.1590785873899;
        Fri, 29 May 2020 13:57:53 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id o4sm2493719lfb.75.2020.05.29.13.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:57:53 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d7so479042lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:57:52 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr5417023lfm.30.1590785872566;
 Fri, 29 May 2020 13:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk> <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk> <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
 <20200529204628.GI23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529204628.GI23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 13:57:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
Message-ID: <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  I'd been concerned about code generation, but it actually gets
> split into a pair of scalars just fine...

We actually have depended on that for a long time: our 'pte_t' etc on
32-bit kernels were very much about "structs of two words are handled
fairly well by gcc".

IIrc, we (for a while) had a config option to switch between "long
long" and the struct, but passing and returning two-word structs ends
up working fine even when it's a function call, and when it's all
inlined it ends up generating pretty good code on just two registers
instead.

> Al, trying to resist the temptation to call those struct bad_idea and
> struct bad_idea_32...

I'm sure you can contain yourself.

> All jokes aside, when had we (or anybody else, really) _not_ gotten
> into trouble when passing structs across the kernel boundary?  Sure,
> sometimes you have to (stat, for example), but just look at the amount
> of PITA stat() has spawned...

I'd rather see the struct than some ugly manual address calculations
and casts...

Because that's fundamentally what a struct _is_, after all.

               Linus
