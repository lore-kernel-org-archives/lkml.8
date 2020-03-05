Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4715C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA97020637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCEQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:58:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:47489 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCEQ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:58:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352395418"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Mar 2020 08:57:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Mar 2020 18:57:52 +0200
Date:   Thu, 5 Mar 2020 18:57:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200305165752.GB68079@kuha.fi.intel.com>
References: <20200220003102.204480-1-pmalani@chromium.org>
 <20200220003102.204480-2-pmalani@chromium.org>
 <158279287307.177367.4599344664477592900@swboyd.mtv.corp.google.com>
 <20200227163825.GB18240@kuha.fi.intel.com>
 <158284127336.4688.623067902277673206@swboyd.mtv.corp.google.com>
 <20200228162400.GA27904@kuha.fi.intel.com>
 <158293703400.112031.11453499974796783579@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158293703400.112031.11453499974796783579@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 04:43:54PM -0800, Stephen Boyd wrote:
> Quoting Heikki Krogerus (2020-02-28 08:24:00)
> > On Thu, Feb 27, 2020 at 02:07:53PM -0800, Stephen Boyd wrote:
> > > Quoting Heikki Krogerus (2020-02-27 08:38:25)
> > > > No.
> > > > 
> > > > The above follows the usb-connector bindings, so it is correct:
> > > > Documentation/devicetree/bindings/connector/usb-connector.txt
> > > > 
> > > > So the connector is always a child of the "CC controller" with the USB
> > > > Type-C connectors, which in this case is the EC (from operating systems
> > > > perspective). The "CC controller" controls connectors, and it doesn't
> > > > actually do anything else. So placing the connectors under the
> > > > "connector controller" is also logically correct.
> > > 
> > > Ah ok I see. The graph binding is for describing the data path, not the
> > > control path. Makes sense. 
> > > 
> > > > 
> > > > > Yes, the connector is intimately involved with the EC here, but I would
> > > > > think that we would have an OF graph connection from the USB controller
> > > > > on the SoC to the USB connector, traversing through anything that may be
> > > > > in that path, such as a USB hub. Maybe the connector node itself can
> > > > > point to the EC type-c controller with some property like
> > > > 
> > > > I think your idea here is that there should be only a single node for
> > > > each connector that is then linked with every component that it is
> > > > physically connected to (right?), but please note that that is not
> > > > enough. Every component attached to the connector must have its own
> > > > child node that represents the "port" that is physically connected to
> > > > the USB Type-C connector.
> > > > 
> > > > So for example, the USB controller nodes have child nodes for every
> > > > USB2 port as well as for every USB3 port. Similarly, the GPU
> > > > controllers have child node for every DisplayPort, etc. And I believe
> > > > that is already how it has been done in DT (and also in ACPI).
> > > 
> > > It looks like perhaps you're conflating ports in USB spec with the OF
> > > graph port? I want there to be one node per type-c connector that I can
> > > physically see on the device. Is that not sufficient?
> > 
> > It is. We don't need more than one node that represents the physical
> > connector (and we should not have more than one node for that). And
> > actually, I was not mixing the OF graph ports and USB ports... I
> > think I should be talking about PHY instead of "port". That is
> > probable more clear.
> > 
> > My point is that every PHY that is connected to a Type-C connector
> > must still be represented with its own node in devicetree and ACPI. So
> > there still needs to be a node for the USB2 PHY, USB3 PHY, DisplayPort
> > PHY, etc., on top of the connector node. I got the picture that you
> > are proposing that we don't need those PHY nodes anymore since we have
> > the connector nodes, but maybe I misunderstood?
> 
> Alright. Maybe a full example will help. See below. I think I understand
> how it's supposed to look.
> 
> > 
> > > Are there any examples of the type-c connector in DT? I see some
> > > NXP/Freescale boards and one Renesas board so far. Maybe there are other
> > > discussions I can read up on?
> > > 
> > > > 
> > > > Those "port" nodes then just need to be linked with the "connector"
> > > > node. I think for that the idea was to use OF graph, but I'm really
> > > > sceptical about that. The problem is that with the USB Type-C
> > > > connectors we have to be able to identify the connections, i.e. which
> > > > endpoint is the USB2 port, which is the DisplayPort and so on, and OF
> > > > graph does not give any means to do that on its own. We will have to
> > > > rely on separate device properties in order to do the identification.
> > > > Currently it is not documented anywhere which property should be used
> > > > for that.
> > > 
> > > I hope that this patch series can document this.
> > 
> > Well, we do need that to be documented, but do we really need to block
> > this series because of that? This driver does not depend on OF graph
> > yet.
> 
> I don't know. I think this binding patch will go for another round so
> maybe it's blocked in other ways?

Let me put it this way: Since the code in this series does not utilize
the connection description, it actually should _not_ propose the
binding for it. The connection description is out side the scope of
the series.

The connection description is still far from being clear in any case.

> > > Why can't that work by having multiple OF graph ports for USB2 port,
> > > DisplayPort, USB3 port, etc? The data path goes to the connector and
> > > we can attach more information to each port node to describe what
> > > type of endpoint is there like a DisplayPort capable type-c
> > > connector for example.
> > 
> > The PHY nodes we must still always have. So the OF graph will always
> > describe the connection between the PHY and the connector, and the
> > connection between the PHY and the controller must be described
> > separately.
> 
> Got it.
> 
> Here's the same example that hopefully shows how all this stuff can
> work. I've added more nonsense to try and make it as complicated as
> possible.

You are not suggesting anything for the identification problem below,
so how do we know where does an endpoint actually go to in the code?

But could you actually please first explain what exactly is the
benefit from using OF graph with with the USB Type-C connector? Why
not just use good old phandles, i.e. device properties that return
reference to a node? With those the device property name by itself is
the identifier.

>  / {
> 
> 	// Expand single usb2/usb3 from SoC to 4 port hub
>         usb-hub {
> 		compatible = "vendor,usb-hub-4-port";
> 		usb-vid = <0xaaad>;
> 		usb-pid = <0xffed>;
> 		vdd-supply = <&pp3300_usb>;
> 		reset-gpios = <&gpio_controller 50 GPIO_ACTIVE_LOW>;
> 
> 		ports { 
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
> 				usb2_hub0: endpoint0 {
> 					remote-endpoint = <&left_typec2>;
> 				};
> 
> 				usb3_hub0: endpoint1 {
> 					remote-endpoint = <&left_typec3>;
> 				};
> 			};

Note. USB2 and USB3 are separate ports.

> 			port@1 {
> 				reg = <1>;
> 				usb2_hub1: endpoint0 {
> 					remote-endpoint = <&right_typec2>;
> 				};
> 
> 				usb3_hub1: endpoint1 {
> 					remote-endpoint = <&right_typec3>;
> 				};
> 			};
> 
> 			port@2 {
> 				reg = <2>;
> 				usb2_hub2: endpoint0 {
> 					remote-endpoint = <&left_typea2>;
> 				};
> 				usb3_hub2: endpoint1 {
> 					remote-endpoint = <&left_typea3>;
> 				};
> 			};
> 
> 			port@3 {
> 				reg = <3>;
> 				usb2_hub3: endpoint0 {
> 					// Not connected
> 				};
> 				usb3_hub3: endpoint1 {
> 					// Not connected
> 				};
> 			};
> 
> 			port@4 {
> 				reg = <4>;
> 				usb2_hub_in: endpoint0 {
> 					remote-endpoint = <&usb2_phy_out>;
> 				};
> 				usb3_hub_in: endpoint1 {
> 					remote-endpoint = <&usb3_phy_out>;
> 				};
> 			};
> 		};
> 	};

I don't still see any kind of independent device nodes for the USB
ports? Is the idea to only have the OF graph "ports" to represent the
physical USB ports?

It was clearly a mistake to talk about PHY, but in any case...

All the physical ports really need to have their own device nodes. If
we are to use OF graph, then a OF graph "port" is an interface to a
physical USB port, DisplayPort, Thunderbolt 3 port, whatever port,
that then has an endpoint to the connector. OF graph ports are
generic, and they can not represent physical points on the hardware,
while the USB, DP, whatever ports are specific and represent the
physical points on the hardware.

So basically, the OF graph describes the connection (the interconnect)
between the physical ports on the components and the connector, but it
does _not_ describe the connectors nor the physical ports themselves.

That is the only way I see this ever working. Otherwise you don't have
a clear place where to put for example device nodes describing
integrated USB devices, or even a clear way to describe port specific
properties.

> 	// Maybe this should go under EC node too if EC controls it
> 	// somehow?
> 	connector {
> 		compatible = "usb-a-connector";
> 		label = "type-A-left"
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			port@0 {
> 				reg = <0>;
> 				left_typea2: endpoint0 {
> 					remote-endpoint = <&usb2_hub2>;
> 				};
> 				left_typea3: endpoint1 {
> 					remote-endpoint = <&usb3_hub2>;
> 				};
> 			};
> 
> 	};

Is this actually necessary? You will never associate the connector in
this case with a real device entry (struct device), so why define the
node at all?

The node will give you the connector type, but since (AFAIK) that
information is not used anywhere in case of Type-A, why bother?

> 	// Steer DP to either left or right type-c port
> 	mux {
> 		compatible = "vendor,dp-mux";
> 		// Inactive: port 0
> 		// Active: port 1
> 		mux-gpios = <&gpio_controller 23 GPIO_ACTIVE_HIGH>;
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			port@0 {
> 				reg = <0>;
> 				mux_dp_0: endpoint {
> 					remote-endpoint = <&right_typec_dp>;
> 				};
> 			};
> 
> 			port@1 {
> 				reg = <1>;
> 				mux_dp_1: endpoint {
> 					remote-endpoint = <&left_typec_dp>;
> 				};
> 			};
> 
> 			port@2 {
> 				reg = <1>;
> 				mux_dp_in: endpoint {
> 					remote-endpoint = <&dp_phy_out>;
> 				};
> 			};
> 		};
> 	};

If you use the mux between the DP and the connector, then you actually
should do the same with the USB ports as well. They will after all go
trough the same mux, right?

But using the mux in the middle even with the DP is problematic. We
will simply not always have a mux to control. Therefore our plan was
to always describe the connections directly from the connector to
whatever location they ultimately go to without the mux in the middle.
The mux will have its connection described in the connector node, but
in parallel.

I'll skip the rest if it's OK. I think at this point we really need an
explanation to the question: why do we have to use OF graph with the
USB Type-C connectors at all?

The identification problem has to be solved if it is to be used in any
case, but in the end, what value does OF graph add? Right now it looks
like something that just adds unnecessary complexity.

I'm sure that it is useful when it is possible to predict where the
endpoints actually go. For example with the cameras, every endpoint
an image processor has is most likely a sensor. But the USB Type-C
connectors can go anywhere (I guess even to the image processor).

With USB Type-C connector, the good old reference properties would
simply be superior.


thanks,

-- 
heikki
