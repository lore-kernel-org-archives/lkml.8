Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FBC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E41C20857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbMUxmCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgCCGbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:31:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46808 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:31:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so927164pfp.13;
        Mon, 02 Mar 2020 22:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndx+j6LnVMqCAXHMVDFZLXsjTKEuusKvWbflCc649JY=;
        b=UbMUxmCCJ1iqtAUi6lktmncZnowFCN1CA8b4uv3RRka2O4keDihSXfn8yE9a2iXPoL
         9z7MgPOfyHIRosPIN1a1t2ACLwEftyMbcu3gmo9dew1aYCQFhNfkGldLuMWqX7FNANqi
         b3IkikKS9IgVFw5xhru6Tv/r/MSX3e890v5jp060Rpf0liav7ePur3okq8pvAjXZez3f
         RbpgV6gQE3ti6GZ9F7AQSEaz5PlWceHqzCoQ28ZFbN31V7noE07UcLBpPgX479J2mwQe
         pvsYq98tdanDbB4+zLyYdr0tGxAT/h0gaiN12AZbDOO0eCW7wu6gYGx8ehDn/5CpVpCJ
         a+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndx+j6LnVMqCAXHMVDFZLXsjTKEuusKvWbflCc649JY=;
        b=CFpoUbNxO29uwnXYVOZyQlje7oHTe6rk06wvKKf36FKj1oRX/2sSDdbwj0WIC0w60T
         0z48bz5m2RbMBM+q80zA0mXxI2kcRa1VIP6+haVgspdKU1/bGNcaFqJkBa+wc35xyKpo
         oC3jmbybvTBrZInWJ+04J+esryMovzyzloP1gMmL90raJyH9ha+PmDdYXv1RBRwLt9nh
         h01yjiU8o21MdxBA8zCzai/J8UdgD3t92mBLaPr/ekH/hjlTX6vF1rgZefe8v0f/5kRb
         tWJ9hjjK8QI0yAm0jjzI/Jb4pjEz2kRm1BRCYV5tnh10Jn6eHCwnaGBYFhr9+AuX4iuN
         hnTg==
X-Gm-Message-State: ANhLgQ2d1de71eAOuYr9UuS6xoNxXW0wz7HxxJLVf+dgplrq8Kii9vbt
        fO4N0jDwuJS3H4JAvNljX3M=
X-Google-Smtp-Source: ADFU+vuGZQszw51zqWe1fJX1aHCdONMS54hLYZPiwaStPENZVZ7FsvgKtDNPs8Yql9brDHHw68ftjQ==
X-Received: by 2002:aa7:9726:: with SMTP id k6mr146994pfg.196.1583217064295;
        Mon, 02 Mar 2020 22:31:04 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 69sm4375913pfz.97.2020.03.02.22.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 22:31:03 -0800 (PST)
Date:   Mon, 2 Mar 2020 22:30:57 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v6 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200303063056.GA6751@taoren-ubuntu-R90MNF91>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
 <20200228020757.10513-8-rentao.bupt@gmail.com>
 <20200302234744.GA21778@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302234744.GA21778@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the careful review and I've addressed all your feedback in
v7 (based on my understanding). Please kindly let me know if you have
further suggestions.


Cheers,

Tao

On Mon, Mar 02, 2020 at 05:47:44PM -0600, Rob Herring wrote:
> On Thu, Feb 27, 2020 at 06:07:57PM -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add device tree binding documentation for the Aspeed USB 2.0 Virtual HUb
> > Controller.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  Changes in v6:
> >    - added 2 required properties into example and passed "make
> >      dt_binding_check".
> >  Changes in v5:
> >    - updated maintainer to Ben.
> >    - refined patch description per Joel's suggestion.
> >  No change in v2/v3/v4:
> >    - the patch is added to the patch series since v4.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > new file mode 100644
> > index 000000000000..b9f33310e9a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> Dual license new bindings please.
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 
> > +# Copyright (c) 2020 Facebook Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED USB 2.0 Virtual Hub Controller
> > +
> > +maintainers:
> > +  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > +
> > +description: |+
> > +  The ASPEED USB 2.0 Virtual Hub Controller implements 1 set of USB Hub
> > +  register and several sets of Device and Endpoint registers to support
> > +  the Virtual Hub's downstream USB devices.
> > +
> > +  Supported number of devices and endpoints vary depending on hardware
> > +  revisions. AST2400 and AST2500 Virtual Hub supports 5 downstream devices
> > +  and 15 generic endpoints, while AST2600 Virtual Hub supports 7 downstream
> > +  devices and 21 generic endpoints.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-usb-vhub
> > +      - aspeed,ast2500-usb-vhub
> > +      - aspeed,ast2600-usb-vhub
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Common configuration registers
> 
> If 'Common' means something specific to this block, then keep. 
> Otherwise, you can drop ti.
> 
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: The Virtual Hub Controller clock gate
> 
> Drop this.
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  aspeed,vhub-downstream-ports:
> > +    description: Number of downstream ports supported by the Virtual Hub
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> 
> Constraints?
> 
> 'maximum: 5' ?
> 
> default?
> 
> > +
> > +  aspeed,vhub-generic-endpoints:
> > +    description: Number of generic endpoints supported by the Virtual Hub
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> 
> Constraints?
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +  - aspeed,vhub-downstream-ports
> > +  - aspeed,vhub-generic-endpoints
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    vhub: usb-vhub@1e6a0000 {
> > +            compatible = "aspeed,ast2500-usb-vhub";
> > +            reg = <0x1e6a0000 0x300>;
> > +            interrupts = <5>;
> > +            clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +            aspeed,vhub-downstream-ports = <5>;
> > +            aspeed,vhub-generic-endpoints = <15>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&pinctrl_usb2ad_default>;
> > +    };
> > -- 
> > 2.17.1
> > 
