Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C318CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886042070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COc5egj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGQAoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:44:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27418 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbgGQAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594946645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rmdg41JQUJq8opOuNZqgZDP9AkGwDIAIjz0rPo/9Gto=;
        b=COc5egj66ufcJXjDWAILUQJ0E2ILBLJoYpYm0kznwfBMkLpUW+SN0oqKy9QPQQgVHFZDo1
        KvP+IDKtszbkbSnXbcDC9V1W1NNVsYuSGEQsujkBV/wqE2xM+4EOkHL0lv0O8gFYylK8Q9
        //f/1VAUvf3Tf9YNHQ0H63ukiOsPlXk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-WI0QoI4iPV60L1wSCnLwZQ-1; Thu, 16 Jul 2020 20:44:03 -0400
X-MC-Unique: WI0QoI4iPV60L1wSCnLwZQ-1
Received: by mail-qv1-f69.google.com with SMTP id m8so4547311qvv.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rmdg41JQUJq8opOuNZqgZDP9AkGwDIAIjz0rPo/9Gto=;
        b=WgRuVVJ8MzvES06zk1Z4dLPlfOi/uhPV+bOuEifVk0yjSfJ2Y9Ig8+RGcGVGBkUNT1
         ZwVT1CBhJcOhONQM7A+TfTymv24P0r6g925wTZ0YjgPCCmC3uwPzFEKOxrlZP5lgdS1q
         D3SVrzwTZ+07LCYuRllJV6F2vHCciMOlLCiP6Iv5Beqzm0x2IREKodWiNjGTE+VVmE5i
         RyQnEfedUCC3cURaABA+ZGdOsAjATJV6LjLPwSTXTfDV6VKjyCVMd6RcWrniW/V5BaLM
         dAY/ohDpqzuUqUu/zcfGGA4QT3IX3N/MOyZgd6UCqqJvGYa2o8mGaq8PFfb+qKMxwzzh
         /x0w==
X-Gm-Message-State: AOAM530U2Oxe4GBBDaDDjIVYQnREYXxxSVy/qC7BurK2xNSDAnfQQ9Rm
        TzPElhemEXxa3P1kubkhg01suLNMQ/jRplEpvWShbjD04KkpUAeeuHRgT0bqDORGgXYPnTeIHVd
        2dIA2sZGXCcU6vVkEPC83QdRV8wxa6SG5oLdZFeOp
X-Received: by 2002:a37:5c04:: with SMTP id q4mr6803737qkb.192.1594946643135;
        Thu, 16 Jul 2020 17:44:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8dZ0LhZ5SZX3kNAbkEg8LM0oFyVFb+CHDpbaDZnEmRN7ua1G6U67YJDaEwNT4OIDFAmfBXBb89RLpG2bg22A=
X-Received: by 2002:a37:5c04:: with SMTP id q4mr6803712qkb.192.1594946642833;
 Thu, 16 Jul 2020 17:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
In-Reply-To: <20200716235440.GA675421@bjorn-Precision-5520>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 17 Jul 2020 02:43:52 +0200
Message-ID: <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 1:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Sasha -- stable kernel regression]
> [+cc Patrick, Kai-Heng, LKML]
>
> On Fri, Jul 17, 2020 at 12:10:39AM +0200, Karol Herbst wrote:
> > On Tue, Jul 7, 2020 at 9:30 PM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > Hi everybody,
> > >
> > > with the mentioned commit Nouveau isn't able to load firmware onto the
> > > GPU on one of my systems here. Even though the issue doesn't always
> > > happen I am quite confident this is the commit breaking it.
> > >
> > > I am still digging into the issue and trying to figure out what
> > > exactly breaks, but it shows up in different ways. Either we are not
> > > able to boot the engines on the GPU or the GPU becomes unresponsive.
> > > Btw, this is also a system where our runtime power management issue
> > > shows up, so maybe there is indeed something funky with the bridge
> > > controller.
> > >
> > > Just pinging you in case you have an idea on how this could break Nouveau
> > >
> > > most of the times it shows up like this:
> > > nouveau 0000:01:00.0: acr: AHESASC binary failed
> > >
> > > Sometimes it works at boot and fails at runtime resuming with random
> > > faults. So I will be investigating a bit more, but yeah... I am super
> > > sure the commit triggered this issue, no idea if it actually causes
> > > it.
> >
> > so yeah.. I reverted that locally and never ran into issues again.
> > Still valid on latest 5.7. So can we get this reverted or properly
> > fixed? This breaks runtime pm for us on at least some hardware.
>
> Yeah, that stinks.  We had another similar report from Patrick:
>
>   https://lore.kernel.org/r/CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com
>
> Apparently the problem is ec411e02b7a2 ("PCI/PM: Assume ports without
> DLL Link Active train links in 100 ms"), which Patrick found was
> backported to v5.4.49 as 828b192c57e8, and you found was backported to
> v5.7.6 as afaff825e3a4.
>
> Oddly, Patrick reported that v5.7.7 worked correctly, even though it
> still contains afaff825e3a4.
>
> I guess in the absence of any other clues we'll have to revert it.
> I hate to do that because that means we'll have slow resume of
> Thunderbolt-connected devices again, but that's better than having
> GPUs completely broken.
>
> Could you and Patrick open bugzilla.kernel.org reports, attach dmesg
> logs and "sudo lspci -vv" output, and add the URLs to Kai-Heng's
> original report at https://bugzilla.kernel.org/show_bug.cgi?id=206837
> and to this thread?
>
> There must be a way to fix the slow resume problem without breaking
> the GPUs.
>

I wouldn't be surprised if this is related to the Intel bridge we
check against for Nouveau.. I still have to check on another laptop
with the same bridge our workaround was required as well but wouldn't
be surprised if it shows the same problem. Will get you the
information from both systems tomorrow then.

> Bjorn
>

