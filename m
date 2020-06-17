Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4482158C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592410406;
	bh=lpXuFKE5NwbxL+Myuog+8MQSFJww+kAisP26ypU0cmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bLczRBL+HrNsaXqcktbECro6nthXt8f39Z/bwr3hE4t9HAMkiMezRio54k6t4dGCe
	 pm5qTeOADzQdWBAPMqqxZVXuW0p00SVFIoljOrcESUwA4gvhGBBLoRPOh9QUwIP0KN
	 DQg2fu54aDoeAkzTXi5Nba4gH4/wkJeUmAE/HiP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFQQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQQNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:13:21 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263D421852;
        Wed, 17 Jun 2020 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592410400;
        bh=lpXuFKE5NwbxL+Myuog+8MQSFJww+kAisP26ypU0cmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQKB6GGuZecoXsBHLTmTayNjiY525hIvfwz4Ll3WGkpczPsJSiGwwJj3DTf+4SuvZ
         fs9Ii5ZsPU8SWmCnXu2g4c5AUlDblZbcZohUyYL/dTWwqdHxGVPSckL/8wBUP/xHnR
         hCzmG6LwsBojyDDqWKl+/v3MKeXu+e7lC68m7oKo=
Received: by mail-ot1-f47.google.com with SMTP id m2so2034469otr.12;
        Wed, 17 Jun 2020 09:13:20 -0700 (PDT)
X-Gm-Message-State: AOAM5316vtWlq+QZYy/dbCUbaAyt6QzvQ8SgyA5UAYGPvz8Yvttv0sX6
        828JUugR97v4ZgW1tufHWCg707upwvA7ZJF53A==
X-Google-Smtp-Source: ABdhPJzOrYA9hUrCB4Q/Kh4sdCOF7GT0r5cBhyDZEnpNTZzHilQLgrTjTn8l5D6KcVq8iv4r8qlOvEYhFOIkrU6sScc=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr7003769otr.107.1592410399429;
 Wed, 17 Jun 2020 09:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37aec1ae-7fee-44cb-ae24-a10a151abcb3@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3fedbcf4-0977-416b-9979-d557fd9233a7@emailsignatures365.codetwo.com>
 <20200610202255.GA3646369@bogus> <504080a1-cbc9-f781-04bb-12d5679ba697@topic.nl>
In-Reply-To: <504080a1-cbc9-f781-04bb-12d5679ba697@topic.nl>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Jun 2020 10:13:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+6cj99+7cb1vrZ9eLouo-pPWTDjDEOotDQExazdrx-XA@mail.gmail.com>
Message-ID: <CAL_Jsq+6cj99+7cb1vrZ9eLouo-pPWTDjDEOotDQExazdrx-XA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:38 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>
> Met vriendelijke groet / kind regards,
>
> Mike Looijmans
> System Expert
>
>
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topicproducts.com
>
> Please consider the environment before printing this e-mail
> On 10-06-2020 22:22, Rob Herring wrote:
> > On Wed, Jun 03, 2020 at 02:09:15PM +0200, Mike Looijmans wrote:
> >> Support VBUS power control using regulator framework. Enables the regulator
> >> while the port is in host mode.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >> v2: Add missing devm_regulator_get call which got lost during rebase
> >>
> >>   .../devicetree/bindings/usb/dwc3.txt          |  1 +
> >>   drivers/usb/dwc3/core.c                       | 34 ++++++++++++++-----
> >>   drivers/usb/dwc3/core.h                       |  4 +++
> >>   drivers/usb/dwc3/drd.c                        |  6 ++--
> >>   4 files changed, 33 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> >> index 9946ff9ba735..56bc3f238e2d 100644
> >> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> >> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> >> @@ -37,6 +37,7 @@ Optional properties:
> >>    - phys: from the *Generic PHY* bindings
> >>    - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
> >>      or "usb3-phy".
> >> + - vbus-supply: Regulator handle that provides the VBUS power.
> > Does the DWC3 block require Vbus to power itself? Doubtful. This
> > belongs in a usb-connector node. If the DWC3 driver wants to get the
> > Vbus supply, it can fetch it from that node.
> >
> > Rob
>
> Okay, I've been digging into that. But there's no actual driver that
> binds to a "usb-b-connector" compatible, so how do we get to the
> vbus-supply from there?
>
> [devm_]regulator_get only accepts a device as argument, and will not
> look into child nodes. The only way to get at the vbus of a child node
> (or a node linked through a port) would be to hand-code the equivalent
> of of_regulator_get(), which will not be acceptable.

Doesn't it look into child nodes calling of_get_child_regulator()?

You're right that it wouldn't work if graph is used. The connector has
to be either a child of a controller for the connector or the USB
controller. I'd expect you'd have the former for Type-C, but for
"usb-b-connector" the parent is more likely just the USB controller.

In any case, having a struct device shouldn't be a requirement and
most subsystems expose a get function only needing the DT node.

> Or is it the intention that I write a usb-X-connector device driver
> first that handles the vbus?

That's a kernel implementation detail that is independent of the
binding, but yes we'll probably need a driver or library helper
functions eventually. Note that it is possible to have a struct device
without a driver.

Rob
