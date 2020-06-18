Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB74FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FC0207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4it2v0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgFRS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFRS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:59:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E22C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:59:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b16so3187610pfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRvnn8Ty+J9ub0ve3U5qnJId2gPE+UnHi9QjuB+a3bk=;
        b=L4it2v0+jYIWtjtIU214aSZCTKymyjr06cEV2JW+C2tIA5O4sm3lhnsGQWQHlFZTWO
         Yir/6c9W37u6Hpel/cIyXg1hhFjbTGnS+EqW/oCI1BdEgbh8voShcNvC/3PVIG3Tv8E1
         gOFeDwv+OA5S6Xn/9tzja0s3260x01qBU/A3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRvnn8Ty+J9ub0ve3U5qnJId2gPE+UnHi9QjuB+a3bk=;
        b=ifHr3yXu39Ue09sXvsWk77SoM0gyOZIx0VPRzIeGzN+nzssvNSuQmfwbm39qqVNWWX
         Cy6LcMJFISl2yBT6I1Lb0Yw39Zrhu09XWgRm/Vo5A/6Iaj6uu6vw3Ex48ZxoBISTRUJD
         RjyoxqmgEgwyPBQEAnWH/4azr0FJNlgBsDuKB7mZX/ULFCwQ/NusWiM02uH6zyeh/yqb
         BhkxlWJ8ivublhCN3O2OpRuQUDy19TC4pxVQvinHGJUOJch3l9+7oXASa46B8U5vwoUc
         jqIz2EBX9FMnZAAYlSec0ewuAvgoQHZtV4cdvLLSJeXBU0feXEJXHI5hxQcysVnJg/YL
         5Ldw==
X-Gm-Message-State: AOAM5327FAMWPnNwwwtD66sXqFT4SmNA5GvJwcTDX9kSM/bIVXQF1JTH
        OPxDi4mxabu8S/hG3X9Xp/gWcCUUCRU=
X-Google-Smtp-Source: ABdhPJzBi1TYAB9JtNn9rVlZhSSeLNic/mp1y3SuZM3ZOZR6SAmerOHr5vQdEZy+m1Sa+pNGKHnnAw==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr4931409pfb.78.1592506759889;
        Thu, 18 Jun 2020 11:59:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id a3sm3618635pfi.77.2020.06.18.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:59:19 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:59:18 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200618185918.GB255826@google.com>
References: <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
 <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
 <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
 <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
 <CACeCKacUa1-ttBmKS_Q_xZCsArgGWkB4s9eG0c5Lc5RHa1W35Q@mail.gmail.com>
 <20200615132207.GG3213128@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615132207.GG3213128@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki and Rob,

(trimming text):
On Mon, Jun 15, 2020 at 04:22:07PM +0300, Heikki Krogerus wrote:
> On Fri, Jun 12, 2020 at 10:34:06AM -0700, Prashant Malani wrote:
> > Hi Rob,
> > > Yes, but let's stop calling it a mux. It's a "USB Type C signal routing blob".
> > 
> > Ack.
> > 
> > Let's go with "-switch" ? That's what the connector class uses and it
> > conveys the meaning (unless that is a reserved keyword in DT).
> 
> Just as a clarification here, we should not be even talking about
> signal routing here. We are talking about functions that an external
> components perform from the connector's perspective. It depends on the
> platform does that function require changing the routing of the lines
> from the connector. For example, data role swapping does not require
> muxing on platforms that have single dual-role USB controller, but
> platforms that have separate IPs for the USB host and USB device
> controllers will need a mux.
> 
> Note, that it is even possible that switching from USB to DisplayPort
> mode does not require any pin reconfiguration from the mux, even if
> the platform has one, because the PHY can be shared between USB3 and
> DP. Then the PHY just needs to be told that it is now in DP mode when
> DP alt mode is entered instead of the mux.
> 
> > > > Would this block the addition of the "*-switch" properties? IIUC the
> > > > two are related but not dependent on each other.
> > > >
> > > > The *-switch properties are phandles which the Type C connector class
> > > > framework expects (and uses to get handles to those switches).
> > > > These would point to the "mux" or "group of mux" abstractions as noted earlier.
> > >
> > > You don't need them though. Walk the graph. You get the connector
> > > port@1 remote endpoint and then get its parent.
> > >
> > 
> > I see; would it be something along the lines of this? (DT example
> > follows; search for "example_end" to jump to bottom):
> 
> I just realized that you have in practice placed the mux-agent into
> the graph below, right? That we can not do, because it is not
> physically connected to the connector.

Is this a requirement? I read through the graph.txt file [1] and I couldn't
find anything stating that a physical connection between two devices was
required (but I may be misinterpreting that document)

[1]:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/graph.txt

> 
> > <example_start>
> > 
> > <example_end>
> > 
> > Would this be conformant to OF graph and usb-connector bindings
> > requirements? We'll certainly send out a format PATCH/RFC series for
> > this, but I was hoping to gauge whether we're thinking along the right lines.
> > 
> > So, in effect this would mean:
> > - New bindings(and compatible strings) to be added for:
> >   typec-{orientation,data-role,mode}-switch.
> > - Handling in Type C connector class to parse switches from OF graph.
> > - Handling in Type C connector class for distinct switches for port@1
> >   (SS lines) and port@2 (SBU lines).
> > 
> > The only thing I'm confused about is how we can define these switch
> > remote-endpoint bindings in usb-connector.yaml; the port can have an
> > remote-endpoint, but can we specify what the parent of the remote-endpoint
> > should have as a compatible string? Or do we not need to?
> 
> thanks,
> 
> -- 
> heikki

Best regards,

-Prashant
