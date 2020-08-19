Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E23C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1922078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597805531;
	bh=C63ptFzfEJNXZ2OThYV5Nci2QNW3mQLumx9TTfnaCwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gKtKmqRdZFMrsQyqF3SypZCUxQ6TpDlMcCBPHXEP8AR3RiYqFgtVW9fMHGe1ChNZR
	 njZGhh839NIcpkgxedV1YMae0Vbbov/EMF94PEFnbzIbj/Dd4B5KnjwckkgOzlRTuL
	 CcTElSupxtFcKpiryDtfSJpjcbQbrQnv2Iol2u6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHSCwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:52:10 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35726 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHSCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:52:09 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 07J2pprt030370
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:51:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 07J2pprt030370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597805512;
        bh=2WrbbbfKgF3susbAV9hWN0or0trbeWhxb9mZYyMcJfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FxvNF7sDLP+lHfQDJWWNgigHBdtyUyx3NhCGE9xt5ipLimQYjCSd08dumTTAa2OYZ
         2q8Sv91WLBPzXzZU2md9+pMD3tQW8SbQnGrCYzPm52OYc5sTWrEKM1A39IyNacudOX
         oye4pGBvS43DKiJh/Zgo8id49aFJJXID/DUzQZgsELwwKRz3Nf2FcqEmtButHyNCaq
         3z4DSGVYxFopGyYZvXGGLise1G5t/d6u1Ljkc1kaC3xF/Z8lpbndPQrJCrkb4uo/gs
         v3Q42d/q8s+LcxP22jr3iEKnQEmYKmJY6iIR+xyU7xBPjS6SQwdmFQ0ey4x6UrCXzz
         +5P2sVDBA8fRA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id n25so11215489vsq.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 19:51:51 -0700 (PDT)
X-Gm-Message-State: AOAM531wAR4EtVwLwiuBdin6Tq4U/EghVmft9zDgl5HWc29Jz3CVF677
        DRCz75THEUkd1bfnLRx/WsXqMStqut6/ZtzN1u0=
X-Google-Smtp-Source: ABdhPJwCPfXxdGhtRq7wbAGHersu73VU8uUGQkzREk9LZ9W2yXzSW34htlLPfAM54nr5w1oc+4rmZDOUTMI3aXX6T4k=
X-Received: by 2002:a67:7c11:: with SMTP id x17mr14433648vsc.155.1597805510290;
 Tue, 18 Aug 2020 19:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
 <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com> <092a70e9-12c1-29fd-1fb0-fd851024de39@meinberg.de>
In-Reply-To: <092a70e9-12c1-29fd-1fb0-fd851024de39@meinberg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Aug 2020 11:51:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6nddyJh-mzZbY1NTRK6oT+0OZf9FiqTXmAqhvf869Mw@mail.gmail.com>
Message-ID: <CAK7LNAS6nddyJh-mzZbY1NTRK6oT+0OZf9FiqTXmAqhvf869Mw@mail.gmail.com>
Subject: Re: Kernel build system broken in 5.8?
To:     Martin Burnicki <martin.burnicki@meinberg.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Wed, Aug 19, 2020 at 5:50 AM Martin Burnicki
<martin.burnicki@meinberg.de> wrote:
>
> Hello Masahiro,
>
> Masahiro Yamada wrote:
> > On Wed, Aug 19, 2020 at 1:14 AM Martin Burnicki
> > <martin.burnicki@meinberg.de> wrote:
> [...]
> >> I usually build the kernel module as standard user, and only install t=
he
> >> new module as root, e.g.:
> >>
> >>   git checkout devel   # The 'devel' branch is appropriate for testing
> >>   cd mbgclock          # the subdirectory of the kernel module
> >>   git clean -fd; make  # or make V=3D1 for verbose output
> >>   sudo make install
> >
> >
> > This is a bad way for reporting a bug
> > because your project is too big.
>
> Sorry for this. I wasn't sure which was the best way to get a contact to
> folks who are more familiar with details of the kernel build system, and
> what may have been changed.

Sorry, if my response was too harsh.

> A possibility could have
>
> > mbgclock/Makefile include the top Makefile,
> > which is more than 1000 lines.
>
> If you run 'make' in the mbgclock subdirectory then the kernel build
> system is just called as usual, i.e.
>
>   make -C <path-to-the-kernel-build-system> M=3D$PWD <some EXTRA_CFLAGS>


I know.

I tried this, and then
"sudo make modules_install -C <path-to-the-kernel-build-system> M=3D$PWD"
but I did not see the issue.

So, I have no idea what the root-cause is
at this point.


> This has been working without problems for many years, for many popular
> distros, and all kernels from 2.6 up to 5.7 (except that for older
> kernels SUBDIRS=3D$PWD was used instead of M=3D$PWD).
>
> > Please provide steps to reproduce it
> > with a tiny test module.
>
> I was just hoping that someone had an idea like "Oh, this is because xyz
> has changed in kernel 5.18" when he read what I've observed.
>
> In the past I've seen cases where folks e.g. from RedHat or SuSE had
> backported patches from newer kernels to older ones, causing build
> errors in my driver code, and I was able to apply workarounds to my
> source code.
>
> However, this case is different because obviously the kernel source tree
> is modified under certain circumstances. Is my assumption correct that
> this should not happen if I install Linux header packages for a distro,
> that have been pre-configured according to the running kernel?

Right.
External modules should never ever attempt
to modify the kernel tree since it is often read-only.

I did not change that behavior
(unless I was doing a horrible mistake)



>
> Anyway, I'm going to try to set up an example which makes it easier to
> duplicate the problem.
>
> > You state 5.7.15 was fine.
>
> Yes.
>
> > So, could you also run git-bisect, please?
>
> Sorry, I've just recently started using git, and yet I'm not too
> familiar with some of the commands. How could git-bisect help in this cas=
e?



"git bisect" is really useful to find the first bad commit.
If you have not tried it yet,
it is worth learning the usage.



Can you reproduce the issue in the linux-stable source tree
instead of the ubuntu kernel?


You can get the stable kernel repository, like follows:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le.git
$ cd linux-stable
$ git checkout v5.8.1


Once you find how to reproduce the bug
in the git repository,
it is pretty easy to start bisecting
with "git bisect start <bad> <good>"

For example,

git bisect start v5.8.1  v5.7.15

Then, repeat "git bisect good" or "git bisect bad",
depending on whether the bug happens.






> >> Also, I was under the impression that the kernel source tree should be
> >> read-only, and kept clean, but this doesn't seem to be the case anymor=
e.
> >>
> >>
> >> For example:
> >>
> >> On Ubuntu 19.10 with kernel 5.8.1-050801-generic from
> >> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.1/
> >
> >
> > I cannot try it since that is not what
> > I install on my machine, sorry.
>
> What distro are you using? Or do you only run kernels you have compiled
> yourself? ;-)


I also use Ubuntu, but my one is 5.4.0-42-generic.


I am not sure if 5.8.1-050801-generic
is exactly the same as v5.8.1, though.




>
> > Please provide steps to reproduce it
> > for a person using a different environment.
>
> I'm going to try to do this. Do you have any hints what this should look
> like?


I'd like to know the steps to reproduce the bug
in the kernel source tree instead of the distro's one.
(See above to get the stable kernel tree)



We could use your project to debug this, but
if this is purely a problem of the kernel build system,
it is easier and faster to use a small hello-world module.


For example, the minimal Makefile
of an external module will look like follows:



------------------------>8---------------------------
KERNEL=3D$(HOME)/workspace/linux-stable

.PHONY: __default
__default:
        $(MAKE) -C $(KERNEL) M=3D$(CURDIR)

.PHONY: $(MAKECMDGOALS)
$(MAKECMDGOALS):
        $(MAKE) -C $(KERNEL) M=3D$(CURDIR) $@

obj-m :=3D helloworld.o
------------------------>8---------------------------






>
> Should this topic be continued on linux-kernel@, or better on
> linux-kbuild@, or elsewhere?


Please include both lists in To or Cc.

linux-kernel@ is a large amount.

I often miss mails if they are only
sent to linux-kernel@.




Thanks.




>
>
> Thanks,
>
> Martin
> --
> Martin Burnicki
>
> Senior Software Engineer
>
> MEINBERG Funkuhren GmbH & Co. KG
> Email: martin.burnicki@meinberg.de
> Phone: +49 5281 9309-414
> Linkedin: https://www.linkedin.com/in/martinburnicki/
>
> Lange Wand 9, 31812 Bad Pyrmont, Germany
> Amtsgericht Hannover 17HRA 100322
> Gesch=C3=A4ftsf=C3=BChrer/Managing Directors: G=C3=BCnter Meinberg, Werne=
r Meinberg,
> Andre Hartmann, Heiko Gerstung
> Websites: https://www.meinberg.de  https://www.meinbergglobal.com
> Training: https://www.meinberg.academy
>


--=20
Best Regards
Masahiro Yamada
