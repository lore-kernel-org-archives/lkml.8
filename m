Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA38C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A422067B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XbRN0hQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLReK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:34:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F8C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:34:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so4618066pfx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O3A9kqksUUGvdliaTj1158oQyu0tKFSE0txFn2JVaGo=;
        b=XbRN0hQSE+gVdn/cNLHWHpEMCANqatGirZWTgJFnhn32pjwblWKjnxT4fH+Q67LsUH
         s4DP0Sk7hQUA7giCY6dfCeCkkv7SvaXCdrVWcVxNoirfUuus11d+nuuRt8q4fcbaUPiB
         QdJVP5IUllFct+yxKzUwbXLkb2ER45dtLQuWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O3A9kqksUUGvdliaTj1158oQyu0tKFSE0txFn2JVaGo=;
        b=lQ8Iu/THfYXpLUgUfB8tHNJQjUaft3BE7dvMXkZ9nmlfl+mDkiTvqJAtY4U+d0vJs5
         sYtkZjMODofYaQpBwbwPF7YtsbK9VcDDSMcIbarVQh1T+95fQo9rFcG1JqjzFJTpDKo7
         Eiiq5DKP1HNhF2wTg2AhtWh0b/sE+7hVhSXpHsO2+nm7h+qgd37tROjQSdpQJWDWa/Hr
         u4HjRZHvbaH08Fsf/eD/8ZGeXfeNfDLO8YjpGi7inlomqCMJSiZ8V0P4NJ/OG1VdZDl0
         MLsV1LDASBRFDSCjkmhDYltPxAGgf/5owfYuUE52c9wMko74q25yfGZk6UKTyWvThIxn
         dCwg==
X-Gm-Message-State: AOAM530NK2PQx/y6m+1JxZdH6OTAh8IDvsb13l7nhJFDFwpuzJ7NKfEj
        1xsm+ktstyj62Sba92xKRhDKuQ==
X-Google-Smtp-Source: ABdhPJyP9QyUwdi9RfNYHIufg1kSh+t7nG1oE0YcJHHYcgIMKDCp+KMt7gfHLMpSNR2FVhmTrjjP2A==
X-Received: by 2002:a63:7409:: with SMTP id p9mr9764759pgc.6.1591983247727;
        Fri, 12 Jun 2020 10:34:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id b11sm6705969pfr.58.2020.06.12.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:34:07 -0700 (PDT)
Date:   Fri, 12 Jun 2020 10:34:06 -0700
From:   Prashant Malani <pmalani@chromium.org>
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
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <CACeCKacUa1-ttBmKS_Q_xZCsArgGWkB4s9eG0c5Lc5RHa1W35Q@mail.gmail.com>
References: <20200511204635.GC136540@google.com>
 <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com>
 <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
 <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
 <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks as always for your help in reviewing this proposal!

Kindly see inline

(Trimming text);
On Thu, Jun 11, 2020 at 02:00:47PM -0600, Rob Herring wrote:
> On Wed, Jun 10, 2020 at 11:49 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Jun 10, 2020 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> >
> > I think the updated example handles this grouping (port@1 going to a
> > "SS mux") although as you said it should probably be a group of muxes,
> > but I think the example illustrates the point. Is that assessment
> > correct?
>
> Yes, but let's stop calling it a mux. It's a "USB Type C signal routing blob".

Ack.

Let's go with "-switch" ? That's what the connector class uses and it
conveys the meaning (unless that is a reserved keyword in DT).

>
> > Would this block the addition of the "*-switch" properties? IIUC the
> > two are related but not dependent on each other.
> >
> > The *-switch properties are phandles which the Type C connector class
> > framework expects (and uses to get handles to those switches).
> > These would point to the "mux" or "group of mux" abstractions as noted earlier.
>
> You don't need them though. Walk the graph. You get the connector
> port@1 remote endpoint and then get its parent.
>

I see; would it be something along the lines of this? (DT example
follows; search for "example_end" to jump to bottom):

<example_start>

connector@0 {
    compatible = "usb-c-connector";
    reg = <0>;
    power-role = "dual";
    data-role = "dual";
    try-power-role = "source";
    ....
    ports {
        #address-cells = <1>;
        #size-cells = <0>;

        port@0 {
            reg = <0>;
            usb_con_hs: endpoint {
                remote-endpoint = <&foo_usb_hs_controller>;
            };
        };

        port@1 {
            reg = <1>;
            #address-cells = <1>;
            #size-cells = <0>;

            usb_con0_ss_mode: endpoint@0 {
                reg = <0>
                remote-endpoint = <&mode_switch_ss_in>;
            };

            usb_con0_ss_orientation: endpoint@1 {
                        reg = <1>
                        remote-endpoint = <&orientation_switch_ss_in>;
            };

            usb_con0_ss_data_role: endpoint@2 {
                        reg = <2>
                        remote-endpoint = <&data_role_switch_in>;
            };
        };

        port@2 {
            reg = <2>;
            #address-cells = <1>;
            #size-cells = <0>;
            usb_con0_sbu_mode: endpoint@0 {
                        reg = <0>
                        remote-endpoint = <&mode_switch_sbu_in>;
            };
            usb_con0_sbu_orientation: endpoint@1 {
                        reg = <1>
                        remote-endpoint = <&orientation_switch_sbu_in>;
            };
        };
    };
};

mode_switch {
    compatible = "typec-mode-switch";
    mux-controls = <&mode_mux_controller>;
    mux-control-names = "mode";
    #address-cells = <1>;
    #size-cells = <0>;

    port@0 {
        reg = <0>;
        mode_switch_ss_in: endpoint {
            remote-endpoint = <&usb_con0_ss_mode>
        };
    };

    port@1 {
        reg = <1>;
        mode_switch_out_usb3: endpoint {
            remote-endpoint = <&usb3_0_ep>
        };
    };

    port@2 {
        reg = <2>;
        mode_switch_out_dp: endpoint {
            remote-endpoint = <&dp0_out_ep>
        };
    };

    port@3 {
        reg = <3>;
        mode_switch_sbu_in: endpoint {
            remote-endpoint = <&usb_con0_sbu_mode>
        };
    };
    // ... other ports similarly defined.
};

orientation_switch {
    compatible = "typec-orientation-switch";
    mux-controls = <&orientation_mux_controller>;
    mux-control-names = "orientation";
    #address-cells = <1>;
    #size-cells = <0>;

    port@0 {
        reg = <0>;
        orientation_switch_ss_in: endpoint {
            remote-endpoint = <&usb_con0_ss_orientation>
        };
    };

    port@1
        reg = <1>;
        orientation_switch_sbu_in: endpoint {
            remote-endpoint = <&usb_con0_sbu_orientation>
        };
    };
    // ... other ports similarly defined.
};

data_role_switch {
    compatible = "typec-data-role-switch";
    mux-controls = <&data_role_switch_controller>;
    mux-control-names = "data_role";

    port {
        data_role_switch_in: endpoint {
            remote-endpoint = <&usb_con0_ss_data_role>
        };
    };
};

<example_end>

Would this be conformant to OF graph and usb-connector bindings
requirements? We'll certainly send out a format PATCH/RFC series for
this, but I was hoping to gauge whether we're thinking along the right lines.

So, in effect this would mean:
- New bindings(and compatible strings) to be added for:
  typec-{orientation,data-role,mode}-switch.
- Handling in Type C connector class to parse switches from OF graph.
- Handling in Type C connector class for distinct switches for port@1
  (SS lines) and port@2 (SBU lines).

The only thing I'm confused about is how we can define these switch
remote-endpoint bindings in usb-connector.yaml; the port can have an
remote-endpoint, but can we specify what the parent of the remote-endpoint
should have as a compatible string? Or do we not need to?

Best regards,

-Prashant

