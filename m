Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD2520784
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586362824;
	bh=9DP5B5UwQxiLTvlKL/iJiZLtyB0wXB6MEMzwUiduZto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ypg3HbDAygK++ps0M8oLkA1BMhbbJtLlcd9EV5nC214e6kT5DU2o/xzcAuBbdrYx0
	 p9z/71kLh0W06nYzEJ4LqV0Lb3GKshN70FekKW7WOk9I9vH2NkXzbioeEgKfCkq4ch
	 wNDT55wvXGf6RNPrmIK6cx+z1C8EvETulTNl6s/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgDHQUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:20:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41377 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgDHQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:20:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so8240064lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sxnfNnvpd58t1r63CmylWzkoy8L9qj8VsYKS2VPFrk=;
        b=AkBVmBfPV4ogXMiTyE5H40UrdvrnlrdbDajIwvYlBoklpLLimMe1zHLwgHAHKhMrS6
         0j9sWtPETpzjuqwrtw/cxA3M5Y0wZHxQa3xEwuKDMOkRQUn48PK01jz18eogZVTuMYyC
         WtvAPllo9T6mFNPfxmtNoMLa1RyGmaFbE/8MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sxnfNnvpd58t1r63CmylWzkoy8L9qj8VsYKS2VPFrk=;
        b=BdezOjgt9ajlrtAeZmD/14r+oWp6BJi6KjQMhLxsxLz6p5s65J1BOlhqCYLC1Zy+An
         Nfbhcw/H2I7t6Ow0f0Hk/M7Eiqibfo9ZHiHCb3Uh0kxOJ6DwLF+ViNPhIsWsTabk1uCD
         ofUmDZyNVIbD+whqsObOgCUV9IxSJ7OUwHtZCl7RjTaVS5MC5pP/SLZssdH5L3e2jwc4
         /z5A5qXK4BvT1gC8YkNKGBRl9Lr1qFC++HS6ecxMM6KnV63Lf1rYnTghVQI2+4Lmxw1/
         qAFthM2ts6+YzRnq+ilLQApAZxMuFMEidNxRLrZaGRB8JQY1kOy9t5Tiz+r7AVFrPcMx
         vZpA==
X-Gm-Message-State: AGi0PubYRQdk5Tgh/Ui62HnpMvi+if38Bsn0I0JBoe5DwITpy4yyexdu
        dSJqhTlvvQNNnpi153m/DPMKa2yw6/w=
X-Google-Smtp-Source: APiQypIp/afJjgxzI3CVCdt2szOWU7hkYXfTlXjhPpNFzUznyf3LevJOnYiuZD2TsjUyO4PJR7SzbQ==
X-Received: by 2002:a2e:98c3:: with SMTP id s3mr5574117ljj.6.1586362819559;
        Wed, 08 Apr 2020 09:20:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id i20sm3653271lfe.15.2020.04.08.09.20.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:20:17 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id g27so8220445ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:20:17 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr5516543lji.150.1586362816627;
 Wed, 08 Apr 2020 09:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200408155924.107722-1-peterx@redhat.com>
In-Reply-To: <20200408155924.107722-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 09:20:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjR=rtvm21=yP_1tqscXpOSEVpZaJ+oBAD8qU9ZKeZEWQ@mail.gmail.com>
Message-ID: <CAHk-=wjR=rtvm21=yP_1tqscXpOSEVpZaJ+oBAD8qU9ZKeZEWQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: Let __get_user_pages_locked() return -EINTR for
 fatal signal
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 8:59 AM Peter Xu <peterx@redhat.com> wrote:
>
> __get_user_pages_locked() will return 0 instead of -EINTR after commit
> 4426e945df588 which added extra code to allow gup detect fatal signal
> faster.  Restore that behavior.

I've applied this, but it's worth noting that
__get_user_pages_locked() can still return 0 in other situations.

I realize that "I got zero pages" is a valid return value, but I do
wonder if we should make the rule be that a zero return value isn't
possible (return -EAGAIN or whatever if you doin't have the
EFAULT/EINTR conditions).

So that you'd always get either an error, or a successful number of pages.

The only case where __get_user_pages_locked() might return zero is if
you pass in a zero 'nr_pages', although I suspect even for that case
returning -EINVAL might be a better option.

Anyway, this is not a new issue, but I thought I'd mention it.

             Linus
