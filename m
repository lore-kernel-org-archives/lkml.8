Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35F52311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734640;
	bh=ll51haRcfUUGpNWUeqW2uD1NJ+9leuM0WTfnjz3Zyb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MB0bN8FV9nLjR5TvKE89/2PZq9ppvxqMwA2pglgLKHSUahx83iITNHYWUY7cGauSO
	 T051LmxDOOZRpU1PeTFzRzIqq9KjQ1kUJa3snUqGCZqqFsQ6ELCY/aRqslYJfaSo65
	 4lWgzcx8ibPAqZ+RU9BW9WVD8SEJbuVWgIyAhunY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgHFRXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgHFRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579FC034612
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:10:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l4so50184292ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y37dSXMpF9i5zwI93ayCq0fr59uu6XSE2Odw+I/dNvE=;
        b=q8sjFvgHM0X7asxHMfSQI0E/0lUVZpTLaBQcdNapsY+haLKU8yj/yOcAyd4yHoL/Zn
         8OzL+aiIWsTkZpCbQa+rYja3b/wX2wdfiT0slTbbsm2SLoLUXXrX6+hvNmST2j9bigTh
         Q1ApEcKJv0hhJ7l7i64LTfxnekJQ46Fi5Uh5XnHEHPNQOQiI4qW8vL6VXbmNgJ/aVhhm
         CI+1dtK7bu7+uIsAmcxnW1J7GHDqhFqx9tCozej3QWGWkgUFsd5SK4sV2dDw/IC0xs/i
         BrWrvwVWRcHozdyGMqN69MKQveO7MQmMSFiwTMr/ziyhwI6NbngQt++5fhxTCbyxnTYV
         V5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y37dSXMpF9i5zwI93ayCq0fr59uu6XSE2Odw+I/dNvE=;
        b=DklcmGsXu1rUBxK5swHvi645piJ3dEgA0Pnft7kwz612pgGnngmOs2NB5Mq7rUsVdq
         YtsK8nex5kh02ytSBE7v91PVzqxUL5Bwt2r/G69j97FXRmkBx3D6iGvepmZzmwoyNk6R
         EFyVy9KmfrnKetMI6Kb54FGxxztOzGQ/3RCeLzzS9IXT4i0lCzE43fMYt0qOfqAXG4zK
         NHQXRaVGFU/lNCcXB1YbTbVMzSxWHmLJZchrIjZqIO8F+f4mytqoE9K6DIjTX5PDDqmN
         1AIIJR2izdufYxj5H3ZhkOloX3SJWYyzThGBu9X81npuHJfFB2afsxS/W40QfN6dUHmu
         hLMw==
X-Gm-Message-State: AOAM533GIAneEUWO6xsmKdOt/n8WC9/l1QGcf8rvabas9yiZhOAf695M
        rDhTC2hZAL7nJwLdOXJKri0=
X-Google-Smtp-Source: ABdhPJw8FI8o0LJCCc4YFIXvzfnQAjaWtw1rRx4JdSipZ0NvrLS7FIMh5tpaW1eYj1ORhmiInoxG0g==
X-Received: by 2002:a17:906:5a8a:: with SMTP id l10mr4031628ejq.397.1596719437400;
        Thu, 06 Aug 2020 06:10:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x1sm3625544ejc.119.2020.08.06.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:10:36 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:10:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806131034.GA2067370@gmail.com>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 5, 2020 at 4:03 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The commit 8bb9bf242d1f ("x86/mm/64: Do not sync vmalloc/ioremap
> > mappings") causes the OOPS below, in Linus' tree and in linux-next,
> > unearthed by my CI on <https://www.wireguard.com/build-status/>.
> > Bisecting reveals 8bb9bf242d1f, and reverting this makes the OOPS go
> > away.
> 
> The oops happens early in the function, and the "Code:" line actually
> gets almost the whole function prologue in it (missing first two bytes
> are probably "push %rbp"):
> 
>    0: 41 56                push   %r14
>    2: 41 55                push   %r13
>    4: 41 54                push   %r12
>    6: 55                    push   %rbp
>    7: 48 89 f5              mov    %rsi,%rbp
>    a: 53                    push   %rbx
>    b: 48 89 fb              mov    %rdi,%rbx
>    e: 48 83 ec 08          sub    $0x8,%rsp
>   12: 48 8b 06              mov    (%rsi),%rax
>   15: 4c 8b 67 40          mov    0x40(%rdi),%r12
>   19: 49 89 c6              mov    %rax,%r14
>   1c: 45 30 f6              xor    %r14b,%r14b
>   1f: a8 04                test   $0x4,%al
>   21: b8 00 00 00 00        mov    $0x0,%eax
>   26: 4c 0f 44 f0          cmove  %rax,%r14
>   2a:* 49 8b 46 08          mov    0x8(%r14),%rax <-- trapping instruction
> 
> 
> > BUG: unable to handle page fault for address: ffffe8ffffd00608
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> 
> Yeah, missing page table because it wasn't copied.
> 
> Presumably because that kthread is using the active_mm of some random
> user space process that didn't get sync'ed.
> 
> And the sync_global_pgds() may have ended up being sufficient
> synchronization with whoever allocated thigns, even if it wasn't about
> the TLB contents themselves.
> 
> So apparently the "the page-table pages are all pre-allocated now" is
> simply not true. Joerg?
> 
> Unless somebody can figure this out fairly quickly, I think it should
> just be reverted.

Agreed. Joerg?

Thanks,

	Ingo
