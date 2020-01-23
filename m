Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2CAC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178D21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579820326;
	bh=nqyAn+k//cppuY1vQFi8Y79KM+6wFbIlIZtyopOiBL0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=YNsPMrPrfG9zxQZVoSgV6TsTYM/CcuN6rzTa0XWMIDAXoyX1P2bLwPJngp+F7Qt6F
	 8ZKiE0D78f54AiSjKNLfMqXVsrjh3X/qv3OAZS0BXX9+/QPg2FULM/aPtU3f7P8rvF
	 kXf0HNX0zAyZ4b5c+QG2KPJ44xwM1uO8MUoNSSRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgAWW6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgAWW6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:58:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EF021D7D;
        Thu, 23 Jan 2020 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579820325;
        bh=nqyAn+k//cppuY1vQFi8Y79KM+6wFbIlIZtyopOiBL0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Gh6n8JsETgFNjzbgwg67lZty0nl3M912MhrZIypM7/DqPCfpMwjF2OH0jD9vB+Jua
         tmd3fr+FTt70fX7rXxRYqfahPPhfnbGrxykQBuJKPVgMeH++RStiGJqYONW6epYMUS
         qXFdXQmTi/kv2bNCXfZgew0W3ve+snA+iLo69iSM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1575527759-26452-3-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-3-git-send-email-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 2/6] clk: zynqmp: Extend driver for versal
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
Date:   Thu, 23 Jan 2020 14:58:44 -0800
Message-Id: <20200123225844.E7EF021D7D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-12-04 22:35:55)
> Add Versal compatible string to support Versal
> binding.
>=20
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next

