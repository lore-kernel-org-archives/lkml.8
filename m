Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9DC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42183206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061966;
	bh=Gr+uLrPetDSGG/lprsGxdFyfl6NmdPsAenZULogTMfM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=IgG7u4X0JbOBJcJ79mga9Ayoq1r1fU9k/PR0ylPY/oqNptDNdRvryHFYs2YiSqPqD
	 EpaGL7JAP1LT9Mft7n+Sk1B5woxBg7fwpTSQQ+QgY+eQKVKXXPK4C0myaiqXWowTDV
	 CGbKcfJeO1Y0FOkym2vWZJI/JJ7PJmjowYp7KTqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCMBMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgCMBMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:12:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0197D206EB;
        Fri, 13 Mar 2020 01:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061964;
        bh=Gr+uLrPetDSGG/lprsGxdFyfl6NmdPsAenZULogTMfM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QzkKJ7X3d6SkQbm3jgvmaYEY0pYXbkXWaYRKn74MawiXpGMBi0jJFJejdWwb/+w8R
         EEJSDrRJuPWmLG/uaN17YyosyVZf++nGJgDlDaJKr3xtGqIQMnjMbAUKtvQQQ+plUu
         g8Nroiay/nLoBY5XENu/K1cQXdUBvgjCLyn1d77g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <75dd8f658a253649c176509f0d8d3dd10354ce51.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <75dd8f658a253649c176509f0d8d3dd10354ce51.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 13/89] clk: bcm: rpi: Switch to clk_hw_register_clkdev
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Thu, 12 Mar 2020 18:12:43 -0700
Message-ID: <158406196321.149997.9414275114529922737@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:15)
> Since we don't care about retrieving the clk_lookup structure pointer
> returned by clkdev_hw_create, we can just use the clk_hw_register_clkdev
> function.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
