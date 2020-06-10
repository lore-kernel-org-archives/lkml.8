Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41870C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C542063A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgFJPeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:34:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:4941 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:34:00 -0400
IronPort-SDR: xx1XglR9u2jUiy2pJtH5muznMBJTb5XKSiYOKBbOshMV5vavXSo36p8cLFiirwBz2YBu7ULt5O
 v0vSBjEnXR1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 08:33:59 -0700
IronPort-SDR: C8mpojf6rG8PFTCnkMLPkSE9uAC0MKC3wnQbTf0JKd9HMz3jyTcxx6XeQ5rqXL8jPAFdmRHChz
 eqF62gUvMNUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="380094962"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Jun 2020 08:33:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 10 Jun 2020 18:33:56 +0300
Date:   Wed, 10 Jun 2020 18:33:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200610153356.GC3213128@kuha.fi.intel.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com>
 <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609235740.GA154315@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> Hi Rob,
> 
> Thanks again for the comments and feedback. Kindly see responses inline:
> 
> (Trimming unrelated text from thread):
> 
> On Tue, Jun 09, 2020 at 02:30:11PM -0600, Rob Herring wrote:
> > On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > Nodes truncated and unrelated fields omitted in the interest of brevity:
> > >
> > > // Chrome OS EC Type C Port Manager.
> > > typec {
> > >     compatible = "google,cros-ec-typec";
> > >     #address-cells = <1>;
> > >     #size-cells = <0>;
> > >
> > >     connector@0 {
> > >         compatible = "usb-c-connector";
> > >         reg = <0>;
> > >         power-role = "dual";
> > >         data-role = "dual";
> > >         try-power-role = "source";
> > >         mode-switch = <&foo_mux>;
> > >         // Other switches can point to the same mux.
> > >         ....
> > 
> > The connector is supposed to have 'ports' for USB2, USB3, and Aux
> > unless the parent is the USB controller.
> Understood; so, coupled with Heikki's explanation (see below for where
> I've pasted it), would it be something like so? (adding inline to the connector
> node definition):
> 
>             ports {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 port@0 {
>                     reg = <0>;
>                     usb_con_hs: endpoint {
>                         remote-endpoint = <&foo_usb_hs_controller>;
>                     };
>                 };
> 
>                 port@1 {
>                     reg = <1>;
>                     usb_con0_ss: endpoint@0 {
>                         remote-endpoint = <&mode_mux_in>;
>                     };
>                 };
> 
>                 port@2 {
>                     reg = <2>;
>                     usb_con_sbu: endpoint {
>                         remote-endpoint = <&foo_dp_aux>;
>                     };
>                 };
>             };

The pins that can be reassigned can in practice go anywhere. We can't
group them in any way. What do we do for example when the two sideband
pins go to different locations?

It looks like the OF graph for the USB Type-C connectors expects the
pins to be grouped like that, which is too bad, because unfortunately
it will not work. It would require that we have a separate port for
every pin that can be reassigned on the connector, and let's not even
consider that.

We need higher level description of the connections for the USB Type-C
connectors. For example, a connector can be connected to this (or
these) DisplayPort(s), this USB 2.0 port, this USB 3.x port, this USB4
port, etc. And this is the mux that handles the pins on this
connector, and these are the retimers, etc. etc.

We also need a way to identify those connections, and relying on
something like fixed port node addresses, so indexes in practice,
feels really risky to me. A conflict may seem unlikely now, but we
seen those so many times in the past other things like GPIOs, IRQs,
etc. We really need to define string identifiers for these
connections.


thanks,

-- 
heikki
