Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1720CC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA02820771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587319220;
	bh=TpSGjLK6Os3XD9yctC02fA91I/meIQhSlAd8+qaXXv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PKuyX/zHigAkkoUxSP9Kz1emzI9Zycse/ph8xRmJJ+/Eq/Cf1ruQYW3G8Ft59Vj8u
	 m7RnjFx8YasBa4NITeVk2VnfFr3/8/m+gnSShWz+gEJO18UdJpZ8b9YzBQQzJfQTr0
	 JiIng+cCZApOK+HNV/JGvi1K+QGB1akj1jET33cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDSSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:00:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F39C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:00:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so7399755ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KquQ7eqJ5WxLr4ruGXMoT/FQZYgAagIrOw4D8jrNTS4=;
        b=b5UUF65TFhoiwY6dQWiWGe/vGQW+FgBnonYQnlUUCMjWlRU22RHod2dAIgJ3iz6fXV
         iHPKFSUyF0y9t9WsYQQ9kcB4/DxZHIV6ObTaC9u1rZW5FgGVn0mO6KxSqN3rfAPJuw14
         TD6cuXjvI56ndC599LrGWOU/QkG+aROAcxZTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KquQ7eqJ5WxLr4ruGXMoT/FQZYgAagIrOw4D8jrNTS4=;
        b=oEq5uVCjzFHNWbAXvFCJtcTIz97GmrFUZ5AVg2uSsKgnVBolQFLRVjSobLNNMhiPsH
         Js1cv7tUEER37JjYI9RSytbohDD0AAahNms1cr+6y68SQo3Z0ECx4gpLbjekiTNcRK0x
         VYkyDJ4Fm+ySdCxW6fwKxApBBtnj5pC21L4KQ6ef4XXRgHYvnT5VRsU2aAgX/iooJmNh
         W1OKEibviK23xKUXBU57n1eCHvzFABY/MKtxGzmdpqp+sHLoLFpDUO6gBP8S/t0XYeQS
         oL9MLt/r/E1dyBNEmNysg/ifGe4MOgRc3ed5H2HiqZ7x32lfpXCxKHM/TDWHCFZJpFQF
         FvoA==
X-Gm-Message-State: AGi0PuYP5PgHxE2G+wrXoFXQ9mTbBhut3vvI2Dx0LJXIqaQ/tLEIrUU/
        ahP5dE9yqsojnm6K07qBclpWMuv3m2g=
X-Google-Smtp-Source: APiQypLJGs7v5fbmZ7VI+iHnQMKIRVY+V2oCzwab2koy9w3vQBmwhLgl7kbqxJ0f/ILLMGXUfmyXtg==
X-Received: by 2002:a2e:8752:: with SMTP id q18mr7762621ljj.72.1587319216518;
        Sun, 19 Apr 2020 11:00:16 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c19sm7129570ljd.0.2020.04.19.11.00.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u6so7432051ljl.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr3316865lji.201.1587319215104;
 Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200417172556.217480-1-bgeffon@google.com>
In-Reply-To: <20200417172556.217480-1-bgeffon@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Apr 2020 10:59:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
Message-ID: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix MREMAP_DONTUNMAP accounting on VMA merge
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Sonny Rao <sonnyrao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:26 AM Brian Geffon <bgeffon@google.com> wrote:
>
> However, MREMAP_DONTUNMAP leaves that original portion in place which
> means that the VMA which was split and then remerged is not actually
> split at the end of the mremap.

I was waiting to hear others comment on this, but it's been very quiet.

The patch looks correct to me, and the explanation is great. I'm
inclined to just apply it.

HOWEVER.

I started looking at copy_vma(), and noticed that we seem to have
exactly one caller: move_vma().

So I do have a query: would it perhaps not be a good idea to simply
remove the "vma_merge()" call from copy_vma(), and do at the end of
move_vma() instead?

I don't hate this patch either, and I'll happily apply it if people
prefer this one, but before doing that I thought I'd ask whether maybe
instead of fixing up the mess made by vma_merge() that people didn't
think about, maybe we should fix it at the underlying source of the
problem?

Are there any advantages to merging early? Shouldn't the basic
principle be that we'd strive to always do the vma_merge() at the end
of an operation that might have generated a mergable sequence of
vma's?

               Linus
