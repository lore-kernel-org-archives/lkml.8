Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5475B20791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVon6Pb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGPCuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGPCuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:50:04 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:50:04 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id s20so2205513vsq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEKmkAw0uwcvvBEVpu10W/Sa5gQp5k7qXmo5AR9AurA=;
        b=FVon6Pb3ZKgtvlu6hExXOR+GxSVISq63TByCX4gSkKOhQlnbEzC4eSF6fOoXpDTtq0
         pQY3Vxm7slt/77qZ7EjB8PYM7R7tPC2UnR3whxkMhALBsJPZm2mtqNBNYJ50MId7sz/U
         VnFSnIlZpMtl294S/qgEb0x4zixD73XKt8NlreDpuTshjgFnl7ORvOC8c6e7j0POYBwS
         AyyyoLhV+/agwsr3q70DWj82Eymx6336qEJaKKGTYOvPmsSVlF4I4ZURExC+91VAkSYE
         8GCvhcqpaZV5yPhIUU4To8aSIbgvsvoMJhg0JwOeryqCUOrOUaBendC536fqgWMM5yGf
         ZwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEKmkAw0uwcvvBEVpu10W/Sa5gQp5k7qXmo5AR9AurA=;
        b=DySBwzwGqWHSzCAH7E2wk6KQPYvMsRvYV9hOnLeRYLWP+/yQ6rQBBa6RKl1HiteCBN
         0WJLZHlLdp0xWjJQ5G3ckthXC/6ZJt8HmzANnDQzJlDNXCufGXgY0D/OOrYlLqX21BxJ
         0QDbHX9+X8QGBNeFsB/riB8K2i8SbkTiAJ6Lx9uLw8595nwKczRos5KGQG0Bl4dQxIYe
         EeEjn6rCNa5/TBFlQFgn77bY+Tcfr0ov/dNwJGJueQQ0wwNxLibRkR9ckCPniq8lt7uA
         An+F6Xqp0oaY5p14do2xANG0DP3LDV5kXL8+bayiWEbHZqokLnEZgTL3kn0jbCkk9Una
         TkAw==
X-Gm-Message-State: AOAM530LTNhJVB8WOlkoQ4Pmzu86M9vvAeIDjXpK3oj7CnrKqqDK2Uev
        UHdN9f6U2ndzRXDvqt7+psmLe8Dwf85YHjuCN1khgA==
X-Google-Smtp-Source: ABdhPJwxCXQz0WoadyQHNKpsbOvxJMTRPicLoxVEytHah6x5/VcIKiVX4ciSJ6j/Gj2uPkLh6VB0DKXak2Z5ddYHgFM=
X-Received: by 2002:a67:6441:: with SMTP id y62mr1679674vsb.82.1594867803345;
 Wed, 15 Jul 2020 19:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000b5f9d059aa2037f@google.com> <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com> <20200714140859.15156-1-hdanton@sina.com>
 <20200714141815.GP24642@dhcp22.suse.cz> <CAHRSSEzbCW3E0QTR0ryf3p=5J5uhs_vY2D6fFQEzP=HeCDkPGQ@mail.gmail.com>
 <CAJuCfpExhJJO_xPk663-eUkmAXVVwNDd9a7ahQuwMW8JVMBJpg@mail.gmail.com>
 <CAJuCfpFz9kEfTPxcausVj63mUvU7i6Dvv6=KNePVX2qR+-Ci2A@mail.gmail.com> <20200715063639.GA5451@dhcp22.suse.cz>
In-Reply-To: <20200715063639.GA5451@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 15 Jul 2020 19:49:52 -0700
Message-ID: <CAJuCfpFFCtmbvjLWDLZ9_bpNq-iT2+1cfdkpEcGV5tFCnbd+5g@mail.gmail.com>
Subject: Re: possible deadlock in shmem_fallocate (4)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Todd Kjos <tkjos@google.com>, Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:36 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 14-07-20 10:32:20, Suren Baghdasaryan wrote:
> [...]
> > I'm not sure how we can annotate the fact that the inode_lock in
> > generic_file_write_iter and in shmem_fallocate always operate on
> > different inodes. Ideas?
>
> I believe that the standard way is to use lockdep_set_class on your
> backing inode. But asking lockdep experts would be better than relying
> on my vague recollection

Thanks Michal! I think https://lkml.org/lkml/2020/7/15/1390 should fix
it, however I was unable to reproduce the lockdep warning to confirm
that this warning gets fixed by the patch.

>
> --
> Michal Hocko
> SUSE Labs
