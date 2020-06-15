Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CDEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030462076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgFONWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:22:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:24235 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbgFONWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:22:15 -0400
IronPort-SDR: oL7MMLqnTJi+LrNFK+73CcAzWyWnuuWj4VDUeerUmiWxhtU2IEkyCO/vrFF7zRHWS/lNF2KM12
 fagsG7eDTc7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 06:22:11 -0700
IronPort-SDR: Isa4E4uTJMkkSo2ZlLmIqfPIaJ+R6Kk7H+n9197KtuYSbjF2bfITOzXlZWlWIRSQPFlg0/SPe9
 SiEzxJcxxCOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382545177"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Jun 2020 06:22:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jun 2020 16:22:07 +0300
Date:   Mon, 15 Jun 2020 16:22:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
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
Message-ID: <20200615132207.GG3213128@kuha.fi.intel.com>
References: <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
 <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
 <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
 <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
 <CACeCKacUa1-ttBmKS_Q_xZCsArgGWkB4s9eG0c5Lc5RHa1W35Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKacUa1-ttBmKS_Q_xZCsArgGWkB4s9eG0c5Lc5RHa1W35Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:34:06AM -0700, Prashant Malani wrote:
> Hi Rob,
> 
> Thanks as always for your help in reviewing this proposal!
> 
> Kindly see inline
> 
> (Trimming text);
> On Thu, Jun 11, 2020 at 02:00:47PM -0600, Rob Herring wrote:
> > On Wed, Jun 10, 2020 at 11:49 AM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Wed, Jun 10, 2020 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > >
> > > I think the updated example handles this grouping (port@1 going to a
> > > "SS mux") although as you said it should probably be a group of muxes,
> > > but I think the example illustrates the point. Is that assessment
> > > correct?
> >
> > Yes, but let's stop calling it a mux. It's a "USB Type C signal routing blob".
> 
> Ack.
> 
> Let's go with "-switch" ? That's what the connector class uses and it
> conveys the meaning (unless that is a reserved keyword in DT).

Just as a clarification here, we should not be even talking about
signal routing here. We are talking about functions that an external
components perform from the connector's perspective. It depends on the
platform does that function require changing the routing of the lines
from the connector. For example, data role swapping does not require
muxing on platforms that have single dual-role USB controller, but
platforms that have separate IPs for the USB host and USB device
controllers will need a mux.

Note, that it is even possible that switching from USB to DisplayPort
mode does not require any pin reconfiguration from the mux, even if
the platform has one, because the PHY can be shared between USB3 and
DP. Then the PHY just needs to be told that it is now in DP mode when
DP alt mode is entered instead of the mux.

> > > Would this block the addition of the "*-switch" properties? IIUC the
> > > two are related but not dependent on each other.
> > >
> > > The *-switch properties are phandles which the Type C connector class
> > > framework expects (and uses to get handles to those switches).
> > > These would point to the "mux" or "group of mux" abstractions as noted earlier.
> >
> > You don't need them though. Walk the graph. You get the connector
> > port@1 remote endpoint and then get its parent.
> >
> 
> I see; would it be something along the lines of this? (DT example
> follows; search for "example_end" to jump to bottom):

I just realized that you have in practice placed the mux-agent into
the graph below, right? That we can not do, because it is not
physically connected to the connector.

> <example_start>
> 
> connector@0 {
>     compatible = "usb-c-connector";
>     reg = <0>;
>     power-role = "dual";
>     data-role = "dual";
>     try-power-role = "source";
>     ....
>     ports {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         port@0 {
>             reg = <0>;
>             usb_con_hs: endpoint {
>                 remote-endpoint = <&foo_usb_hs_controller>;
>             };
>         };
> 
>         port@1 {
>             reg = <1>;
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             usb_con0_ss_mode: endpoint@0 {
>                 reg = <0>
>                 remote-endpoint = <&mode_switch_ss_in>;
>             };
> 
>             usb_con0_ss_orientation: endpoint@1 {
>                         reg = <1>
>                         remote-endpoint = <&orientation_switch_ss_in>;
>             };
> 
>             usb_con0_ss_data_role: endpoint@2 {
>                         reg = <2>
>                         remote-endpoint = <&data_role_switch_in>;
>             };
>         };
> 
>         port@2 {
>             reg = <2>;
>             #address-cells = <1>;
>             #size-cells = <0>;
>             usb_con0_sbu_mode: endpoint@0 {
>                         reg = <0>
>                         remote-endpoint = <&mode_switch_sbu_in>;
>             };
>             usb_con0_sbu_orientation: endpoint@1 {
>                         reg = <1>
>                         remote-endpoint = <&orientation_switch_sbu_in>;
>             };
>         };
>     };
> };
> 
> mode_switch {
>     compatible = "typec-mode-switch";
>     mux-controls = <&mode_mux_controller>;
>     mux-control-names = "mode";
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     port@0 {
>         reg = <0>;
>         mode_switch_ss_in: endpoint {
>             remote-endpoint = <&usb_con0_ss_mode>
>         };
>     };
> 
>     port@1 {
>         reg = <1>;
>         mode_switch_out_usb3: endpoint {
>             remote-endpoint = <&usb3_0_ep>
>         };
>     };
> 
>     port@2 {
>         reg = <2>;
>         mode_switch_out_dp: endpoint {
>             remote-endpoint = <&dp0_out_ep>
>         };
>     };
> 
>     port@3 {
>         reg = <3>;
>         mode_switch_sbu_in: endpoint {
>             remote-endpoint = <&usb_con0_sbu_mode>
>         };
>     };
>     // ... other ports similarly defined.
> };
> 
> orientation_switch {
>     compatible = "typec-orientation-switch";
>     mux-controls = <&orientation_mux_controller>;
>     mux-control-names = "orientation";
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     port@0 {
>         reg = <0>;
>         orientation_switch_ss_in: endpoint {
>             remote-endpoint = <&usb_con0_ss_orientation>
>         };
>     };
> 
>     port@1
>         reg = <1>;
>         orientation_switch_sbu_in: endpoint {
>             remote-endpoint = <&usb_con0_sbu_orientation>
>         };
>     };
>     // ... other ports similarly defined.
> };
> 
> data_role_switch {
>     compatible = "typec-data-role-switch";
>     mux-controls = <&data_role_switch_controller>;
>     mux-control-names = "data_role";
> 
>     port {
>         data_role_switch_in: endpoint {
>             remote-endpoint = <&usb_con0_ss_data_role>
>         };
>     };
> };
> 
> <example_end>
> 
> Would this be conformant to OF graph and usb-connector bindings
> requirements? We'll certainly send out a format PATCH/RFC series for
> this, but I was hoping to gauge whether we're thinking along the right lines.
> 
> So, in effect this would mean:
> - New bindings(and compatible strings) to be added for:
>   typec-{orientation,data-role,mode}-switch.
> - Handling in Type C connector class to parse switches from OF graph.
> - Handling in Type C connector class for distinct switches for port@1
>   (SS lines) and port@2 (SBU lines).
> 
> The only thing I'm confused about is how we can define these switch
> remote-endpoint bindings in usb-connector.yaml; the port can have an
> remote-endpoint, but can we specify what the parent of the remote-endpoint
> should have as a compatible string? Or do we not need to?

thanks,

-- 
heikki
