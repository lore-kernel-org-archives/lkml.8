Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9682C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA3D2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJA+l7Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgFZTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZTFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:05:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6EBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:05:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so8257243qtr.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feEl/u8azpaeqW6RfARQL9oMyPymwJO5VI5g0EP6AEY=;
        b=UJA+l7Ocu48/tZ+XKlR+NSOZks4PEuR8pjuU35SntOcfN1c1fmgpQQA7DvZvdUZYrs
         /PLvXXPWdloganx6+5GR1/HSPTmvbRibHEmZgwRtKZ38uRR45mos9swYRGJSKxBdiAUW
         HLT3XRTNwwk0owsgYEWBj9ErGpYHSJE+/gxTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feEl/u8azpaeqW6RfARQL9oMyPymwJO5VI5g0EP6AEY=;
        b=a0+txtlEY6z2hUp9NpexJCN0wraTi151dgtM2uiRmQd+nR8s+C7DQJ+drkMrA/km9s
         WYThSVMcJihWWiSe4anNiEJ71hohFHK0WDjfuma7nBbQC3cjNiHYQ07CLATp/ylAGhtL
         6piIe+5oJrdFtvn93/rjCqnXZt9zA3/rcyRo7uFf2iQa1uRzXy47bYOdZ/co/xOtNLUd
         /bAzBznKlFj6QnjdAONQV52M6ly7fLhnH+Tj8rUT1xqFeUA8dN1AWBaIPssqS+qbpG/2
         uesyJDsrdelkYPnVAygauVaCWINjmAHwUefToNhhCMJ4Dqp/Rqg9mBgHSrw9ARk1Pxru
         VsIw==
X-Gm-Message-State: AOAM531Nfc09cAFnYsfXaL5CIhasSq3N5Q7RnDrBZCIPX76qn11yDXMI
        weMA5F3opDSuC2w5uvmWnUtu2dkXDadhZzthBs65Wg==
X-Google-Smtp-Source: ABdhPJztsTk11XTm+El6+1GB+QPjH9Nm9W+QjD3SU8IppGRkF6BHKyWIToveYya8HQYdtolvmaeJhx5OFuNsX0Cr1u8=
X-Received: by 2002:ac8:346e:: with SMTP id v43mr4269862qtb.265.1593198302392;
 Fri, 26 Jun 2020 12:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200624080926.165107-1-pmalani@chromium.org> <26f8dac0-36a0-65ba-a219-8c1d65f1799f@collabora.com>
In-Reply-To: <26f8dac0-36a0-65ba-a219-8c1d65f1799f@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 26 Jun 2020 12:04:52 -0700
Message-ID: <CACeCKae7LHrCPS20SjtSTVYViaKqTHaTxxhBbBcp4GFrjuUdyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Add TBT pd_ctrl fields
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric!

On Fri, Jun 26, 2020 at 2:11 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 24/6/20 10:09, Prashant Malani wrote:
> > To support Thunderbolt compatibility mode, synchronize
> > ec_response_usb_pd_control_v2 with the Chrome EC version, so that
> > we get the Thunderbolt related control fields and macros.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> Applied both patches for 5.9
>
> > ---
> >  .../linux/platform_data/cros_ec_commands.h    | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> > index a7b0fc440c35..b808570bdd04 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -4917,15 +4917,26 @@ struct ec_response_usb_pd_control_v1 {
> >  #define USBC_PD_CC_UFP_ATTACHED      4 /* UFP attached to usbc */
> >  #define USBC_PD_CC_DFP_ATTACHED      5 /* DPF attached to usbc */
> >
> > +/* Active/Passive Cable */
> > +#define USB_PD_CTRL_ACTIVE_CABLE        BIT(0)
> > +/* Optical/Non-optical cable */
> > +#define USB_PD_CTRL_OPTICAL_CABLE       BIT(1)
> > +/* 3rd Gen TBT device (or AMA)/2nd gen tbt Adapter */
> > +#define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
> > +/* Active Link Uni-Direction */
> > +#define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
> > +
> >  struct ec_response_usb_pd_control_v2 {
> >       uint8_t enabled;
> >       uint8_t role;
> >       uint8_t polarity;
> >       char state[32];
> > -     uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
> > -     uint8_t dp_mode;  /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> > -     /* CL:1500994 Current cable type */
> > -     uint8_t reserved_cable_type;
> > +     uint8_t cc_state;       /* enum pd_cc_states representing cc state */
> > +     uint8_t dp_mode;        /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> > +     uint8_t reserved;       /* Reserved for future use */
> > +     uint8_t control_flags;  /* USB_PD_CTRL_*flags */
> > +     uint8_t cable_speed;    /* TBT_SS_* cable speed */
> > +     uint8_t cable_gen;      /* TBT_GEN3_* cable rounded support */
> >  } __ec_align1;
> >
> >  #define EC_CMD_USB_PD_PORTS 0x0102
> >
