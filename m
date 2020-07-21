Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25834C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB612070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595346081;
	bh=90abIK1WPEAsZ8pHsKRXmnSgfQkanY20p75sSFbtnNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b/CLVPAlIL50K6KSIpxkygNg3QK6iuP7u8h7oorlwWUOu1fXutXn4awslwSbYfYjd
	 FvQQjfPm0eCl/PQTl2cFyL+3WgaC5m7ogJkrmxvcoqa5/avRuP5PdfWkb7A1aadNjy
	 Pyz4vmpqxmxo1Qkf/6CfKYIJ9EIe3bNPumNZxa4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgGUPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGUPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:41:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:41:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so24553657ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc7d3kia3peQVaNkOBs+CgkXjLZrvv2+JxJ4SW1Uwi4=;
        b=Wi40gVzOfopUd5bmwly6mhHvMK0xKKObfcv0su+cEkjgbvz9MCXU8Jaoj+JIZ2crlF
         /3Z5HywSN8mErnnP4EA60pD+BzjLtu366+Y+alSJk2/bat/X1PqHD3T9i9RxjloeBWit
         REssY3blC8jZ57Orceq3Azdxr3qjD++csbGRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc7d3kia3peQVaNkOBs+CgkXjLZrvv2+JxJ4SW1Uwi4=;
        b=Eh43i6RqSJdZ3QvXuos8RuCTPBr+JRKxGNtI7KwXdQ7BEQ+AMeK6e6NlzMEqsqmbIG
         Vh8FVeMYeUWIDRsqId01EAqM4zFNlE1shpqCrQcQBytZYWyCWKQp9KUyFtAA2Ivlu1+m
         A7iXUmwTDIj0pTLK1eZ/lK9IgdPsQjzYHmjKDEwMuaJHU3yPfBDzM5MWYU41t8aqwi7/
         UwfpUCry+lfb+6pA1GQH00We56tbzwTGgyErozybsGcpDUjh+mVN3eoX5VhWX+S3PM4A
         VMFVCLgrFYjYtDh01mJRbRbKUhIvV+oMJeihU2A10xznCVcqj1hevdRHxyt0R1eQBJw/
         foWw==
X-Gm-Message-State: AOAM530AaKOwP+NTqb2Kow+dtXSzNeNrSfMEyI0PGN2ccTcZyhWST2Ya
        tkApNUanNbZfhNYE2vJeZo+uYQWfQKc=
X-Google-Smtp-Source: ABdhPJyCvFfsFFTriDK0+D7sOWdWNKAX6Tf2OJa+4uvOjxOiy7hGPHg9KG9UoA0jRGlQHcmwftxVUw==
X-Received: by 2002:a2e:9144:: with SMTP id q4mr13715073ljg.84.1595346075925;
        Tue, 21 Jul 2020 08:41:15 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f24sm5255583ljc.99.2020.07.21.08.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:41:14 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id s9so3197905lfs.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:41:14 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr2421912lfl.30.1595346074084;
 Tue, 21 Jul 2020 08:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de> <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain> <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
In-Reply-To: <20200721144220.GE44523@jagdpanzerIV.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 08:40:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
Message-ID: <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 7:42 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> we will have more info than just "0x80000000 + raw_smp_processor_id()".

I think it's really preempt_count() that we want to have there.

That has the softirq/hardirq/NMI information in it.

So the "context" identifier of an incomplete write would be { task,
cpu, preempt_count() } of the writer. If a new KERN_CONT writer comes
in, it would have to match in that context to actually combine.

You can probably play "hide the bits" tricks to not *ac tually* use
three words for it. The task structure in particular tends to be very
aligned, you could hide bits in the low bits there. The CPU number
would fit in there, for example.

             Linus
