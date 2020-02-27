Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AAEC3F2C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEC924677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mo854CQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgB0WH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:07:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgB0WH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:07:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so366751pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TCgFgmnmVNoNLpKm+CzEz0ezwvXIfKf3HTcMqbhXQxI=;
        b=Mo854CQy+qdEmlCyfOZBHwhAwruPIZeiGuFjrn4Yt8mri6b6FkhTr9oCotMZN3I1cr
         EiJFlJhh+Uflhc6D9hlqxqnrAKtWPSz/qRfgKCs5EqKjoNCSM/KNUmrhUEzuemeC92bq
         1P98mavtoTdWY8ga/VSSD2XNBc7zvGMC+ll7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TCgFgmnmVNoNLpKm+CzEz0ezwvXIfKf3HTcMqbhXQxI=;
        b=cKD9B+xf0fMjqpN4GRtHgxLi8hYt8Zx72rLrapUICYobK8x47PPuY5Wq+ozNlxSuHH
         UyW0AaCsYMdjCbmdbatc+pV2ha2hEmygiJjwFtVu2F4fg8HWidAao8fPsWogbNwZDHbf
         7B1r9G43/YwiIW0IKP0O6xpzm/1Hkx9KmV7Alm6j0H1pMm/6Q+eXfJ8v7pkMn7rDr6ZS
         iKH583GwwwSgbO1k6/c1bUzwGzHVp0VVEpo+6YiGDNGqF7Ftfrh9OI2/B58ZQowHBHfi
         k8sgb53VP9vv7ywTtJFCFctaOy8QKfvgB4PBMC8C1borHGNWogGxGS80s1lSiZJXzLmU
         EvFQ==
X-Gm-Message-State: APjAAAVWO/mY00hcHVHf0fnrfOT58cXE/UMqYQTdFcRjP8bTAbaoweSK
        PYzIlUeDHTIRodrLz20TVg01iA==
X-Google-Smtp-Source: APXvYqw/tQi7tCabfCC+1nJEE/UWsXDGZsSLQlhSvUhM1EvK50NmXr0EwYj9QWrNPetplUxgNhVUqw==
X-Received: by 2002:a65:63d1:: with SMTP id n17mr1285707pgv.298.1582841274953;
        Thu, 27 Feb 2020 14:07:54 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a18sm8583066pfl.138.2020.02.27.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:07:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200227163825.GB18240@kuha.fi.intel.com>
References: <20200220003102.204480-1-pmalani@chromium.org> <20200220003102.204480-2-pmalani@chromium.org> <158279287307.177367.4599344664477592900@swboyd.mtv.corp.google.com> <20200227163825.GB18240@kuha.fi.intel.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Thu, 27 Feb 2020 14:07:53 -0800
Message-ID: <158284127336.4688.623067902277673206@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heikki Krogerus (2020-02-27 08:38:25)
> Hi Stephen,
>=20
> On Thu, Feb 27, 2020 at 12:41:13AM -0800, Stephen Boyd wrote:
> > > +examples:
> > > +  - |+
> > > +    cros_ec: ec@0 {
> > > +      compatible =3D "google,cros-ec-spi";
> > > +
> > > +      typec {
> > > +        compatible =3D "google,cros-ec-typec";
> > > +
> > > +        usb_con: connector {
> > > +          compatible =3D "usb-c-connector";
> > > +          port-number =3D <0>;
> > > +          power-role =3D "dual";
> > > +          data-role =3D "dual";
> > > +          try-power-role =3D "source";
> > > +        };
> >=20
> > I thought that perhaps this would be done with the OF graph APIs instead
> > of being a child of the ec node. I don't see how the usb connector is
> > anything besides a child of the top-level root node because it's
> > typically on the board. We put board level components at the root.
>=20
> No.
>=20
> The above follows the usb-connector bindings, so it is correct:
> Documentation/devicetree/bindings/connector/usb-connector.txt
>=20
> So the connector is always a child of the "CC controller" with the USB
> Type-C connectors, which in this case is the EC (from operating systems
> perspective). The "CC controller" controls connectors, and it doesn't
> actually do anything else. So placing the connectors under the
> "connector controller" is also logically correct.

Ah ok I see. The graph binding is for describing the data path, not the
control path. Makes sense.=20

>=20
> > Yes, the connector is intimately involved with the EC here, but I would
> > think that we would have an OF graph connection from the USB controller
> > on the SoC to the USB connector, traversing through anything that may be
> > in that path, such as a USB hub. Maybe the connector node itself can
> > point to the EC type-c controller with some property like
>=20
> I think your idea here is that there should be only a single node for
> each connector that is then linked with every component that it is
> physically connected to (right?), but please note that that is not
> enough. Every component attached to the connector must have its own
> child node that represents the "port" that is physically connected to
> the USB Type-C connector.
>=20
> So for example, the USB controller nodes have child nodes for every
> USB2 port as well as for every USB3 port. Similarly, the GPU
> controllers have child node for every DisplayPort, etc. And I believe
> that is already how it has been done in DT (and also in ACPI).

It looks like perhaps you're conflating ports in USB spec with the OF
graph port? I want there to be one node per type-c connector that I can
physically see on the device. Is that not sufficient?

Are there any examples of the type-c connector in DT? I see some
NXP/Freescale boards and one Renesas board so far. Maybe there are other
discussions I can read up on?

>=20
> Those "port" nodes then just need to be linked with the "connector"
> node. I think for that the idea was to use OF graph, but I'm really
> sceptical about that. The problem is that with the USB Type-C
> connectors we have to be able to identify the connections, i.e. which
> endpoint is the USB2 port, which is the DisplayPort and so on, and OF
> graph does not give any means to do that on its own. We will have to
> rely on separate device properties in order to do the identification.
> Currently it is not documented anywhere which property should be used
> for that.

I hope that this patch series can document this. Why can't that work by
having multiple OF graph ports for USB2 port, DisplayPort, USB3 port,
etc? The data path goes to the connector and we can attach more
information to each port node to describe what type of endpoint is there
like a DisplayPort capable type-c connector for example.

>=20
> For ACPI we are going to propose that with every type of connection,
> there should be a device property that returns a reference to the
> appropriate port. That way there are no problems identifying the
> connections. All we need to do is to define the property names for
> every type of connection. "usb2-port" for the USB2 or high speed port,
> "usb3-port" for USB3, etc.
>=20

That sounds like something we should figure out now for DT firmwares
too. For this particular binding, I don't know if we need to do anything
besides figure out how to represent multiple connectors underneath the
EC node. The other properties seem fairly generic and so I'd expect this
series to migrate
Documentation/devicetree/bindings/connector/usb-connector.txt to YAML
and refine the binding with anything necessary, like a 'reg' property to
allow multiple ports to exist underneath the "CC controller".
