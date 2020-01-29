Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F789206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIzrCznP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgA2SBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:01:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35949 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgA2SBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:01:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so337863lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v49qSJDDhvOaRsBI9gc+tYZ4RfGmEGHF1xKb4v6wLhw=;
        b=XIzrCznP9I3gq08sozdu3CWZBayLW7ZkHxJeQxM+XmEdLhqmWxUHfD3rocLMQ2MXdY
         XP89vxP5NvtBFfL7hPVxhlhj6bl9yyT13nUd5CkifWcfrpdgAF6+hihMrGBflE4yVM5k
         2HJWDzCDAQp8LGiZCQ9KXSJ8hZULCEJiiM0ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v49qSJDDhvOaRsBI9gc+tYZ4RfGmEGHF1xKb4v6wLhw=;
        b=Nw/Wy1ikyP1InPLnpl7N9qyhQ2A5ERfIqRjbHGjpx0XM8mBIf/tYL+lVb5TWIwwCar
         hcGjj/29o9rq72OlOFRAoHGsxjLIoeWOeB34FOkn0fnXgQb2SvUQEJT0fFdNYAFzgzTy
         yF7Dyz3VLPH2+KTK9lt8xXMrTUN9eqtFtBuvRc09sKvay6GhEs0jgsLpBZ2SeX+5yThI
         rOzePqXujNaBFPOSA3f5yDNrjMxQuq/tk8mF0/XxvSVBVaJ62S8Ym5wFtf/oCacoaHVu
         8lyF3URYMhVHMKzbMVrH+K4rf37XYhp9g0lEwi6smOOBI2kPw5nShNdI9ejSOA2knf9M
         7btg==
X-Gm-Message-State: APjAAAWPI838Am5ZNZTnQD4FQDb12mX8BXbt/KVz6JJ6wK9b9jUKYKDa
        MlJtlDoSQwZTwv2ILYMp+jQ6ni4HY24=
X-Google-Smtp-Source: APXvYqwxKRXE3HOalPfG8rbEllCeb1iIuKw7hyT1uZmAcmnycxLRNwGNoCP69AdrYK7gsntZIskxCw==
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr252678lfs.99.1580320897901;
        Wed, 29 Jan 2020 10:01:37 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u13sm1432726lfq.19.2020.01.29.10.01.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:01:36 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l18so349501lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:01:36 -0800 (PST)
X-Received: by 2002:a19:c205:: with SMTP id l5mr259903lfc.159.1580320896113;
 Wed, 29 Jan 2020 10:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com> <87pnf342pr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pnf342pr.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 10:00:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
Message-ID: <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 2:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Tue, Jan 28, 2020 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> The patch is only lightly tested, but so far it survived.
> >>
> >
> > Hi Thomas,
> > Thanks for the patch, I gave it a try. I get the following splat, then a hang:
> >
> > [   62.238406]        CPU0
> > [   62.241135]        ----
> > [   62.243863]   lock(vector_lock);
> > [   62.247467]   lock(vector_lock);
> > [   62.251071]
> > [   62.251071]  *** DEADLOCK ***
> > [   62.251071]
> > [   62.257687]  May be due to missing lock nesting notation
> > [   62.257687]
> > [   62.265274] 2 locks held by migration/1/17:
> > [   62.269946]  #0: 00000000cfa9d8c3 (&irq_desc_lock_class){-.-.}, at:
> > irq_migrate_all_off_this_cpu+0x44/0x28f
> > [   62.280846]  #1: 000000006885da2d (vector_lock){-.-.}, at:
> > msi_set_affinity+0x13c/0x27b
> > [   62.289801]
> > [   62.289801] stack backtrace:
> > [   62.294669] CPU: 1 PID: 17 Comm: migration/1 Not tainted 4.19.96 #2
> > [   62.310713] Call Trace:
> > [   62.313446]  dump_stack+0xac/0x11e
> > [   62.317255]  __lock_acquire+0x64f/0x19bc
> > [   62.321646]  ? find_held_lock+0x3d/0xb8
> > [   62.325936]  ? pci_conf1_write+0x4f/0xdf
> > [   62.330320]  lock_acquire+0x1b2/0x1fa
> > [   62.334413]  ? apic_retrigger_irq+0x31/0x63
> > [   62.339097]  _raw_spin_lock_irqsave+0x51/0x7d
> > [   62.343972]  ? apic_retrigger_irq+0x31/0x63
> > [   62.348646]  apic_retrigger_irq+0x31/0x63
> > [   62.353124]  msi_set_affinity+0x25a/0x27b
>
> Bah. I'm sure I looked at that call chain, noticed the double vector
> lock and then forgot. Delta patch below.

It's working well with the delta patch, been running for about an hour
with no issues.
-Evan
