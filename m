Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71444C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD5520575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axOblyzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD0WJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgD0WJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:09:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430FC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:09:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so8451689pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xe8RUkEJu/E4jWUvQIevudFni0eW89aFKGU5bjDlftc=;
        b=axOblyzYYZwm23zJs/yIhW4AiXhyGbo1u4AhSQWZk6aCS3SbgYhrO3uxU/GIgXJe+R
         lZFY51Gu9ZAm1+Wx8ojNeFt262o3xlrjkkPW0UDsqW7aQHJ1kxx3GUTkZZ+SHEwEx4sj
         qIXCdTHxBwmKDJGtD8EE1vu3RoM8rdzvr7zJDbahVKaFbLW3BvoGBtbrg30QQDm9ZjL4
         NPsfDMvwSpCub92zGM4zYe+Jb2mMQ9YPQ+DnbHm8ALegArlm8BVMTVmhVxMj9B3OIDe9
         C66WGlEQ/5l6bbT1mq3LFfU7EdwlU0npz53O3fl3EQgOzkoYeSp2jk4DOPWs1j31cN1R
         XZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xe8RUkEJu/E4jWUvQIevudFni0eW89aFKGU5bjDlftc=;
        b=FCcVLYZ6mTyfcqf5VELLYt6ClwxnrsvNRPJcqdl/fEtL8C/LWJ21x7PhcHJswMxdBv
         5Q1d2kgs5K0niBi7SCzWDlQMnyOzNUZEdySbjlpwMAwA0EyJy7YThUYOgWOpxwhBg27o
         xVVsbGfDcDgtXFooA1TsGHsEJ3J8odwx+Carpv2fFJjry8lFVEBhqYEEGLMZ/g7ufrbf
         tmsMOJXqsUKyLFT9r3EebfxALWMVgfjoKDdw76piPGML+smXJ8/sXDj/Ej8KleuxIDEL
         UY6ziIfM5fy8Dth7q79BM+h6/JPWYyIKkjx3vGEVg42QpEscAKZtamt3FgmXCmW3jEtA
         CZGw==
X-Gm-Message-State: AGi0Pub0pHVo7Ufgyndwh0ULliBL1dfh1MbidHqOgA+fCvSttSkYhlDz
        IrsCB5nbrjp4yDuI0aak8KWTFQ==
X-Google-Smtp-Source: APiQypJpQnaMid4q4FwB9UWWT+cZC0Q4L77KS//F8Pl43k21RxaiBYMIK3X+fVPtnLNFejOX3p7P2Q==
X-Received: by 2002:aa7:951a:: with SMTP id b26mr25384503pfp.44.1588025389927;
        Mon, 27 Apr 2020 15:09:49 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id l8sm3554016pga.60.2020.04.27.15.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 15:09:49 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:09:42 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Marc Zyngier <maz@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 00/12] add support for Clang's Shadow Call Stack
Message-ID: <20200427220942.GB80713@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200427160018.243569-1-samitolvanen@google.com>
 <CAMj1kXGASSCjTjvXJh=_iPwEPG50_pVRe2QO1hoRW+KHtugFVQ@mail.gmail.com>
 <CAMj1kXFYv6YQJ0KGnFh=d6_K-39PYW+2bUj9TDnutA04czhOjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFYv6YQJ0KGnFh=d6_K-39PYW+2bUj9TDnutA04czhOjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:50:34PM +0200, Ard Biesheuvel wrote:
> > OK, so one thing that came up in an offline discussion about SCS is
> > the way it interacts with the vmap'ed stack.
> >
> > The vmap'ed stack is great for robustness, but it only works if things
> > don't explode for other reasons in the mean time. This means the
> > ordinary-to-shadow-call-stack size ratio should be chosen such that it
> > is *really* unlikely you could ever overflow the shadow call stack and
> > corrupt another task's call stack before hitting the vmap stack's
> > guard region.
> >
> > Alternatively, I wonder if there is a way we could let the SCS and
> > ordinary stack share the [bottom of] the vmap'ed region. That would
> > give rather nasty results if the ordinary stack overflows into the
> > SCS, but for cases where we really recurse out of control, we could
> > catch this occurrence on either stack, whichever one occurs first. And
> > the nastiness -when it does occur- will not corrupt any state beyond
> > the stack of the current task.
> 
> Hmm, I guess that would make it quite hard to keep the SCS address
> secret though :-(

Yes, and the stack potentially overflowing into the SCS sort of defeats
the purpose. I'm fine with increasing the SCS size to something safer,
but using a vmapped shadow stack seems like the correct solution to this
problem, at least on devices where allocating a full page isn't an issue.

Sami
