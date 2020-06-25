Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEF120578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593047742;
	bh=slMjPRa67K16YFPswiAcJrSACF0ga1IiQ1WSlFEumHI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=CGm0UtWo3u9JlntDnWGPP4743gxe3PxMR0W3sownXPV+3Nc73uhzEiQ1n7NivGjwu
	 MERSrLzCTQmia9y1jb22qvRNAO0msv0eA1vJ6AJwqJ0prBZHOqSy2EvJHs7xHYh61n
	 BciIzcJ+4nNiTrRYaura6l0zKUBtMJv0Ic0XEr2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbgFYBPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389183AbgFYBPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:15:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ECC20578;
        Thu, 25 Jun 2020 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593047733;
        bh=slMjPRa67K16YFPswiAcJrSACF0ga1IiQ1WSlFEumHI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ORIO8EoynDIzF4ep5xBiRUWrGI7/V+pgBWZbrlds84dQKm6M3vZj0f4EOlqqGlH0L
         2ujQ8VsK5WcOcMUV78XQJmb9MN1tWxUiMywbWmNuKJI/sEOPGCyKAGKXVBZEMsvTZS
         syXLvmJpugcCfTidoJ4ym2XEkVcwxR64pLP5TMnE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
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
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 18:15:32 -0700
Message-ID: <159304773261.62212.983376627029743900@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:40)
> Hi,
>=20
> Since the whole DRM/HDMI support began to grow fairly big, I've chosen
> to split away the two discussions between the firmware clocks and the
> HDMI support.
>=20

I see one problem.

WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/bcm/clk-bcm2711-d=
vp.o

Can you send a followup patch to fix this?
