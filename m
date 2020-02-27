Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F00C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8EE246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582845351;
	bh=zb26Cnnjbg/kOZ/hJDKS+VzhwbGyX1inxDibK0JQclU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=owsxVxCt3/o8Q7ytqGL+96DEN3em0Y1JooKjGcYOHGW18gOut9Wn8ItXtbbqkHFej
	 Ukp3HY/SRq/FH7SpJbIwrGrI/Y7PqjAmWP7wW7RqqoLuC9D8EQtp82ByUIfL8GKHsF
	 alEpU3ifeUZwaC2uypLtPwSpiOviefMfLpGb1TRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgB0XPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:15:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39770 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:15:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id x97so879090ota.6;
        Thu, 27 Feb 2020 15:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLtDgKUtML63xT0GORqWvBmKtcu4lnFLu8g073y0h0c=;
        b=AcG7ob9vUZY8VNO5fN+EaTaI1laRxF3p6J2JPE7USjVtHZc5U2kzxrTCmqF2FKpPcJ
         US4tgYX2Rd7Ny9NSkFJzWJwZkalzRUoAVodxDsg4o0RqYJLcpBCQMNF3ioSya5KL0jDv
         p0Xsse7F547pzFaSsJ0UUG/LVh/yzq0uW7pdexvrvtO0/Njb22W33g8PKd/wwbMVcYZx
         uPuemICtwvO0GHL38b8b+XmqQwD/mfRd/1wJGlw8PuRpsMmusBH0920fqB8dMPMOWfyy
         kU4PZ4Zl5IRhNRLAm43A4EBIfncoG1cLG4/gf4vAKO2Nac79kawxSKDIJ5APNkcyMiyH
         ZD8Q==
X-Gm-Message-State: APjAAAUzaks6eolO2dEsoYBCI9FKfti7sxURAZT5k5FxN5956AubphK3
        DtDVE8hnzd9Q8piNpUJg5ovn67g=
X-Google-Smtp-Source: APXvYqxIoRVB7eVVQGml6DtJc4JKdbiIQZPUrF2oRrGOzVSEVa7ooJT+zyUS2L/h0c3zJ2WbCYRNvQ==
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr1006748otp.242.1582845349443;
        Thu, 27 Feb 2020 15:15:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm2490902otn.81.2020.02.27.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:15:48 -0800 (PST)
Received: (nullmailer pid 5803 invoked by uid 1000);
        Thu, 27 Feb 2020 23:15:47 -0000
Date:   Thu, 27 Feb 2020 17:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200227231547.GA30103@bogus>
References: <20200220003102.204480-1-pmalani@chromium.org>
 <20200220003102.204480-2-pmalani@chromium.org>
 <20200227151216.GA18240@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227151216.GA18240@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:12:16PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> On Wed, Feb 19, 2020 at 04:30:55PM -0800, Prashant Malani wrote:
> > Some Chrome OS devices with Embedded Controllers (EC) can read and
> > modify Type C port state.
> > 
> > Add an entry in the DT Bindings documentation that lists out the logical
> > device and describes the relevant port information, to be used by the
> > corresponding driver.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> > 
> > Changes in v3:
> > - Fixed license identifier.
> > - Renamed "port" to "connector".
> > - Made "connector" be a "usb-c-connector" compatible property.
> > - Updated port-number description to explain min and max values,
> >   and removed $ref which was causing dt_binding_check errors.
> > - Fixed power-role, data-role and try-power-role details to make
> >   dt_binding_check pass.
> > - Fixed example to include parent EC SPI DT Node.
> > 
> > Changes in v2:
> > - No changes. Patch first introduced in v2 of series.
> > 
> >  .../bindings/chrome/google,cros-ec-typec.yaml | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > new file mode 100644
> > index 00000000000000..97fd982612f120
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Chrome OS EC(Embedded Controller) Type C port driver.
> > +
> > +maintainers:
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Prashant Malani <pmalani@chromium.org>
> > +
> > +description:
> > +  Chrome OS devices have an Embedded Controller(EC) which has access to
> > +  Type C port state. This node is intended to allow the host to read and
> > +  control the Type C ports. The node for this device should be under a
> > +  cros-ec node like google,cros-ec-spi.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,cros-ec-typec
> > +
> > +  connector:
> > +    description: A node that represents a physical Type C connector port
> > +      on the device.
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        const: usb-c-connector
> > +      port-number:
> > +        description: The number used by the Chrome OS EC to identify
> > +          this type C port. Valid values are 0 - (EC_USB_PD_MAX_PORTS - 1).
> > +      power-role:
> > +        description: Determines the power role that the Type C port will
> > +          adopt.
> > +        maxItems: 1
> > +        contains:
> > +          enum:
> > +            - sink
> > +            - source
> > +            - dual
> > +      data-role:
> > +        description: Determines the data role that the Type C port will
> > +          adopt.
> > +        maxItems: 1
> > +        contains:
> > +          enum:
> > +            - host
> > +            - device
> > +            - dual
> > +      try-power-role:
> > +        description: Determines the preferred power role of the Type C port.
> > +        maxItems: 1
> > +        contains:
> > +          enum:
> > +            - sink
> > +            - source
> > +            - dual
> > +
> > +    required:
> > +      - port-number
> > +      - power-role
> > +      - data-role
> > +      - try-power-role
> 
> Do you really need to redefine those?

No.

> 
> I think you just need to mention that there is a required sub-node
> "connector", and the place where it's described. So something
> like this:
> 
>         Required sub-node:
>         - connector : The "usb-c-connector". The bindings of the
>           connector node are specified in:
> 
>                 Documentation/devicetree/bindings/connector/usb-connector.txt

Ideally, we'd convert this to schema first and then here just have:

connector:
  $ref: /schemas/connector/usb-connector.yaml#

> 
> 
> Then you just need to define the Chrome OS EC specific properties, so
> I guess just the "port-number".

'reg' as Stephen suggested.

Rob
