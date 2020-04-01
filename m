Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94390C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FBA20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585785135;
	bh=Jz0/Tmfi38wg1zgHfPE4PHQZ5xpHWkQUEbAm/9nBj/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jb9rOGuv/cn7aK/AGwpxBhX7dE4IKbvR6eR75cLSEGSL4sHfkMDy1hiZr9mxdSmu6
	 2FYAa87RELC1ErNwNq/Rt7SrRES9nH4Saso7NG3HYaG49RmjMvcS1aBpvUlo6ocxJC
	 fCedH9dQlTFqiP6ieu7N4jrflhy5vfrVHesnq0GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgDAXv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:51:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44030 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732872AbgDAXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:51:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so1296360ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9rQ+4MX6AGqiS4gDh7zcouPJInPh/6Vm7fyt3tgD0k=;
        b=JX+jSiMzF2RZC7X1UHsV906x8DewgkAwWN6EQ17vLXZEJQX6swhg/zVI1vxFEEZxIH
         PbSD0KAyottCcGb/rT1bEA1sm5NRoFsrhBrQoH3A79V86rZeArdSk7sJvXfa6DN/8YJY
         Q2hGYFvnvtsGpe9Mfmd01M2hX1hq6hVJbWiug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9rQ+4MX6AGqiS4gDh7zcouPJInPh/6Vm7fyt3tgD0k=;
        b=W5J6M+KedCrXbsu2pmh9mLHHxfmoaLr2wjg6HNNZLvJxb5Xb0Q+/Ht7ASSMHHDBsxC
         iI9wQKFqxIE+MUW6SAeofQgjorqI1NT1Cml0EAFI7u9ptvAJGs+1WawI0Q+HtVEdg4ip
         zX2XOl0Fygun370D4yjt/7gJLSKJxF90nHxVFWHOa14SgV3SFXL4sBerpBJ76l/KBub7
         XVdsuN2yIOFql6KC5B3O3/r+7eXGcc3eJLsJ/bA6ESVqc4yLiQX87/V3HkQYoV9J5XYL
         e+B9ic68l9oBLVHDOb9rw6oI5cvyZFY6ndlNDb/dE6mVKcbL0z31ksCEqzLYvWXbYHBd
         mwNA==
X-Gm-Message-State: AGi0PuZpDEoPhyADFghdhTStg6pM59PWBiqZi9XgGI/cpnLVLRY+UENF
        PjuFYICswl9wQSFU+2X0u+Evanv05ng=
X-Google-Smtp-Source: APiQypLpiarPRvPKED2Ve1Wc0l8u50MEair+E8rV477f/0XPCsiIGFv+IYlfebXLiv5g4I/mIQviIA==
X-Received: by 2002:a2e:954e:: with SMTP id t14mr326020ljh.253.1585785115610;
        Wed, 01 Apr 2020 16:51:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m8sm2070608lji.12.2020.04.01.16.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 16:51:54 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 19so1316159ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:51:54 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr373016ljj.265.1585785113845;
 Wed, 01 Apr 2020 16:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook>
 <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org> <CAG48ez3nYr7dj340Rk5-QbzhsFq0JTKPf2MvVJ1-oi1Zug1ftQ@mail.gmail.com>
In-Reply-To: <CAG48ez3nYr7dj340Rk5-QbzhsFq0JTKPf2MvVJ1-oi1Zug1ftQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 16:51:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
Message-ID: <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:37 PM Jann Horn <jannh@google.com> wrote:
>
> GCC will generate code for this without complaining, but I think it'll
> probably generate a tearing store on 32-bit platforms:

This is very much a "we don't care" case.

It's literally testing a sequence counter for equality. If you get
tearing in the high bits on the write (or the read), you'd still need
to have the low bits turn around 4G times to get a matching value.

So no. We're not doing atomics for the 32-bit case. That's insane.

               Linus
