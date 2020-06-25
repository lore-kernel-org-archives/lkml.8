Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AFEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BBC207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045757;
	bh=50m5t8XvnoSxjgR1BevTOCsBr3sDDGVAGPgInYyBWsU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Qy9b0oYcvxN6IQofSXwemrJuAI05DKG5xTl/AxhM5jUQucnl26qVVI1D8i+bP97bW
	 IW0eOXNCFiq9gHQLrdYqrdebW9jmheYDtfp/C/7cNKvlww1sJOkAZFtJ7efLokFGsG
	 FtgR/JZ8iYZ40lf5PlqYzIxX6VvzaCIkdQuklymY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbgFYAmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbgFYAma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C27C2078D;
        Thu, 25 Jun 2020 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045749;
        bh=50m5t8XvnoSxjgR1BevTOCsBr3sDDGVAGPgInYyBWsU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jk/D4u2Sw9qxV+Vz8l9rszeJ5x5VEnBgeNSlxjzw+nPeA+TIjYdYRbPyZKB1+X7px
         ODRHyNy+Y2ejNqK5AwNqAv3Aryg8pjAs6toMPnrvPs570RqHkzOfaW0axTceTIZFMd
         zTAmhhxXAHccwAVMVD6bsjxcNSrNegNf3Je7Rc7g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <72114c4287ebda2dbd952ea238d4489d359897e5.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <72114c4287ebda2dbd952ea238d4489d359897e5.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 03/27] firmware: rpi: Only create clocks device if we don't have a node for it
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:42:28 -0700
Message-ID: <159304574895.62212.6836058758414679572@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:43)
> The firmware clocks driver was previously probed through a platform_device
> created by the firmware driver.
>=20
> Since we will now have a node for that clocks driver, we need to create t=
he
> device only in the case where there's no node for it already.
>=20
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
