Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CB8217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCrWK9fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgBNVw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:52:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45192 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNVw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:52:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so10565291otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfz71M/wdFurvbEGy7B2dsQgM4lhgzxbWoyk5L4uqZg=;
        b=oCrWK9faCv0eyCNkLHw7uqHtAPxK7shw63hdimWtDt1Z0/z/heha6UoXD+HQb5LFB6
         AT72xYfkh2cwCRfta4dPbxRTH9zaChSs5wmXq/Sa88WhzEXaXWURqRd3BnfyqTnMgqyJ
         feADgzXJNTIrayAEFAFvoQ1OiMQ9PYqhQA7HhT65EajieK0BLj0iGsvvzaCr4rQjnwzS
         OvinxUmAro358jWX0bhmBKbP1ebGn+iFBnvtlJPtLQfvBi4WE0z+zN0/BYDRarBlDdJy
         8Bcm6NKPBShaNu5Unkp6rFUZyngflBI5t85w/SbkiTZAakpsS0GPJZ1+DvzMwDcu4spv
         3jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfz71M/wdFurvbEGy7B2dsQgM4lhgzxbWoyk5L4uqZg=;
        b=EqRk1l+SW0RCex36v2qVPQFvf2yIGWADje9BB29T0w0GF6EXvZM7esi19QYpWLzXRH
         4Safn6D6y2PMThkyPb0HeNpLiUqFnfzypInQW14Yl/M+5cZfGzTpkIcBXkXPwzTzLanm
         QHl4Se9VbpvSvdtzGY/APpnStl6mHT/V448rga0cWQns7BRYAjpamLnUYEknMUYLcEYG
         ZWEvCngUbtxZ/SgE52wJoBU5afKRa9JbUylGhUVGcjznnxQ1WySmdvB0tghdBRE+ndke
         6/eqEAnadyAYogmkRAgoPyY6sfcfQc7kOPVPOA0O5x3yUf8YGwcoKeujraLghpxqWj+u
         IsiA==
X-Gm-Message-State: APjAAAXABm6pSDb4CpnHjJ4xA6aHVweSUMy2ykMOnR2sD/J57JnfaJlb
        xD9BAAOZOMBYkXGrgQ01gbiwNr80opIrRg3qTQcHJA==
X-Google-Smtp-Source: APXvYqwes6IDSgTZ+5dDGo6PkrHSOiVjFbV51t6Z5ISM9HZ58CtfnhEz5I51yjlbxeFhVVn4Sm9FGeIz9ygn1oGSUf8=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr3967181otq.191.1581717176988;
 Fri, 14 Feb 2020 13:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20200214071233.100682-1-shakeelb@google.com> <20200214214730.GA99109@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200214214730.GA99109@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 13:52:46 -0800
Message-ID: <CALvZod4sum32d_ujFrRFhBVrE6TmhHrwWu=LPX+mG0urD4w80w@mail.gmail.com>
Subject: Re: [PATCH] memcg: net: do not associate sock with unrelated memcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 1:47 PM Roman Gushchin <guro@fb.com> wrote:
>
> Hello, Shakeel!
>
> On Thu, Feb 13, 2020 at 11:12:33PM -0800, Shakeel Butt wrote:
> > We are testing network memory accounting in our setup and noticed
> > inconsistent network memory usage and often unrelated memcgs network
> > usage correlates with testing workload. On further inspection, it seems
> > like mem_cgroup_sk_alloc() is broken in irq context specially for
> > cgroup v1.
>
> A great catch!
>
> >
> > mem_cgroup_sk_alloc() can be called in irq context and kind
> > of assumes that it can only happen from sk_clone_lock() and the source
> > sock object has already associated memcg. However in cgroup v1, where
> > network memory accounting is opt-in, the source sock can be not
> > associated with any memcg and the new cloned sock can get associated
> > with unrelated interrupted memcg.
> >
> > Cgroup v2 can also suffer if the source sock object was created by
> > process in the root memcg or if sk_alloc() is called in irq context.
>
> Do you mind sharing a call trace?
>

Sure, see below. I added a dump_stack() in mem_cgroup_sk_alloc().

[  647.255327] CPU: 68 PID: 15859 Comm: ssh Tainted: G           O
 5.6.0-smp-DEV #1
[  647.255328] Hardware name: ...
[  647.255328] Call Trace:
[  647.255329]  <IRQ>
[  647.255333]  dump_stack+0x57/0x75
[  647.255336]  mem_cgroup_sk_alloc+0xe9/0xf0
[  647.255337]  sk_clone_lock+0x2a7/0x420
[  647.255339]  inet_csk_clone_lock+0x1b/0x110
[  647.255340]  tcp_create_openreq_child+0x23/0x3b0
[  647.255342]  tcp_v6_syn_recv_sock+0x88/0x730
[  647.255343]  tcp_check_req+0x429/0x560
[  647.255345]  tcp_v6_rcv+0x72d/0xa40
[  647.255347]  ip6_protocol_deliver_rcu+0xc9/0x400
[  647.255348]  ip6_input+0x44/0xd0
[  647.255349]  ? ip6_protocol_deliver_rcu+0x400/0x400
[  647.255350]  ip6_rcv_finish+0x71/0x80
[  647.255351]  ipv6_rcv+0x5b/0xe0
[  647.255352]  ? ip6_sublist_rcv+0x2e0/0x2e0
[  647.255354]  process_backlog+0x108/0x1e0
[  647.255355]  net_rx_action+0x26b/0x460
[  647.255357]  __do_softirq+0x104/0x2a6
[  647.255358]  do_softirq_own_stack+0x2a/0x40
[  647.255359]  </IRQ>
[  647.255361]  do_softirq.part.19+0x40/0x50
[  647.255362]  __local_bh_enable_ip+0x51/0x60
[  647.255363]  ip6_finish_output2+0x23d/0x520
[  647.255365]  ? ip6table_mangle_hook+0x55/0x160
[  647.255366]  __ip6_finish_output+0xa1/0x100
[  647.255367]  ip6_finish_output+0x30/0xd0
[  647.255368]  ip6_output+0x73/0x120
[  647.255369]  ? __ip6_finish_output+0x100/0x100
[  647.255370]  ip6_xmit+0x2e3/0x600
[  647.255372]  ? ipv6_anycast_cleanup+0x50/0x50
[  647.255373]  ? inet6_csk_route_socket+0x136/0x1e0
[  647.255374]  ? skb_free_head+0x1e/0x30
[  647.255375]  inet6_csk_xmit+0x95/0xf0
[  647.255377]  __tcp_transmit_skb+0x5b4/0xb20
[  647.255378]  __tcp_send_ack.part.60+0xa3/0x110
[  647.255379]  tcp_send_ack+0x1d/0x20
[  647.255380]  tcp_rcv_state_process+0xe64/0xe80
[  647.255381]  ? tcp_v6_connect+0x5d1/0x5f0
[  647.255383]  tcp_v6_do_rcv+0x1b1/0x3f0
[  647.255384]  ? tcp_v6_do_rcv+0x1b1/0x3f0
[  647.255385]  __release_sock+0x7f/0xd0
[  647.255386]  release_sock+0x30/0xa0
[  647.255388]  __inet_stream_connect+0x1c3/0x3b0
[  647.255390]  ? prepare_to_wait+0xb0/0xb0
[  647.255391]  inet_stream_connect+0x3b/0x60
[  647.255394]  __sys_connect+0x101/0x120
[  647.255395]  ? __sys_getsockopt+0x11b/0x140
[  647.255397]  __x64_sys_connect+0x1a/0x20
[  647.255398]  do_syscall_64+0x51/0x200
[  647.255399]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  647.255401] RIP: 0033:0x7f45464fcd50

> Also, shouldn't cgroup_sk_alloc() be changed in a similar way?
>

I will check cgroup_sk_alloc() too.

Thanks,
Shakeel
