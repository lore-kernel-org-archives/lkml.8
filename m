Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282F02080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593177443;
	bh=ih6xJ92s1/W10+gSLqgRTgoWophOuPS9vj+qwA1LP3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U/vnn+Q13GGsWzRNDogCRZDst/Ih+cSAK1CFyYXS8qxc+sI2IosA1LoXgwreREKxy
	 bYiLaI3Vog9jP6XFuzp285w6XSY3icDbnA0oxqq/zHQAYxvPVtYdWuKUe3qReMMXB/
	 kelsu4OBweEmVJmGtwJRbOx2tZfZPYp0eiemV7ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgFZNRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:17:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46707 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgFZNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:17:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id n24so6317125otr.13;
        Fri, 26 Jun 2020 06:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEpxwyqxU/CXnVQNUqgC4JtnG+1gAIg8SLvP9r7YDQs=;
        b=HKmaPajkrDo5tPSSTGjN7fAIkTCVnt5zPTmWWJ+ermiHCZS39jkBMy+Wq41x8/BvVF
         Gtq2apva5IncZzozTpoD+tUq3nacjHdb0rOHgMOw5oM72eZ1zCTzbWCh5zGLiJKqGfhh
         jdflkCrk9JxzA/8gFcTmXjcCfosL7iS889UuL7zcrcrJbyJkf3g8gJMuPKEVXor+O+i+
         seg21xp9mstWxGRFoqgHbT1WSbBAA/8UjCKuQumocyl2wY04v9WC8kWLcMaz7bCKvJYP
         DKiLODz3jcl3QvEWlYNwM9cpSsB+e/K4UZT8ANqIiulHMU8iW7bR8h54aqDQnJeRzAi9
         zuhA==
X-Gm-Message-State: AOAM532Zfp/GMeLSl1MY7VXMzeNCzR9qswgT3kUFK4GtiNDYXBsY0SRe
        9Y1BmSiDPDeb2NiJ8P+QxNQGizuwrZ8pEU9dIGDBDg==
X-Google-Smtp-Source: ABdhPJyMDD4C50COKuuFiVYxSlLVuYKRyZWoBsls7kAHGP6D2L4tgrB28JwOI/k3pEfxBKTMMOieqO23bboqAtM/1iI=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr2243614oto.167.1593177439501;
 Fri, 26 Jun 2020 06:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200530143430.5203-1-oscar.carter@gmx.com> <07911cc62ef21900c43aeefbcbfc8d9f@kernel.org>
In-Reply-To: <07911cc62ef21900c43aeefbcbfc8d9f@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 15:17:08 +0200
Message-ID: <CAJZ5v0gJJsLyWokpVT8Cy-h+GE5nyqGip_Log1L9i5z+x+nTwg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] drivers/acpi: Remove function callback casts
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Len Brown <lenb@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 3:07 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Rafael,
>
> On 2020-05-30 15:34, Oscar Carter wrote:
> > In an effort to enable -Wcast-function-type in the top-level Makefile
> > to
> > support Control Flow Integrity builds, there are the need to remove all
> > the function callback casts in the acpi driver.
> >
> > The first patch creates a macro called
> > ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
> > to initialize the acpi_probe_entry struct using the probe_subtbl field
> > instead of the probe_table field to avoid function cast mismatches.
> >
> > The second patch modifies the IRQCHIP_ACPI_DECLARE macro to use the new
> > defined macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY instead of the macro
> > ACPI_DECLARE_PROBE_ENTRY. Also, modifies the prototype of the functions
> > used by the invocation of the IRQCHIP_ACPI_DECLARE macro to match all
> > the
> > parameters.
> >
> > The third patch removes the function cast in the
> > ACPI_DECLARE_PROBE_ENTRY
> > macro to ensure that the functions passed as a last parameter to this
> > macro
> > have the right prototype. This macro is used only in another macro
> > called "TIMER_ACPI_DECLARE". An this is used only in the file:
> >
> > drivers/clocksource/arm_arch_timer.c
> >
> > In this file, the function used in the last parameter of the
> > TIMER_ACPI_DECLARE macro already has the right prototype. So there is
> > no
> > need to modify its prototype.
>
> I'd like to see this into 5.9. Can you please let me know if
> you are OK with the acpi.h changes?

Yes, I am.

> I can queue it via the irqchip tree.

Please do!  Also please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patches.

Thanks!
