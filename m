Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B93C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FAF2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cGYorvrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB2An5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:43:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2An5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:43:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so2359592pgu.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=YdhnRSd+cstE0kPU3FgjhuNOoqtyTRInPO9ECVleTR8=;
        b=cGYorvrA+0g1YKC2gbx72oqQinYu9/SZTx0KC8KxdEHXVx8rQdgp4dQQewFte2eK09
         4I69D5bdKcEmojgjKy9S0z2PSR/QS6aF/c5FBZsAI09oSYaIX1hYkfXcvvR8L2tlMR/Q
         25ArSUkoDULpdxy2HVGv7PPwRZODZIOjLEGTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=YdhnRSd+cstE0kPU3FgjhuNOoqtyTRInPO9ECVleTR8=;
        b=Fujd2El86z2CsbO6owEWgTfjXKpIUDu6cwH6OC5I9B/f85JcX0iL5VO6kTHQXq1dIN
         uR33484j+kfWVLVXK3KjWxfKL6je3KFtwSmjKp2ZxZW9/ZU72MJaIL4YHU1JjxgEposv
         PCiM5G6ZX8Lq7U6HUh3vDJKBtS6G9AaXau70sKvGzkb7LzE13o1iv+1zny3c0EBR2Gcm
         gpx8Q9bWV+upwI0Sjhega0zaGII2LKdIBfmR7nBkbmGZm4X1R+/lkIE1wGLlySs6DfNh
         uQjar7j1ZRNDUtObsktDw1Jc2gYqgcb2ZzWBF26xpeXU0o9wDUcFX0Vjfejkqah4XOkH
         I1jA==
X-Gm-Message-State: APjAAAWZMcJcStqsxuoOHGcP/Lp/vWut95paVmWkwPEbIoGxmAMYBtvz
        S93USb0S3J8xCHKyUwNEGYCSGQ==
X-Google-Smtp-Source: APXvYqxrO8EYk/uoLMVCoKsKrUzR9xWTQZa/snALm2yszlQdg0gXFKsYipDOCuXpRckETEc7Qgm67g==
X-Received: by 2002:a63:5f43:: with SMTP id t64mr7436900pgb.207.1582937035720;
        Fri, 28 Feb 2020 16:43:55 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w184sm11039601pgw.84.2020.02.28.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 16:43:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200228162400.GA27904@kuha.fi.intel.com>
References: <20200220003102.204480-1-pmalani@chromium.org> <20200220003102.204480-2-pmalani@chromium.org> <158279287307.177367.4599344664477592900@swboyd.mtv.corp.google.com> <20200227163825.GB18240@kuha.fi.intel.com> <158284127336.4688.623067902277673206@swboyd.mtv.corp.google.com> <20200228162400.GA27904@kuha.fi.intel.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Fri, 28 Feb 2020 16:43:54 -0800
Message-ID: <158293703400.112031.11453499974796783579@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heikki Krogerus (2020-02-28 08:24:00)
> On Thu, Feb 27, 2020 at 02:07:53PM -0800, Stephen Boyd wrote:
> > Quoting Heikki Krogerus (2020-02-27 08:38:25)
> > > No.
> > >=20
> > > The above follows the usb-connector bindings, so it is correct:
> > > Documentation/devicetree/bindings/connector/usb-connector.txt
> > >=20
> > > So the connector is always a child of the "CC controller" with the USB
> > > Type-C connectors, which in this case is the EC (from operating syste=
ms
> > > perspective). The "CC controller" controls connectors, and it doesn't
> > > actually do anything else. So placing the connectors under the
> > > "connector controller" is also logically correct.
> >=20
> > Ah ok I see. The graph binding is for describing the data path, not the
> > control path. Makes sense.=20
> >=20
> > >=20
> > > > Yes, the connector is intimately involved with the EC here, but I w=
ould
> > > > think that we would have an OF graph connection from the USB contro=
ller
> > > > on the SoC to the USB connector, traversing through anything that m=
ay be
> > > > in that path, such as a USB hub. Maybe the connector node itself can
> > > > point to the EC type-c controller with some property like
> > >=20
> > > I think your idea here is that there should be only a single node for
> > > each connector that is then linked with every component that it is
> > > physically connected to (right?), but please note that that is not
> > > enough. Every component attached to the connector must have its own
> > > child node that represents the "port" that is physically connected to
> > > the USB Type-C connector.
> > >=20
> > > So for example, the USB controller nodes have child nodes for every
> > > USB2 port as well as for every USB3 port. Similarly, the GPU
> > > controllers have child node for every DisplayPort, etc. And I believe
> > > that is already how it has been done in DT (and also in ACPI).
> >=20
> > It looks like perhaps you're conflating ports in USB spec with the OF
> > graph port? I want there to be one node per type-c connector that I can
> > physically see on the device. Is that not sufficient?
>=20
> It is. We don't need more than one node that represents the physical
> connector (and we should not have more than one node for that). And
> actually, I was not mixing the OF graph ports and USB ports... I
> think I should be talking about PHY instead of "port". That is
> probable more clear.
>=20
> My point is that every PHY that is connected to a Type-C connector
> must still be represented with its own node in devicetree and ACPI. So
> there still needs to be a node for the USB2 PHY, USB3 PHY, DisplayPort
> PHY, etc., on top of the connector node. I got the picture that you
> are proposing that we don't need those PHY nodes anymore since we have
> the connector nodes, but maybe I misunderstood?

Alright. Maybe a full example will help. See below. I think I understand
how it's supposed to look.

>=20
> > Are there any examples of the type-c connector in DT? I see some
> > NXP/Freescale boards and one Renesas board so far. Maybe there are other
> > discussions I can read up on?
> >=20
> > >=20
> > > Those "port" nodes then just need to be linked with the "connector"
> > > node. I think for that the idea was to use OF graph, but I'm really
> > > sceptical about that. The problem is that with the USB Type-C
> > > connectors we have to be able to identify the connections, i.e. which
> > > endpoint is the USB2 port, which is the DisplayPort and so on, and OF
> > > graph does not give any means to do that on its own. We will have to
> > > rely on separate device properties in order to do the identification.
> > > Currently it is not documented anywhere which property should be used
> > > for that.
> >=20
> > I hope that this patch series can document this.
>=20
> Well, we do need that to be documented, but do we really need to block
> this series because of that? This driver does not depend on OF graph
> yet.

I don't know. I think this binding patch will go for another round so
maybe it's blocked in other ways?

>=20
> > Why can't that work by having multiple OF graph ports for USB2 port,
> > DisplayPort, USB3 port, etc? The data path goes to the connector and
> > we can attach more information to each port node to describe what
> > type of endpoint is there like a DisplayPort capable type-c
> > connector for example.
>=20
> The PHY nodes we must still always have. So the OF graph will always
> describe the connection between the PHY and the connector, and the
> connection between the PHY and the controller must be described
> separately.

Got it.

Here's the same example that hopefully shows how all this stuff can
work. I've added more nonsense to try and make it as complicated as
possible.

 / {

	// Expand single usb2/usb3 from SoC to 4 port hub
        usb-hub {
		compatible =3D "vendor,usb-hub-4-port";
		usb-vid =3D <0xaaad>;
		usb-pid =3D <0xffed>;
		vdd-supply =3D <&pp3300_usb>;
		reset-gpios =3D <&gpio_controller 50 GPIO_ACTIVE_LOW>;

		ports {=20
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			port@0 {
				reg =3D <0>;
				usb2_hub0: endpoint0 {
					remote-endpoint =3D <&left_typec2>;
				};

				usb3_hub0: endpoint1 {
					remote-endpoint =3D <&left_typec3>;
				};
			};

			port@1 {
				reg =3D <1>;
				usb2_hub1: endpoint0 {
					remote-endpoint =3D <&right_typec2>;
				};

				usb3_hub1: endpoint1 {
					remote-endpoint =3D <&right_typec3>;
				};
			};

			port@2 {
				reg =3D <2>;
				usb2_hub2: endpoint0 {
					remote-endpoint =3D <&left_typea2>;
				};
				usb3_hub2: endpoint1 {
					remote-endpoint =3D <&left_typea3>;
				};
			};

			port@3 {
				reg =3D <3>;
				usb2_hub3: endpoint0 {
					// Not connected
				};
				usb3_hub3: endpoint1 {
					// Not connected
				};
			};

			port@4 {
				reg =3D <4>;
				usb2_hub_in: endpoint0 {
					remote-endpoint =3D <&usb2_phy_out>;
				};
				usb3_hub_in: endpoint1 {
					remote-endpoint =3D <&usb3_phy_out>;
				};
			};
		};
	};

	// Maybe this should go under EC node too if EC controls it
	// somehow?
	connector {
		compatible =3D "usb-a-connector";
		label =3D "type-A-left"

		ports {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			port@0 {
				reg =3D <0>;
				left_typea2: endpoint0 {
					remote-endpoint =3D <&usb2_hub2>;
				};
				left_typea3: endpoint1 {
					remote-endpoint =3D <&usb3_hub2>;
				};
			};

	};

	// Steer DP to either left or right type-c port
	mux {
		compatible =3D "vendor,dp-mux";
		// Inactive: port 0
		// Active: port 1
		mux-gpios =3D <&gpio_controller 23 GPIO_ACTIVE_HIGH>;

		ports {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			port@0 {
				reg =3D <0>;
				mux_dp_0: endpoint {
					remote-endpoint =3D <&right_typec_dp>;
				};
			};

			port@1 {
				reg =3D <1>;
				mux_dp_1: endpoint {
					remote-endpoint =3D <&left_typec_dp>;
				};
			};

			port@2 {
				reg =3D <1>;
				mux_dp_in: endpoint {
					remote-endpoint =3D <&dp_phy_out>;
				};
			};
		};
	};

        soc@0 {
                #address-cells =3D <1>;
                #size-cells =3D <0>;

                spi@a000000 {
                        compatible =3D "soc,spi-controller";
                        reg =3D <0xa000000 0x1000>;
                        cros_ec: ec@0 {
                                compatible =3D "google,cros-ec-spi";
                                reg =3D <0>;

                                connector@0 {
                                        compatible =3D "usb-c-connector";
                                        label =3D "type-c-left";
                                        reg =3D <0>;
                                        power-role =3D "dual";
                                        ...

                                        ports {  // Maybe ports is overkill=
 with only one port?
                                                #address-cells =3D <1>;
                                                #size-cells =3D <0>;

                                                port@0 {
                                                        reg =3D <0>;
                                                        left_typec2: endpoi=
nt0 {
                                                                remote-endp=
oint =3D <&usb2_hub0>;
                                                        };

                                                        left_typec3: endpoi=
nt1 {
                                                                remote-endp=
oint =3D <&usb3_hub0>;
                                                        };

                                                        left_typec_dp: endp=
oint2 {
                                                                remote-endp=
oint =3D <&mux_dp_1>;
                                                        };
                                                };
                                        };
                                };

                                connector@1 {
                                        compatible =3D "usb-c-connector";
                                        label =3D "type-c-right";
                                        reg =3D <1>;
                                        power-role =3D "dual";
                                        ...

                                        ports {=20
                                                #address-cells =3D <1>;
                                                #size-cells =3D <0>;

                                                port@0 {
                                                        reg =3D <0>;
                                                        right_typec2: endpo=
int0 {
                                                                remote-endp=
oint =3D <&usb2_hub1>;
                                                        };

                                                        right_typec3: endpo=
int1 {
                                                                remote-endp=
oint =3D <&usb3_hub1>;
                                                        };

                                                        right_typec_dp: end=
point2 {
                                                                remote-endp=
oint =3D <&mux_dp_0>;
                                                        };
                                                };
                                        };
                                };
                        };
                };

                usb2_phy: phy@da00000 {
                        compatible =3D "soc,usb2-phy";
                        reg =3D <0xda00000 0x1000>;
                        ports {
                                port@0 {
                                        reg =3D <0>;
                                        usb2_phy_out: endpoint {
                                                remote-endpoint =3D <&usb2_=
hub_in>;
                                        };
                                };
                        };
                };

                usb3_phy: phy@db00000 {
                        compatible =3D "soc,usb3-phy";
                        reg =3D <0xdb00000 0x1000>;
                        ports {
                                port@0 {
                                        reg =3D <0>;
                                        usb3_phy_out: endpoint {
                                                remote-endpoint =3D <&usb3_=
hub_in>;
                                        };
                                };
                        };
                };

                dp_phy: phy@dc00000 {
                        compatible =3D "soc,dp-phy";
                        reg =3D <0xdc00000 0x1000>;
                        ports {
                                port@0 {
                                        reg =3D <0>;
                                        dp_phy_out: endpoint {
                                                remote-endpoint =3D <&mux_d=
p_in>;
                                        };
                                };
                        };
                };

                usb@ea00000 {
                        compatible =3D "soc,dwc3-controller";
                        reg =3D <0xea00000 0x1000>;
                        phys =3D <&usb2_phy>, <&usb3_phy>;
                };

	        display-controller@eb00000 {
                        compatible =3D "soc,dwc3-controller";
                        reg =3D <0xeb00000 0x1000>;
                        phys =3D <&dp_phy>;
			// TODO: Connect audio to DP phy somehow
	        };

        };
 };
