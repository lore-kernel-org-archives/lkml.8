Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2697C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76E02068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587494067;
	bh=P4ncD5bZbHABRs0QYU1Pe/eIgzdYrE9K7q1Hk9tSOzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RdpxLnTAelW7zu9Lc/GZKWew3V5B8sG8agRFO+F3VcqZDojuvQK/l5gSx3Qe2okgl
	 c92ciuQ7fmXLQqnZj3VA02uHDPZl6Krx8QqWHyeblgjgcQD46tCWwgb4m6KWDsvqWW
	 ABLrCAQfFh0sgu1txFlf8qm5KezDuIFH1k4nbBMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgDUSe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:34:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:34:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so15018099ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Sxsn5oS4nqpkBX5BqB24mfzH+Rga+VCB+qgnhYUWk=;
        b=EN4eMrfRCQ2BTajrHemVrZRGdfNv+VjF0Hxxcl6iPzUIc4bkpVZwbpHp6Y8qjqbOly
         NQiQcxT3IZhkG8k/a9SX63SzMRhr6smIcOvnSUCBWIYLh5jNRcmyHxwhZdGgJqJWyNtZ
         yrajiBGrLqcdHIip5S59MA6DWpMQ2o4gnwtCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Sxsn5oS4nqpkBX5BqB24mfzH+Rga+VCB+qgnhYUWk=;
        b=aVaAMnPmAbrf039D+AS3TUBEccbmp3tdMso3/rcEBR8TD6WsiZMSH7OTOu5F2JyiO5
         OHxyY48R0M4Tt3Ko7iAroNxcbdTQ3N7FQgY2mVZmiJtpC6zkmBqBYsnLZLMFhdVsZJyH
         3Zn/YesR5/3SdEJzLOQxKv45agUHc6XN6H/+Xgyu0PaZsJcGiwhEfiWwYn4+7DYJZNSK
         tTYIpQul/WjMy0XdaZLPCNuGY9aSjoeKqKKj3zAuRTljammSciTbPcLI+Z4ft+W8Kq3q
         155/7bWEpiLTxYSGVVT0LEqcJ4RpyA8JTnVAWnSMshoacwUO7/lc22Fo/ZIf4SiEHDFV
         Jw4A==
X-Gm-Message-State: AGi0PuaB2JUVhnozMGnEDfRk/2dnyaNBKZDPM6Cl/E239QHHAhqTH++H
        B6lvgVCi4zXqg/yhfDdEV1G8GolEEQQ=
X-Google-Smtp-Source: APiQypK8rwKR7A9IFjYksSY50BHy07Vl0RUfB7/+HSuKaCH1T8e9Ia3ySgYz6heS/b84ErmQoepROw==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr13828584lji.130.1587494063012;
        Tue, 21 Apr 2020 11:34:23 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d24sm2770272lfi.21.2020.04.21.11.34.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 11:34:21 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id g4so6942462ljl.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:34:21 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr9624239lji.201.1587494060836;
 Tue, 21 Apr 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
 <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
 <20200403205205.GK23230@ZenIV.linux.org.uk> <20200421024919.GA23230@ZenIV.linux.org.uk>
In-Reply-To: <20200421024919.GA23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 11:34:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuHxXwuPynLFh-fYjuUE3_HNPh79e_P6MFMbq4Ki+QCw@mail.gmail.com>
Message-ID: <CAHk-=wiuHxXwuPynLFh-fYjuUE3_HNPh79e_P6MFMbq4Ki+QCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to user_full_access_begin/end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 7:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The only source I'd been able to find speaks of >= 60 cycles
> (and possibly much more) for non-pipelined coprocessor instructions;
> the list of such does contain loads and stores to a bunch of registers.
> However, the register in question (p15/c3) has only store mentioned there,
> so loads might be cheap; no obvious reasons for those to be slow.
> That's a question to arm folks, I'm afraid...  rmk?

_If_ it turns out to be expensive, is there any reason we couldn't
just cache the value in general?

That's what x86 tends to do with expensive system registers. One
example would be "msr_misc_features_shadow".

But maybe that's something to worry about when/if it turns out to
actually be a problem?

                 Linus
