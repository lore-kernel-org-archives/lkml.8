Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C32C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159182073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf11dO7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgDCLfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:35:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22382 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbgDCLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585913737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40KtlpFLs6LS0RfB6llGDlqZR+Nh7iIxNr1jvPN9DyY=;
        b=Zf11dO7u914Hrw8T30xJ9YIUH27PJe8nO2RgpbUjdza2E4zu0iUD0Cp67MXypoZKvxaQNt
        gTJG3liFbIeEVtzrDDUcCGcMGnuyHL3dG4g03Vloq6ujar1QqIdz2a3eQVGKn+xB7N3ujL
        atYrL05KRGTj+AsjKPg7zjB7vsULHBU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-D38_oc8_Nx-282WzAKvcVA-1; Fri, 03 Apr 2020 07:35:36 -0400
X-MC-Unique: D38_oc8_Nx-282WzAKvcVA-1
Received: by mail-qk1-f199.google.com with SMTP id c1so5994475qkg.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=40KtlpFLs6LS0RfB6llGDlqZR+Nh7iIxNr1jvPN9DyY=;
        b=ZPPgPQlN4kLgWAfA8eszvI66elFy5KIMBN1R7BRwHXulsMicAGdWGa3ZTgj44UlNay
         d1yzcLlOogDOSwZM2JjFXjj3tP1wSezxNWGCik4oJc8GWwRsiJwU/n4SKU1GrRLTUnRy
         7i+Dp5zhEgasCfYvH8NnLv1on+/aiC1PItsUGshUanx957xnpg00pNsDktMbIqsQsZtt
         3J/YJe6I9ZyjTfrFeHbMJ+lB9jfwP/YUOTG1ju38fQ4WDn3VHAL9E5yvsSLA9GHQ39pG
         Z75bl2mQ9BrYEQH8VoLMZjkbeno86pNIAK4KQ/Enk4Ff/OYZ7KX0niaddvPqVVkYwMUf
         eqng==
X-Gm-Message-State: AGi0PuaEEsTdEBxbzcsXdu9l4T28FjzlTOPMT837VSzdde1pSUl3OWNv
        4ExrlIdZ86WQX6WXqghEgP2kRHDOqIWmhPuFjefAynj0QFe+udVwxSsXJNnCUjYRSAAD0iGKmdZ
        98U+NoN0yZD2AFd7PJLhT95QG1wwZP5d7GMxE3htm
X-Received: by 2002:a37:8c06:: with SMTP id o6mr7886201qkd.27.1585913735375;
        Fri, 03 Apr 2020 04:35:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYDyAt2EVj4La/hOdssuO6dJur8OqhjVmxkZp+s31VKzOSaKOCeG5/1V4Y4Qh6icTxJF7LI/guG24r/6eiML0=
X-Received: by 2002:a37:8c06:: with SMTP id o6mr7886185qkd.27.1585913735107;
 Fri, 03 Apr 2020 04:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
 <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com> <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 3 Apr 2020 13:35:24 +0200
Message-ID: <CAO-hwJJpk4B2EdCO3sB+rg8Hdwo3E=ptPaRuFED7-0WuRUEpSA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 5.7
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Samuel_=C4=8Cavoj?= <sammko@sammserver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 12:05 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 1 Apr 2020, Linus Torvalds wrote:
>
> > > Samuel =C4=8Cavoj (1):
> > >       HID: Add driver fixing Glorious PC Gaming Race mouse report des=
criptor
> >
> > What a glorious name for a piece of hardware. Even if it's apparently
> > buggy and needs help to work right.
>
> Yeah, the vendor apparently was not of the humble kind :)
>
> > I felt bad saying I don't need that glorious driver when doing my
> > oldconfig.
>
> :))
>
> > Anyway, because I noticed this due to the name, it does strike me that
> > clearly Windows must be ignoring - or otherwise reacting differently to
> > - the HID_MAIN_ITEM_CONSTANT flag. Because presumably those mice work
> > under Windows without special drivers?
> >
> > In fact, reading that driver, it looks like they report being *both*
> > constant *and* variable in their report descriptors. Which sounds odd.
> > Maybe we should do whatever Windows does, and not need a special driver
> > for this maybe-bot-so-glorious-after-all mouse hardware?
>
> Adding Samuel to CC.
>
> From what I understood is that in order to access the buttons reported in
> report #2 (the one marked with HID_MAIN_ITEM_CONSTANT), you actually *do*
> need a special software on windows anyway.
>
> What we do is that we ignore any changes in reports with
> HID_MAIN_ITEM_CONSTANT in the HID core.

Funny enough, I think most hardware vendors are actually correct with
the CONSTANT implementation but Microsoft itself with the Surface
touchpad line :)

>
> It would still be possible to access the report via hidraw, and maybe
> that's analogy of what the Windows driver/special Glorious software :)
> does, I don't know. It's hard to believe that Windows would be actually
> willing to report any changes coming through HID_MAIN_ITEM_CONSTANT
> reports, but who knows.

I'll need to check whether we have too many drivers that replace
constant by variable. But I know it bit us in the past a few times
(and the Surface covers are the ones I remember). But again, Windows
is weird in a lot of ways, and I believe that they do not have one
unified driver for everything, but some behaviour that depends on the
application. So I am a little bit hesitant to toggle the switch to
consider constant usages as variable ones. Luckily, we now have a
regression test suite. It's not complete, but it can prevent such
regressions with the devices we have in there.

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs
>

