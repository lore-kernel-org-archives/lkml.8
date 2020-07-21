Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CFC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6981020717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321558;
	bh=AvrWomrOItpeCrbu57V6/xnDp8Pumll1n0l/9GBrPvc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=NCoUKdKoyFdvVitAHQwH6IletKwexgpiuh+LXmJFGTmckpMNigFg5OuERTi1MGOhb
	 ynwTUaLSUztrktx9BbbWLzcXTLbj7nBqdeHWHftWe0xP0/6pbQtHDuC8+KHIPc1IkI
	 7bBC9CsfWo0nElo+4vYszVj5TeDjdydmpOlG9nPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGUIwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgGUIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:36 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4806820717;
        Tue, 21 Jul 2020 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321556;
        bh=AvrWomrOItpeCrbu57V6/xnDp8Pumll1n0l/9GBrPvc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wmCZUkUPpuhQleeO8yl9p5grFdCSoJsgVYWVJfv2SyixDcU0GVzBNiSmVaIcRwWAe
         ZaypqruaBfIrVPHQG0ONqltjzkoT+Sv7lykV8+kGnKNJg8uGem/x+pQEjQDvGB4709
         rRldL2AU45t8hJt+2/vFSTK18LzQj7Mmg7/cHceU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3fba2e6f0edfac97cb8c6ce60f95c24852578eac.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com> <3fba2e6f0edfac97cb8c6ce60f95c24852578eac.1593788312.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 5/6] clk: actions: Add Actions S500 SoC Reset Management Unit support
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
Date:   Tue, 21 Jul 2020 01:52:35 -0700
Message-ID: <159532155563.3847286.2008458191107142489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-07-03 10:05:11)
> Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
