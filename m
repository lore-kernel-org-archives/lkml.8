Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F665C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2246020674
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580430731;
	bh=lYwPMXe3BcjHwP+vuoaJdFcWvSiw+gBazE1ST16A8js=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=C/jt2RNg4OQHltLLIzz1cEC/24e+twv1LW9zAGSznOlc1iDw5ePs1qe2GlVEmDFlq
	 +eHDRYfbti4BIF8pT+uO3KjHishk4Ur/HnWsFqJFPbkmzBaY3e+An4uo/QZRRAQuVO
	 2CmNVzWsk3WxhKauRIp9HuDBNVA0g7WC/8zShpRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgAaAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgAaAcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:32:09 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C3920674;
        Fri, 31 Jan 2020 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580430728;
        bh=lYwPMXe3BcjHwP+vuoaJdFcWvSiw+gBazE1ST16A8js=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=JIkegiuENvzNMhP0bgIcPcqyYhI6KVbNkmW+PlL2YO9PueYilsiMu+nhTg7ph56+4
         ixotbYpHoSwjwMLnRzkmJuUDTneDWwgVoQXI4vRjofKnpDBrKDaUf4Z4T0XjFiFekn
         bZBkcZgAGk8H/3zZGJ8RBhqe0C6aOX2wOg28gW8M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191213083402.35678-2-wen.he_1@nxp.com>
References: <20191213083402.35678-1-wen.he_1@nxp.com> <20191213083402.35678-2-wen.he_1@nxp.com>
Subject: Re: [v12 2/2] clk: ls1028a: Add clock driver for Display output interface
To:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 16:32:07 -0800
Message-Id: <20200131003208.95C3920674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-12-13 00:34:02)
> Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY),
> as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
> integer division and range of the display output pixel clock's 27-594MHz.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Applied to clk-next

