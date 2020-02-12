Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CF9C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62B12168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581527274;
	bh=gY9xg2lYmEH31YVZeN90mWoT7Zt+lBe98MFz9EzLzV0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=bxGS6QXOS5Jrrv6YVu0VR0gwSukW76LqJ3Qveb76HslI3pu7OZLgT9ZfBOB3M0duH
	 Z+xKR6PrameSrWAbrrotbqN8rbP8D2PplNbN0J3uRGO19HWgJgHy2Itmie1VznEIm9
	 p74JwR7fkbX9a4wLfnana6i7Op3tzOOr/rik3DBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgBLRHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397A020658;
        Wed, 12 Feb 2020 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527273;
        bh=gY9xg2lYmEH31YVZeN90mWoT7Zt+lBe98MFz9EzLzV0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IEc3LiciQzcim2iwz+Cf5oA2Tjn2yWCP6EUnI2HyqRcgg8JD+qQWDc4iSo42NQZ01
         vKGlnMhQJ1UVqY2MeTLiFYc0rHwhdbHDWgEuzhlsJ4CidNcFZ//goMfqwumbSxReUW
         7pBhE2k8+Y05IBvTLEy/l2XN8ndRgB+BoVdkvKts=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101651.9010-1-geert+renesas@glider.be>
References: <20200212101651.9010-1-geert+renesas@glider.be>
Subject: Re: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Date:   Wed, 12 Feb 2020 09:07:52 -0800
Message-ID: <158152727251.121156.1263717527305809701@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:16:51)
> The Andes platform code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
