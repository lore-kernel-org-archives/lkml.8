Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A250C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3150221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q2tp+5P1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgHFSjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgHFSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:39:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA633C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:39:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so45848161qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEB+eFbcq/8iHsVmYFS7GFD4Ork+qLK5d/Ky4s3qseI=;
        b=Q2tp+5P1jjX7ju+lu4QjZLIHjUwFBSVpdKRx5cHBtE2mbipB6yjkGx9HczVww/9HMu
         LOTPafsEWgRWDVZeJjKFyKzI/KoRVSMHwKlbrI/HuNMmFOvFq6PZYJsrvzRcHIjLk4LE
         hEmBbV28IrEOAXwhWtCYJFBJCR+/gAUYzJTvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEB+eFbcq/8iHsVmYFS7GFD4Ork+qLK5d/Ky4s3qseI=;
        b=qu0PB2CeMYdxFNPrwA+H97B5rVS1lsRDy35Wy2xUske0cMwkdJZGMC4j12jIr0oKXx
         m2HcKBWGVL6E9p2M7i/ah5BL64xIatqieD0svfSwjtaYZXjnDx3BZFMDEYaUG5cmX7JO
         okIJnlf3q8uHhS1QfijvIzvb97ePBxLP8+FJZAxtfcEFoyyruCGGML7yJjuzD7s/QUIf
         NItQ7Y3o8k7NCnMbUvA7eISbDnpNmtqlxmbGAh0FG4u6wRXHAxRRt9fxhtqlWMhgdplq
         DZ+fWQ5UKE9UdLnFKC5Fz4QJu0/E4HKoLXFybQ9YohqC4wEUFhdnuMCJl3tjuee8DAYr
         fXgA==
X-Gm-Message-State: AOAM530g6vJ2HRpd4RZxKYTGHV74MukYYn1t/LeeObRSm/ITnQ3OMXhP
        hCHPq0Q0+KKpzrusGBe5thr0Djs3dZ2IUxtPh3RwRg==
X-Google-Smtp-Source: ABdhPJzFzzFbqbRQyoOETbw3G8FdBFxzF/Y39ZK/3j5jMz8+Kj+aqclKQnQvhWeswXsGDvrdXC9xQLyanNW3umXpEZI=
X-Received: by 2002:a37:e01:: with SMTP id 1mr9696836qko.128.1596739159829;
 Thu, 06 Aug 2020 11:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200730225609.7395-1-azhar.shaikh@intel.com> <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com> <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com> <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com> <20200806113907.GX883641@kuha.fi.intel.com>
In-Reply-To: <20200806113907.GX883641@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 6 Aug 2020 11:39:08 -0700
Message-ID: <CACeCKaeLmVudhssvnYrQGmnJiD-byW8jOas1QKyQj4gg0=sC4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Aug 6, 2020 at 4:39 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Aug 05, 2020 at 12:37:14PM -0700, Prashant Malani wrote:
> > Hi Azhar,
> >
> >
> > On Wed, Aug 5, 2020 at 12:22 PM Shaikh, Azhar <azhar.shaikh@intel.com> wrote:
> > >
> > > Hi Prashant,
> > >
> > > > Is this documented anywhere? Kindly provide the links to that if so. I wasn't
> > > > aware of any ordering requirements (but I may be missing something).
> > >
> > > The configuration of the connector should always happen in the order defined in the
> > > USB Type-C specification. Check ch. 2.3 (USB Type-C Spec R2.0). So that will basically give you:
> > >
> > > 1. orientation
> > > 2. role(s)
> > > 3. the rest.
> >
> > Thanks for the link. Are you referring to Section 2.3 (Configuration
> > Process) ? I couldn't find anything there which
> > implied any required ordering (I'm reading Release 2.0, Aug 2019, so I
> > don't know if something has been added since).
> > Could you kindly point me to the appropriate subsection?
>
> Please check the section 4.5.1.2 (Connecting Sources and Sinks). Check
> the typical flow. You can also check the Connection State Machine
> Requirements. The order should be clear from those as well.

Thanks for sending the section info.

>
> 1. Source/sink detection
> 2. Orientation
> 3. Data role
> 4. VCONN
> 5. VBUS (USB Type-C currents)
> 6. The connector is now configured. We can start the PD communication
>    that should lead into configuration of the mux if we enter a mode.

The cros-ec-typec driver only receives a USB_PD_MUX_INFO [1] host
command after we've
already entered the mode as far as PD communication is concerned
(steps 1-5 and even PD communication
to enter the mode is already done by the time cros-ec-typec receives
PD_MUX_INFO).
There is no further PD communication to be done in this case (for a
particular mode), at least nothing that
is triggered by the AP.

>
> The data role, the thing that we are talking about here, really should
> be set before the mux is configured.

I apologize but I still didn't see anything there enforcing an
ordering for those on any AP switches. The state
machine you're referring to ((I assume you are referring to Figure
4-12 to Figure Figure 4-18)
is already implemented in the TCPM in the Chrome EC for the Chrome OS
Platform [2]

Perhaps we can take that discussion off-mailing list if necessary ?
(I'd like to avoid blasting the large mailing list
with more discussion email, but also happy to continue here if that's
the preference).

To be clear, all these comments are limited to the only Chrome OS platform.
>
> > Additionally, I think any ordering requirements there are already
> > handled by the TCPM in the Chrome OS EC.
>
> The TCPM does not execute the steps that configure the port on this
> platform. The OS is the part that actually executes the steps.

My response was w.r.t section 2.3 (the section which was originally
quoted) which deals
with things like:
"
- Source-to-Sink attach/detach detection
- Plug orientation/cable twist detection
- Detect if cable requires Vconn
"
etc.

All these things are performed by the Chrome OS EC (via TCPM or the TCPC).
For the items listed in Section 4.5.1.2, AFAIK those steps are
performed by the Chrome OS EC (via
a combination of the TCPM and TCPC).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/tree/include/linux/platform_data/cros_ec_commands.h?h=for-kernelci#n5214
[2]: https://source.corp.google.com/chromeos_public/src/platform/ec/common/usbc/

>
> That is one reason (but not the only one) why it is important that
> both parts follow the order that is proposed in the spec. Otherwise we
> may endup negotiating things with the partner in one order but then
> actually executing those steps in some other.

I agree with this, but since the role of TCPM is performed by the
Chrome EC, I'm not convinced this patch is
addressing any spec related ordering requirements.

As I mentioned above, the Chrome OS EC is following the state machine
as well as the section
of the spec you referred to.

I would suggest:
- Merging Patch 1 (role set correction) and Patch 2 (moving the
usb_role_switch_set_role() inside cros_typec_configure_mux()
*but* keep it at the end to preserve existing ordering) into 1 patch.
- Add another patch which re-orders the calls and which in the commit
message lists out all the reasons why this re-ordering
needs to be done.

Doing the above will help keep better track of why the changes were made.

BR,

-Prashant
>
>
> thanks,

>
> --
> heikki
