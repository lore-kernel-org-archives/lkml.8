Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B48DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0949A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321527;
	bh=bJ2uW6D6yhLSgCBhz8qOnHNLFH8PMXA0mGPxUD6Ro8k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=TVdae4Ek1LKJ7yBTPCM/big67rIXdUCtZTmZbNT4k46+Ir1F7FwNLfveOExkpflBV
	 TnV8LATmQpFT59v7a5W+MgB5ZAKy6BGAnv7KpuK2hhvBx7+bvgC4EOof7UaN4w62Nl
	 FWWPbhe5yoaRiOdNp7b9/A0JTk3UxQOv3JpRhu4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGUIwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUIwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A33020717;
        Tue, 21 Jul 2020 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321525;
        bh=bJ2uW6D6yhLSgCBhz8qOnHNLFH8PMXA0mGPxUD6Ro8k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UJiJMQ5qpVOBYBPf+uW8Nt8yAByaphliOCOJqA199uEKd8nlZFNJb+yS16DKJd7xS
         YEvpevnJ8BcM2hzgprFMJFODbZVtG2ycsc2HtSqRgy5URM/5dD+AOoABagal29+PY3
         /fM91wZ5kkFCD3G1uAupMV63ULycVbusWbqqDh0g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c57e7ebabfa970014f073b92fe95b47d3e5a70b1.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com> <c57e7ebabfa970014f073b92fe95b47d3e5a70b1.1593788312.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 1/6] clk: actions: Fix h_clk for Actions S500 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 01:52:04 -0700
Message-ID: <159532152438.3847286.9241157708889575975@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-07-03 10:05:07)
> The h_clk clock in the Actions Semi S500 SoC clock driver has an
> invalid parent. Replace with the correct one.
>=20
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
