Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E919EC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB28D24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G46DzT2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgBSAsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:48:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46289 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSAsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:48:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so22104770oid.13;
        Tue, 18 Feb 2020 16:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UH3IDmpA8z5gal2ML7pd0cStB9p9jlzpO3tNMXaPA/Y=;
        b=G46DzT2wR7mYuLF4OdUnkxuJ4vV9LkHQlyise1UPaWycBuqVo/+9sYVe8CyABlQv9S
         FcUJycWUQDFZnNIlbZ+MminrFt5KgbpHqxmdce4wMJYLLh1+CBPEYQPZTlyvHyRgTQ4D
         HioT4agIrXoLHvU6tXSFFkR9JNa+5dLE6qgA47RPU/52G9HUFaWn2z9XbBhtNaW6QCcU
         3c2vd06Z93HYAT/1PC9LJvttO84Hp5cXHLapMrXBB4xuvgpv/f4Fs1sAVVerd5d/NSIH
         2IWDe9AJ61HbC/PUwKOgDL36FvElTN+3JEg1tqIzBURSswp6DZZ22wUBNfX/edekr0et
         aT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH3IDmpA8z5gal2ML7pd0cStB9p9jlzpO3tNMXaPA/Y=;
        b=Lg8SMk8Mkmm+MWvTgCviCJegNSpCWNxzGBYqB8ohpaC1cOAhjEfjitulFj5l62VUgs
         Ms5CiUnlBdwSf7DRp56KV2uBpz/I4ZAQq9BPyyMeWC5P1S7YyNUZg332pIMDs0fjKATl
         HoeKc5bOdytQoRNjPeczcjz6ekRuTapvV5k9GWVl3ZpgDeHt6BYKp/d7cDwqjauqLp1B
         l9crm1RHPq9aROPH6QHSPRBtHnC9sztA6Wwjl2gjvO4FYcgYS7O1juNZx0TFDiW50MGl
         8hTG9nJEbTKSXblz0gnkzxeXt+DuJ/CPQv1rG0zft8t3Yo9q1Cq6a++I6JtCvNMBl4xj
         i05g==
X-Gm-Message-State: APjAAAUxeRlK9Va/M2P17HOJaUeuuJZy/JvFfvjOgmQCp05bjoKDp1OD
        0znR9UpzNs8wYXE5P7JOsx5fyilK1gjkemKQeNRuSKFOfRw=
X-Google-Smtp-Source: APXvYqxVg8rifc6xWARcGcKwhNsrc+w58M3hPOw37yAdk62NyvEgpr0Be+TDHX4flYJZQCOr+WF75uOxrdy81pUxUvA=
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr3124374oie.5.1582073287013;
 Tue, 18 Feb 2020 16:48:07 -0800 (PST)
MIME-Version: 1.0
References: <1582022829-27032-1-git-send-email-wanpengli@tencent.com> <87zhdg84n6.fsf@vitty.brq.redhat.com>
In-Reply-To: <87zhdg84n6.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 19 Feb 2020 08:47:56 +0800
Message-ID: <CANRm+Cyx+J+YK8FzFBV8LRNPeCaXPc93vjFdpA0D_hA+wrpywQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Recalculate apic map in batch
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 20:24, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Wanpeng Li <kernellwp@gmail.com> writes:
>
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > In the vCPU reset and set APIC_BASE MSR path, the apic map will be recalculated
> > several times, each time it will consume 10+ us observed by ftrace in my
> > non-overcommit environment since the expensive memory allocate/mutex/rcu etc
> > operations. This patch optimizes it by recaluating apic map in batch, I hope
> > this can benefit the serverless scenario which can frequently create/destroy
> > VMs.
> >
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>
> An alternative idea: instead of making every caller return bool and
> every call site handle the result (once) just add a
> KVM_REQ_APIC_MAP_RECALC flag or a boolean flag to struct kvm. I
> understand it may not be that easy as it sounds as we may be conunting
> on valid mapping somewhere before we actually get to handiling

Yes.

> KVM_REQ_APIC_MAP_RECALC but we may preserve *some*
> recalculate_apic_map() calls (and make it reset KVM_REQ_APIC_MAP_RECALC).

Paolo, keep the caller return bool or add a booleen flag to struct
kvm, what do you think?

    Wanpeng
