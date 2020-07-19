Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A315C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B820B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595183281;
	bh=sx35FK3bwoMxo9piLWwLMWCYRKEtL3hr8XMP+Qczgsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Lr/960CAmmnw4n2kwtfb2gxM+LP+oSeegG4KFulvDl+b4u8H01Xi2+fcwhFri54q
	 X7YgqPVZHRmktU2IUUfTLiDURbQXgeYhOF2Dc2Ie8BE0UMUOIOkcSNHRrlEJqL0Mj6
	 1tH2zJ0bPwJocKEjsXMIvH3j3hXz/D5b2Yz4Qg5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgGSS2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:27:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:27:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so6168376lfe.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhhbzvucFkqakxARis8Sxj56SPuBqmQrW/ijj9gwFQ0=;
        b=CLLngWB0WxpE2RJRwDT7YyQzRzXMJSZZRACN77HN9swGDQl3M1BjEHchStCuMkE/0i
         txvKyP+mB18gwerf3S+Q0QK32pEZdrjt/K+5nOSTeqkTioKEUYym1YDIGb54ZWjDp3f2
         JBN1QZN0lNogsjhUokZp49JpVeCNk0vxqPnNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhhbzvucFkqakxARis8Sxj56SPuBqmQrW/ijj9gwFQ0=;
        b=XQ3nsv5oLxNsgbBHMvVTClo2EtTyFFFMY5kCZFSAsa+QkTrlOoN/4o9WnZIZxF43Yg
         8u+cnCxP/O1KlQbeis0Oi/5Fwdm2/hAaSEHI174R7HhO7Pa6JAvzSqZQP4cBQMfEhcmO
         F7YVkAlv0X7cFzbTLWZdgpousKgZdZadH6g1PW1okUgR6ZLDgT7xpcE7VBCE8gMv6Gi6
         1oAhl/Mo54bouYBV6NKRRZrrP58RHc9v6ojAxnoyyOKZ0j54cYhfGL+vVQ2JkY2kJysD
         2NEjwO1p+vlTztWytNZL9QDyEyimo98g3VbCIIvezwrH5xUInS9N97M8KZSs9efKv6PO
         5Etw==
X-Gm-Message-State: AOAM531whnAwwT7GiIuQeMm3HzOLPRzM351Ib0vaMCz6gBuVr+5VgWtg
        pKWPzi2oC5W/S3EEa0P5AfQWE1xvLPA=
X-Google-Smtp-Source: ABdhPJzqql8a0QZUD6d665TiYhP6DhigNB+IpFZLOFFPGgmRVOmQadvYfjq8peYLqLYn5SKbWTfo8Q==
X-Received: by 2002:a19:6d1e:: with SMTP id i30mr1402186lfc.104.1595183277353;
        Sun, 19 Jul 2020 11:27:57 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k12sm3142052lfe.68.2020.07.19.11.27.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 11:27:56 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f5so17869056ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:27:55 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr8205568lji.70.1595183275645;
 Sun, 19 Jul 2020 11:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de> <20200719143527.GA566@jagdpanzerIV.localdomain>
In-Reply-To: <20200719143527.GA566@jagdpanzerIV.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 11:27:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
Message-ID: <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
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

On Sun, Jul 19, 2020 at 7:35 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Can we merge lines that we don't want to merge?
>
>    pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()

That pr_cont in either IRQ or NMI context would be a bug.

You can't validly have a PR_CONT without the non-cont that precedes it.

                Linus
