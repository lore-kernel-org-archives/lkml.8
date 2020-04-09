Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6634D2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586449974;
	bh=DYwppOLwkfPa4XgwiQTeHVsrktiIcUD7bj7mMKlJKQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=me5Me4V7cS9RzYm0H8zDLYpAgzbX85MWxjVXtsz1RLm0JiLaZwlk1XwdTnXKfgI1G
	 7bfbxDjycQ9zp2hd5/ficE9s5IdMrDHbtdz7WyL4UbcmtYT4h2WdJhgbYIwU1bIimx
	 soitm+F0GPAjwudc0plgTPeqrH+DVURiHwG32GLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDIQcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:32:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41286 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDIQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:32:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id n17so306330lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC7kYJwRVzKHnxfAJY+zhOS/4IxZ14gUH4Q28+oWVVU=;
        b=FN70qft0JxfpeYALHYDqEd3xGP4+0u0HEjyJLNo79lStaWLbzv3Pcrd7GYQ8RZEd5N
         vlx0SX3NJL6lLlrGhUq5KKBbqWNS4G66iVTZEAvPYtKGSuNEJvo4jbc+ed1Ie4H/PR4v
         kOpubErh88uFgUpLN+EKdwc3Va5WTKhYVDkeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC7kYJwRVzKHnxfAJY+zhOS/4IxZ14gUH4Q28+oWVVU=;
        b=bKNEbBWrDUjIX1Qz4stUyXrfW5kL591B4KWmlsS8aNVpMC67t0yEGqXqO8O/ifC3Yj
         m/6CROigOBTlzvcvbfR3x2Bt5CI1+kiw4D+5l2Ez3oEkoiaxRnHeK9IsaJOzr1FblVlG
         oP2VIGZ9guOLlQVyxk3gMxz7q2flKRzPe7HuFILk596Hp0MH5dyRi0uF0KWw5Wnh2GCd
         wIf1D9Pcie5WbAWX+jQIPzbSaOIanYJwas+qKg+27raQGKu5P5ObFmnd/gZuwutV0dNo
         tHnwoPvI/FplJyuK1MjYicIbN1jimQFr+ddGnZgy1c7ObHoac0QrX2G/THWtjikq3iqU
         xtmA==
X-Gm-Message-State: AGi0PuaN8wY8UIR1m0PKuZh3Py1m8sfDo33hV7E2+q39ItEdCBXpm3qk
        4GBkPsgjrOHLBWsYHI/SbDUEnvFMFRo=
X-Google-Smtp-Source: APiQypIpYRWiPVf006NhZVRtKomAoLqBDGVuyXreL9m8ZWy6J10oXfQimK+kbM9cMhbI/sVTsaPKpQ==
X-Received: by 2002:a2e:a362:: with SMTP id i2mr398266ljn.52.1586449969917;
        Thu, 09 Apr 2020 09:32:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c4sm17573672lfg.82.2020.04.09.09.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:32:49 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t17so279470ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:32:48 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr370008ljj.265.1586449968616;
 Thu, 09 Apr 2020 09:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
In-Reply-To: <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 09:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
Message-ID: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 5:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> linux-next is boot-broken for more than a month and bugs are piling
> onto bugs, I've seen at least 3 different ones.
> syzbot can't get any working linux-next build for testing for a very
> long time now.

Ouch.

Ok, that's not good. It means that linux-next has basically only done
build-testing this whole cycle.

Stephen, Dmitry - is there some way linux-next could possibly kick out
trees more aggressively if syzbot can't even boot?

This merge window has seemed otherwise fairly smooth to me (famous
last words), and it's really sad how the nice page fault cleanups
ended up being such an ongoing pain when the problems _could_ have
been caught earlier. We started to get syzbot reports very quickly
after they got merged into my tree, so this is clearly something that
gets exercised well - but it would have been oh-so-much better if it
had gotten noticed in linux-next.

Kicking trees out of linux-next and making noise if they cause syzbot
failures might also make some maintainers react more..

                Linus
