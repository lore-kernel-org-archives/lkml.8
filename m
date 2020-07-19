Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB35C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC3A21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmaF0854"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgGSTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 15:51:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgGSTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595188269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+W4juhVWCiEA3fhSp7PQYC8FiX7DnbLymUoDvTE4gg=;
        b=hmaF0854vEaDyXo3jhOu1rLfdEDINnMjQwwvYvuWrrDi9xSzynTTDKGgnPsKZCRArOx072
        CtOKQYAEajORhXDeYeOEPwi7bYP+1AhiOjwR1dueArMVck36Hzm641JYR10sXH+55NE+Wc
        Kdgv2LVQJKlgo/RvOBaQggAhFGpgDnY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-z6lWsa8HPM2rgocvSnkYSg-1; Sun, 19 Jul 2020 15:51:08 -0400
X-MC-Unique: z6lWsa8HPM2rgocvSnkYSg-1
Received: by mail-qk1-f198.google.com with SMTP id q3so1563740qkj.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+W4juhVWCiEA3fhSp7PQYC8FiX7DnbLymUoDvTE4gg=;
        b=PSbjgMJk3a0atyYPH+Y4W57nsygqie+cRjD5BXxH2u7xqfplNdA53ThWdMEUwVAzNj
         wB+XWIR04ud8KXga1Wk7zZkLJLx/Gk9oZN2dI4/5cD83GO8ZUzc7bA9PbMJBfg+lGQDm
         aZ/Ks8VZQlLTpa5ydu/KVlmsXSysLQ3QCe61VNJBbHpB+g9l7feQwNBco3NkWz3DmVlN
         PbwGb9OazNXWu4ggFg15z+MDBIXxkPUKw552iMTOKyS6MJjJSAwtxhRKMXxeF8YhbSe+
         jP7SQoC5J0pbY+Wo1b6zo78D0ziByYluMZpdljpgMT0xBIOzUicAQQ62U5KUFj25G8eY
         n+MQ==
X-Gm-Message-State: AOAM531TAjf2ioDg3tZm1qRCoo8oZSq/Z3P0xFiQn/Ek/VyFnGpVt9XS
        hIY3R/R6a5CBg2awOQfcMo1GWEf7BtT7rRu3zkqgNU+PUCZRpPck9ssAzsIJa0vsluMgSfqeWAp
        6u8hjaGSlaAFpYRIGv+wDjsiuHgkQ3AjNo9rsfPlf
X-Received: by 2002:ac8:4250:: with SMTP id r16mr20990800qtm.378.1595188267463;
        Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9yVJg1QjyL9ivv5A6w+hu0GivIVSEEJqorLOC5n0j8PWQVDcfmYvz9E5//ryrqzbOSjwmCLlGhUm5y3yGbRs=
X-Received: by 2002:ac8:4250:: with SMTP id r16mr20990785qtm.378.1595188267211;
 Sun, 19 Jul 2020 12:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200717190547.648604-1-kherbst@redhat.com> <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
In-Reply-To: <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sun, 19 Jul 2020 21:50:56 +0200
Message-ID: <CACO55tvLCrqeV8MsVDbTaWP2EPAeZtfU08Kb2fVGCD6X+g3-rg@mail.gmail.com>
Subject: Re: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics laptops
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 9:52 PM Alex Hung <alex.hung@canonical.com> wrote:
>
> On 2020-07-17 1:05 p.m., Karol Herbst wrote:
> > It's hard to figure out what systems are actually affected and right now I
> > don't see a good way of removing those...
> >
> > But I'd like to see thos getting removed and drivers fixed instead (which
> > happened at least for nouveau).
> >
> > And as mentioned before, I prefer people working on fixing issues instead
> > of spending time to add firmware level workarounds which are hard to know
> > to which systems they apply to, hard to remove and basically a big huge
> > pain to work with.> In the end I have no idea how to even figure out what systems are affected
> > and which not by this, so I have no idea how to even verify we can safely
> > remove this (which just means those are impossible to remove unless we risk
> > breaking systems, which again makes those supper annoying to deal with).
> >
> > Also from the comments it's hard to get what those bits really do. Are they
> > just preventing runtime pm or do the devices are powered down when booting?
> > I am sure it's the former, still...
> >
> > Please, don't do this again.
> >
> > For now, those workaround prevent power savings on systems those workaround
> > applies to, which might be any so those should get removed asap and if
> > new issues arrise removing those please do a proper bug report and we can
> > look into it and come up with a proper fix (and keep this patch out until
> > we resolve all of those).
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > CC: Alex Hung <alex.hung@canonical.com>
> > CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > CC: Len Brown <lenb@kernel.org>
> > CC: Lyude Paul <lyude@redhat.com>
> > CC: linux-kernel@vger.kernel.org
> > CC: dri-devel@lists.freedesktop.org
> > CC: nouveau@lists.freedesktop.org
> > ---
> >  drivers/acpi/osi.c | 24 ------------------------
> >  1 file changed, 24 deletions(-)
> >
> > diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> > index 9f68538091384..d4405e1ca9b97 100644
> > --- a/drivers/acpi/osi.c
> > +++ b/drivers/acpi/osi.c
> > @@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
> >       {"Processor Device", true},
> >       {"3.0 _SCP Extensions", true},
> >       {"Processor Aggregator Device", true},
> > -     /*
> > -      * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> > -      * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> > -      * cards will hang without RTD3 disabled.
> > -      *
> > -      * Once NVidia drivers officially support RTD3, this _OSI strings can
> > -      * be removed if both new and old graphics cards are supported.
> > -      */
> > -     {"Linux-Dell-Video", true},
> > -     /*
> > -      * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
> > -      * audio device which is turned off for power-saving in Windows OS.
> > -      * This power management feature observed on some Lenovo Thinkpad
> > -      * systems which will not be able to output audio via HDMI without
> > -      * a BIOS workaround.
> > -      */
> > -     {"Linux-Lenovo-NV-HDMI-Audio", true},
> > -     /*
> > -      * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> > -      * output video directly to external monitors on HP Inc. mobile
> > -      * workstations as Nvidia and AMD VGA drivers provide limited
> > -      * hybrid graphics supports.
> > -      */
> > -     {"Linux-HPI-Hybrid-Graphics", true},
> >  };
> >
> >  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> >
>
> The changes were discussed and tested a while ago, and no crashes were
> observed. Thanks for solving PM issues in nouveau.
>
> Acked-by: Alex Hung <alex.hung@canonical.com>
>

By any chance, do you have a list of systems implementing those workarounds?

