Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3752468E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCAACK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:02:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55476 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgCAACJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:02:09 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8C3a-0004tG-JZ; Sun, 01 Mar 2020 01:02:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, dianders@chromium.org
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: fix Rockchip rk3399-evb bindings
Date:   Sun, 01 Mar 2020 01:02:06 +0100
Message-ID: <3089122.gegXmbq47i@phil>
In-Reply-To: <229c3511-d99d-8bac-6241-0088c5fc13ef@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com> <78b8b53f-2e2a-3804-41fb-bb2610947ca2@arm.com> <229c3511-d99d-8bac-6241-0088c5fc13ef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 28. Februar 2020, 14:28:36 CET schrieb Johan Jonker:
> Hi Robin,
> 
> When I look at the review process of rk3399-evb.dts
> it is mentioned here:
> 
> https://lore.kernel.org/patchwork/patch/672327/
> 
> >> +	model = "Rockchip RK3399 Evaluation Board";
> >> +	compatible = "rockchip,rk3399-evb", "rockchip,rk3399",
> >> +		     "google,rk3399evb-rev2", google,rk3399evb-rev1",
> >> +		     "google,rk3399evb-rev0" ;
> > 
> > can you check against which compatibles that coreboot really matches?
> > 
> > As we said that the evb changed between rev1 and rev2, I would expect the 
> > compatible to be something like
> > 
> > 	compatible = "rockchip,rk3399-evb",  "google,rk3399evb-rev2", 
> > 			"rockchip,rk3399";
> > 
> > leaving out the rev1 and rev0
> 
> The consensus in version 4 ends in what is shown in the dts file, so I
> changed it in rockchip.yaml. Things from the past maybe can better be
> explained by Heiko. Please advise if this patch needs to change and in
> what file.

Just get rid of the "google,rk3399evb-rev2" from the .dts please :-) .

(1)  "rockchip,rk3399-evb", "rockchip,rk3399", "google,rk3399evb-rev2";
    is just wrong for the reasons Robin explained, I guess that slipped
    through review at the time.
(2) "google,rk3399evb-rev2" was a specific variant for Google I'm pretty
    sure they'll have scraped all these boards directly after they had the
    first actual rk3399-gru development devices

So I'm pretty sure the only rk3399-evbs in existence are the general ones.


Heiko



