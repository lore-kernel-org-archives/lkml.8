Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5536D20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045749;
	bh=7H8rdOs4Gi82auT8J5a9dYX1b6KF67Yi7qDXrxeXEZM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=PQ8ngdXJJZT9ZxyzaakVe4MsRxX6/JHKO5ec2Q+csBleAC64pEX8oYLcm4x+c2pw0
	 UE0GK4ncjV0sRv381hhAPJdlp6RgycZwWOlxf5p6IXGmUm/nmNMcopdxnIqnJslVNB
	 7nHfiy4QHpRRxhUUnLA1AB4fJC3KnyQ7lcs3n0Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgFYAm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbgFYAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0D920781;
        Thu, 25 Jun 2020 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045745;
        bh=7H8rdOs4Gi82auT8J5a9dYX1b6KF67Yi7qDXrxeXEZM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hH1QJDyTMsTvkMb6gi09Ru+RXDevvIqelUHN0jSxfb1igjyee1k95vC8X46zgawhc
         yntWHmqQbywoxLssx7gvDa8kdHh4k7PSP33bGaknyZnh3xFQvn1LpgApXsDuzzaHMc
         kDl3DLVETgcsh07zg0Z33aqf9WUHVo7ILAgSs8W8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f6105207e7ef5a5ea8d7a1774faf989d341a25f5.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <f6105207e7ef5a5ea8d7a1774faf989d341a25f5.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 02/27] dt-bindings: clock: Add a binding for the RPi Firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:42:24 -0700
Message-ID: <159304574441.62212.5242673927924093268@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:42)
> The firmware running on the RPi VideoCore can be used to discover and
> change the various clocks running in the BCM2711. Since devices will
> need to use them through the DT, let's add a pretty simple binding.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
