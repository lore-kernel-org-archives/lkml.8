Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C34C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C806206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFEa1TXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGQSER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgGQSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:04:16 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97279C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:04:16 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z15so2801735qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jT6rzpeEE5qo24AcCOcM6oByRnSEaKB4PNbeCotZ59c=;
        b=MFEa1TXlROSydlqaUMmmn0e/gd3aRzO9YSBdx2NQCmmwvqKJWI6nkXfoht3xmgAlkf
         Nu0ONqaQwg0qCmLsX9eqMzHGTcCu5gQZqHrDsvhupqCGleXrGeTNrLBLXv+BPtVg2WwX
         E2Y2EW/VUVDrQLzUZ8xpHftPsOdmwv1RBnwdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jT6rzpeEE5qo24AcCOcM6oByRnSEaKB4PNbeCotZ59c=;
        b=NsQKou+PAN5Tjh4G6yjGFiqm7qOQxxpLsY4iSNUiNLd2aBTY9M0wFFTyUgXj1DAOsf
         QfPELVIdj7ZyrRiSWI9Bb0iGxFLopQPNH7H9UB6+5XXh2tWbzL7VUsFCf6Yz33A+iAJa
         aTAudnSwyyfKI2bOKb+OZMSqPJRCTjsF4sF/5dGD8nq3vjIbD5w+Pko6F1WTf40PR8BK
         nKwOyPIVC23MVOMUeBjvej9zV5X/ddEOKg1z19AwmrNWxy1mjM0+p+zLgaZrPzhArMQB
         mgint3GWDdMjqm42apRdDtRDSAF8lzSiNo7yqCCx26AqBL5Iz086F1o9OOWpWFf0bZci
         jIkg==
X-Gm-Message-State: AOAM5328yFTNm1s6+Zq7hWSUOdD94slwEJwn+zQqLWzjXyqm7GMSa93z
        tYPivqo/KJXJ1BuW8LSi2GQ6tPa8zqEx1frftesajg==
X-Google-Smtp-Source: ABdhPJy4raU1tZqb28ThgVAtPum8IY5fp2bxXKnubFFGzV9D6bOjs35SnNm36hOsnP9S9/hRNF6BpupZqGW3nk7PGi8=
X-Received: by 2002:a37:9682:: with SMTP id y124mr10089836qkd.442.1595009055606;
 Fri, 17 Jul 2020 11:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com> <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
 <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
 <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
 <CACeCKacUa1-ttBmKS_Q_xZCsArgGWkB4s9eG0c5Lc5RHa1W35Q@mail.gmail.com>
 <CACeCKachd34UtiZXY3i8za_ZHG9xtHSiPX55=Ed78n=S15b3Hg@mail.gmail.com> <CACeCKacKBdZ0D0+-QA1SLd3UTX=pGWv9pTfF2oWnstD245kD2A@mail.gmail.com>
In-Reply-To: <CACeCKacKBdZ0D0+-QA1SLd3UTX=pGWv9pTfF2oWnstD245kD2A@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 17 Jul 2020 11:04:04 -0700
Message-ID: <CACeCKadx4P757i96wX=kY4R6DbtSo6qX0Zny_HrCJvMKLzGO0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Rob Herring <robh@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Just checking in again to see if you have any thoughts about the
proposal outlined in previous emails in this thread.

Best regards,

On Fri, Jul 10, 2020 at 1:51 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Rob,
>
> Thought I'd check in again to see if you've had a chance to look at
> this proposal.
>
> Since Type C connector class framework assumes the existing
> "{mode,orientation,data-role}-switch" bindings for non-DT platforms
> already, as I see it, we can either:
>
> 1. Implement a different handling for DT platforms which utilizes port
> end-points and update the Type C connector class framework to parse
> those accordingly; this is what the above proposal suggests. It
> reserves some end-points for the "switches" that the Type C connector
> class framework expects and just follows the OF graph till it finds
> the various switches. Other schemas that use usb-connector.yaml schema
> can add more end-points as their use case deems needed, as long as
> they're not the reserved ones.
>
> <or>
>
> 2. Let various schemas that use usb-connector.schema add their own
> bindings according to their requirements (in the example of
> cros-ec-typec, it is adding the "*-switch" nodes directly under each
> connector instead of using OF graph so that Type C connector class
> framework can detect the switches, but there other examples for other
> use cases).
>
> I'm fine with either, but since this thread is now nearly 3 months
> old, it would be nice to arrive at a decision.
>
> Best regards,
>
> On Mon, Jun 29, 2020 at 1:41 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > Just following up on this. Would the below example align better with
> > OF graph requirements?
> >
> > Example begins at <example_start>, but in summary:
> > - port@1 (Superspeed) of usb-c-connector will have 3 endpoints (0 =
> > goes to mode switch, 1 = goes to orientation switch, 2 = goes to data
> > role switch)
> > - port@2 (SBU) of usb-c-connector will have 2 endpoints (0 = goes to
> > mode switch, 1 = goes to orientation switch)
> > -These end points can go through arbitrarily long paths (including
> > retimers) as long as they end up at the following devices:
> >     a. device with compatible string "typec-mode-switch" for endpoint 0.
> >     b. device with compatible string "typec-orientation-switch" for endpoint 1.
> >     c. device with compatible string "typec-data-role-switch" for endpoint 2.
> > - Connector class framework will perform the traversal from
> > usb-c-connector port endpoints to the "*-switch" devices.
> >
> > Best regards,
> >
> > On Fri, Jun 12, 2020 at 10:34 AM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks as always for your help in reviewing this proposal!
> > >
> > > Kindly see inline
> > >
> > > (Trimming text);
> > > On Thu, Jun 11, 2020 at 02:00:47PM -0600, Rob Herring wrote:
> > > > On Wed, Jun 10, 2020 at 11:49 AM Prashant Malani <pmalani@chromium.org> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Wed, Jun 10, 2020 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > > > >
> > > > > I think the updated example handles this grouping (port@1 going to a
> > > > > "SS mux") although as you said it should probably be a group of muxes,
> > > > > but I think the example illustrates the point. Is that assessment
> > > > > correct?
> > > >
> > > > Yes, but let's stop calling it a mux. It's a "USB Type C signal routing blob".
> > >
> > > Ack.
> > >
> > > Let's go with "-switch" ? That's what the connector class uses and it
> > > conveys the meaning (unless that is a reserved keyword in DT).
> > >
> > > >
> > > > > Would this block the addition of the "*-switch" properties? IIUC the
> > > > > two are related but not dependent on each other.
> > > > >
> > > > > The *-switch properties are phandles which the Type C connector class
> > > > > framework expects (and uses to get handles to those switches).
> > > > > These would point to the "mux" or "group of mux" abstractions as noted earlier.
> > > >
> > > > You don't need them though. Walk the graph. You get the connector
> > > > port@1 remote endpoint and then get its parent.
> > > >
> > >
> > > I see; would it be something along the lines of this? (DT example
> > > follows; search for "example_end" to jump to bottom):
> > >
> > > <example_start>
> > >
> > > connector@0 {
> > >     compatible = "usb-c-connector";
> > >     reg = <0>;
> > >     power-role = "dual";
> > >     data-role = "dual";
> > >     try-power-role = "source";
> > >     ....
> > >     ports {
> > >         #address-cells = <1>;
> > >         #size-cells = <0>;
> > >
> > >         port@0 {
> > >             reg = <0>;
> > >             usb_con_hs: endpoint {
> > >                 remote-endpoint = <&foo_usb_hs_controller>;
> > >             };
> > >         };
> > >
> > >         port@1 {
> > >             reg = <1>;
> > >             #address-cells = <1>;
> > >             #size-cells = <0>;
> > >
> > >             usb_con0_ss_mode: endpoint@0 {
> > >                 reg = <0>
> > >                 remote-endpoint = <&mode_switch_ss_in>;
> > >             };
> > >
> > >             usb_con0_ss_orientation: endpoint@1 {
> > >                         reg = <1>
> > >                         remote-endpoint = <&orientation_switch_ss_in>;
> > >             };
> > >
> > >             usb_con0_ss_data_role: endpoint@2 {
> > >                         reg = <2>
> > >                         remote-endpoint = <&data_role_switch_in>;
> > >             };
> > >         };
> > >
> > >         port@2 {
> > >             reg = <2>;
> > >             #address-cells = <1>;
> > >             #size-cells = <0>;
> > >             usb_con0_sbu_mode: endpoint@0 {
> > >                         reg = <0>
> > >                         remote-endpoint = <&mode_switch_sbu_in>;
> > >             };
> > >             usb_con0_sbu_orientation: endpoint@1 {
> > >                         reg = <1>
> > >                         remote-endpoint = <&orientation_switch_sbu_in>;
> > >             };
> > >         };
> > >     };
> > > };
> > >
> > > mode_switch {
> > >     compatible = "typec-mode-switch";
> > >     mux-controls = <&mode_mux_controller>;
> > >     mux-control-names = "mode";
> > >     #address-cells = <1>;
> > >     #size-cells = <0>;
> > >
> > >     port@0 {
> > >         reg = <0>;
> > >         mode_switch_ss_in: endpoint {
> > >             remote-endpoint = <&usb_con0_ss_mode>
> > >         };
> > >     };
> > >
> > >     port@1 {
> > >         reg = <1>;
> > >         mode_switch_out_usb3: endpoint {
> > >             remote-endpoint = <&usb3_0_ep>
> > >         };
> > >     };
> > >
> > >     port@2 {
> > >         reg = <2>;
> > >         mode_switch_out_dp: endpoint {
> > >             remote-endpoint = <&dp0_out_ep>
> > >         };
> > >     };
> > >
> > >     port@3 {
> > >         reg = <3>;
> > >         mode_switch_sbu_in: endpoint {
> > >             remote-endpoint = <&usb_con0_sbu_mode>
> > >         };
> > >     };
> > >     // ... other ports similarly defined.
> > > };
> > >
> > > orientation_switch {
> > >     compatible = "typec-orientation-switch";
> > >     mux-controls = <&orientation_mux_controller>;
> > >     mux-control-names = "orientation";
> > >     #address-cells = <1>;
> > >     #size-cells = <0>;
> > >
> > >     port@0 {
> > >         reg = <0>;
> > >         orientation_switch_ss_in: endpoint {
> > >             remote-endpoint = <&usb_con0_ss_orientation>
> > >         };
> > >     };
> > >
> > >     port@1
> > >         reg = <1>;
> > >         orientation_switch_sbu_in: endpoint {
> > >             remote-endpoint = <&usb_con0_sbu_orientation>
> > >         };
> > >     };
> > >     // ... other ports similarly defined.
> > > };
> > >
> > > data_role_switch {
> > >     compatible = "typec-data-role-switch";
> > >     mux-controls = <&data_role_switch_controller>;
> > >     mux-control-names = "data_role";
> > >
> > >     port {
> > >         data_role_switch_in: endpoint {
> > >             remote-endpoint = <&usb_con0_ss_data_role>
> > >         };
> > >     };
> > > };
> > >
> > > <example_end>
> > >
> > > Would this be conformant to OF graph and usb-connector bindings
> > > requirements? We'll certainly send out a format PATCH/RFC series for
> > > this, but I was hoping to gauge whether we're thinking along the right lines.
> > >
> > > So, in effect this would mean:
> > > - New bindings(and compatible strings) to be added for:
> > >   typec-{orientation,data-role,mode}-switch.
> > > - Handling in Type C connector class to parse switches from OF graph.
> > > - Handling in Type C connector class for distinct switches for port@1
> > >   (SS lines) and port@2 (SBU lines).
> > >
> > > The only thing I'm confused about is how we can define these switch
> > > remote-endpoint bindings in usb-connector.yaml; the port can have an
> > > remote-endpoint, but can we specify what the parent of the remote-endpoint
> > > should have as a compatible string? Or do we not need to?
> > >
> > > Best regards,
> > >
> > > -Prashant
> > >
