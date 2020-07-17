Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FDDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CBC21775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6ABQZyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGQLcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:32:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbgGQLcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594985543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYpWDk5YRbEJgevYd6gB8eGgLm0tIiJeUcncZGG+w6o=;
        b=i6ABQZygQAef7piM003bSba61BBGO8Rvdm6v1YtrN9Uf4Fm32+vz9lXwjJcUQ+5oJMgedJ
        7mRYlrUVRAV0uwNbnxqRcLYnCt9kPyaFOm3dpYXzxZSAL3ZUdCMdwpqWs0OOTA/kS7dDOg
        Y1AYhXm+3PnveeHdtzlvHkWmmy4WDQc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-QjwDNDEUPVuBvGum1B7NZw-1; Fri, 17 Jul 2020 07:32:21 -0400
X-MC-Unique: QjwDNDEUPVuBvGum1B7NZw-1
Received: by mail-qv1-f71.google.com with SMTP id r12so5372082qvk.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYpWDk5YRbEJgevYd6gB8eGgLm0tIiJeUcncZGG+w6o=;
        b=FAamrOSeHf23yC513NgsC6qsrsxbId/LhVuV59bDEXUB7Eo83T0yzBYnTJd4v+zEfJ
         vwz7Pf3QlMABGdC4urFf1lDvpHjEubDilaa4W18V+9SUxFUxHdyP5zYyk2n8sGQ5szpW
         p0k6aFkKXG3g0LZyZnLgyfWOOnIjlMQYYR/oHohr5ga65Gl1n3n7bcJVDN5q4seC7SBi
         +A6Z7kxPSoHYTkIGtK83JttKnhPO3zqObp3CUs3GGrfjhecNxOiolVlKRbPRPmZQshE4
         AmxxsER5eFo7WYXq1FUwK0+P84gAwinZFSR1eUzK+brGZNz+IosGXe511zbvQAKZrsO8
         bkww==
X-Gm-Message-State: AOAM531FfZZL8gGtRbAtVxrO9uLBQU0OEQVtu0/DaSmz0WvDV6Wxaa0x
        7n5WoFAHaSdjDO5rjSMXN7dx/3qbgCtbBRWQLsYXpyNa8wtfliNBPkFK0ux0bd7fdtvsKARxXpt
        /zEvnmoo0Kb5a1nK+cfSMeGz28TZnd/QYpCIQx66K
X-Received: by 2002:a37:a589:: with SMTP id o131mr8525050qke.102.1594985541178;
        Fri, 17 Jul 2020 04:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8U5sWpquWmgK/Rg67k2lvFtnWDq2c6Co4MkYKbyr1oubN2HBDkG+dq9s8lm6gAwtT3o4kndbiPD79JItfOvo=
X-Received: by 2002:a37:a589:: with SMTP id o131mr8525028qke.102.1594985540875;
 Fri, 17 Jul 2020 04:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520> <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
In-Reply-To: <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 17 Jul 2020 13:32:10 +0200
Message-ID: <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filed at https://bugzilla.kernel.org/show_bug.cgi?id=208597

oddly enough I wasn't able to reproduce it on my XPS 9560, will ping
once something breaks.

On Fri, Jul 17, 2020 at 2:43 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Fri, Jul 17, 2020 at 1:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Sasha -- stable kernel regression]
> > [+cc Patrick, Kai-Heng, LKML]
> >
> > On Fri, Jul 17, 2020 at 12:10:39AM +0200, Karol Herbst wrote:
> > > On Tue, Jul 7, 2020 at 9:30 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > Hi everybody,
> > > >
> > > > with the mentioned commit Nouveau isn't able to load firmware onto the
> > > > GPU on one of my systems here. Even though the issue doesn't always
> > > > happen I am quite confident this is the commit breaking it.
> > > >
> > > > I am still digging into the issue and trying to figure out what
> > > > exactly breaks, but it shows up in different ways. Either we are not
> > > > able to boot the engines on the GPU or the GPU becomes unresponsive.
> > > > Btw, this is also a system where our runtime power management issue
> > > > shows up, so maybe there is indeed something funky with the bridge
> > > > controller.
> > > >
> > > > Just pinging you in case you have an idea on how this could break Nouveau
> > > >
> > > > most of the times it shows up like this:
> > > > nouveau 0000:01:00.0: acr: AHESASC binary failed
> > > >
> > > > Sometimes it works at boot and fails at runtime resuming with random
> > > > faults. So I will be investigating a bit more, but yeah... I am super
> > > > sure the commit triggered this issue, no idea if it actually causes
> > > > it.
> > >
> > > so yeah.. I reverted that locally and never ran into issues again.
> > > Still valid on latest 5.7. So can we get this reverted or properly
> > > fixed? This breaks runtime pm for us on at least some hardware.
> >
> > Yeah, that stinks.  We had another similar report from Patrick:
> >
> >   https://lore.kernel.org/r/CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com
> >
> > Apparently the problem is ec411e02b7a2 ("PCI/PM: Assume ports without
> > DLL Link Active train links in 100 ms"), which Patrick found was
> > backported to v5.4.49 as 828b192c57e8, and you found was backported to
> > v5.7.6 as afaff825e3a4.
> >
> > Oddly, Patrick reported that v5.7.7 worked correctly, even though it
> > still contains afaff825e3a4.
> >
> > I guess in the absence of any other clues we'll have to revert it.
> > I hate to do that because that means we'll have slow resume of
> > Thunderbolt-connected devices again, but that's better than having
> > GPUs completely broken.
> >
> > Could you and Patrick open bugzilla.kernel.org reports, attach dmesg
> > logs and "sudo lspci -vv" output, and add the URLs to Kai-Heng's
> > original report at https://bugzilla.kernel.org/show_bug.cgi?id=206837
> > and to this thread?
> >
> > There must be a way to fix the slow resume problem without breaking
> > the GPUs.
> >
>
> I wouldn't be surprised if this is related to the Intel bridge we
> check against for Nouveau.. I still have to check on another laptop
> with the same bridge our workaround was required as well but wouldn't
> be surprised if it shows the same problem. Will get you the
> information from both systems tomorrow then.
>
> > Bjorn
> >

