Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BDBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608AD2137B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592611226;
	bh=619+Wt+vDRk64Ku14T9Siv1alCzBunMBcYsA7lo5HXw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-ID:From;
	b=XnoYK0WY4gQ2tqIsqi7unClKa+cNBaRlRrSynGQ7GLMGOqGcaOayR5dWN8Y6dBjJv
	 s6HQaBkPR+cJiO6La+8x5lo+m9tK9pjG2t7A9SKt4C5xplesr2o2gcJSJOS+S4Ym27
	 8GYXjRo+1EZSdQp9hPbu7DF2prkxfRXPy9sifzgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgFTAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgFTAAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:00:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F93206D7;
        Sat, 20 Jun 2020 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592611220;
        bh=619+Wt+vDRk64Ku14T9Siv1alCzBunMBcYsA7lo5HXw=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=Fco8Iq1m3csA/NlUxjibipKJo/3I2id/mpiACADkRzt5vBSL9HsnYpJk/7/aqE5Q6
         /i4HgLF26WQn/5K0rPygvQ3JBAXT/MZFNL5z0YsA1c44BbAQo7B3P8Cx/RnGkyOB5i
         7IQEGOd6mjCIDlPWHE0UJ7eP2031Hv6NbUvDypIQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200610140858.207329-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com> <20200610140858.207329-1-noltari@gmail.com>
Subject: Re: [PATCH v2 0/2] clk: bcm63xx-gate: add BCM6318 support
From:   Stephen Boyd <sboyd@kernel.org>
To:     noltari@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, f4bug@amsat.org, jonas.gorski@gmail.com,
        julia.lawall@lip6.fr, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, mturquette@baylibre.com, robh+dt@kernel.org
Date:   Fri, 19 Jun 2020 17:00:19 -0700
Message-ID: <159261121936.62212.219486512557338832@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add support for the gated clock controllers found on the BCM6318.
>=20
> =C3=81lvaro Fern=C3=A1ndez Rojas (2):
>   dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
>   clk: bcm63xx-gate: add BCM6318 support
>=20
>  .../bindings/clock/brcm,bcm63xx-clocks.txt    |  2 +
>  drivers/clk/bcm/clk-bcm63xx-gate.c            | 44 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>=20

Sorry please don't send these in reply to the original patch series. I
have a hard time finding new patch series in my 'thread summary' view.
