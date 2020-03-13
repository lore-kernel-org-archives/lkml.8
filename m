Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C3C1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB87206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061917;
	bh=h4bPyPm/Sm9lF/OmxTJ07z1JAhtZcaucXFkueOwMQYs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=n1nc68iPPU9vgzOGaNCOagHj/VQNDfXcdTMm+GtSR8O1Lr6ofw07zPV1EpHZgNLvp
	 IC6+VMhlNkc+Up/+n90OzybNtpQKE/TyRlHATxVnh62X7lSpdAQjKluw2cRhipzbQU
	 YlnoWB5MPEy86q5KfKifX3EX4vNeLt/KrIuGzxbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCMBL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgCMBLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:11:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB56206EB;
        Fri, 13 Mar 2020 01:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061914;
        bh=h4bPyPm/Sm9lF/OmxTJ07z1JAhtZcaucXFkueOwMQYs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L8gWd01GOJPLWBVOF2VUOqULsENOZVKgTTlgP2cq0rv9AN0rHPu+bxidHlYK1d6C1
         j+cNuzFZInccS5X8889e7tsruGdB4ychm5pD8yNYJm5D5BXpjfiG86rJtFkmB+EwVt
         lessXmkSmrbMv01nOr02JpXVmh/oOC4RLs8du0eI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1779dd1489125be571fb3c2ee3e04c32f9875420.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <1779dd1489125be571fb3c2ee3e04c32f9875420.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 14/89] clk: bcm: rpi: Make sure the clkdev lookup is removed
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
Date:   Thu, 12 Mar 2020 18:11:53 -0700
Message-ID: <158406191350.149997.7619291875265095634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:16)
> The clkdev lookup created for the cpufreq device is never removed if
> there's an issue later in probe or at module removal time.
>=20
> Let's convert to the managed variant of the clk_hw_register_clkdev functi=
on
> to make sure it happens.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
