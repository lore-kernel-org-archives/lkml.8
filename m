Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0784207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045954;
	bh=PEw7OU0K6NvMrbxEGNMZbGg2q9OAjpgG8RD+pU15Ku4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xmwlt/BEtLc3QNCH+JPJzhRUeCXqEDiX5W+itjHf2NKLF4MyU87ooVatEC6X0notj
	 6YARHFL+gYAb+2dC514BkquxGK2GTjwl4wqNxq+C4vF3wZsZcrJUyusNvM7bZSgCo4
	 IcbgYPpj5RceY0ZlNWL18F7uInondiRNg+f0XWIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbgFYApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYApv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8859E20781;
        Thu, 25 Jun 2020 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045951;
        bh=PEw7OU0K6NvMrbxEGNMZbGg2q9OAjpgG8RD+pU15Ku4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O6SIV1uMEHErtJOtGcAen5GUjLMlHb8lyezX51YEQG/4WbhMURxfmbBGz/PYMwWyg
         3Kn5RAqiyvc0nRL0nIK83Yzbo6GK3XRmlDb8ECH3dyWWBH8dxy7iskD5eVIRkEteQA
         6UkRzrgDbQqZVcNh3EcVR0R0yrWBfuA19KellIhM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a52a5f5768cd33716cdd35237c6613f26ad75013.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <a52a5f5768cd33716cdd35237c6613f26ad75013.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 22/27] clk: bcm: rpi: Give firmware clocks a name
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
Date:   Wed, 24 Jun 2020 17:45:50 -0700
Message-ID: <159304595094.62212.14613931379549423607@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:02)
> We've registered the firmware clocks using their ID as name, but it's much
> more convenient to register them using their proper name. Since the
> firmware doesn't provide it, we have to duplicate it.
>=20
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
