Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D64520768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMfC0SRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:14:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74EC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 08:14:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id t15so11147034iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKTBim8KTV4YYSPcKr4lTz1ll7NO32DkOj8t7IHHcLM=;
        b=OMfC0SRvrBeXjj4WClZCp7FBrPwMiRg24Qq1pQ8QQR1s3+wC9byYLHIQdNlsmW2LOE
         nA8qD1MgJH+azoVMFeKNF13H6ZmDqmcq6c3G6bQCK0zCxO1fFs5qUwdUjRyP4yoJfF6R
         ThM9Eo4bod3FG/y64B7XL4G4AlwCqtKs8M5qBNIKjZ6n5Z13YypUItfsFC1qHQg1KqfN
         ErMv7ZvGIw9VfhoUOCmRzFWkBx77Zr82/29j6hqtQDStsyBSq91L9Bw1j5JqXFfIgEmL
         w2N+pSosGgOeyKXZWd8G9wFR4awDPjl7fkhpJmwoY3kHKqgxsKzhVUth7ZOKJc4AGXah
         i3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKTBim8KTV4YYSPcKr4lTz1ll7NO32DkOj8t7IHHcLM=;
        b=E50nHVVnSpMDy9b6PJFgAF3BfasIpCfreJYNgqpxPjZHfR0++UzrbYXObgPlKWuGVg
         TGQPvAgUwVhhaneyWvunWeSFVVxRpzfyaALcTIj0x5TML9+THO06Pn6+Ap9fwoco7ZP9
         QgJisQgMeEiYEI05sBsi7N6ny+Iwp39y+C78Io6jBXXqXerBKiQRlhB8/yHtnqvwQQsm
         f2AdPfLCeQVBrg0KgEPCL8V6Z3Ep34i1HpvACr5yhBsMlzXTEzijiYS10n/xHdNQCiUg
         +9WqrWCVjMnBg7ICEG40ewmzyD7GJM/yiB6T/qjqUwsgKGP1KvgaWWgqKPindPPMtzZ1
         WAag==
X-Gm-Message-State: AOAM531ZFdWHtCMd/hVN07LaOODQsmBsMf2o2JYQ4SHzP2DHYDa7fgIl
        psHZShCt1lJ4SHA3oHqwy9biHRkcn9cmrfuYjPSbKg==
X-Google-Smtp-Source: ABdhPJxtrAzyjhyQfi2P+J75BasSp3zQNNU33ONWMQHPXuUdsXEvXQk81EraFs9H1NVwsR4f9XlGB6Rzl/9BMA1PU0I=
X-Received: by 2002:a5e:df42:: with SMTP id g2mr2488843ioq.117.1597418051772;
 Fri, 14 Aug 2020 08:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <6e3bace9ebea4f59a567a9ab0ef85d90@huawei.com>
In-Reply-To: <6e3bace9ebea4f59a567a9ab0ef85d90@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Aug 2020 08:14:00 -0700
Message-ID: <CANn89iKgM6KbMFh8z2inQrWwZS7AEF9Meujad89WfY-gZvXDgQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: Fix potential deadloop in skb_copy_ubufs()
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "jeremy@azazel.net" <jeremy@azazel.net>,
        "mashirle@us.ibm.com" <mashirle@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:14 AM linmiaohe <linmiaohe@huawei.com> wrote:
>
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >On Thu, Aug 6, 2020 at 1:48 PM linmiaohe <linmiaohe@huawei.com> wrote:
> >>
> >> From: Miaohe Lin <linmiaohe@huawei.com>
> >>
> >> We could be trapped in deadloop when we try to copy userspace skb
> >> frags buffers to kernel with a cloned skb:
> >> Reproduce code snippet:
> >>         skb = alloc_skb(UBUF_DATA_LEN, GFP_ATOMIC);
> >>         clone = skb_clone(skb, GFP_ATOMIC);
> >>         skb_zcopy_set_nouarg(clone, NULL);
> >>         pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
> >>
> >> Catch this unexpected case and return -EINVAL in skb_orphan_frags()
> >> before we call skb_copy_ubufs() to fix it.
> >
> >Is this a hypothetical codepath?
> >
> >skb zerocopy carefully tracks clone calls where necessary. See the call to skb_orphan_frags in skb_clone, and the implementation of that callee.
> >
> >The only caller of skb zerocopy with nouarg is tpacket_fill_skb, as of commit 5cd8d46ea156 ("packet: copy user buffers before orphan or clone").
> >
> >As the commit subject indicates, this sets skb_zcopy_set_nouarg exactly to be sure that any clone will trigger a copy of "zerocopy"
> >user data to private kernel memory.
> >
> >No clone must happen between alloc_skb and skb_zcopy_set_nouarg, indeed. But AFAIK, none exists.
>
> Since we always call skb_orphan_frags in skb_clone, is it unnecessary to call skb_orphan_frags in pskb_expand_head when skb is cloned ?

Please give us a real case.

I fear that your patches are coming directly from some kind of
automated tool, that really misses how the code is really used
from _current_ code base, not _hypothetical_ one.

This is very time consuming. Please provide evidence first.

Thank you.
