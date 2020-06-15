Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA8FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC11F206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFOKYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:24:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:44816 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOKYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:24:25 -0400
IronPort-SDR: xTQoMOai+79a0VMSW6vB0JQ2mLh6f5u76zxCxoCKDMriqo4vIaKZTd3zuDeKz7uUFRfixzkUXJ
 N1s0U51xfpTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 03:24:12 -0700
IronPort-SDR: QHNkefPRDepG2BFbs+0Y3tudqdRM70isz34I66Nj59VSt0I2p9Zdf+zIemowO/QBeLIhyjg6m4
 BbuWOJYUhU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382505677"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Jun 2020 03:24:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jun 2020 13:24:08 +0300
Date:   Mon, 15 Jun 2020 13:24:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200615102408.GF3213128@kuha.fi.intel.com>
References: <20200511204635.GC136540@google.com>
 <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
 <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
 <20200612124634.GD3213128@kuha.fi.intel.com>
 <CAL_Jsq+ORkzHchpD0qsH97zDJzXGj3jWy8=orXSVhNQd4kr9Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ORkzHchpD0qsH97zDJzXGj3jWy8=orXSVhNQd4kr9Kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> > Either I'm missing something, or the devicetree description of the
> > Type-C connectors really is way too complex, way too "low level",
> > causing us potential problems without providing anything that we could
> > actually ever use in the operating system.
> 
> Well, all bindings are a balancing act of being flexible enough vs.
> high-level enough to be stable. What I need is something that's going
> to work for everyone, not just CrOS. Adding a new property at time is
> death by 1000 cuts and usually a sign of someone only fixing their own
> immediate problem.

If you referring to the phandles that are related to the muxes, then
those we will need. Those phandles point to the components that can
configure the muxes, but those components are not the muxes
themselves. On these platforms the muxes can not be configured
directly, and this is by the way the normal setup these days. I have
even alternate mode adapters that do not configure the mux directly
from the microcontroller. So we are not talking about the first
platform with this setup here.

The problem is that these components are not physically connected to
the connector, so we can't place them to the OF graph. The mux should
be placed into the graph (we may not be able to configure the muxes,
but we may still be able to read their status), but these components
should not.

I was really hoping that we could follow the "mux-controller"
bindings, but it just did not feel it would work perfectly with these
components that are not exactly the mux-controllers, but more like
proxies to the actual mux-controllers. We could probable ignore that
fact if the real mux-controllers were not visible to us, but
unfortunately they are visible to us. More importantly, the "muxes"
that we need to use with USB Type-C connectors will not always be
actual muxes at all. Depending on the platform, for example the USB
role switching will be handled by a mux, or a dual-role capable USB
controller.

But I'm open for suggestions here. The only thing that I can say for
sure about this is that we can't rely on OF graph with the muxes.
Right now I actually only have a wish that we had a reference array
that would hold all the phandles to the components that can configure
the lines behind the connector a bit like in mux bindings, but
regardless of were they real muxes, "proxy" to the muxes, or
anything else. Then we would need to define also somekind of device
property for each known function, like "orientation", "role" and so
on, that would return index to the component (mux, or what ever it is)
in the reference array that can handle that particular function.

I also don't feel comfortable using the name "mux" with these because,
they really will not always be muxes. That's why I talk about switches,
though I'm not sure if that's any better.

Sorry about the long mail.

thanks,

-- 
heikki
