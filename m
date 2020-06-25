Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF837C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF9020849
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045943;
	bh=FEAhPTzXwf9/a1MkZxoTkGk5AsCEybOOMPbaOkXOhFQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wpu7bF3eFLrzhC1dryL2F1bjrwFpVpDTBxhGgquGvRjvZN4Hng3FxDy8+YHv1j6zl
	 hUA8fmCN4w214hILH/JIra6AHwDA8+mNqR/3d7u+lWcE+4wc64ctzVyq9TDGnk3cUK
	 6TvnLJCoBYXsp+NRZuR1+lJMaa4K1ViZyzBihcBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbgFYApl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYApj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390E5207DD;
        Thu, 25 Jun 2020 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045939;
        bh=FEAhPTzXwf9/a1MkZxoTkGk5AsCEybOOMPbaOkXOhFQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tFBSOAt8C6PWkW6FUaiEb8HokkMM8f4+6KCCBObo59di2n7Z8ijB3kA5tYv+OTS/B
         oQQyrP8DlIBAMjDpmCmE95Ki9D4PCc8glNTvBXAXYI/aewbRqyJfu4fkdCOFooZHNR
         NZ8qcNxbDeML98mGHqaqVtlkO9HsNlWsDc5rD0Vk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4738f77ee7de9b48a3bb1c558ead958d0cc064d9.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <4738f77ee7de9b48a3bb1c558ead958d0cc064d9.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 20/27] clk: bcm: rpi: Add an enum for the firmware clocks
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
Date:   Wed, 24 Jun 2020 17:45:38 -0700
Message-ID: <159304593855.62212.13370559607640884860@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:00)
> While the firmware allows us to discover the available clocks, we need to
> discriminate those clocks to only register the ones meaningful to Linux.
> The firmware also doesn't provide a clock name, so having a list of the ID
> will help us to give clocks a proper name later on.
>=20
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
