Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A5DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B56920897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590785932;
	bh=u/BjcM0vgDDnwUaHHYA++wMYVaatNaYVe4DyeskMjHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZR/r8O9gnhr2WO3EkGCZ9K6P2n8f1lSsiky37t7NksVZ0YTOJk5wERuVgY7SWPVoX
	 1Uqor/BoHVtZYiJIrwYGteVPuGFBooEnXgJDe+sIPbRJyjKd64T3nlXW8HNku4u1MF
	 GB5IimHjbN7XtLhuc76f6cQnh9cKV+jdYHj9WSwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgE2U6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgE2U6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:58:51 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B880B20897;
        Fri, 29 May 2020 20:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590785930;
        bh=u/BjcM0vgDDnwUaHHYA++wMYVaatNaYVe4DyeskMjHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OR6gfXkH/fYgmYWbzhUpHkb+S1gWwPKoCY5+xi9dtyjvBcbkUohmOidEdtySj3Lh/
         ViHCKbYSJ5yZW5Dh1Hgpt62eeXc78X6loxSNB0H0xGHPPg+YB71kL9Msu7nCqZABx8
         p2VM4t4vMeY51/mxrkSZYewcBAixMaQnJrxS9PkM=
Received: by mail-ot1-f46.google.com with SMTP id u23so3000703otq.10;
        Fri, 29 May 2020 13:58:50 -0700 (PDT)
X-Gm-Message-State: AOAM533BGI5JmmUkM2rOf+UssOw8PeXfRN8rvltO4dCTRzS43d0eXguT
        sxzTGIm0LnGvc5TE6DiHV3xB+EbIvHwZmOnXfw==
X-Google-Smtp-Source: ABdhPJxku4CiKqKbXARDJdKlVE7/iYLyWdVcoIOOuIVkaKsd3FDEqBDjZCj8I+sBXKm+NG+kSvECK39UUA2JfLp/y8U=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr7702206oth.129.1590785930016;
 Fri, 29 May 2020 13:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200527164934.28651-1-dmurphy@ti.com> <20200527164934.28651-2-dmurphy@ti.com>
 <20200529182544.GA2691697@bogus> <b8a0b1e8-c7fb-d38b-5c43-c6c4116a3349@ti.com>
In-Reply-To: <b8a0b1e8-c7fb-d38b-5c43-c6c4116a3349@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 May 2020 14:58:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJyE5fssKhO+p-=7S8jo_Pw6gt1vWSkYr-pgWutrej0w@mail.gmail.com>
Message-ID: <CAL_JsqLJyE5fssKhO+p-=7S8jo_Pw6gt1vWSkYr-pgWutrej0w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: Add tx and rx internal delays
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:24 PM Dan Murphy <dmurphy@ti.com> wrote:
>
> Rob
>
> On 5/29/20 1:25 PM, Rob Herring wrote:
> > On Wed, May 27, 2020 at 11:49:31AM -0500, Dan Murphy wrote:
> >> tx-internal-delays and rx-internal-delays are a common setting for RGMII
> >> capable devices.
> >>
> >> These properties are used when the phy-mode or phy-controller is set to
> >> rgmii-id, rgmii-rxid or rgmii-txid.  These modes indicate to the
> >> controller that the PHY will add the internal delay for the connection.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>   .../bindings/net/ethernet-controller.yaml          | 14 ++++++++++++++
> >>   1 file changed, 14 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> >> index ac471b60ed6a..70702a4ef5e8 100644
> >> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> >> @@ -143,6 +143,20 @@ properties:
> >>         Specifies the PHY management type. If auto is set and fixed-link
> >>         is not specified, it uses MDIO for management.
> >>
> >> +  rx-internal-delay-ps:
> >> +    $ref: /schemas/types.yaml#definitions/uint32
> >> +    description: |
> >> +      RGMII Receive PHY Clock Delay defined in pico seconds.  This is used for
> >> +      PHY's that have configurable RX internal delays.  This property is only
> >> +      used when the phy-mode or phy-connection-type is rgmii-id or rgmii-rxid.
> > Isn't this a property of the phy (this is the controller schema)? Looks
> > like we have similar properties already and they go in phy nodes. Would
> > be good to have a standard property, but let's be clear where it goes.
> >
> > We need to add '-ps' as a standard unit suffix (in dt-schema) and then a
> > type is not needed here.
>
> This is a PHY specific property.
>
> I will move them.
>
> Dumb question but you can just point me to the manual about how and
> where to add the '-ps' to the dt-schema

Here[1], but looks like I already added it. I'd checked the old kernel
version (property-units.txt) which didn't have it.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-units.yaml#L48
