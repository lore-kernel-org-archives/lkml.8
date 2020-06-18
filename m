Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56347C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C956208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592516181;
	bh=FdXArNlOB0a4SDD87jaMCdex3U6cqGK9MVm02lJxTSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vBu0EL18HBjkCooXvQeIb/oJ7+UuOviQoct/yEXD73H6uF+rPTjgf93b4JLm49ejY
	 YBBi+CiJWEZNXtBeBP8ErbVP7O+W0CPrOHSCeUJhAtsCeRxHDPkPt2rayxh+OtNWcn
	 Y1C++xkIQbtRc0Def38A0Ru/2aT4OpjdmdU8oaGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgFRVgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgFRVgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:36:18 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E55208C3;
        Thu, 18 Jun 2020 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592516177;
        bh=FdXArNlOB0a4SDD87jaMCdex3U6cqGK9MVm02lJxTSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=beeDmxTP1FFdQ3fvaOLfntCXvqSjM3gB0ixl7YhxxFGB/mfix17N8JFG/UjJrYG3g
         6lvMLng2x6l2hVHi2tl35XW4q49P4rxa2+1KBsca738X6+70/pLG9iaaG1wZ1qRCjB
         pE40dTIfIrnvWuKQ4u6tseDX82wTkRlK6KDebxAc=
Received: by mail-ot1-f53.google.com with SMTP id d4so5765447otk.2;
        Thu, 18 Jun 2020 14:36:17 -0700 (PDT)
X-Gm-Message-State: AOAM532zS7R+0gYIxgbdx09hosojqjOHhHvvWyqtSt+d0+QToo4G248w
        FoC+KQeMdTNKx+QiSYN0LZzsDmhPYeSsivL1Cw==
X-Google-Smtp-Source: ABdhPJyK9lNDKrCs4w4FjkehZE7UEcLoAPbiczZmKhA3RVLvDbYsghyBlmLbtquEkOgGmeQG/6IBs3D5jEV5pBdXu0Y=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr681576ots.192.1592516176577;
 Thu, 18 Jun 2020 14:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200618202447.872851-1-robh@kernel.org> <20200618205922.GA89738@ravnborg.org>
In-Reply-To: <20200618205922.GA89738@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Jun 2020 15:36:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dm-YRtTkQNbNh2JSD_qhf0Do9jP74wKp32=BYgOVRYQ@mail.gmail.com>
Message-ID: <CAL_Jsq+dm-YRtTkQNbNh2JSD_qhf0Do9jP74wKp32=BYgOVRYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Convert connectors to DT schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 2:59 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob.
>
> On Thu, Jun 18, 2020 at 02:24:47PM -0600, Rob Herring wrote:
> > Convert the analog TV, DVI, HDMI, and VGA connector bindings to DT schema
> > format.
> >
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > I put myself as maintainer, but would be happy if someone else was like
> > one of the Cc'ed people.
> I nominate Laurent for this....
>
> See some comments in the following.
> Mostly related to required - I may have missed something.
>
>         Sam
> >
> >  .../display/connector/analog-tv-connector.txt | 31 --------
> >  .../connector/analog-tv-connector.yaml        | 47 ++++++++++++
> >  .../display/connector/dvi-connector.txt       | 36 ---------
> >  .../display/connector/dvi-connector.yaml      | 75 +++++++++++++++++++
> >  .../display/connector/hdmi-connector.txt      | 31 --------
> >  .../display/connector/hdmi-connector.yaml     | 63 ++++++++++++++++
> >  .../display/connector/vga-connector.txt       | 36 ---------
> >  .../display/connector/vga-connector.yaml      | 42 +++++++++++
> >  8 files changed, 227 insertions(+), 134 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/display/connector/dvi-connector.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/connector/hdmi-connector.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/display/connector/vga-connector.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/connector/vga-connector.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> > deleted file mode 100644
> > index 883bcb2604c7..000000000000
> > --- a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -Analog TV Connector
> > -===================
> > -
> > -Required properties:
> > -- compatible: "composite-video-connector" or "svideo-connector"
> > -
> > -Optional properties:
> > -- label: a symbolic name for the connector
> > -- sdtv-standards: limit the supported TV standards on a connector to the given
> > -                  ones. If not specified all TV standards are allowed.
> > -                  Possible TV standards are defined in
> > -                  include/dt-bindings/display/sdtv-standards.h.
> > -
> > -Required nodes:
> > -- Video port for TV input
> > -
> > -Example
> > --------
> > -#include <dt-bindings/display/sdtv-standards.h>
> > -
> > -tv: connector {
> > -     compatible = "composite-video-connector";
> > -     label = "tv";
> > -     sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
> > -
> > -     port {
> > -             tv_connector_in: endpoint {
> > -                     remote-endpoint = <&venc_out>;
> > -             };
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
> > new file mode 100644
> > index 000000000000..d9ac42cb7e04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/connector/analog-tv-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog TV Connector
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - composite-video-connector
> > +      - svideo-connector
> > +
> > +  label: true
> > +
> > +  sdtv-standards:
> > +    description: Limit the supported TV standards on a connector to the given
> > +      ones. If not specified all TV standards are allowed. Possible TV
> > +      standards are defined in include/dt-bindings/display/sdtv-standards.h.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  port:
> > +    description: Connection to controller providing analog TV signals
> required:
>   - compatible
>   - port
>
> ??

compatible is implicitly required as that has to be there to match on.
So if it was the only thing, I just omitted it. Maybe better to just
list it.

I was thinking port is optional on all these as it could just be the
parent node.

>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/display/sdtv-standards.h>
> > +
> > +    connector {
> > +      compatible = "composite-video-connector";
> > +      label = "tv";
> > +      sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
> > +
> > +      port {
> > +        tv_connector_in: endpoint {
> > +          remote-endpoint = <&venc_out>;
> > +        };
> > +      };
> > +    };
> My personal preference is 4 space indent.
> Easier to read for me.

Sure.

> But we discussed this before - would be good
> with a recommendation so we know what to expect.

I don't really care until we have a way to automatically check it.
Then it will be the Law.

>
> Oh, and example-schema uses 6 spaces :-(

Humm...

> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/display/connector/dvi-connector.txt b/Documentation/devicetree/bindings/display/connector/dvi-connector.txt
> > deleted file mode 100644
> > index 207e42e9eba0..000000000000
> > --- a/Documentation/devicetree/bindings/display/connector/dvi-connector.txt
> > +++ /dev/null
> > @@ -1,36 +0,0 @@
> > -DVI Connector
> > -==============
> > -
> > -Required properties:
> > -- compatible: "dvi-connector"
> > -
> > -Optional properties:
> > -- label: a symbolic name for the connector
> > -- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> > -- analog: the connector has DVI analog pins
> > -- digital: the connector has DVI digital pins
> > -- dual-link: the connector has pins for DVI dual-link
> > -- hpd-gpios: HPD GPIO number
> > -
> > -Required nodes:
> > -- Video port for DVI input
> > -
> > -Note: One (or both) of 'analog' or 'digital' must be set.
> > -
> > -Example
> > --------
> > -
> > -dvi0: connector@0 {
> > -     compatible = "dvi-connector";
> > -     label = "dvi";
> > -
> > -     digital;
> > -
> > -     ddc-i2c-bus = <&i2c3>;
> > -
> > -     port {
> > -             dvi_connector_in: endpoint {
> > -                     remote-endpoint = <&tfp410_out>;
> > -             };
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml b/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
> > new file mode 100644
> > index 000000000000..aaf61bce64ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/connector/dvi-connector.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/connector/dvi-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DVI Connector
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    const: dvi-connector
> > +
> > +  type:
> > +    description: The HDMI connector type
> > +    enum:
> > +      - a   # Standard full size
> > +      - b   # Never deployed?
> > +      - c   # Mini
> > +      - d   # Micro
> > +      - e   # automotive
> type looks like something that was copied from another binding.
> It is not part of the .txt binding.

Err, copy-n-paste from hdmi...

Rob
