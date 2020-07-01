Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B185EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A73F20748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKVnDFIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGADhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGADhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:37:04 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98BC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:37:04 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o4so11269999ybp.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3Jq5zLzpbl6Zv3uYHByFe0ZmS4s3FezoDHzT/nIYcQ=;
        b=MKVnDFITxci7XZwoiI2Qwlr/n6NcWOarH7ex0rhrRXAfYSXZBOstF2ROLvMxeiCDkc
         UvKCz9Vdfr3s6ws1b6KY39kujwl9Y+TbQTAKz56nj1bk/C9IF2K6EBy38VjZXAulUqWK
         AXJ4iNasKw/tA0z0uJKYC562PRFKvOkQYrCA1z5o3WqyeBxbM9+1OvbWg8a6pnJX07jK
         wYkVEeKcmJ5kTb8zi2yOJlT3dY3ns0Df9MbjnkETH48l7DsBe6CveAhPuY/etE2WmxRB
         CvSJ+ybMGJjV86LvWAFyYC/wRUypUW7ajimzh0ksVFxcPavrKl8HATU2xMMdOdfj2nPA
         hpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3Jq5zLzpbl6Zv3uYHByFe0ZmS4s3FezoDHzT/nIYcQ=;
        b=e5z+PcEJNuT+MU6Ys19SC1oZDImjFk2RNoMH+J++y71yLvBLwxpyDmrpq48ERUY+/N
         iAxGvD+mrqN/GHdq9hqXR3sTLyzHEIr7Omb/8kGJiY077KNa6enG2ys4atwzxxcER187
         bQvJs+LV7ryn2BIqHDS3a3jyS4bCUFIaB/o5zVodUN/dVkVMYGfaOFkTK9zDekH7kz0h
         jipelo5Xkgud64B5GHGVnX6+x5zMRKNu7MEmm0XueEbl9qpA18z3QNS0JT4ehdxJbM5D
         UIQxyuPLvAyTytO67JuZ2lHgqNNxSFVUow9GcE20NkdAyeVizdn8tntE/CsLlmCmdKyI
         /Uhw==
X-Gm-Message-State: AOAM5331h2WH85HzmXYasZBmmtiAolxFutbQP3+51iflRUmmwxmKYdeN
        RIR8eIplVOtRiXBBG+XZ3iaUxVBJ1p1fN6CqIF53Ew==
X-Google-Smtp-Source: ABdhPJzptl+ZwuKHWxBxEUKXN0tTbaalbFddIAtD50sheOjj7wa+/JmdyFI74aYBGH2qjkuBhjY6U5OjoVwYPi/KA6U=
X-Received: by 2002:a25:b7cc:: with SMTP id u12mr23794552ybj.173.1593574623004;
 Tue, 30 Jun 2020 20:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iLPqtJG0iESCHF+RcOjo95ukan1oSzjkPjoSJgKpO2wSQ@mail.gmail.com>
 <20200701020211.GA6875@gondor.apana.org.au> <CANn89iKP-evuLxeLo6p_98T+FuJ-J5YaMTRG230nqj3R=43tVA@mail.gmail.com>
 <20200701022241.GA7167@gondor.apana.org.au> <CANn89iLKZQAtpejcLHmOu3dsrGf5eyFfHc8JqoMNYisRPWQ8kQ@mail.gmail.com>
 <20200701025843.GA7254@gondor.apana.org.au>
In-Reply-To: <20200701025843.GA7254@gondor.apana.org.au>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 20:36:51 -0700
Message-ID: <CANn89iKnf6=RFd-XRjPv=qaU8P-LGCBcw6JU5Ywwb16gU2iQqQ@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:59 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Jun 30, 2020 at 07:30:43PM -0700, Eric Dumazet wrote:
> >
> > I made this clear in the changelog, do we want comments all over the places ?
> > Do not get me wrong, we had this bug for years and suddenly this is a
> > big deal...
>
> I thought you were adding a new pair of smp_rmb/smp_wmb.  If they
> already exist in the code then I agree it's not a big deal.  But
> adding a new pair of bogus smp_Xmb's is bad for maintenance.
>

If I knew so many people were excited about TCP / MD5, I would have
posted all my patches on lkml ;)

Without the smp_wmb() we would still need something to prevent KMSAN
from detecting that we read uninitialized bytes,
if key->keylen is increased.  (initial content of key->key[] is garbage)

Something like this :

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f111660453241692a17c881dd6dc2910a1236263..c3af8180c7049d5c4987bf5c67e4aff2ed6967c9
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4033,11 +4033,9 @@ EXPORT_SYMBOL(tcp_md5_hash_skb_data);

 int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct
tcp_md5sig_key *key)
 {
-       u8 keylen = key->keylen;
+       u8 keylen = READ_ONCE(key->keylen); /* paired with
WRITE_ONCE() in tcp_md5_do_add */
        struct scatterlist sg;

-       smp_rmb(); /* paired with smp_wmb() in tcp_md5_do_add() */
-
        sg_init_one(&sg, key->key, keylen);
        ahash_request_set_crypt(hp->md5_req, &sg, NULL, keylen);
        return crypto_ahash_update(hp->md5_req);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 99916fcc15ca0be12c2c133ff40516f79e6fdf7f..0d08e0134335a21d23702e6a5c24a0f2b3c61c6f
100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1114,9 +1114,13 @@ int tcp_md5_do_add(struct sock *sk, const union
tcp_md5_addr *addr,
                /* Pre-existing entry - just update that one. */
                memcpy(key->key, newkey, newkeylen);

-               smp_wmb(); /* pairs with smp_rmb() in tcp_md5_hash_key() */
+               /* Pairs with READ_ONCE() in tcp_md5_hash_key().
+                * Also note that a reader could catch new key->keylen value
+                * but old key->key[], this is the reason we use __GFP_ZERO
+                * at sock_kmalloc() time below these lines.
+                */
+               WRITE_ONCE(key->keylen, newkeylen);

-               key->keylen = newkeylen;
                return 0;
        }

@@ -1132,7 +1136,7 @@ int tcp_md5_do_add(struct sock *sk, const union
tcp_md5_addr *addr,
                rcu_assign_pointer(tp->md5sig_info, md5sig);
        }

-       key = sock_kmalloc(sk, sizeof(*key), gfp);
+       key = sock_kmalloc(sk, sizeof(*key), gfp | __GFP_ZERO);
        if (!key)
                return -ENOMEM;
        if (!tcp_alloc_md5sig_pool()) {
