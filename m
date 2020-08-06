Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E7F221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC7prWFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgHFR2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgHFRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:28 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A9C061A2B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:26:36 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id d20so4258169ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENhodf2YoBg1Pmsfjazaz/7CkxNbPH+EsWhjLL6Mz5A=;
        b=QC7prWFPCRV++k6goOsc8GWMtgQPqd9JxDIp4XUlR+Fyr283M++afQrf7AAWOAmF3o
         HKKC2CP0NgoqF0ByInagurjybL1pic7EwqN9flQcd9bT2C1R1Wng+uBy4A/2OHyikrOu
         D3NW9SAee5kn/dv9QwzytpUFFisgpUtv8KswkBDpxnCcB4IiULkVC6f+zuFitfePEwsm
         lyCRR9RXn9qC8EptXYgNA3WtjmZ9lxM7GAUjWf1LAZ6EgKIeutCyepkZS0n3/4ure6nL
         lJJH2mhtSB/9KI4Spictb/CWwLX4qnQHRfuLg9LdJh3psSlU8Fhkxjv+wTfO9mmQi+re
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENhodf2YoBg1Pmsfjazaz/7CkxNbPH+EsWhjLL6Mz5A=;
        b=VO654QAi9PwbXqaU1JoNARENy8H7DXz10oLAugYxZ9P+S/yFDwJUMhBngsY6B2Iium
         uP8kjY5LyZSeTU7Syyd/Nv7YFwVPgHZkJhApvYKbyhg6d9TDb7f+I7+b8XDGS/Ls1VEX
         /+2BHNBmC+2fKX7ne1nBu6KWVu8bOcZb9GsRG7qlxlcmAWyzUO39gIuJv0eMzzfJMYtB
         vVrnfzK5jJV6XQp9IWdBv8E/lqPShG2XGl1iB0czJN0NxogSFYHdAESg8bTk/u0Dgbtx
         Btl/ca7wpIj7JwFjUcLw7nYnUTYRIPA9Fi/dPCbfoSuAf/hd02QTSyFOw5oF28l6gX14
         sNLg==
X-Gm-Message-State: AOAM531R7OVZGas6A6hTghezeQWGXKaPzNeWVFIeIeFhjw7V1c5WIkcc
        SPa98hCUxNRAIbkWhqI54/XqHqS26HI=
X-Google-Smtp-Source: ABdhPJwJ9pKO1JuKQBxAo4IZYdWwSz0Tnj6YA2vBozU9lYG+byjbp/adagVIMskb8Ff45YaI1tN1iA==
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr5818327uay.15.1596716792798;
        Thu, 06 Aug 2020 05:26:32 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id p5sm997315vkp.44.2020.08.06.05.26.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:26:32 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id b26so19503600vsa.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 05:26:32 -0700 (PDT)
X-Received: by 2002:a67:bb06:: with SMTP id m6mr6268521vsn.54.1596716791730;
 Thu, 06 Aug 2020 05:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1596714642-25183-1-git-send-email-linmiaohe@huawei.com>
In-Reply-To: <1596714642-25183-1-git-send-email-linmiaohe@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 6 Aug 2020 14:25:54 +0200
X-Gmail-Original-Message-ID: <CA+FuTSf48QvUhzmUROmSe-3W_H-FuCigq8Rg7otB0-XprDu6-A@mail.gmail.com>
Message-ID: <CA+FuTSf48QvUhzmUROmSe-3W_H-FuCigq8Rg7otB0-XprDu6-A@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: Fix potential deadloop in skb_copy_ubufs()
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, rdunlap@infradead.org,
        decui@microsoft.com, Jakub Sitnicki <jakub@cloudflare.com>,
        jeremy@azazel.net, mashirle@us.ibm.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:48 PM linmiaohe <linmiaohe@huawei.com> wrote:
>
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> We could be trapped in deadloop when we try to copy userspace skb frags
> buffers to kernel with a cloned skb:
>
> [kbox] catch panic event, panic reason:kernel stack overflow
> [kbox] catch panic event, start logging.
> CPU: 3 PID: 4083 Comm: insmod Kdump: loaded Tainted: G       OE  4.19 #6
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>         dump_backtrace+0x0/0x198
>         show_stack+0x24/0x30
>         dump_stack+0xa4/0xcc
>         kbox_panic_notifier_callback+0x1d0/0x310 [kbox]
>         notifier_call_chain+0x5c/0xa0
>         atomic_notifier_call_chain+0x3c/0x50
>         panic+0x164/0x314
>         __stack_chk_fail+0x0/0x28
>         handle_bad_stack+0xfc/0x108
>         __bad_stack+0x90/0x94
>         pskb_expand_head+0x0/0x2c8
>         pskb_expand_head+0x290/0x2c8
>         skb_copy_ubufs+0x3cc/0x520
>         pskb_expand_head+0x290/0x2c8
>         skb_copy_ubufs+0x3cc/0x520
>         pskb_expand_head+0x290/0x2c8
>         skb_copy_ubufs+0x3cc/0x520
>         pskb_expand_head+0x290/0x2c8
>         skb_copy_ubufs+0x3cc/0x520
>         ...
>         pskb_expand_head+0x290/0x2c8
>         skb_copy_ubufs+0x3cc/0x520
>         ...
>
> Reproduce code snippet:
>         skb = alloc_skb(UBUF_DATA_LEN, GFP_ATOMIC);
>         clone = skb_clone(skb, GFP_ATOMIC);
>         skb_zcopy_set_nouarg(clone, NULL);
>         pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
>
> Catch this unexpected case and return -EINVAL in skb_orphan_frags() before
> we call skb_copy_ubufs() to fix it.

Is this a hypothetical codepath?

skb zerocopy carefully tracks clone calls where necessary. See the
call to skb_orphan_frags in skb_clone, and the implementation of that
callee.

The only caller of skb zerocopy with nouarg is tpacket_fill_skb, as
of commit 5cd8d46ea156 ("packet: copy user buffers before orphan or
clone").

As the commit subject indicates, this sets skb_zcopy_set_nouarg
exactly to be sure that any clone will trigger a copy of "zerocopy"
user data to private kernel memory.

No clone must happen between alloc_skb and
skb_zcopy_set_nouarg, indeed. But AFAIK, none exists.
