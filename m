Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D07DC5ACBF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356EF20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2GOS5ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCLOGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:06:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38669 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgCLOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:06:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id t28so3701860ott.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLTQ7SxBP998ZRyt/spl3MxmTSGFK+HueOsxsAmc57o=;
        b=Y2GOS5ow5Z2ATB76Xuh3T3CMKkXp5qVt41XsjiE6pQGBXTSgEBhbAcwXb717V9+AKw
         BElLgBjrApQXE7b61mevES4kmBQzO5+jLlw8D3cgtsqv9S+/TnzeISX8omqk9KnvdHT7
         FQNz7ALIo6NSVs2E53XNeu+8zDW2lTBi3ANGUB8w3Ua9XKJ321a/ob4BOnH7KF54D1+I
         OQrnmWRpMI72Y9SJgafKstMXjjOlNlCQwFFLXAt/X/6HyWc3C7nilLQ/4fmdMqlR8yUw
         B0dSA4kWeWY8mNa1qvZjcca/CLW12Cq5iYL86BkhalfzpghJPJMt7AsEr9Ie6WzpPR2B
         MnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLTQ7SxBP998ZRyt/spl3MxmTSGFK+HueOsxsAmc57o=;
        b=I9agI4lnU91KWlTIHAPWk7jKZPwIAjc1X0uIeI5YZ5sRcnjexLdkHCsg/7MT9cfcPc
         WztuFkTytgq14qUzwLTGbRH3Vpupe1YU0UmM8dvKyYRc4UOlnBr6tXoul5liDTb3IjRY
         yz8Rczb/PBGWNjLObTHdeg3tAtUiWDQod2/ob7NRzVawnfm51g3tLB/u8YJ7+UG+rx+E
         T4JFRtW+7GNh+Q5rPbJFske26oid5c+LgS9eqWCZ8kujEL/ZMSrKhev/8oJ5ekZjbL4w
         7/g+zTdRTW8PdDLbRnymzp7gTrjUJuXNUqpuNmfxPZE6w2xKh5L7mQbbJAcbPE1T/9mP
         2hRg==
X-Gm-Message-State: ANhLgQ0bB1CotKSULWi2wnLsiivSDhV65XL2Fy8yGT1lBXTydv0Fd8ft
        TfFMb7tSlJQXbjJ1Cv2jG1we8JsJYrRtxVi3Bvtykg==
X-Google-Smtp-Source: ADFU+vuAeU13QzGVA33BSC1Tpqr+aYm8tNHddgFpAfKTwXQWbSyNcgyhErv8/Luep3EXUE+e7LH6oja9a0UoqI403zE=
X-Received: by 2002:a9d:6c99:: with SMTP id c25mr6060360otr.124.1584021966391;
 Thu, 12 Mar 2020 07:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200310051606.33121-1-shakeelb@google.com> <20200310051606.33121-2-shakeelb@google.com>
 <1584021811.7365.180.camel@lca.pw>
In-Reply-To: <1584021811.7365.180.camel@lca.pw>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Mar 2020 07:05:55 -0700
Message-ID: <CALvZod4yOoskh8-MQw+JR0N78Ns+Gqvwcrmqm89DB1RTX0__=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] net: memcg: late association of sock to memcg
To:     Qian Cai <cai@lca.pw>
Cc:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 7:03 AM Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2020-03-09 at 22:16 -0700, Shakeel Butt wrote:
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index a4db79b1b643..65a3b2565102 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >               }
> >               spin_unlock_bh(&queue->fastopenq.lock);
> >       }
> > +
> > +     if (mem_cgroup_sockets_enabled) {
> > +             int amt;
> > +
> > +             /* atomically get the memory usage, set and charge the
> > +              * sk->sk_memcg.
> > +              */
> > +             lock_sock(newsk);
>
> Here we have a deadlock,

It's a missing lockdep annotation. Eric already has a patch in
progress to fix this and another typo in the original patch.

>
> [  362.620977][ T4106] WARNING: possible recursive locking detected
> [  362.626983][ T4106] 5.6.0-rc5-next-20200312+ #5 Tainted: G             L
> [  362.633941][ T4106] --------------------------------------------
> [  362.639944][ T4106] sshd/4106 is trying to acquire lock:
> [  362.645251][ T4106] 7bff008a2eae6330 (sk_lock-AF_INET){+.+.}, at:
> inet_csk_accept+0x370/0x45c
> inet_csk_accept at net/ipv4/inet_connection_sock.c:497
> [  362.653791][ T4106]
> [  362.653791][ T4106] but task is already holding lock:
> [  362.661007][ T4106] c0ff008a2eae9430 (sk_lock-AF_INET){+.+.}, at:
> inet_csk_accept+0x48/0x45c
> inet_csk_accept at net/ipv4/inet_connection_sock.c:451
> [  362.669452][ T4106]
> [  362.669452][ T4106] other info that might help us debug this:
> [  362.677364][ T4106]  Possible unsafe locking scenario:
> [  362.677364][ T4106]
> [  362.684666][ T4106]        CPU0
> [  362.687801][ T4106]        ----
> [  362.690937][ T4106]   lock(sk_lock-AF_INET);
> [  362.695204][ T4106]   lock(sk_lock-AF_INET);
> [  362.699472][ T4106]
> [  362.699472][ T4106]  *** DEADLOCK ***
> [  362.699472][ T4106]
> [  362.707469][ T4106]  May be due to missing lock nesting notation
> [  362.707469][ T4106]
> [  362.715643][ T4106] 1 lock held by sshd/4106:
> [  362.719993][ T4106]  #0: c0ff008a2eae9430 (sk_lock-AF_INET){+.+.}, at:
> inet_csk_accept+0x48/0x45c
> [  362.728874][ T4106]
> [  362.728874][ T4106] stack backtrace:
> [  362.734622][ T4106] CPU: 22 PID: 4106 Comm: sshd Tainted:
> G             L    5.6.0-rc5-next-20200312+ #5
> [  362.744096][ T4106] Hardware name: HPE Apollo
> 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  362.754525][ T4106] Call trace:
> [  362.757667][ T4106]  dump_backtrace+0x0/0x2c8
> [  362.762022][ T4106]  show_stack+0x20/0x2c
> [  362.766032][ T4106]  dump_stack+0xe8/0x150
> [  362.770128][ T4106]  validate_chain+0x2f08/0x35e0
> [  362.774830][ T4106]  __lock_acquire+0x868/0xc2c
> [  362.779358][ T4106]  lock_acquire+0x320/0x360
> [  362.783715][ T4106]  lock_sock_nested+0x9c/0xd8
> [  362.788243][ T4106]  inet_csk_accept+0x370/0x45c
> [  362.792861][ T4106]  inet_accept+0x80/0x1cc
> [  362.797045][ T4106]  __sys_accept4_file+0x1b0/0x2bc
> [  362.801921][ T4106]  __arm64_sys_accept+0x74/0xc8
> [  362.806625][ T4106]  do_el0_svc+0x170/0x240
> [  362.810807][ T4106]  el0_sync_handler+0x150/0x250
> [  362.815509][ T4106]  el0_sync+0x164/0x180
>
>
> > +
> > +             /* The sk has not been accepted yet, no need to look at
> > +              * sk->sk_wmem_queued.
> > +              */
> > +             amt = sk_mem_pages(newsk->sk_forward_alloc +
> > +                                atomic_read(&sk->sk_rmem_alloc));
> > +             mem_cgroup_sk_alloc(newsk);
> > +             if (newsk->sk_memcg && amt)
> > +                     mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> > +
> > +             release_sock(newsk);
> > +     }
> >  out:
> >       release_sock(sk);
> >       if (req)
