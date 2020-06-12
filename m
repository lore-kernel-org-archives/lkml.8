Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED82C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF052074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:46:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:14543 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgFLMqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:46:39 -0400
IronPort-SDR: 49zUuSK0a2jGt58vtpZE3Cp5JKCj49cKP8nfcl2IQOGRL3LZ5gsfmqf3Ef7av7/ILAig5OWKFb
 CtxRZnQ7blXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 05:46:38 -0700
IronPort-SDR: L21NZGrdqQp2qnuBtOPnXkZ0pSHOMGXSZDk/lEaKxTyXU2QxT6zlMggNm0vyLrifRezR3WBljH
 Kush8WavtS2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="380690326"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 Jun 2020 05:46:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 12 Jun 2020 15:46:34 +0300
Date:   Fri, 12 Jun 2020 15:46:34 +0300
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
Message-ID: <20200612124634.GD3213128@kuha.fi.intel.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com>
 <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
 <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:53:45AM -0600, Rob Herring wrote:
> On Wed, Jun 10, 2020 at 9:34 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > > Hi Rob,
> > >
> > > Thanks again for the comments and feedback. Kindly see responses inline:
> > >
> > > (Trimming unrelated text from thread):
> > >
> > > On Tue, Jun 09, 2020 at 02:30:11PM -0600, Rob Herring wrote:
> > > > On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
> > > > >
> > > > > Nodes truncated and unrelated fields omitted in the interest of brevity:
> > > > >
> > > > > // Chrome OS EC Type C Port Manager.
> > > > > typec {
> > > > >     compatible = "google,cros-ec-typec";
> > > > >     #address-cells = <1>;
> > > > >     #size-cells = <0>;
> > > > >
> > > > >     connector@0 {
> > > > >         compatible = "usb-c-connector";
> > > > >         reg = <0>;
> > > > >         power-role = "dual";
> > > > >         data-role = "dual";
> > > > >         try-power-role = "source";
> > > > >         mode-switch = <&foo_mux>;
> > > > >         // Other switches can point to the same mux.
> > > > >         ....
> > > >
> > > > The connector is supposed to have 'ports' for USB2, USB3, and Aux
> > > > unless the parent is the USB controller.
> > > Understood; so, coupled with Heikki's explanation (see below for where
> > > I've pasted it), would it be something like so? (adding inline to the connector
> > > node definition):
> > >
> > >             ports {
> > >                 #address-cells = <1>;
> > >                 #size-cells = <0>;
> > >
> > >                 port@0 {
> > >                     reg = <0>;
> > >                     usb_con_hs: endpoint {
> > >                         remote-endpoint = <&foo_usb_hs_controller>;
> > >                     };
> > >                 };
> > >
> > >                 port@1 {
> > >                     reg = <1>;
> > >                     usb_con0_ss: endpoint@0 {
> > >                         remote-endpoint = <&mode_mux_in>;
> > >                     };
> > >                 };
> > >
> > >                 port@2 {
> > >                     reg = <2>;
> > >                     usb_con_sbu: endpoint {
> > >                         remote-endpoint = <&foo_dp_aux>;
> > >                     };
> > >                 };
> > >             };
> >
> > The pins that can be reassigned can in practice go anywhere. We can't
> > group them in any way. What do we do for example when the two sideband
> > pins go to different locations?
> 
> The sideband pins from the connector go to multiple places or the
> sideband signal from a controller go to multiple connectors? Either
> way, that's solved with multiple endpoints. In the former case, port@2
> would have multiple endpoints with all the possible connections. The
> general model of the graph is each port is a separate data channel and
> multiple endpoints are either a mux or fanout depending on the data
> direction.

No, that's not what I'm trying to ask here. Bad example, sorry. I'm
trying to understand why is it necessary to slit the connector into
three separate interfaces? There does not seem to be anything in the
kernel that would benefit from that. Why isn't the connector described
as a single interface in devicetree?

My concern with the three separate interfaces is that they may force
us to know in kernel which of the three interfaces are association
with a mode, and actually not just the mode, but the possible the pin
configurations of the mode. That is something that we may end up
having to hard code into the drivers, even though it does not provide
any useful information to us, and that would not be OK.

Right now they also allow making assumptions regarding the alternate
modes since there are no "bindings" for those, for example, if these
OF graph ports have an endpoint to the DP, it means DP alt mode is
supported. But that is of course not true. DisplayPort is used also
with other alternate modes. We must never make any assumptions based
on those interfaces. So again, why do we have them?

Either I'm missing something, or the devicetree description of the
Type-C connectors really is way too complex, way too "low level",
causing us potential problems without providing anything that we could
actually ever use in the operating system.


thanks,

-- 
heikki
