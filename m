Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE7C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3684E206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr40nDBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCGBje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:39:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40476 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 20:39:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id 19so1336143ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vk7WexqGs9tKsJw0u0mXwTU3mYoTxeM70bWaTcQP0sk=;
        b=Mr40nDBsa29tmNy/wYcVN8rJvjzzdDoxgm/e0OT/i+X5gj6oERCsq+lDLv8GhQsZvs
         /BW/cUQyoz4S/WPxdEptsHM+GBEilpD4Nq2ZVnf1e/VdUZcP0S3oH15LeXAmHUqNpMJU
         hc+dfOGM0+/pKDaVUcRjZuLA2ZX+8fzJpf6a2+OZhv4DoKt4FhZxKsKX+TMfoM8eV3cX
         gdf6759jtZGcpu+05fD27i3KizcmrSWCB490SZhraUQfGXmd1xm/l2W3UJxNjhz63IlK
         KwRoD0XOwJmlTmmjvAY3H6VoHLcfOfb/26gbr1LMAchIY5Qk65YOqoeA6kQTVQKBaRnJ
         rxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vk7WexqGs9tKsJw0u0mXwTU3mYoTxeM70bWaTcQP0sk=;
        b=TI8EdJYR8PZX6eHpEKfJ5iE//r+WxWUi8WBGbYSR4exe5KJAxUag9yI7jUXmORF2kL
         KJL8ozeveOwFb9y8woDFPRxz+LOXiOuACJRIDSf4c9yydR3KAv1Q7MCPD8AQn26MrGCC
         5WK2RmYLntPyw4LIsW7MiLjXmfntmtnZdp6T4wGHgoqTTYsGxSe9htk27NKMGS6IZtRh
         zxvW4ZrifSuMorSTUK39gARxla7avj3LMLssYbujIgQk9Z3QUviFV4+KFZgmsb1nFf2h
         NdVwmaE5IStPmqUdRv6gbgOLKRvq74NG32r99FVdx9oVVI1Z+amBDkhyDUNqjiy8evIm
         Cfaw==
X-Gm-Message-State: ANhLgQ21uvnZwk+AhOovGcSKF0H1ILFoZabwG9akdAwEuLgVwrAv7BP6
        ibJvO4FF9BIvnqiU5moRpQb84OmamB408NTff4rYjQ==
X-Google-Smtp-Source: ADFU+vsV+qVX0unqQUwWcGQVeYWEY2ubHw2+vJbqxcPBD1kNsVUvnDRy2az5R7tCqlw5INchb6uGPLZKiPuNJEV393c=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr3359183ljp.66.1583545170498;
 Fri, 06 Mar 2020 17:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-3-rajatja@google.com>
 <87o8tbnnqa.fsf@intel.com> <CACK8Z6HRB9q1KeborGr7V-0Qp0AApHV6gBTkc6xD5NokH8gr0w@mail.gmail.com>
 <87tv31om53.fsf@intel.com>
In-Reply-To: <87tv31om53.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 6 Mar 2020 17:38:53 -0800
Message-ID: <CACK8Z6HFOpsfhHo=y9Qj_NSdiCGBHsvchZ335mU1BQ5CYQq1VQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm/i915: Lookup and attach ACPI device node for connectors
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 1:42 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Thu, 05 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > On Thu, Mar 5, 2020 at 1:41 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>
> >> On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> >> 1) See if we can postpone creating and attaching properties to connector
> >> ->late_register hook. (I didn't have the time to look into it yet, at
> >> all.)
> >
> > Apparently not. The drm core doesn't like to add properties in
> > late_register() callback. I just tried it and get this warning:
>
> I kind of had a feeling this would be the case, thanks for checking.

Thinking about it again, it looks like there is a difference in
creating a property and attaching a property. I'm wondering if drm
would let me (unconditionally) create a property before registering,
and attach it in late_register() only in case a privacy screen is
detected. (If not present, I can destroy the property in
late_register()). If this approach sound more promising, I can try it
out.

>
> >> 2) Provide a way to populate connector->acpi_device_id and
> >> connector->acpi_handle on a per-connector basis. At least the device id
> >> remains constant for the lifetime of the drm_device
> >
> > Are you confirming that the connector->acpi_device_id remains constant
> > for the lifetime of the drm_device, as calculated in
> > intel_acpi_device_id_update()?  Even in the face of external displays
> > (monitors) being connected and disconnected during the lifetime of the
> > system? If so, then I think we can have a solution.
>
> First I thought so. Alas it does not hold for DP MST, where you can have
> connectors added and removed dynamically. I think we could ensure they
> stay the same for all other connectors though. I'm pretty sure this is
> already the case; they get added/removed after all others.
>
> Another thought, from the ACPI perspective, I'm not sure the dynamically
> added/removed DP MST connectors should even have acpi handles. But
> again, tying all this together with ACPI stuff is not something I am an
> expert on.

I propose that we:

1) Maintain a display_index[] array within the drm_dev, and increment
as connectors are added.
2) Initialize connector->acpi_device_id and and connector->acpi_handle
while registering (one time per connector).
3) Remove the code to update acpi_device_id on every resume.

It doesn't look like anyone on the DP MST side has cared for ACPI so
far, so I doubt if we can do anything that might break MST currently.
In other words, the above should not make things any worse for MST, if
not better. For connectors other than MST, this should allow them to
get ACPI handle and play with it, if they need.

WDYT?

Thanks,

Rajat

>
> >> (why do we keep
> >> updating it at every resume?!) but can we be sure ->acpi_handle does
> >> too? (I don't really know my way around ACPI.)
> >
> > I don't understand why this was being updated on every resume in that
> > case (this existed even before my patchset). I believe we do not need
> > it. Yes, the ->acpi_handle will not change if the ->acpi_device_id
> > does not change. I believe the way forward should then be to populate
> > connector->acpi_device_id and connector->acpi_handle ONE TIME at the
> > time of connector init (and not update it on every resume). Does this
> > sound ok?
>
> If a DP MST connector gets removed, should the other ACPI display
> indexes after that shift, or remain the same? I really don't know.
>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel Open Source Graphics Center
