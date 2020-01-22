Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733D8C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607A24125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l0BjLgYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAVS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:27:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAVS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:27:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so59688ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBMN4EhSOng7OnOM0rFt2rQoKyMKqooeWsHDlQ/9cwM=;
        b=l0BjLgYLS21obPxMv7d6xqzMaOed/W5XTPs9Jiy2R5BcIFcoPH/KAbR0zP72cJuPhM
         6fni2+ohfrz9SGtbVkxchp8s/haS3M73YZjtu7djO8sq/aDCiz60GbWTYw2kbyOsKIHo
         SWbU9PtSdm2UWgu/bArY2QGZaEjTux8sunsCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBMN4EhSOng7OnOM0rFt2rQoKyMKqooeWsHDlQ/9cwM=;
        b=TPgiMfSPNusnVdGoxJpBP7oj/Yk/BQZzXZ8fMe30AAtJcJvRuK+Pt7c4t18a5NxeUl
         mIMVveCXSTrzkazHITp4vEKUmseRk1fi1sp9unepuXl/+llAijs42Y54n40Qb9ugKQm8
         c4pBn9w0TV++k/wFwUsGWeuB5Sc2Hx0tvYFes+DTcQVQAiI2fWTSyodix7pUV04vEqBh
         JxEJTnIhwEjbYdkdza9xt57Gu+weC61Xg1Mrag8NBMxQP9fhjFxhduMgStfsLnCbjrnw
         Tm2K9DX5YE84UqLyNhyAcfcy4zLmgiTdtZOh93+Fayh+I6m+D7jJZrkOy2cucek+F4fA
         qEVg==
X-Gm-Message-State: APjAAAXUA4RLySx4AjiU4g0pzwnW0H76fxwg573HI78PIDP4eBCzMq6R
        yJgF1oyohnlOGlHNNRDnbSO6c8Z6pvs=
X-Google-Smtp-Source: APXvYqxKkA6UfMPOcgcyY8/UdQy7QKh1+zeNYVEMvfnoLuu8mgxV8xaky89/WElRHbxb9TT67k1ltA==
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr19820192ljc.246.1579717633345;
        Wed, 22 Jan 2020 10:27:13 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o6sm870961lfg.11.2020.01.22.10.27.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 10:27:12 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f24so361062lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:27:11 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2260437lfs.99.1579717631192;
 Wed, 22 Jan 2020 10:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <20200122172816.GA139285@google.com>
In-Reply-To: <20200122172816.GA139285@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 10:26:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
Message-ID: <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 9:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Thomas, Marc, Christoph, Rajat]
>
> On Thu, Jan 16, 2020 at 01:31:28PM -0800, Evan Green wrote:
> > __pci_write_msi_msg() updates three registers in the device: address
> > high, address low, and data. On x86 systems, address low contains
> > CPU targeting info, and data contains the vector. The order of writes
> > is address, then data.
> >
> > This is problematic if an interrupt comes in after address has
> > been written, but before data is updated, and the SMP affinity of
> > the interrupt is changing. In this case, the interrupt targets the
> > wrong vector on the new CPU.
> >
> > This case is pretty easy to stumble into using xhci and CPU hotplugging.
> > Create a script that targets interrupts at a set of cores and then
> > offlines those cores. Put some stress on USB, and then watch xhci lose
> > an interrupt and die.
> >
> > Avoid this by disabling MSIs during the update.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >
> > Bjorn,
> > I was unsure whether disabling MSIs temporarily is actually an okay
> > thing to do. I considered using the mask bit, but got the impression
> > that not all devices support the mask bit. Let me know if this going to
> > cause problems or there's a better way. I can include the repro
> > script I used to cause mayhem if needed.
>
> I suspect this *is* a problem because I think disabling MSI doesn't
> disable interrupts; it just means the device will interrupt using INTx
> instead of MSI.  And the driver is probably not prepared to handle
> INTx.
>
> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
> disabled, the Function requests servicing using INTx interrupts (if
> supported)."
>
> Maybe the IRQ guys have ideas about how to solve this?
>

But don't we already do this in __pci_restore_msi_state():
        pci_intx_for_msi(dev, 0);
        pci_msi_set_enable(dev, 0);
        arch_restore_msi_irqs(dev);

I'd think if there were a chance for a line-based interrupt to get in
and wedge itself, it would already be happening there.

One other way you could avoid torn MSI writes would be to ensure that
if you migrate IRQs across cores, you keep the same x86 vector number.
That way the address portion would be updated, and data doesn't
change, so there's no window. But that may not actually be feasible.

-Evan
