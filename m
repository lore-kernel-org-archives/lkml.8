Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E8EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3D72311C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592623383;
	bh=2HnlBkRLF7ByW7jdhl2LVoO9lFMmnDi8HAinor2wg74=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=bSQpSm1/mWLTlOIQqFTUsyq75V/vUtxCHn711926A6kE/yaHtIWV9kAxDF86HWdJ4
	 gC21NNKWqdfIcW8/LX6Y6xIop6yMWg0sW9IHvAj3fYbFMR8ioO8JSMQfWjXyI8ryJJ
	 uKUcPHEfjV9zf82+2Fo2o1lTIpdwA0F3cxRjQmM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgFTDW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbgFTDW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:22:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E144B2311B;
        Sat, 20 Jun 2020 03:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592623379;
        bh=2HnlBkRLF7ByW7jdhl2LVoO9lFMmnDi8HAinor2wg74=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PbbATne29lk3/Dq9iGYrKoi848LMjPV5Lcp7tCVOoTSK8XPuhyi+wMwbj5zp9zfWh
         AVbtrt23/zJrBm5NE442FMvclWJDeaGpXlrlaKdBB93Z+lIPhwYnnYl3/YDBmVurE2
         yCgbgfZAd/r6KIFS4tgf63GCrLWmHFvxe7dhmJvg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2 1/9] clk: composite: Export clk_hw_register_composite()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, allison@lohutok.net, arnd@arndb.de,
        daniel.baluta@nxp.com, festevam@gmail.com, fugang.duan@nxp.com,
        gregkh@linuxfoundation.org, info@metux.net, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com,
        oleksandr.suvorov@toradex.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, sfr@canb.auug.org.au, shawnguo@kernel.org,
        stefan.agner@toradex.com, tglx@linutronix.de, yuehaibing@huawei.com
Date:   Fri, 19 Jun 2020 20:22:58 -0700
Message-ID: <159262337815.62212.6627329090856383673@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-06-09 00:32:05)
> Export clk_hw_register_composite() to support user built as module.
>=20
> ERROR: modpost: "clk_hw_register_composite" [drivers/clk/imx/mxc-clk.ko] =
undefined!

Get rid of these messages below. We don't care that make modules failed.

> scripts/Makefile.modpost:111: recipe for target 'Module.symvers' failed
> make[1]: *** [Module.symvers] Error 1
> make[1]: *** Deleting file 'Module.symvers'
> Makefile:1384: recipe for target 'modules' failed
> make: *** [modules] Error 2
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Otherwise

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
