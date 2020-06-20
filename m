Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC0AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E222527
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592611991;
	bh=oKZt2XpuBFJetNv+O+2UZ/i8GnyLDNthpwC/ZKvtjmg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=B2VzjyQxVyUML62q9AzPwmDM01U4tv9WlLlFbVHhRrb5ZLV1qQJlPoZGcjTojC7A2
	 r0GJMwT18AxOChkZ+aAB3vj1USORTquoRvZpJcMukVBLdaFKuWHKVVX4GYamEsRFJ+
	 RtbJgAH/6K4lagcR5hSrwQ41dWj8inMNeqoqFngw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgFTANG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730639AbgFTANE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:13:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200A922518;
        Sat, 20 Jun 2020 00:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592611984;
        bh=oKZt2XpuBFJetNv+O+2UZ/i8GnyLDNthpwC/ZKvtjmg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XgvNYlUvhN2x6f88No+RZzedTdb9nFnbSttEHcgcHobq+lhoe4InsxoIWvsr+CvN8
         1nIl8n7Y5mZWboVsJ68l0Gdtv4DKqV2nsmVBRDY1DwQ7rQWRz5f6Zt47Nh9qwX0R9b
         0vB4E2PB3mGpdTXS4tAL66Xe2gcK6fML6Ex+hqR8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0b8f09baff1ff3c471631e6f523e2b2cd773ec47.1591867332.git-series.maxime@cerno.tech>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech> <0b8f09baff1ff3c471631e6f523e2b2cd773ec47.1591867332.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add BCM2711 DVP binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Fri, 19 Jun 2020 17:13:03 -0700
Message-ID: <159261198344.62212.6959178295186241543@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-11 02:23:15)
> The BCM2711 has a unit controlling the HDMI0 and HDMI1 clock and reset
> signals. Let's add a binding for it.
>=20
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
