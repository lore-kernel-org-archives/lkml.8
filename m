Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A4EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F51C2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595796110;
	bh=Di1F9IpUh186TW/q5MwgyFE08ckJfsk+JgXrpsi0Rk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2dQzlHzAXMTk8KCe6w9HmatKl3kfNDF2nvkWtI5ffaRieKcMzY+g3YmDFTN/IQYcE
	 TCmMaJQD8BuL8kRY0wv+All8AqI6ZN7FsUnWxYKIoDX3CFOfq9Vm5wlHXnmy5kYk5I
	 9PF522txx5LoPw9tfJvtoTPlqmFETa8kBRjBmfnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGZUlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 16:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgGZUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:41:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43BC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:41:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m15so7217076lfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMAqM19mk6Z9hrysbVvmXBiZmKyuJZ/Q/akYm6Ar5O8=;
        b=VgsUmhcZ3TmL8PgzB6o7dC+JS3frPjbw6MQDMCMiEzv9oMbMxuQYkleMes2lYNtFRX
         ZDWnCDaWTL+RvDudxDYAUTOCn1MqyzZQxhxZU0etSaJR+Qj6T+1p4T9CjrG6CK524+F5
         FyyAoED45cuGDWZQmmbxBFVESvc0nq6NlSqsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMAqM19mk6Z9hrysbVvmXBiZmKyuJZ/Q/akYm6Ar5O8=;
        b=Ay63IjnjUI1E7cQQEkSHRafFThuPkcsaLHj0IH2pE0EatIvxvSBT6R/aAXMT/5fUmw
         dlFMiuqiWFjqTdBMAhCOoYpnoNFdDiTk7i/gvxYgYAwjY9bLQRjwA87i6bUSeSDh4nZX
         XRwUedvg6B9RDoT1KsW0aUrBBq0xY7NPkxmvaL5VZJ3IQUIAYSu1gc6iLR6Htgb+IY0L
         ivynykM6fXATR2yFa88bNyzuC3k13tpRv5zh0FxxKLGGbnXyezlMt3hVseEepKxgqp/I
         B1zXg/HWtxFivLMxM7IxijbxLWrHDicNtwgSDQFyC/Bt8E5D1o60T0YcbF76iRVwBeES
         X4oA==
X-Gm-Message-State: AOAM533+TBAHZ/wQz3mkxqWrJOrOIz9wFChEx7UvYl0nYvTQpvpc1Ej2
        X75G0tENl2XtmHMBDg5765KNFYkQebM=
X-Google-Smtp-Source: ABdhPJwG3xLT4cxrllJJF/eyTTe0kettletngsUVVdPBxFdoSdN2gi/Z7FBku7JDWD0sbnNbryTLFA==
X-Received: by 2002:a05:6512:312b:: with SMTP id p11mr9458825lfd.202.1595796093988;
        Sun, 26 Jul 2020 13:41:33 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c14sm1955733ljj.112.2020.07.26.13.41.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 13:41:32 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id d17so15030446ljl.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:41:32 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr8304055ljj.102.1595796091999;
 Sun, 26 Jul 2020 13:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jul 2020 13:41:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+7Wk7BLmLiDkoNDBvMfoooDVEaLimDY+10Jr9jLKLZg@mail.gmail.com>
Message-ID: <CAHk-=wg+7Wk7BLmLiDkoNDBvMfoooDVEaLimDY+10Jr9jLKLZg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 1:30 PM Hugh Dickins <hughd@google.com> wrote:
>
> I've deduced nothing useful from the logs, will have to leave that
> to others here with more experience of them.  But my assumption now
> is that you have successfully removed one bottleneck, so the tests
> get somewhat further and now stick in the next bottleneck, whatever
> that may be.  Which shows up as "failure", where the unlock_page()
> wake_up_page_bit() bottleneck had allowed the tests to proceed in
> a more serially sedate way.

Well, that's the very optimistic reading.

As the optimistic and happy person I am (hah!) I'm going to agree with
you, and plan on just merging that patch early in the next merge
window. It may fix a real bug in the current trere, but it's much too
late to apply right now, particularly with your somewhat ambiguous
results.

Oleg's theoretical race has probably never been seen, and while the
watchdog triggering is clearly a real bug, it's also extreme enough
not to really be a strong argument for merging this out-of-window..

> The xhci handle_cmd_completion list_del bugs (on an older version
> of the driver): weird, nothing to do with page wakeups, I'll just
> have to assume that it's some driver bug exposed by the greater
> stress allowed down, and let driver people investigate (if it
> still manifests) when we take in your improvements.

Do you have the bug-report, just to google against anybody else
reporting something simialr>

> One nice thing from the comparison runs without your patches:
> watchdog panic did crash one of those with exactly the unlock_page()
> wake_up_page_bit() softlockup symptom we've been fighting, that did
> not appear with your patches.  So although the sample size is much
> too small to justify a conclusion, it does tend towards confirming
> your changes.

You win some, you lose some. But yes, I'll take that as a tentative
success and that the approach is valid.

Thanks,

               Linus
