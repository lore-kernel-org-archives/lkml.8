Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA20C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C442221D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579820341;
	bh=zEuOC3td88tpHLgeBxK5wnCGR91LNEGrEovg5lXPIWk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OU79p+Z1ibMEsGLtZhXT19ykf2xkZa5T6U1Kw6OG3QlWCk6mMX8xjhwEKP0pZ12zy
	 VXw//JA7kEWwzhjZasXeTDpuZMw9v+h0ZHpc8gBWkLjSJw3+hRurL/IQhGE+EbaFFo
	 WKsj12pcWBh37JlUgvn1Wg7RQcRZe/XNRrwg7n+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgAWW7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgAWW7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:59:00 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B264120718;
        Thu, 23 Jan 2020 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579820339;
        bh=zEuOC3td88tpHLgeBxK5wnCGR91LNEGrEovg5lXPIWk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Dluiq1xHhJ2Gs+g+ZFcZgKpL8P/eAedGwAdaXjAzu2QplsivR52091g9VkeMirFEP
         jebgeC+xNRqUWjKg8MGbvB0rCiLhlOn1Wj6kB1bwN08czoJej8O27m818gZ31q1arc
         TlWQuxLXCTj34+k7QbYjzyIG3eUIS1CZMkAYsiRA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1575527759-26452-6-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-6-git-send-email-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 5/6] clk: zynqmp: Fix divider calculation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, gustavo@embeddedor.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        mark.rutland@arm.com, mdf@kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, nava.manne@xilinx.com, robh+dt@kernel.org,
        tejas.patel@xilinx.com
User-Agent: alot/0.8.1
Date:   Thu, 23 Jan 2020 14:58:59 -0800
Message-Id: <20200123225859.B264120718@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-12-04 22:35:58)
> zynqmp_clk_divider_round_rate() returns actual divider value
> after calculating from parent rate and desired rate, even though
> that rate is not supported by single divider of hardware. It is
> also possible that such divisor value can be achieved through 2
> different dividers. As, Linux tries to set such divisor value(out
> of range) in single divider set divider is getting failed.
>=20
> Fix the same by computing best possible combination of two
> divisors which provides more accurate clock rate.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next

