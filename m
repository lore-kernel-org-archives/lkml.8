Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E42024125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlyKzP0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWAIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 19:08:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35179 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgAWAIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:08:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so982144lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljR4qIScgnHlVgotRz5jvHzcfQpNvaV3xGDWeSwVuWI=;
        b=VlyKzP0aHglwI0D+fnQ6xSvab3aMMbG4BkNrmqROWoeBP1sfY1F+z/40Y6ZaJ9RRoS
         VMI1GSrctXZvVoV1+bCx+hEvKrzCoQ6AriVBgiSP9kt9mQkzCBExmT+f7c0T97GT4ufO
         twLmXNlfgnlTSMMciIYIpm4Rz/XgTauBDiaSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljR4qIScgnHlVgotRz5jvHzcfQpNvaV3xGDWeSwVuWI=;
        b=hc64MqoQkFqHlMFqnVsxe6iH8XjZDDPJJyOvr+WIGvWRKa/vc2lNxxnHnVGq8qhubp
         NG2VxJWe7WjDbfQdkn3twzksVr+FbpL1ptC5vZKh/U1AvbjWEoIKBT8pYZS8DlxpsfFM
         qcvWBH3pWGgO8FxGnyaHXDtOF4/QVqBvmJZxnMb1oJh1tCjV0qPwAAcIm2o1KoYAsKsH
         Fne2gv0/xng6/avJRp2z0PK14DgLfLlVpnmuktZqXftFo0LgwUnnhrkw058yLXBKacrD
         DXtGo2jgU2i+YOX0UaV5EGWs7Jgdq74KLUqkdrlNfYWPJg4GjDuzdi5WJKAHerQ0yQ5Y
         AEeQ==
X-Gm-Message-State: APjAAAW/0mEmLK/6MStw9zEjOqMymmEGmn57iq40mq0LRLt5jBeM9VfT
        LuvkEFnYTCDlafxSy0P+UtXUY+WfjfU=
X-Google-Smtp-Source: APXvYqxgsRjq2MXWO3tPTD1k3p35Z55XQmK6GqDDmlsCHKg6QTTaLky5/E0myT3DzWcdbown/gvgjA==
X-Received: by 2002:a19:ca07:: with SMTP id a7mr3091682lfg.103.1579738098814;
        Wed, 22 Jan 2020 16:08:18 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p12sm90133lfc.43.2020.01.22.16.08.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 16:08:18 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id v201so935393lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 16:08:17 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2832952lfs.99.1579738097075;
 Wed, 22 Jan 2020 16:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
 <875zh3ukoy.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zh3ukoy.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 16:07:40 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
Message-ID: <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan Green <evgreen@chromium.org> writes:
> > On Wed, Jan 22, 2020 at 9:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> I suspect this *is* a problem because I think disabling MSI doesn't
> >> disable interrupts; it just means the device will interrupt using INTx
> >> instead of MSI.  And the driver is probably not prepared to handle
> >> INTx.
> >>
> >> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
> >> disabled, the Function requests servicing using INTx interrupts (if
> >> supported)."
>
> Disabling MSI is not an option. Masking yes, but MSI does not have
> mandatory masking. We already attempt masking on migration, which covers
> only MSI-X reliably, but not all MSI incarnations.
>
> So I assume that problem happens on a MSI interrupt, right?
>
> >> Maybe the IRQ guys have ideas about how to solve this?
>
> Maybe :)
>
> > But don't we already do this in __pci_restore_msi_state():
> >         pci_intx_for_msi(dev, 0);
> >         pci_msi_set_enable(dev, 0);
> >         arch_restore_msi_irqs(dev);
> >
> > I'd think if there were a chance for a line-based interrupt to get in
> > and wedge itself, it would already be happening there.
>
> That's a completely different beast. It's used when resetting a device
> and for other stuff like virt state migration. That's not a model for
> affinity changes of a live device.

Hm. Ok.

>
> > One other way you could avoid torn MSI writes would be to ensure that
> > if you migrate IRQs across cores, you keep the same x86 vector number.
> > That way the address portion would be updated, and data doesn't
> > change, so there's no window. But that may not actually be feasible.
>
> That's not possible simply because the x86 vector space is limited. If
> we would have to guarantee that then we'd end up with a max of ~220
> interrupts per system. Sufficient for your notebook, but the big iron
> people would be not amused.

Right, that occurred to me as well. The actual requirement isn't quite
as restrictive. What you really need is the old vector to be
registered on both the old CPU and the new CPU. Then once the
interrupt is confirmed to have moved we could release both the old
vector both CPUs, leaving only the new vector on the new CPU.

In that world some SMP affinity transitions might fail, which is a
bummer. To avoid that, you could first migrate to a vector that's
available on both the source and destination CPUs, keeping affinity
the same. Then change affinity in a separate step.

Or alternatively, you could permanently designate a "transit" vector.
If an interrupt fires on this vector, then we call all ISRs currently
in transit between CPUs. You might end up calling ISRs that didn't
actually need service, but at least that's better than missing edges.

>
> The real critical path here is the CPU hotplug path.
>
> For regular migration between two online CPUs we use the 'migrate when
> the irq is actually serviced ' mechanism. That might have the same issue
> on misdesigned devices which are firing the next interrupt before the
> one on the flight is serviced, but I haven't seen any reports with that
> symptom yet.
>
> But before I dig deeper into this, please provide the output of
>
> 'lscpci -vvv' and 'cat /proc/interrupts'
>

Here it is:
https://pastebin.com/YyxBUvQ2

This is a Comet Lake system. It has 8 HT cores, but 4 of those cores
have already been offlined.

At the bottom of the paste I also included the script I used that
causes a repro in a minute or two. I simply run this, then put some
stress on USB. For me that stress was "join a Hangouts meeting", since
that stressed both my USB webcam and USB ethernet. The script exits
when xhci dies.
-Evan
