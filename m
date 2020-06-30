Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E3620780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="uWbdZD5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgF3XLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgF3XLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:11:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F142C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:11:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so13748869wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60A/ztCtbleXmn8nw4N8D3f/1EaxzEfXsB1qFiYpLKI=;
        b=uWbdZD5KdcFt4170VI6Ty93eDyVCXrqF0d6dLsxjSLpkjfj59veQeCHNd4SnziymWZ
         P83M8X/+GKaatEgb/8EGNPuBWcCpd+5giYAVVqpZpPtdtLrSDKxplZ7j7CquKXQE4rBK
         DizWuJR4bvnelLMmNqxRVFAjcqGch4LVWPUeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60A/ztCtbleXmn8nw4N8D3f/1EaxzEfXsB1qFiYpLKI=;
        b=Mxv8IgnXPLjN6DcrkjWzlemFqX5BRmEjCI8xHgIYuPr2ZuJgLmu0nuA2W514O9TLXH
         xpDPeiSmilSwDI7/bk4PqfXAeDMD21mZ1EVyPSVxVKyB3ts3eLuaYsNVuiyu6FZD9wvX
         yImQUcBssUTKDUSxCut/r8DIWsvhoU7ifo74YXUhYCaNmB6v+xqvRQ7YaNsVGr6/fiAq
         DekMMJlPzc0VmF/OSOg3y1fMnwi7yQJ7U8kQf26e/uzxW2kAHOv1aa8WNd4K8KjfSBdm
         DAkwAT6bYzzI0a9uk2mnLyJeF/5oMVRErRlWoon74lzFfjkeIqoZMg4ZRHQ3XlgyIrNk
         xw7w==
X-Gm-Message-State: AOAM5304LGNRm09z/E1UiF2FIZuOuk5+v14lDNSfBuY0c51jfGBeHld5
        7LcCtRGRdc2WJYeUAlMdwq6GjriKuyXOs2T1bl3lHyvw1rAR6A==
X-Google-Smtp-Source: ABdhPJzh4UBEmvPEiISxqLnsveDB5qbxD+s+32qFrlOaYhpioFYbSMwTtn0KTpiY4Ngbr8KgsXcTmbOL68C023dM8Us=
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr23427437wrr.354.1593558702790;
 Tue, 30 Jun 2020 16:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200624212319.403689-1-ignat@cloudflare.com> <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
In-Reply-To: <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 1 Jul 2020 00:11:31 +0100
Message-ID: <CALrw=nGOnz0St1j6fyMJWeZicdBjsbXA54A==3XUigN7kMAXQA@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:47 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 2:23 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.
> >
> > This change is too restrictive. I've been running UML statically linked kernel
> >  with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
> > As long as we don't reference network peers by hostname and use only IP
> > addresses, NSS is not needed, so not used. In other words, it is possible to
> > have statically linked UML and UML_NET_VECTOR (and other networking types) and
> > use it, although with some restrictions, so let's not disable it.
> >
> > Additionally, it should be at least theoretically possible to use another libc
> > (like musl, bionic etc) for static linking. I was able with some hacks to
> > compile UML against musl, although the executable segfaults for now. But this
> > option prevents even the research to be done.
>
> The reason that we removed support for static linking when these
> networking options are enabled is because gcc doesn't support loading
> NSS when statically linked, which consequently breaks allyesconfig for
> UML under gcc. That is still the case with your revert.

Yes, sure. But I'm not only "researching", but using UML as a "router"
in one of my dev setups. 3363179385629c1804ea846f4e72608c2201a81e
mentions UML_NET_VECTOR incompatibility (and some other networking
options), which I had enabled and actually my whole dev networking is
based around UML_NET_VECTOR: I have two interfaces - one in raw mode
and one doing ipsec. All this was running in an empty "FROM: scratch"
container and obviously linked statically.

If the static linking breaks some other config options in allyesconfig
- that's another story, but I wanted to point out that config options
mentioned in the commit message worked just fine (if not trying to
resolve hostnames). In other words: if you don't resolve - glibc will
not try to load NSS. glibc-nss is a known problem and I would assume
most people trying to do static linking are aware of this - that is,
if they choose this path they are willing to live with the
consequences. That's why completely disabling the possibility sounds
too restrictive for me.

> I fully support the goal behind what you are trying to do. However, I
> do not want to see this patch accepted unless it is accompanied by an
> alternative change that still allows UML to compile under
> allyesconfig.

If I succeed linking it to musl (or other non-glibc lib), would that be enough?

> You said that in the current state, researching a solution is
> possible? Can you not research a solution with your patch applied to
> your own branch?


As a side note: I tried to revert this patch and statically link 5.7
UML with glibc, but the binary still segfaults on start, so I would
assume it is not related to my previous attempts linking with musl.

Regards,
Ignat

>
> Cheers
