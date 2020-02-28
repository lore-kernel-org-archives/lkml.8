Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F17C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7A2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1QYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:24:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:12638 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1QYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:24:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="350947379"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 28 Feb 2020 08:24:01 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Feb 2020 18:24:00 +0200
Date:   Fri, 28 Feb 2020 18:24:00 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200228162400.GA27904@kuha.fi.intel.com>
References: <20200220003102.204480-1-pmalani@chromium.org>
 <20200220003102.204480-2-pmalani@chromium.org>
 <158279287307.177367.4599344664477592900@swboyd.mtv.corp.google.com>
 <20200227163825.GB18240@kuha.fi.intel.com>
 <158284127336.4688.623067902277673206@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158284127336.4688.623067902277673206@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Feb 27, 2020 at 02:07:53PM -0800, Stephen Boyd wrote:
> Quoting Heikki Krogerus (2020-02-27 08:38:25)
> > Hi Stephen,
> > 
> > On Thu, Feb 27, 2020 at 12:41:13AM -0800, Stephen Boyd wrote:
> > > > +examples:
> > > > +  - |+
> > > > +    cros_ec: ec@0 {
> > > > +      compatible = "google,cros-ec-spi";
> > > > +
> > > > +      typec {
> > > > +        compatible = "google,cros-ec-typec";
> > > > +
> > > > +        usb_con: connector {
> > > > +          compatible = "usb-c-connector";
> > > > +          port-number = <0>;
> > > > +          power-role = "dual";
> > > > +          data-role = "dual";
> > > > +          try-power-role = "source";
> > > > +        };
> > > 
> > > I thought that perhaps this would be done with the OF graph APIs instead
> > > of being a child of the ec node. I don't see how the usb connector is
> > > anything besides a child of the top-level root node because it's
> > > typically on the board. We put board level components at the root.
> > 
> > No.
> > 
> > The above follows the usb-connector bindings, so it is correct:
> > Documentation/devicetree/bindings/connector/usb-connector.txt
> > 
> > So the connector is always a child of the "CC controller" with the USB
> > Type-C connectors, which in this case is the EC (from operating systems
> > perspective). The "CC controller" controls connectors, and it doesn't
> > actually do anything else. So placing the connectors under the
> > "connector controller" is also logically correct.
> 
> Ah ok I see. The graph binding is for describing the data path, not the
> control path. Makes sense. 
> 
> > 
> > > Yes, the connector is intimately involved with the EC here, but I would
> > > think that we would have an OF graph connection from the USB controller
> > > on the SoC to the USB connector, traversing through anything that may be
> > > in that path, such as a USB hub. Maybe the connector node itself can
> > > point to the EC type-c controller with some property like
> > 
> > I think your idea here is that there should be only a single node for
> > each connector that is then linked with every component that it is
> > physically connected to (right?), but please note that that is not
> > enough. Every component attached to the connector must have its own
> > child node that represents the "port" that is physically connected to
> > the USB Type-C connector.
> > 
> > So for example, the USB controller nodes have child nodes for every
> > USB2 port as well as for every USB3 port. Similarly, the GPU
> > controllers have child node for every DisplayPort, etc. And I believe
> > that is already how it has been done in DT (and also in ACPI).
> 
> It looks like perhaps you're conflating ports in USB spec with the OF
> graph port? I want there to be one node per type-c connector that I can
> physically see on the device. Is that not sufficient?

It is. We don't need more than one node that represents the physical
connector (and we should not have more than one node for that). And
actually, I was not mixing the OF graph ports and USB ports... I
think I should be talking about PHY instead of "port". That is
probable more clear.

My point is that every PHY that is connected to a Type-C connector
must still be represented with its own node in devicetree and ACPI. So
there still needs to be a node for the USB2 PHY, USB3 PHY, DisplayPort
PHY, etc., on top of the connector node. I got the picture that you
are proposing that we don't need those PHY nodes anymore since we have
the connector nodes, but maybe I misunderstood?

> Are there any examples of the type-c connector in DT? I see some
> NXP/Freescale boards and one Renesas board so far. Maybe there are other
> discussions I can read up on?
> 
> > 
> > Those "port" nodes then just need to be linked with the "connector"
> > node. I think for that the idea was to use OF graph, but I'm really
> > sceptical about that. The problem is that with the USB Type-C
> > connectors we have to be able to identify the connections, i.e. which
> > endpoint is the USB2 port, which is the DisplayPort and so on, and OF
> > graph does not give any means to do that on its own. We will have to
> > rely on separate device properties in order to do the identification.
> > Currently it is not documented anywhere which property should be used
> > for that.
> 
> I hope that this patch series can document this.

Well, we do need that to be documented, but do we really need to block
this series because of that? This driver does not depend on OF graph
yet.

> Why can't that work by having multiple OF graph ports for USB2 port,
> DisplayPort, USB3 port, etc? The data path goes to the connector and
> we can attach more information to each port node to describe what
> type of endpoint is there like a DisplayPort capable type-c
> connector for example.

The PHY nodes we must still always have. So the OF graph will always
describe the connection between the PHY and the connector, and the
connection between the PHY and the controller must be described
separately.

> > For ACPI we are going to propose that with every type of connection,
> > there should be a device property that returns a reference to the
> > appropriate port. That way there are no problems identifying the
> > connections. All we need to do is to define the property names for
> > every type of connection. "usb2-port" for the USB2 or high speed port,
> > "usb3-port" for USB3, etc.
> > 
> 
> That sounds like something we should figure out now for DT firmwares
> too. For this particular binding, I don't know if we need to do anything
> besides figure out how to represent multiple connectors underneath the
> EC node. The other properties seem fairly generic and so I'd expect this
> series to migrate
> Documentation/devicetree/bindings/connector/usb-connector.txt to YAML
> and refine the binding with anything necessary, like a 'reg' property to
> allow multiple ports to exist underneath the "CC controller".

OK.

thanks,

-- 
heikki
