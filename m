Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727EF2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDMwtKQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGAABe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGAABd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:01:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A71C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:01:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j19so8010684ybj.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKc0i29ur8bZ3QP5tHtJmPHNVBdp2DJUaH455nkGk4s=;
        b=GDMwtKQ+H/jIvrSzz12y4L6SpqnTjq6z16AaR9iUU/G80hyILg7zCLy8m/9ECUJPcz
         /Jr4LSIFh0xiTXtiH4+dzVwzmNoC2mNW0f2ZwiHzBYeN2rnNPDFeVd7Q0cSynOMxPaar
         p64b73DOlTJf8SxO5xsnR9UsOUJVdYJQLM9yWP1WUZvCylChUXX67KJ8dKVtufyzq9rb
         5/N0moL9Yhk8Vh9rqWTyIHh9k+2jKEEByttbH1Ww166ld0CzLMdNTXHMobgYIA96gJOJ
         BT3GHsN0NTZS8qQONc/Z4oEU2ifY8LDigwIzT+wanKzBSNKD7DbZyIRT0Oy9FpFqJnBr
         Xjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKc0i29ur8bZ3QP5tHtJmPHNVBdp2DJUaH455nkGk4s=;
        b=VMAHR8653SuLjuex/oP+9Xf8wLKA5QFRTNtQjUdP/F29Kk1CoYf38OghX7DV+5myQl
         Tph5vfLom+54Jjy3deInk8DN3GMUgWPOrQ1ukbb1nF4n5abgkLzFrIRI741hmDzK4jbT
         ymS/7F9beDCo0INZ3Hd/GR6iPtbXe/TsoCDpo83BxeOJASC88qwFk9SCpBhW1aWP6tC4
         +E8F6YFyzVczOgJoGpyGvnaRiLiiVb+QvPlov5k1D+bJfwElouYzq7ab2Q67rgLi3chx
         mD8XBXEyOTTZ863rB54i7zRsyMhENde/C/5SPSaHveHbTlADB2aH0dmjG1B0deZVlVwl
         wsDQ==
X-Gm-Message-State: AOAM532xFS1RJCDtP2UKn+gQxk48SDcdkxmqO9yl1xtQklDevwDsnAlH
        FCFGr2S5rAHtCKDAKYnmL0hhMZjVwXDg0KaPsCk1LyW3ip8=
X-Google-Smtp-Source: ABdhPJzwiaAEoJlLUXgcx2Je5sfgdYP4Cc3XmW/lp0GaOLJvy1YnkiYPkJ/Z8tot1orkQMc/4IM9t5rSuo3ymSVkN9w=
X-Received: by 2002:a25:b7cc:: with SMTP id u12mr22675401ybj.173.1593561692346;
 Tue, 30 Jun 2020 17:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjEghg5_pX_GhNP+BfcUK6CRZ+4mh3bciitm9JwXvR7aQ@mail.gmail.com>
 <20200630.134429.1590957032456466647.davem@davemloft.net> <CANn89i+b-LeaPvaaHvj0yc0mJ2qwZ0981fQHVp0+sqXYp=kdkA@mail.gmail.com>
 <474095696.17969.1593551866537.JavaMail.zimbra@efficios.com>
 <CANn89iKK2+pznYZoKZzdCu4qkA7BjJZFqc6ABof4iaS-T-9_aw@mail.gmail.com>
 <CANn89i+_DUrKROb1Zkk_nmngkD=oy9UjbxwnkgyzGB=z+SKg3g@mail.gmail.com>
 <CANn89iJJ_WR-jGQogU3-arjD6=xcU9VWzJYSOLbyD94JQo-zAQ@mail.gmail.com>
 <CANn89iLPqtJG0iESCHF+RcOjo95ukan1oSzjkPjoSJgKpO2wSQ@mail.gmail.com> <416125262.18159.1593560661355.JavaMail.zimbra@efficios.com>
In-Reply-To: <416125262.18159.1593560661355.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 17:01:20 -0700
Message-ID: <CANn89iKjggLK8u=E-1guVUuvO4cV3JY4bXcw63We1rNqTyWixA@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 4:44 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jun 30, 2020, at 6:38 PM, Eric Dumazet edumazet@google.com wrote:
> [...]
> >
> > For updates of keys, it seems existing code lacks some RCU care.
> >
> > MD5 keys use RCU for lookups/hashes, but the replacement of a key does
> > not allocate a new piece of memory.
>
> How is that RCU-safe ?
>
> Based on what I see here:
>
> tcp_md5_do_add() has a comment stating:
>
> "/* This can be called on a newly created socket, from other files */"
>
> which appears to be untrue if this can indeed be called on a live socket.

"This can be called" is not the same than "this is always called for
newly created socket"

>
> The path for pre-existing keys does:
>
>         key = tcp_md5_do_lookup_exact(sk, addr, family, prefixlen, l3index);
>         if (key) {
>                 /* Pre-existing entry - just update that one. */
>                 memcpy(key->key, newkey, newkeylen);
>                 key->keylen = newkeylen;
>                 return 0;
>         }
>
> AFAIU, this works only if you assume there are no concurrent readers
> accessing key->key, else they can see a corrupted key.

This is fine.

>
> The change you are proposing adds smp_wmb/smp_rmb to pair stores
> to key before key_len with loads of key_len before key. I'm not sure
> what this is trying to achieve, and how it prevents the readers from
> observing a corrupted state if the key is updated on a live socket ?



By definition if you change the MD5 key on a socket while packets are
flying, the incoming packet could either

1) See old key (packet is dropped)
2) See new key.

So any other decision (catching intermediate state) is really not an
issue, since you already accepted the fact that a packet could be
dropped,
and TCP will retransmit.

TCP MD5 implementation does not support multiple keys  for one flow,
you can not have both old and new keys being checked.


>
> Based on my understanding, this path which deals with pre-existing keys
> in-place should only ever be used when there are no concurrent readers,
> else a new memory allocation would be needed to guarantee that readers
> always observe a valid copy.

This is not _needed,_ and since memory allocations can fail, we would
potentially break applications
assuming that changing MD5 key would never fail.

Patch has been sent for review on netdev@ (
https://patchwork.ozlabs.org/project/netdev/patch/20200630234101.3259179-1-edumazet@google.com/
)
