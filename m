Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC58C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E18A206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgELNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:42:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:50466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELNmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:42:02 -0400
IronPort-SDR: +RRSjdhlvNWnGfL/4eGyaIFU7j7f4zrJRgU5QsxpJo6FDMflV7JC1Y3HFqap7NKyfYQq7+B2ZQ
 kgsaMss7zCPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 06:42:00 -0700
IronPort-SDR: x2nk/Tb1YN4TUb8cjAbnzEnwap4bCiymXiruUW7jTrtkvGsKW3saY9tFd1bGLoQq6ARV2Y1+Sg
 jf9Q4f1byRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="371566424"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 May 2020 06:41:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 May 2020 16:41:54 +0300
Date:   Tue, 12 May 2020 16:41:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200512134154.GC2085641@kuha.fi.intel.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511204635.GC136540@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Mon, May 11, 2020 at 01:46:35PM -0700, Prashant Malani wrote:
> Hi Rob,
> 
> Thank you for reviewing the patch. Kindly see my comments inline:
> 
> On Mon, May 11, 2020 at 02:28:00PM -0500, Rob Herring wrote:
> > On Wed, Apr 22, 2020 at 03:22:39PM -0700, Prashant Malani wrote:
> > > Add properties for mode, orientation and USB data role switches for
> > > Type C connectors. When available, these will allow the Type C connector
> > > class port driver to configure the various switches according to USB PD
> > > information (like orientation, alt mode etc.) provided by the Chrome OS
> > > EC controller.
> > > 
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
> > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > index 6d7396ab8bee..b5814640aa32 100644
> > > --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > @@ -21,7 +21,21 @@ properties:
> > >      const: google,cros-ec-typec
> > >  
> > >    connector:
> > > -    $ref: /schemas/connector/usb-connector.yaml#
> > > +    allOf:
> > > +      - $ref: /schemas/connector/usb-connector.yaml#
> > > +      - type: object
> > > +        properties:
> > 
> > These don't seem CrOS EC specific, so why document them as such. 
> 
> Are you referring to the "mode-switch", "orientation-switch" and
> "usb-role-switch" properties? If so, then yes, they aren't Cros EC
> specific. The Type C connector class framework requires the nodes to be
> named like this, and the cros-ec-typec driver uses this framework, hence
> the description here (the Type C connector class framework doesn't have
> any bindings).
> 
> Would it be better to add in the description string that Type Connector
> class expects these switches to be named this way? :
> 
> " Reference to a DT node for the USB Type C Multiplexer controlling the
> data lines routing for this connector. This switch is assumed registered
> with the Type C connector class framework, which requires it to be named
> this way."
> > 
> > > +          mode-switch:
> > > +            description: Reference to a DT node for the USB Type C Multiplexer
> > > +              controlling the data lines routing for this connector.
> > 
> > This is for alternate mode muxing I presume.
> 
> Yes, that's right.
> > 
> > We already have a mux-control binding. Why not use that here?
> 
> Heikki might be able to offer more insight into why this is the case,
> since the connector class framework seems to expect a phandle and for
> the device driver to implement a "set" command. Heikki, would you happen to know?

The mode-switch here would actually represent the "consumer" part in
the mux-control bindings. So the mux-controls would describe the
relationship between the "mode-switch" and the mux controller(s),
while the mode-switch property describes the relationship between
something like USB Type-C Port Manager (or this cros_ec function) and
the "mux consumer".

> > > +
> > > +          orientation-switch:
> > > +            description: Reference to a DT node for the USB Type C orientation
> > > +              switch for this connector.
> > 
> > What's in this node?
> 
> Similar to the other "-switch", this will contain a phandle to a device
> which can control orientation settings for the Type C Mux. The connector
> class API assumes the switches are named this way. For example:
> 
> orientation-switch:
> https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/usb/typec/mux.c#L64
> 
> mode-switch:
> https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/usb/typec/mux.c#L258
> 
> > 
> > > +
> > > +          usb-role-switch:
> > > +            description: Reference to a DT node for the USB Data role switch
> > > +              for this connector.
> > >  
> > >  required:
> > >    - compatible
> > > @@ -49,6 +63,17 @@ examples:
> > >              data-role = "dual";
> > >              try-power-role = "source";
> > >            };
> > > +
> > > +          connector@1 {
> > > +            compatible = "usb-c-connector";
> > > +            reg = <1>;
> > > +            power-role = "dual";
> > > +            data-role = "host";
> > > +            try-power-role = "source";
> > > +            mode-switch = <&typec_mux>;
> > > +            orientation-switch = <&typec_orientation_switch>;
> > > +            usb-role-switch = <&typec_mux>;
> > > +          };
> > >          };
> > >        };
> > >      };
> > > -- 
> > > 2.26.1.301.g55bc3eb7cb9-goog
> > > 

thanks,

-- 
heikki
