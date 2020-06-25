Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2220836
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045774;
	bh=2l1FZ/e7QiPwMzZSxnPFJMddntCY445SqFEe91qeBzY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=afA6wmjm47/EIBzvBSEUf6bVveolpKIHizqY+F/W6aHy+ItFdrViTqzq2CGOzbyba
	 m4LN/IUvlLSvV2WbcBS4p6Cht4+9fvO7ajTi4aTgtMQR0Pb5hSfNO1GI7qcUdIa743
	 X+/CfNRR8E0lIGc8nulKjXZxH2iw3TYzPEkTc8JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgFYAmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgFYAmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E90207DD;
        Thu, 25 Jun 2020 00:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045769;
        bh=2l1FZ/e7QiPwMzZSxnPFJMddntCY445SqFEe91qeBzY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=z7sa0vMcSPy6CAOsLaL0l7Rso3AeLs+vZqUwmiz5phECl512t12Fp1yS+k+QJdH1I
         lJGEGFf23zBuTTvx9f+1B1NfLXBfkpZcmyykA8XSLoW3goRhYfIWrTdFE1m0DBZ85Z
         XhPtra3o+XbynjKBcuxw7DoWU2OV0siHQR8DvtkE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <842859cf1a77478620f45049178a588448202858.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <842859cf1a77478620f45049178a588448202858.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 07/27] clk: bcm: rpi: Remove global pllb_arm clock pointer
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
Date:   Wed, 24 Jun 2020 17:42:48 -0700
Message-ID: <159304576826.62212.17238872421995034330@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:47)
> The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
> anywhere but in the raspberrypi_register_pllb_arm.
>=20
> Let's remove it, this will make our lives easier in future patches.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
