Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4839C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29A920720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321553;
	bh=0BmSIHJeo2wcTRiuEf/6+C3xly89h+A1vf4whOdCRB0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ssyKQFGlHBFpkZhZ7BRoWl5fqySC568ICJEBa4XIS6JOhxz70bPzMnhyC2HOvrrNa
	 zr5HLHLVycxt0+ySnbi6wZMQFYhT/7pAKG+8aE7G5f4HLp1eXmSzGDVApRyngnxoxo
	 gdipA9DVb/kGZLCs9X1IHhUUdXXdvnBiHnayv4Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGUIwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgGUIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BBB20717;
        Tue, 21 Jul 2020 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321551;
        bh=0BmSIHJeo2wcTRiuEf/6+C3xly89h+A1vf4whOdCRB0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AkRp3nOByQTzcnnomfqy0CytNP7Hz5PoOkUc+LPtjXOECcZLBbjzKKWDpS51XfMu1
         xIWP9OcSIRqUdKBewtsq3eTkJzTmMitCkWC2brXHv4xXrVIpl7B5s6mK3H61zqsrOI
         5zeRzGIUWOub3QOov2KVyJUQojN/A3cv687rYzrg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com> <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: reset: Add binding constants for Actions S500 RMU
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
Date:   Tue, 21 Jul 2020 01:52:30 -0700
Message-ID: <159532155027.3847286.9653491370230964734@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-07-03 10:05:10)
> Add device tree binding constants for Actions Semi S500 SoC Reset
> Management Unit (RMU).
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next
