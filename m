Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169D22065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589486200;
	bh=GxE8ANtTfub60hMSFbauTD0SDXUv1h7GY8/7gYwkj1s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Z41gSm/OpEKWmOZEPTa6Vu/GAOX1cQqGiLTxczMU2IV1N7wGFAYGQKrOZRz9hdm1t
	 eilaEdeQgFocNGh/cIU/gxLzSSPckWylHub9NdftyJELshnMS/UEZfTzijO3wpLIKE
	 YLOeMfw3PUNSd2EPzHTpCYAQeNC0exFZ5/tPfvWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgENT4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:56:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F962065D;
        Thu, 14 May 2020 19:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486198;
        bh=GxE8ANtTfub60hMSFbauTD0SDXUv1h7GY8/7gYwkj1s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lgNmKs8ZeUDv5XB7NX0ds36hRGZoVZieEig0mf4RgEgTJWjlQ6+m143PLJBuYH7wx
         F05bfIZU6PCyTM5ZT28JE3VFQo8RYr73pSsG2RpJMSiGr2Tv3MSh4FqAMH5Rio/+J1
         4uTcZX2ZW9B+JDol6KOeKnqZDX9cUmkFUCGu2Oss=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-3-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-3-sboyd@kernel.org>
Subject: Re: [PATCH v2 02/10] ARM: Remove redundant CLKDEV_LOOKUP selects
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:56:37 -0700
Message-ID: <158948619792.215346.16103604948090575932@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:08)
> These platforms select COMMON_CLK indirectly through use of the
> ARCH_MULTIPLATFORM config option that they depend on implicitly via some
> V7/V6/V5 multi platform config option. The COMMON_CLK config option
> already selects CLKDEV_LOOKUP so it's redundant to have this selected
> again.
>=20
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
