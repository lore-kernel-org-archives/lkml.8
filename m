Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932BD2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJXH5kgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGACSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgGACR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:17:59 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C4EC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:17:59 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e197so7142744yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 19:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ3KRdyNKq0NjChcDS5Efh5/mojKWckJwK+l+KsphhM=;
        b=fJXH5kgAaIYzB9rvTW3U8j5fmccmSA2+BZfNUdfYIAtTuU56W7Y0oFU3fczx2+skFX
         0Jm11JvxZahtDz5DQF5DRP8qBedrTLySaMN8TKxxdRFNEz0vc3XOtEx5yOb2mWzEZrTj
         bnneqqERieACLYgpzOV3LEI2+4or2SnpV+9bZdt+nE1Q61ZZowJ1BzVAMJdS/zn+YqE1
         6PqJ+RDkkuB5TiDQiaK/XwClyG4Jp8BA5ss9XY9UStTr8e5p184j7g6VoNUaly9io3jX
         MD+FViLQmQsp0CjbZNld+lhsKFPu8hRdWZaiqEOlJYgJ9dPwV4s+gaDtVzTva3vsVHPD
         7FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ3KRdyNKq0NjChcDS5Efh5/mojKWckJwK+l+KsphhM=;
        b=L1yp95rrVayQ5lMbuUgz6tq+4eMIeFiYLOwpGI9opu20Id1MBuTdDJRQ1YxDFO4ZoE
         uFVqOkzuIawx558PHc+UtBmG4mnVx3o9gbZE6Slc5Es5eQJQRFhJGIgZGJURPiZXEtJY
         53AkL8JemIDbEXNgbBNe6Ad/x49/CMtDTmmd4I9tbd+9JdFrGykMb9jwOoPVMy0dKBGp
         4oaDuBvXr1SQMOjSv9RfGDarwF7R5Nx9oNMfHYgQ3sGtd4RnPiGqb+j/ndPOGjxWKORp
         uuZ2MexOG4XsfRTCfyNnFbjtSPJ5Hf+clpvL+yzBMuH2H7x5bbG11gM1kQgbPmSEBZrm
         RLbQ==
X-Gm-Message-State: AOAM532OvIHlJliRg978igNVYQJNIb+Xxky2DMlEt+cWIXYHhxLkcS3z
        eRqmePatyAxvxizSNdZ3VYI9TVt311hlPOwctIlrMr8bHSE=
X-Google-Smtp-Source: ABdhPJxb/7CdKcnOoMbFkhx1mIWpXPOIVNhLUOE+TiuUBaE3PllWXwaKAgIIzzFvXdXbDTh1SASNn48H5oBd2F6SqD8=
X-Received: by 2002:a25:ca4a:: with SMTP id a71mr17561581ybg.101.1593569878306;
 Tue, 30 Jun 2020 19:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iLPqtJG0iESCHF+RcOjo95ukan1oSzjkPjoSJgKpO2wSQ@mail.gmail.com>
 <20200701020211.GA6875@gondor.apana.org.au>
In-Reply-To: <20200701020211.GA6875@gondor.apana.org.au>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 19:17:46 -0700
Message-ID: <CANn89iKP-evuLxeLo6p_98T+FuJ-J5YaMTRG230nqj3R=43tVA@mail.gmail.com>
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

On Tue, Jun 30, 2020 at 7:02 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Eric Dumazet <edumazet@google.com> wrote:
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 810cc164f795f8e1e8ca747ed5df51bb20fec8a2..ecc0e3fabce8b03bef823cbfc5c1b0a9e24df124
> > 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -4034,9 +4034,12 @@ EXPORT_SYMBOL(tcp_md5_hash_skb_data);
> > int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct
> > tcp_md5sig_key *key)
> > {
> >        struct scatterlist sg;
> > +       u8 keylen = key->keylen;
> >
> > -       sg_init_one(&sg, key->key, key->keylen);
> > -       ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
> > +       smp_rmb(); /* paired with smp_wmb() in tcp_md5_do_add() */
> > +
> > +       sg_init_one(&sg, key->key, keylen);
> > +       ahash_request_set_crypt(hp->md5_req, &sg, NULL, keylen);
> >        return crypto_ahash_update(hp->md5_req);
> > }
> > EXPORT_SYMBOL(tcp_md5_hash_key);
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index ad6435ba6d72ffd8caf783bb25cad7ec151d6909..99916fcc15ca0be12c2c133ff40516f79e6fdf7f
> > 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1113,6 +1113,9 @@ int tcp_md5_do_add(struct sock *sk, const union
> > tcp_md5_addr *addr,
> >        if (key) {
> >                /* Pre-existing entry - just update that one. */
> >                memcpy(key->key, newkey, newkeylen);
> > +
> > +               smp_wmb(); /* pairs with smp_rmb() in tcp_md5_hash_key() */
> > +
> >                key->keylen = newkeylen;
> >                return 0;
> >        }
>
> This doesn't make sense.  Your smp_rmb only guarantees that you
> see a version of key->key that's newer than keylen.  What if the
> key got changed twice? You could still read more than what's in
> the key (if that's what you're trying to protect against).

The worst that can happen is a dropped packet.

Which is anyway going to happen anyway eventually if an application
changes a TCP MD5 key on a live flow.

The main issue of the prior code was the double read of key->keylen in
tcp_md5_hash_key(), not that few bytes could change under us.

I used smp_rmb() to ease backports, since old kernels had no
READ_ONCE()/WRITE_ONCE(), but ACCESS_ONCE() instead.
