Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD05DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78E2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmeqDr3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgAYSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 13:13:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43144 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 13:13:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so2567734qvo.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E+cu/QJKN5uT8la7yZxdrY+Jr2Gm5Xc2nC3nhoLTrS8=;
        b=UmeqDr3LtDrnKxoURMJ2NVNttinEbKnApSiJ5hecVmoSYF+NNk33LGrN5gpKI8h1j5
         NiXJ+lhrh+TPUWIb4LPEvcRBR1isgyk+ns6dRIo+rQhYOV84VVRU5WtGJa/n1ANZunRr
         ZX0xqcQdgyCLin0wRfCHP+rag/viDDNJHXdzdvii4YmrQAy6Ciu45C9NL0axmcVXyGdh
         d1YU8KnvVqWruQhsitVxFu/ZND8SX6h0kn9V7+or2/Pio+OBh3jYEKTaof7f1I9RK9uq
         IHamWzTJG2KjHBY7FkUIUgVlzbSeaR7DLnsZvAr6dW9a1ruqJl786deHrrIsohzxo6XF
         w2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E+cu/QJKN5uT8la7yZxdrY+Jr2Gm5Xc2nC3nhoLTrS8=;
        b=CuM9vQaNXrklsieDDc1dCDyx92zpQrQqjkIfUphP35c/e95/Uc5c5eijFG+MtMDKEp
         nXl5BjO6M9QCVjWQe1uXeu7nO/IYVK8JcY23feol5IC5g+8BFUqDrrCVr+QzjTglKus/
         ztJo6sVF8H++0NDM9rCguLXI2fXFptm8SsJHi8uKBN81OXEm5mMGBEgHYRnU0HCbu9Ae
         C0F+qY88lEKFt0vc7B0PSu4+rME77nKenhrRMnyOI7D98SWvRGCGoVz3IOkfRB6l8HQH
         boz59SP1AvtDlrtn7+A1CsKG7pPGJ1Lh75aq/7pSS4rypQBWVITEpbt4avFHq4uLBFQ2
         87lA==
X-Gm-Message-State: APjAAAVSYow3wCGeD3mnu1mBdBjFvV9AV9sX/lQPFGu6lsJPet7Kzelw
        3emG3QI3oM258zMpsi7cbtXdexET4tTtXIdJ3l5bPA==
X-Google-Smtp-Source: APXvYqxm7T6ryNnPOvvufckliHZ/8tFmlEyft2z6YJr6twfkmfUd/0M4VFP/t19+493a+jP4pEDKyHxXqo68wyWg2k8=
X-Received: by 2002:a0c:ee91:: with SMTP id u17mr8846749qvr.22.1579975994183;
 Sat, 25 Jan 2020 10:13:14 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
In-Reply-To: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 25 Jan 2020 19:13:03 +0100
Message-ID: <CACT4Y+bckC4k-EpWiCkD+BBo5ypmkcb2g8Axb62LnBbwJjcqdw@mail.gmail.com>
Subject: Re: binderfs interferes with syzkaller?
To:     Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 6:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hi binder maintainers,
>
> It seems that something has happened and now syzbot has 0 coverage in
> drivers/android/binder.c:
> https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> It covered at least something there before as it found some bugs in binder code.
> I _suspect_ it may be related to introduction binderfs, but it's
> purely based on the fact that binderfs changed lots of things there.
> And I see it claims to be backward compatible.
>
> syzkaller strategy to reach binder devices is to use
> CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
> give each test process a private one):
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671
>
> Then it knows how to open these /dev/binderN devices:
> https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
> and do stuff with them.
>
> Did these devices disappear or something?

Oh, I see, it's backwards compatible if it's not enabled, right?

if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
    strcmp(binder_devices_param, "") != 0) {
/*
* Copy the module_parameter string, because we don't want to
* tokenize it in-place.
*/
device_names = kstrdup(binder_devices_param, GFP_KERNEL);
if (!device_names) {
ret = -ENOMEM;
goto err_alloc_device_names_failed;
}

device_tmp = device_names;
while ((device_name = strsep(&device_tmp, ","))) {
ret = init_binder_device(device_name);
if (ret)
goto err_init_binder_device_failed;
}
}

And we enabled it because, well, enabling things generally gives more
coverage. I guess I will disable CONFIG_ANDROID_BINDERFS for now to
restore coverage in the binder itself.
