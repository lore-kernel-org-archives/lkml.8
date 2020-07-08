Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C497021835
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNWOruLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGHIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgGHIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:35:03 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71401C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:35:03 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x205so3803242vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h4SPVfRZuCVSbYgatd3ieJt++U37sA6cj7z9VhNAanU=;
        b=PNWOruLcNlYep0iJV4gN/ef908gpH1uqJoYvaHKCSlQhSZwb7ICfq2r3tSSpVD9tBG
         9f0vR4Twkq+KA9v34Kz+1Y8TZ8/tBoeWJMZQBlgE6UGGCj44R4S2Zl7jpduUANo9LjHq
         PFw/taec8weGxXV0F2lAC3U4/6JVGw/NgwfG4klDtI2YEU+zGe7nP0gy4YPPg8bbLwn4
         cD5CX2qnF0cOvHJG1bYweINc6pnL1YCQxZZBYrCTakfTE9aMCsk67i2M1kVB/LFWhxDR
         vs41OAIPHBwpKvYOZBwJEO9QaBrz7ve8tnxgHGuPzQdJjX4+Qn497RyXrRNpXqPBfBu7
         mUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h4SPVfRZuCVSbYgatd3ieJt++U37sA6cj7z9VhNAanU=;
        b=Xu/CzNIeCCr9fnDAJAVE4CiY5J9C/z7h9OKWcEvLP2JY7w97FI8jZmC/2MZUlJO+K3
         kbwh72tV1R0SwnJEsbBrZWMyroRN5w3jm2bBl3HyasgRUxAB2QhxeqM+RO11u1qznxc8
         TA3PFQCxO0VpighaQxwoTbX3bI1mSv9EtW58oHPIhxtVkPjYmqWxbZxlyY+HeU26dpAd
         L0cM7Hdh6iLb5xigly6Tsh5fv4HKNMFg1o+cAAqmzeClNBQqcTwgTGRCLWODAvgz6ozm
         awlgYCsA84muvhC/JQfK8qAfqWj0jDUzDYCYNoH4laGig7rz68f96UNu21IVXcYJ1R1A
         An0A==
X-Gm-Message-State: AOAM533/qn4t/ccvCPoqSQRQRAfZn+EJD1TDbQMhDzD0ZjriNw0QixB9
        BN0+PTiRp3l578OFNVnzEMjB0SBp83MRe0COz2skYA==
X-Google-Smtp-Source: ABdhPJwhJnVOIBgaVJ/WyPck2dfDBjcMZIJ59nm0XNuoYYC2iHh0PbqQfGz6Wjf3oIE9NeXzkPwReLHskXVUs90FMFM=
X-Received: by 2002:a05:6102:390:: with SMTP id m16mr25932066vsq.55.1594197302473;
 Wed, 08 Jul 2020 01:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com> <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
 <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com> <20200708070912.GA351187@kroah.com>
In-Reply-To: <20200708070912.GA351187@kroah.com>
From:   Martin Zaharinov <micron10@gmail.com>
Date:   Wed, 8 Jul 2020 11:34:52 +0300
Message-ID: <CALidq=UYNMxLQTT_D=EOESUxr82LYH04YCjT6igwqdnw3YwyiA@mail.gmail.com>
Subject: Re: Bug Report High CPU Usage events_power_efficient
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes i search but not find any information.

And write hear to help if any have same problem or any of you have
idea from where is comme this problem.

If need more debug i will only write how to get more information.

Martin


=D0=9D=D0=B0 =D1=81=D1=80, 8.07.2020 =D0=B3. =D0=B2 10:09 Greg KH <gregkh@l=
inuxfoundation.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
>
> On Wed, Jul 08, 2020 at 09:50:49AM +0300, Martin Zaharinov wrote:
> > Add Greg , Florian, Eric to this bug
> >
> > > On 7 Jul 2020, at 22:54, Martin Zaharinov <micron10@gmail.com> wrote:
> > >
> > > And this is log from /sys/kernel/debug/tracing/trace
> > >
> > >
> > > # entries-in-buffer/entries-written: 32410/32410   #P:64
> > > #
> > > #                              _-----=3D> irqs-off
> > > #                             / _----=3D> need-resched
> > > #                            | / _---=3D> hardirq/softirq
> > > #                            || / _--=3D> preempt-depth
> > > #                            ||| /     delay
> > > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > #              | |       |   ||||       |         |
> > >           <...>-57259 [005] .... 29619.680698: workqueue_execute_star=
t: work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
> > >           <...>-57259 [005] .... 29623.811407: workqueue_execute_end:=
 work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
> > >           <...>-57259 [005] .... 29623.811410: workqueue_execute_star=
t: work struct 0000000000aeec55: function fb_flashcursor
> > >           <...>-57259 [005] .... 29623.811421: workqueue_execute_end:=
 work struct 0000000000aeec55: function fb_flashcursor
> > >           <...>-57259 [005] .... 29623.811422: workqueue_execute_star=
t: work struct 00000000a6d382bb: function vmstat_update
> > >           <...>-57259 [005] .... 29623.811435: workqueue_execute_end:=
 work struct 00000000a6d382bb: function vmstat_update
> > >
> > >> On 7 Jul 2020, at 22:44, Martin Zaharinov <micron10@gmail.com> wrote=
:
> > >>
> > >> the problem is hear with kernel 5.7.7
> > >>
> > >> last work kernel without this problem is 5.6.7
> > >>
> > >> hear is more info:
> > >>
> > >> cat /proc/57259/stack
> > >> root@megacableamarilis:~# cat /proc/57259/stack
> > >> [<0>] gc_worker+0x1be/0x380 [nf_conntrack]
> > >> [<0>] process_one_work+0x1bc/0x3b0
> > >> [<0>] worker_thread+0x4d/0x460
> > >> [<0>] kthread+0x10d/0x130
> > >> [<0>] ret_from_fork+0x1f/0x30
> > >>
> > >> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ C=
OMMAND                            57259 root      28   0       0      0    =
  0 R  69.8   0.0  82:42.14 kworker/5:2+events_power_efficient
> > >> 32 root      21   0       0      0      0 R  31.0   0.0  87:06.33 ks=
oftirqd/4
> > >>
> > >>
> > >> Please help to fix this problem
> > >>
> > >>> On 22 Apr 2020, at 15:55, Martin Zaharinov <micron10@gmail.com> wro=
te:
> > >>>
> > >>> Hello Qian and Greg
> > >>> With latest 5.6.x kernel have problem with events_power_efficient 2=
8488 root      28   0       0      0      0 R  95.5   0.0 101:38.19 kworker=
/2:1+events_power_efficient Process start to load machine after 3-4 hour an=
d load not stop only reboot machine remove process . Server runing on AMD E=
PIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when machine load over 1G =
traffic machine locked and only restart fix problem to next load . After mo=
ve traffic and server stop load process still hear and load server ?
> > >>> And after reboot process move to other core .
>
> Have you used 'git bisect' to try to find the offending commit?
>
> Without that, it's going to be hard to help you out here.
>
> thanks,
>
> greg k-h
