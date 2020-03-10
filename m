Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB7824655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIynxTGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCJAKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:10:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34124 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCJAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:10:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id i19so3392327lfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qgrrl/PIS4y9k8c+4r54kiLV+rLBtZ0nrsWDLZmeMn4=;
        b=MIynxTGDbmrJlCOvfmOik94Q8oGE0PsOjavcV+1d61XGYkRoLB1qrCJIi8VIhezGuR
         sMIhJZjGAfnmbCB/ldF9KkgTjYgL9aHpUWFKOH7MjRLCAakxN1pw5bsnfSC/v0H8kKsL
         zNhp/U/O8wx+lJ60wHTqEajE8uSFkfo4bulvlBhsjHmJOMQr7qLMz/wtXhQaWK2DgKs7
         ULYhtHP6mxfbf0vk1XeDO61EfEW/SECdbsUMxFJZIGLTTUBQBLPP8o3g+RGbJpNkkqAx
         RpL4g4roKcNrreA2utPOR8gust4fdB8coMyE/9t3o5dg3Xntr0bpe/Zfbrz50BSMk/yW
         RTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qgrrl/PIS4y9k8c+4r54kiLV+rLBtZ0nrsWDLZmeMn4=;
        b=eCLHTbK+NbjchXQFjd691D/02nvCTTiPAlz/+uWwBtX6gMPCpyW89wUyIsngIpbXPX
         x+AkNH92xVXC2L7E492Pe0RieszNypMr1q/SIB1TgFz+m28rXEgB9WyYiw9uTO2yzQqE
         y+7LbpS9GoseTj7fX5V2uMy3yh7sD9b3zxT35oSd5N60KiVRq7EhoprgObG9Vl3T9NNK
         Z0zC4XCqgXdVNXnyhNwbBHNuaHlkyVA+4enX3yDxIFTiR+GhFaeDH3SsuxmY8GCC2HHd
         yLQlTIcC7ICSIbdG/XnbuHDCcLtGZ8ULR7Xgxy8hkHmGWPnm4qyX6pVQx9quD8iucaHg
         IJ/w==
X-Gm-Message-State: ANhLgQ03ZuqJ4vgxTzmyFv5irxHxz+z0vh4fmkn+w0UpaGTE9xhCRPQg
        8TYCRGqpksope1/MUp+XnJUFFYuvT1iFHWR1PKJjvw==
X-Google-Smtp-Source: ADFU+vt32UZtqnvEuXoVRdT8OyeT2tec9wmF5Ooht3N0fo2TBipeo6oX7FEFlDeeQ7mewl8OPgZY6Eb6w2C2DpYd0jY=
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr10503227lfb.122.1583799000954;
 Mon, 09 Mar 2020 17:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-3-rajatja@google.com>
 <87o8tbnnqa.fsf@intel.com> <CACK8Z6HRB9q1KeborGr7V-0Qp0AApHV6gBTkc6xD5NokH8gr0w@mail.gmail.com>
 <87tv31om53.fsf@intel.com> <CACK8Z6HFOpsfhHo=y9Qj_NSdiCGBHsvchZ335mU1BQ5CYQq1VQ@mail.gmail.com>
In-Reply-To: <CACK8Z6HFOpsfhHo=y9Qj_NSdiCGBHsvchZ335mU1BQ5CYQq1VQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 9 Mar 2020 17:09:23 -0700
Message-ID: <CACK8Z6FW3p6h1pfW2kPxiwBoDDcK3R76Aoxa-17P+MpU+w20hw@mail.gmail.com>
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

On Fri, Mar 6, 2020 at 5:38 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Fri, Mar 6, 2020 at 1:42 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Thu, 05 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > > On Thu, Mar 5, 2020 at 1:41 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >>
> > >> On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > >> 1) See if we can postpone creating and attaching properties to connector
> > >> ->late_register hook. (I didn't have the time to look into it yet, at
> > >> all.)
> > >
> > > Apparently not. The drm core doesn't like to add properties in
> > > late_register() callback. I just tried it and get this warning:
> >
> > I kind of had a feeling this would be the case, thanks for checking.
>
> Thinking about it again, it looks like there is a difference in
> creating a property and attaching a property. I'm wondering if drm
> would let me (unconditionally) create a property before registering,
> and attach it in late_register() only in case a privacy screen is
> detected. (If not present, I can destroy the property in
> late_register()). If this approach sound more promising, I can try it
> out.

I tried out this approach, and it worked. The new patchset is posted at:

https://patchwork.freedesktop.org/series/74473/#rev1

Thanks!

Rajat

>
> >
> > >> 2) Provide a way to populate connector->acpi_device_id and
> > >> connector->acpi_handle on a per-connector basis. At least the device id
> > >> remains constant for the lifetime of the drm_device
> > >
> > > Are you confirming that the connector->acpi_device_id remains constant
> > > for the lifetime of the drm_device, as calculated in
> > > intel_acpi_device_id_update()?  Even in the face of external displays
> > > (monitors) being connected and disconnected during the lifetime of the
> > > system? If so, then I think we can have a solution.
> >
> > First I thought so. Alas it does not hold for DP MST, where you can have
> > connectors added and removed dynamically. I think we could ensure they
> > stay the same for all other connectors though. I'm pretty sure this is
> > already the case; they get added/removed after all others.
> >
> > Another thought, from the ACPI perspective, I'm not sure the dynamically
> > added/removed DP MST connectors should even have acpi handles. But
> > again, tying all this together with ACPI stuff is not something I am an
> > expert on.
>
> I propose that we:
>
> 1) Maintain a display_index[] array within the drm_dev, and increment
> as connectors are added.
> 2) Initialize connector->acpi_device_id and and connector->acpi_handle
> while registering (one time per connector).
> 3) Remove the code to update acpi_device_id on every resume.
>
> It doesn't look like anyone on the DP MST side has cared for ACPI so
> far, so I doubt if we can do anything that might break MST currently.
> In other words, the above should not make things any worse for MST, if
> not better. For connectors other than MST, this should allow them to
> get ACPI handle and play with it, if they need.
>
> WDYT?
>
> Thanks,
>
> Rajat
>
> >
> > >> (why do we keep
> > >> updating it at every resume?!) but can we be sure ->acpi_handle does
> > >> too? (I don't really know my way around ACPI.)
> > >
> > > I don't understand why this was being updated on every resume in that
> > > case (this existed even before my patchset). I believe we do not need
> > > it. Yes, the ->acpi_handle will not change if the ->acpi_device_id
> > > does not change. I believe the way forward should then be to populate
> > > connector->acpi_device_id and connector->acpi_handle ONE TIME at the
> > > time of connector init (and not update it on every resume). Does this
> > > sound ok?
> >
> > If a DP MST connector gets removed, should the other ACPI display
> > indexes after that shift, or remain the same? I really don't know.
> >
> > BR,
> > Jani.
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
