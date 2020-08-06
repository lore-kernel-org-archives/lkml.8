Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3FE21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S6Vv4bpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHFA6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHFA55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:57:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:57:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so25795864pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YduGH/WmNMcXrCb5ngBp1oczBlJ+WiqT9i5mvHsrLH4=;
        b=S6Vv4bpPIEGnUpRCqhCrG0UiFPtU2epBPuzOhfxyEVJlk3k8+ULDPvNaWHJotGNZFH
         Y7P/uVtx/P0l+wx2q9sT6/fbdQPiPryGWWGjEUZITbzewJ4hQjJXOGVVm/MFitZT7LRP
         qga9KWTVVmnfNhELiuLiyLnd5R7bmuIuwDiKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YduGH/WmNMcXrCb5ngBp1oczBlJ+WiqT9i5mvHsrLH4=;
        b=CkM9msrBbCSdXBB2MS0YQSU/4+y/q2hTb7W5RPrFVyldFWY7TPXzfiL8xshuYipFdv
         EF3hedmL5AS4mGFcFheAY5fhW4mFBVDyOSI7knB8iuZGfZtdWel824ZvEDcH0p7dSOd5
         tcNtbU2PONFP5efvgEUclomPH615JVGwn+8S5TAHgstSnzSXxNeDsKFK1C2ByZnRlqo/
         TMUo2ZmMIwnmzXr+5SZwx3zT3vQqZWUJgZ02gyVyClQnhoQZ3Y7u7u3Forx0U4aLbHxE
         wcu0fGSV1sCRQGlBapDa3TfvuvsgTkFXNICONWYp0UgPVJ0nLDRvnTVE/m88q7fWDgFu
         gY+w==
X-Gm-Message-State: AOAM530wptf+GVybXqnQofeP+fXNBN8f3NuV1HOZNzGCMvSmuk94UbBU
        Rj13OL/4QJ8ecc3Mf0u/fvkm3A==
X-Google-Smtp-Source: ABdhPJz+Ve3iHWhWQjmgncMRzfiQb/wXr0u9O/klfIZQGSYD3nZM4KOkBh8Ix2Vrwn3hJou+1RJYQw==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr5772915pfa.233.1596675472196;
        Wed, 05 Aug 2020 17:57:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id 199sm4820344pgc.79.2020.08.05.17.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 17:57:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 17:57:50 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Message-ID: <20200806005750.GH3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
 <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
 <MWHPR11MB151843C494EAFDAD0DE6BA81914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB151843C494EAFDAD0DE6BA81914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 05, 2020 at 08:28:22PM +0000, Shaikh, Azhar wrote:
> Hi Prashant,
> 
> > >
> > > Hi Prashant,
> > >
> > > > Is this documented anywhere? Kindly provide the links to that if so.
> > > > I wasn't aware of any ordering requirements (but I may be missing
> > something).
> > >
> > > The configuration of the connector should always happen in the order
> > > defined in the USB Type-C specification. Check ch. 2.3 (USB Type-C Spec
> > R2.0). So that will basically give you:
> > >
> > > 1. orientation
> > > 2. role(s)
> > > 3. the rest.
> > 
> > Thanks for the link. Are you referring to Section 2.3 (Configuration
> > Process) ? I couldn't find anything there which implied any required ordering
> > (I'm reading Release 2.0, Aug 2019, so I don't know if something has been
> > added since).
> > Could you kindly point me to the appropriate subsection?
> 
> That is the section I was referring to.

(Followed up with Azhar in a side-thread)
I don't see anything in that section that enforces an ordering on how
these switches should be configured. That said, I may be misinterpreting
it so I'm happy to follow up and withdraw my reservations to the change
given valid reasoning :)

As things stand, it looks like this is being reordered because it is
necessary for the particular switch driver (and architecture) in
question, i.e intel_pmc_mux.c to fix an edge use case
there (correcting the sequencing of PMC IPC messages when handling DP in warm
reboots).

I'd prefer the ordering be kept the way it was because:
1. We should preserve the existing ordering, and only fix the bug
   described in the commit message, i.e avoid setting usb_role switch to
   anything other than "NONE" during disconnect.

2. The CL should do 1 thing or call out why it's doing the re-ordering.
   Here it is not only fixing the double call to usb_role_switch_set_role (which is
   addressed in the commit message), but also re-ordering the call (which
   is not addressed at all).
   1.) and 2.) are sort-of related.

3. We should avoid fixing platform specific issues by changing the top
   level cros-ec-typec driver. Fixing this in the mux driver will make
   the driver more robust against any other sequencing issues that may
   crop up later.
   Also, if for example some other mux driver (driverB) requires a
   different ordering (e.g mode-switch before role-switch), changing
   that in cros-ec-typec will end up breaking the mux agent driver.
   driverB should handle the ordering issues internally, and so should
   intel_pmc_mux.c

BR,

-Prashant


> 
> > 
> > >
> > > Regards,
> > > Azhar
