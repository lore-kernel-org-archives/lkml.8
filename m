Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8EBC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBD207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhvTsaxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgA2Wx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:53:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36544 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Wx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:53:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so1227247ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOj9kLL9OKVQ4bW9RaNCXxV8jEQPASFBUj6KpH5YEho=;
        b=ZhvTsaxyumUnK5Lu8sLn5DccXNEakQ95xz2a5jJgoALEIjbzYMz+4NuzN5D0bwSDAZ
         ZUxe18Sf15dIFiwptjxYt4tad25GXwWuCR0g5arQP9n5P5K+RmXgEeO23cOuZYzu2YBx
         3B334rQ7Kc4A2unostW515ssokqI5D0CdGCL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOj9kLL9OKVQ4bW9RaNCXxV8jEQPASFBUj6KpH5YEho=;
        b=PWKGIztTqgH1rEznIHYvO4fj7wTEYz+VUEQswilQByx652R7e337JK8hV82vBSGKmF
         vKAaFEFPr1FBzTZ6MMzCXhGXAE7VOaxi6PDZuZb83Mii4ozA7mWEWrVO5jBHTYVm2zXH
         pmEbqwQ8LeOJapopmqwCL8jyZymDLLOj0Ffo7xEp+lYK4LgxDbT263J3kFlpdu20Rt//
         WoyiUUVuitc68I5lNqkD4gkiiJkP6KiFI6nbX5QeR/v4j+LGWBiO007rR70tAlN8WwNw
         fWdM8b03scRxG0Moa78rTUM9bt5nfjdrfh3a3vQ6+r3vF/Rdz2v1EjAS9Y7pCkf+/K0X
         QYDQ==
X-Gm-Message-State: APjAAAXuZZIfwcL8hxjNo/tRAQanRFQF4SVvw86Xm0sB7eI8/1xhtMXX
        Dfnf7Fgut3g1eqnNa0eSdvynTsrYE5Y=
X-Google-Smtp-Source: APXvYqwk4ckcMTvX+7gn7Z26lK5WaGXIdQQidh3KQLC2AZ/l7ib16h4i3xWm405xbczYM5h7nA3D1w==
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr846934ljo.32.1580338433828;
        Wed, 29 Jan 2020 14:53:53 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t9sm1719109lfl.51.2020.01.29.14.53.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 14:53:52 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id v17so1215226ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 14:53:52 -0800 (PST)
X-Received: by 2002:a2e:8702:: with SMTP id m2mr596560lji.278.1580338432116;
 Wed, 29 Jan 2020 14:53:52 -0800 (PST)
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
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877e1a2d11.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 14:53:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
Message-ID: <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
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

On Wed, Jan 29, 2020 at 1:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Tue, Jan 28, 2020 at 2:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Bah. I'm sure I looked at that call chain, noticed the double vector
> >> lock and then forgot. Delta patch below.
> >
> > It's working well with the delta patch, been running for about an hour
> > with no issues.
>
> thanks for the info and for testing!
>
> Could you please add some instrumentation to see how often this stuff
> actually triggers spurious interrupts?

In about 10 minutes of this script running, I got 142 hits. My script
can toggle the HT cpus on and off about twice per second.
Here's my diff (sorry it's mangled by gmail). If you're looking for
something else, let me know, or I can run a patch.

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 90baf2c66bd40..f9c46fc30d658 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -61,6 +61,8 @@ static void irq_msi_update_msg(struct irq_data
*irqd, struct irq_cfg *cfg)
        irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
 }

+int evanpending;
+
 static int
 msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 {
@@ -155,8 +157,10 @@ msi_set_affinity(struct irq_data *irqd, const
struct cpumask *mask, bool force)

        unlock_vector_lock();

-       if (pending)
+       if (pending) {
+               printk("EVAN pending %d", ++evanpending);
                irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+       }

        return ret;
 }

-Evan
