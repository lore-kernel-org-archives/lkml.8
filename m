Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E395C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5275420732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586545557;
	bh=eo9HIM5fkOml4DJlITg3YEH7fOeeposL9DFP8Du1qD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VsXoGBs8BitgPxJz1ubCHbuSFK2R2+tgUwR96lKeEK7nbkcDsNU2ux3qHLBxq4Ibg
	 lpmXZOfkVJmTRJ8v2QSvBcVP18EodtUq0Z+7+zMaIEqeCd7f3j3D3ccvMGLZEr4wB4
	 6aptuU4gUFxT+Rd/e/Ooyrd2jfLEZFMy4pviOvwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDJTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:05:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43190 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:05:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id k28so2006440lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J5EMpM4EF1j6KffEA8iQohBq/zjP9lyAeKlJpdX8P8k=;
        b=hQDq56Vp44fMrC+tHAbqfTbg1Y4o/XEtFgVj2gyrOGs+hdNYdpj4wyaOsPUMGeY4B7
         H1wBtwF9gZPGhbYXCYk+8W3TC4ZnVWvhUDrRJgRLQNtvLQMxUsK07fgmNNb93GyEpMwH
         oWJ+bs3mFDkDDDfvbElv6jCAW4wPXxkduklPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J5EMpM4EF1j6KffEA8iQohBq/zjP9lyAeKlJpdX8P8k=;
        b=axC9SDGJGUOzXel4ih9h9tTdmML9JwxZoG5pUKY4AImV2O1xSOMTwLG/9BNiVzM/1p
         pV4YFbANc4hrYaTbPIJjK8NknXuEhYwm/dppl7d4czDdbrNIZ4hkncoDhitXoyulomLQ
         A6gZ+VWLfJ4caux8FO/SZwHF9MCbFj7Fb66JXR1RFTRN2WKJxaVtbyj+H7hgTEAZs1TK
         M6iMKXaychTVZth8ymt3EWO7vVv/ul57NS6Au95b9KVEpLKANRGUo5gsupiFWXILdTcv
         /blUnKRNSCnQlHxb7xtqBxCxnaxfFZ92qPOFQ+zkitJx4lKcAfQjRtWhRj0xUAReUp2r
         hLQg==
X-Gm-Message-State: AGi0PuZKYws3QLOsEISJdM6XG5iH2qqGVV3TaDm2sm/DI7+QdMBoS93E
        W8OZwaDWF9pz/lkA5iK8ibkYetgEIDA=
X-Google-Smtp-Source: APiQypJzae9w5+E7gKN0MchnvNKhEWnZH1FpEjOdR0y4C4YDA5/W8F3in5rdzyqfbq4Q6N7P/QlxLQ==
X-Received: by 2002:ac2:4859:: with SMTP id 25mr3400404lfy.59.1586545550548;
        Fri, 10 Apr 2020 12:05:50 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e7sm2270989lfc.72.2020.04.10.12.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:05:49 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q19so2873578ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:05:49 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr3922433ljj.265.1586545548920;
 Fri, 10 Apr 2020 12:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200410132706.170811b7@canb.auug.org.au> <27c212c4-b522-561d-411c-e74dc0ff0b74@infradead.org>
 <CAHk-=wjhsM-n_NzSh=cSdpThX+62-x3EmyKjhMqGHFYEyG0nPg@mail.gmail.com> <2b0f5d2e-3fe5-10c9-2a9a-9a0b341a52d5@infradead.org>
In-Reply-To: <2b0f5d2e-3fe5-10c9-2a9a-9a0b341a52d5@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Apr 2020 12:05:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXZSPPWzPs=KBDsLZWuq8qO=9qWfiKHw=yV10fFrDv9Q@mail.gmail.com>
Message-ID: <CAHk-=wjXZSPPWzPs=KBDsLZWuq8qO=9qWfiKHw=yV10fFrDv9Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 10 (lib/test_printf.ko)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 11:29 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> > I wonder if these scripts aren't well enough known, I see a lot of raw
> > dumps that could be immensely improved with a little scripting - but
> > they need the original vmlinux binary with debug info, so you can't do
> > it after-the-fact somewhere else..
>
> [I found the script's help output not so helpful.]

Heh.

I think the bigger problem is that decode_stacktrace.sh is probably
hardly mentioned anywhere.

It's been around for 6 years by now, but I guess we never really
advertised it. I end up mentioning it every few months to people when
their stack traces look particularly complex (particularly if the
function at some point goes through 5 levels of inlining and it's
really hard to even find what could possibly be the offending
instruction).

Yours wasn't actually so bad, and I don't think decode_stacktrace ends
up being a big deal in this case (and I find the line numbers less
than useful since this is about linux-next).

But even dump_stack.sh can't sort out how it got from test_printf_init
to software_node_unregister_nodes even though it usually is good about
following all the inlining (in this case selftest -> test_pointer ->
fwnode_pointer).

That may be because of something like a DEBUG_INFO_REDUCED option.

> [  561.071144] _raw_spin_lock_irqsave (linux-next-20200410/rdd64/../inclu=
de/linux/instrumented.h:71 linux-next-20200410/rdd64/../include/asm-generic=
/atomic-instrumented.h:695 linux-next-20200410/rdd64/../include/asm-generic=
/qspinlock.h:78 linux-next-20200410/rdd64/../include/linux/spinlock.h:194 l=
inux-next-20200410/rdd64/../include/linux/spinlock_api_smp.h:119 linux-next=
-20200410/rdd64/../kernel/locking/spinlock.c:159)
> [  561.074868] ? _raw_write_unlock_bh (linux-next-20200410/rdd64/../kerne=
l/locking/spinlock.c:158)
> [  561.078495] ? ida_destroy (linux-next-20200410/rdd64/../lib/idr.c:538)
> [  561.082144] ida_free (linux-next-20200410/rdd64/../lib/idr.c:495 (disc=
riminator 2))
> [  561.085694] ? fprop_new_period.cold (linux-next-20200410/rdd64/../lib/=
idr.c:486)
> [  561.089228] ? kasan_slab_free (linux-next-20200410/rdd64/../mm/kasan/c=
ommon.c:466)
> [  561.092738] ? kfree (linux-next-20200410/rdd64/../mm/slub.c:1478 linux=
-next-20200410/rdd64/../mm/slub.c:3035 linux-next-20200410/rdd64/../mm/slub=
.c:4003)
> [  561.096183] software_node_release (linux-next-20200410/rdd64/../includ=
e/linux/list.h:132 linux-next-20200410/rdd64/../include/linux/list.h:146 li=
nux-next-20200410/rdd64/../drivers/base/swnode.c:613)
> [  561.099644] kobject_put (linux-next-20200410/rdd64/../lib/kobject.c:69=
7 linux-next-20200410/rdd64/../lib/kobject.c:722 linux-next-20200410/rdd64/=
../include/linux/kref.h:65 linux-next-20200410/rdd64/../lib/kobject.c:739)
> [  561.103109] kobject_del (linux-next-20200410/rdd64/../lib/kobject.c:62=
9)
> [  561.106457] kobject_put (linux-next-20200410/rdd64/../lib/kobject.c:69=
0 linux-next-20200410/rdd64/../lib/kobject.c:722 linux-next-20200410/rdd64/=
../include/linux/kref.h:65 linux-next-20200410/rdd64/../lib/kobject.c:739)
> [  561.109785] fwnode_remove_software_node (linux-next-20200410/rdd64/../=
drivers/base/swnode.c:784)
> [  561.113061] software_node_unregister_nodes (linux-next-20200410/rdd64/=
../drivers/base/swnode.c:721 (discriminator 2))
> [  561.116274] test_printf_init (linux-next-20200410/rdd64/../lib/test_pr=
intf.c:685 linux-next-20200410/rdd64/../lib/test_printf.c:688) test_printf

It does print out those multiple lines for some things, but doesn't
have the nice "inlined by XYZ" I sometimes see that makes it really
obvious.

So it ends up still just looking like ida_free -> _raw_spin_lock_irqsave.

Strange. But it's all the same freeing path:

> [  561.278921] Freed by task 1454:
> [  561.289528] kfree (linux-next-20200410/rdd64/../mm/slub.c:1478 linux-n=
ext-20200410/rdd64/../mm/slub.c:3035 linux-next-20200410/rdd64/../mm/slub.c=
:4003)
> [  561.292183] software_node_release (linux-next-20200410/rdd64/../driver=
s/base/swnode.c:624)
> [  561.294865] kobject_put (linux-next-20200410/rdd64/../lib/kobject.c:69=
7 linux-next-20200410/rdd64/../lib/kobject.c:722 linux-next-20200410/rdd64/=
../include/linux/kref.h:65 linux-next-20200410/rdd64/../lib/kobject.c:739)
> [  561.297501] kobject_del (linux-next-20200410/rdd64/../lib/kobject.c:62=
9)
> [  561.300154] kobject_put (linux-next-20200410/rdd64/../lib/kobject.c:69=
0 linux-next-20200410/rdd64/../lib/kobject.c:722 linux-next-20200410/rdd64/=
../include/linux/kref.h:65 linux-next-20200410/rdd64/../lib/kobject.c:739)
> [  561.302784] kobject_del (linux-next-20200410/rdd64/../lib/kobject.c:62=
9)
> [  561.305344] kobject_put (linux-next-20200410/rdd64/../lib/kobject.c:69=
0 linux-next-20200410/rdd64/../lib/kobject.c:722 linux-next-20200410/rdd64/=
../include/linux/kref.h:65 linux-next-20200410/rdd64/../lib/kobject.c:739)
> [  561.307914] fwnode_remove_software_node (linux-next-20200410/rdd64/../=
drivers/base/swnode.c:784)

so it at least superficially looks like software_node_release() might
be called twice.

Maybe the child node is released after the parent node - and the child
node seems to do the

        ida_simple_remove(&swnode->parent->child_ids, swnode->id);

and maybe it's that the parent->child_ids was already free'd by the
previous software_node_release() call? Do children not keep a refcount
to their parent, perhaps?

Somebody who knows the driver core thing needs to look at it. And
since I don't play with linux-next apart from checking when I pull, I
don't know what might have happened in this area..

Adding some driver core people to the cc.

                Linus
