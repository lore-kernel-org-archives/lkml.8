Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21170208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590562060;
	bh=5+tlLkLihU00jqHmrP7H7SWlj+BNK7hJ7XmRaGHL96w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=VsVrrCz6V+3ogHZEBeQ0DD0oloEodMlkqAy76o65P0ZfvWIxMjSgn56+uzCX3tmr6
	 qo0yD2YMM86ISZ9BRAtVbiV3NRab2MYpJOyb+q/j8Xd+FGiN5CWm51EHk88rX8KjSr
	 jH3QXWqkS/r2apgM9C/Bo8gx8D2UzrFCxCf/gjI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgE0Grj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgE0Grj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:47:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ABC20787;
        Wed, 27 May 2020 06:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590562058;
        bh=5+tlLkLihU00jqHmrP7H7SWlj+BNK7hJ7XmRaGHL96w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nZ0/4jIgaBAacgfigDF/ATTLFMH2+8osx1Ba1rg/F7Ox0XbAWloCR0TZG4GKia4Bd
         ABwmIPWaiNEmptbBXpVCXTQd8TJQrLrGAS6A92GnC/aKmfjEKLvpvwzV5ZCYnFIVfG
         egoj4X3fin0ToeOosPdQfr+/anpPn4ia9B0mIHZY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eeae1a92da7812f04a034498d3a1cb60e282fec7.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <eeae1a92da7812f04a034498d3a1cb60e282fec7.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 06/91] clk: bcm: rpi: Statically init clk_init_data
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
Date:   Tue, 26 May 2020 23:47:38 -0700
Message-ID: <159056205813.88029.2378352854347673195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:33:47)
> Instead of declaring the clk_init_data and then calling memset on it, just
> initialise properly.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
