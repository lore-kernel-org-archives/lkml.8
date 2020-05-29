Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B861AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EB9207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590780688;
	bh=P2+9mK0chq14SEg/Rw5Nb7gYuHRESQpxZDwKzioxQLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q7+kN5Fg1/h+n/JCvhgaFniRhsJG/TzXc0grnFQVmLRvEN2y+D/K1683wtCZ395gU
	 hCZt4NkSe+mEbNjEMTG9ju6n4DeFJt44dKOAshye1u+WKEigQ23DOI/WNyQhxr+Pj9
	 O0iUoR/+8TTqYLBfGqh0N6XtxPrLg4l4U/HMT4qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgE2Tb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2TbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:31:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339AC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:31:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z18so595776lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHD8TmCoQhuoCHpObwNDm6CdH7YyaMO9+wxjMxR+Oh8=;
        b=GfHFxtgln7yqSB1se2pJ14wo3yKSKifw0tK/O3YykA6cZk6SnwfwCdJUoPGoBPoiuq
         hvt32o1ueibjeP164cZ8R3sMzIvfIcIo3+4N7mAY1YnFWCZTz7Mto7uPHUpOdH/n6kSA
         PX8IEjgVF+Qcx1Pu1z4J/EywIHY1OR/5PBRqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHD8TmCoQhuoCHpObwNDm6CdH7YyaMO9+wxjMxR+Oh8=;
        b=MHd2XTn8Rzksd5msl6udDzrVdbjTv7pfq2b/Yg6ujLYlWE4ovgia0olihe/pF+GeEc
         JI0QjD0xfCFOEY4eaVzHzae3wXjEXg/KxnYweZzzVliSr67jTjGigF1ZlSiAB2bSBEQH
         VYdRFWoPbKDgDXK4E5rI7xR78gshnhTV1a+u3Coo1wVLT3C6yRqOYZCoiohvli+ysbkP
         KBpzm/YBEfYJkRRnGMAEUmPtmR7/7gQeZL7dFTuK12mOiS9bG0FhiqWaoWA3ZO0jYorq
         BW5s1kZwHdpJMvIIy3e8ZqUQXv4l5sQBI38VVuu5NozoWz/s84VWkOw35BkIsD0xNlEF
         IeNw==
X-Gm-Message-State: AOAM530kro8Dy0k+0ObelUROwlsV9qXr9AY0/usVZRtvYCadtiDkHnqc
        wgmbj/Z6M4/2S7vEiQ0uVxhRF1ReUgk=
X-Google-Smtp-Source: ABdhPJxgeUQ1iRusBCiHy2P3ytCrM7RaujV/V4f3ydBHAmEzqTxkSnvmFQyHcTGoSGVNraIyl0Lukw==
X-Received: by 2002:a2e:9604:: with SMTP id v4mr4570545ljh.341.1590780682630;
        Fri, 29 May 2020 12:31:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g24sm2813014lfh.90.2020.05.29.12.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:31:21 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 82so384361lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:31:20 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr5203392lfn.10.1590780680343;
 Fri, 29 May 2020 12:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org> <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de> <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net> <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble> <20200529161253.GD706460@hirez.programming.kicks-ass.net>
 <20200529165011.o7vvhn4wcj6zjxux@treble>
In-Reply-To: <20200529165011.o7vvhn4wcj6zjxux@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 12:31:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7xda+zM=iRGXWbU9i8S7kbNaSfPhXVXR-vK6uEFNx_w@mail.gmail.com>
Message-ID: <CAHk-=wi7xda+zM=iRGXWbU9i8S7kbNaSfPhXVXR-vK6uEFNx_w@mail.gmail.com>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 9:50 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> From staring at the asm I think the generated code is correct, it's just
> that the nested likelys with ftrace profiling cause GCC to converge the
> error/success paths.  But objtool doesn't do register value tracking so
> it's not smart enough to know that it's safe.

I'm surprised that gcc doesn't end up doing the obvious CSE and then
branch following and folding it all away in the end, but your patch is
obviously the right thing to do regardless, so ack on that.

Al - I think this had best go into your uaccess cleanup branch with
that csum-wrapper update, to avoid any unnecessary conflicts or
dependencies.

             Linus
