Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBAD21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNUKj3I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgFQSGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgFQSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:06:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B1C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:06:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t194so2997429wmt.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yum1itbYwGCVmrfngXbrZP6sf+Nn+eNmWkfS6zoUuA0=;
        b=kNUKj3I5DxcPPrd4rg6poK4TXuYGuPA4GWwH7m9/L1+j8/qA8vNttplARLe4t6GEvA
         hr6XzgtXNWeJboRDI7DdmZVxc/RnuJ+J3ceRfmPyxF2Hx/yIHbSTqacmyESlUQ11bsaz
         l0HPpQI1VCILiAX72sbGMqh4jL/tR9N4xytd7DzkoKA+jeN9FxeYorJsNMCh1IyYPW5C
         +1ZRdZK43LZdU23YSkFTHM9mh+n6u77dfh9+XSgJ305z2g5GxKllrPP7hAeT0/EdUzoJ
         9HdFp1fWFlO3KnbVS0W580RzlzXSa26kQSL9k+jerVnhgku4kBTqiVrRTJKkKeIDCa1p
         wpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yum1itbYwGCVmrfngXbrZP6sf+Nn+eNmWkfS6zoUuA0=;
        b=Vk1YYbjxijJZo2Z0Fe3lEo/jn4l5lJNRsIdUPSAqR+aMCWH+C23FOxFlqeqnlduKK/
         +aa4XL8IaCC0+Lub9TuMRATVD+LrMMZSKe82bnO9O83QVy0/RkS09dEj9klKVNQTa0BB
         rSkgCJ1yJed2DKs8F8W6YzCGbuF0bw67gBradZ2zUIxpQsyapzPUKo5dqLux8eF/HE3N
         SOhZ+idrXlbT/dJkyof0Fem+mJ8NJbl9yFKt+AgzHc+S/M6vOFpshdtPUNldmSHO29DX
         rfxWctWum2jIXzrczvnBf6VJCvLFWKU+ax+IZLyJD8nkbwNMgunSTbL5f70BAXoAZLGD
         HdUg==
X-Gm-Message-State: AOAM530VkCq/xmeLo566JNJmzMiWDZP55uXvIYbIBHt1VBD7lnZWTt1Q
        oNuIEA+nHEEDdj3GVeF2lJXatw==
X-Google-Smtp-Source: ABdhPJxNGCblnLoo9BcEjo2ZUEvANSjruUEwVXonY+vNUkeiPbtiRleDMtIqkO+huPLBEZuwzUY/qA==
X-Received: by 2002:a1c:3b8b:: with SMTP id i133mr9658094wma.111.1592417187758;
        Wed, 17 Jun 2020 11:06:27 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 5sm477701wrr.5.2020.06.17.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:06:26 -0700 (PDT)
Date:   Wed, 17 Jun 2020 20:06:21 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617180621.GD56208@elver.google.com>
References: <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
 <20200617144949.GA576905@hirez.programming.kicks-ass.net>
 <20200617151959.GB56208@elver.google.com>
 <20200617155517.GB576905@hirez.programming.kicks-ass.net>
 <20200617163635.GC576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617163635.GC576905@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:36PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 05:55:17PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 17, 2020 at 05:19:59PM +0200, Marco Elver wrote:
> > 
> > > > Does GCC (8, as per the new KASAN thing) have that
> > > > __builtin_memcpy_inline() ?
> > > 
> > > No, sadly it doesn't. Only Clang 11. :-/
> > > 
> > > But using a call to __memcpy() somehow breaks with Clang+KCSAN. Yet,
> > > it's not the memcpy that BUGs, but once again check_preemption_disabled
> > > (which is noinstr!). Just adding calls anywhere here seems to results in
> > > unpredictable behaviour. Are we running out of stack space?
> > 
> > Very likely, bad_iret is running on that entry_stack you found, and as
> > you found, it is puny.
> > 
> > Andy wanted to make it a full page a while ago, so I suppose the
> > question is do we do that now?
> 
> Andy suggested doing the full page; untested patches here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/entry

Yeah, that works, thanks! I think the stack increase alone fixes any
kind of crash due to the reproducer.

Also, my guess is this is not a hot function, right? One caveat to keep
in mind is that because it's not 'memcpy', the compiler will never
inline these memcpys (unlike before). Whether or not that actually makes
things faster or slower is anyone's guess though.

Thanks,
-- Marco
