Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B559820829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597349388;
	bh=9o4NwebGGbxvd/86oZSJIvwqTDkh55whrbF7MItOn4o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=t4pH+FNkznzlAwzMMFTPjVClMfllUIy+pp1Cwk2zEd3zF4InckInWXOYGcfIzVDhJ
	 ExDgOkIlTUeNJcZGVUnQOA/kMMC1BxtOOzfOGQMhgljsrOO5IjjvAAKhzj0PMqp4wK
	 6YzV5+4Oy2KoA8hD/I4dnVk5Bc7qYOdLW3RDPgUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMUJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgHMUJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:09:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD1F20675;
        Thu, 13 Aug 2020 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597349386;
        bh=9o4NwebGGbxvd/86oZSJIvwqTDkh55whrbF7MItOn4o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ol/0ePVa0tGAd9lxW9H0i6YdWritPzpkZlvmOPNfNU+LFlNlcLXVGVMjYJvE3Ej1E
         dFCFlu8ujl0DbSihAgGSDUjakJ4j9RXrLW/Vh8totrkas5/MjuG8hPMYLrMshMaqSH
         fXf0ZuhMiB3oe4iSkWg5UKod5Vo5PT05UNS9s26k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596523457-40465-2-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com> <1596523457-40465-2-git-send-email-amit.sunil.dhamne@xilinx.com>
Subject: Re: [PATCH v3 1/3] clk: zynqmp: Use firmware specific common clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        linux-clk@vger.kernel.org, m.tretter@pengutronix.de,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        mturquette@baylibre.com
Date:   Thu, 13 Aug 2020 13:09:44 -0700
Message-ID: <159734938481.33733.13244969868345160087@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Sunil Dhamne (2020-08-03 23:44:15)
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index db8d0d7..d813c34 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -271,6 +271,33 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id=
, u32 index,
>         return ret;
>  }
>=20
> +unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
> +{
> +       unsigned long ccf_flag =3D 0;
> +
> +       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE) ?

Please use an if condition instead

	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE)
		ccf_flag |=3D CLK_SET_RATE_GATE;
	if (zynqmp_flag & ...)

> +                     CLK_SET_RATE_GATE : 0;
> +       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE) ?
> +                     CLK_SET_PARENT_GATE : 0;
> +       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT) ?
> +                     CLK_SET_RATE_PARENT : 0;
> +       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED) ?
> +                     CLK_IGNORE_UNUSED : 0;
> +       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE) ?
