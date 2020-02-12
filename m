Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA89C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581527207;
	bh=FYBPlAd3EouP9ZdmmskzJkG4uknbYLeQuSe4D37NHaQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=NRM/TFFXdkAiDvmFoB4NGDwBwT8ahke4/ievBdjKMj2xGEK/921nxeF4HUeKQGao0
	 8mPSMpEK9IdKplKOCANBwOP+1MJTOR1n5H+p+lkTvYQ3Qti1906igOKwpn96H8d7VB
	 WgAgDWL9sRogffOOYnqKEVZH7qDqAUZBWalXJK7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgBLRGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:06:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2580020658;
        Wed, 12 Feb 2020 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527206;
        bh=FYBPlAd3EouP9ZdmmskzJkG4uknbYLeQuSe4D37NHaQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A6Ac0YCrh0w6zIqnaLDwIZAMgMnfCapNTajxkx5d9aJkXXDG6YeYxVxbrfWI2QJYx
         b0xE04D+fxj/ZsuFFIkdCsA+ppBoa4T9StGSsrDQRohGOaTmMnOhTMJrqpRX64Vdg+
         kEpsgmkxr97di0HrmEP3P1QxEaAkaITJAJxDfwrY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101058.11785-1-geert+renesas@glider.be>
References: <20200212101058.11785-1-geert+renesas@glider.be>
Subject: Re: [PATCH] csky: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>
Date:   Wed, 12 Feb 2020 09:06:45 -0800
Message-ID: <158152720542.121156.1480167815216882187@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:10:58)
> The C-Sky platform code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
