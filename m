Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D35C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2A020781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045962;
	bh=h3bQASstGvyPTNmSJn0h1g6M97iVMGwJZ7PDrZYeR/Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Na1AsWEr7b7/KD0GPkgQqBpGtTyZUzOLg//i/P01JVee8n30fQhUGgY68Mm5gj/TC
	 QtycZ/OygIpHitYN/+sE53Qcki9uYZp+k7XzMBdLsO5ik1ZNDhJZOmhYAbxxjeKFGe
	 UeU4hzpZOZ1V5gb2SsO0bhAsxxmmwfUNPgLcFpI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbgFYAqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYAp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CDE207DD;
        Thu, 25 Jun 2020 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045959;
        bh=h3bQASstGvyPTNmSJn0h1g6M97iVMGwJZ7PDrZYeR/Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DkGDbDAFAzsbW66B6pZWSzjU8OV55wMVDrSJpdTlquoLyRyVGIweiyPwNHpxwmSaM
         EedlWFGF8+BlgnWd17BNGz2lq7srM0sW5S0yl6nzIbs+r82/RieujpxfAsnvJ70RA3
         caviAZLcltjxILmY6yIxHRwc9GxM4qVUGwRlgUDQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d26a4c58248f5be7760a7f2f720a1310baea5dd.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <5d26a4c58248f5be7760a7f2f720a1310baea5dd.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 23/27] Revert "clk: bcm2835: remove pllb"
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
Date:   Wed, 24 Jun 2020 17:45:58 -0700
Message-ID: <159304595881.62212.2722553134591611417@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:03)
> This reverts commit 2256d89333bd17b8b56b42734a7e1046d52f7fc3. Since we
> will be expanding the firmware clock driver, we'll need to remove the
> quirks to deal with the PLLB. However, we still want to expose the clock
> tree properly, so having that clock in the MMIO driver will allow that.
>=20
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
