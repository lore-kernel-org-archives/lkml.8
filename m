Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBC4C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A07D21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550269;
	bh=ya1mdjuRhJyPXeD1+2MEVl2H+HZDN2Y1c+0JC5g+Tas=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Ruo/E7wvqEkMoe5sz8Z8wK9CaIY2/8mrhJpaL+sReEs7ssB6IFgDLCue82s9Ybc00
	 xKfw51n8LuEEK+pypuR+RSxGh+otAtpcvxYGzpaZRUsPa6sTnDg1Yu6qxJC77F/PjK
	 HRgVKk+AK55ogU4Zup7qYEwoRBde+8MUI68J96YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgBLXbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:31:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:31:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F372168B;
        Wed, 12 Feb 2020 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550268;
        bh=ya1mdjuRhJyPXeD1+2MEVl2H+HZDN2Y1c+0JC5g+Tas=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aD/VftW1lahVxUo7dvU6291ECKrxjHvvlfqu39uxhdKxXosIwdnAcPKId4/SaPaYP
         Fp5MQ/p8RAxK4/INvOndwiXnJQ+1rcv0Vx9wIY0wq5t+HWtweguNB/e3CJjhRGknyE
         z5YidvvkvDvQPapiSVC5sC7r3yfUZjW6tvLUuam8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579522208-19523-7-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com> <1579522208-19523-7-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 6/8] clk: at91: move sam9x60's PLL register offsets to PMC header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        ludovic.desroches@microchip.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:31:07 -0800
Message-ID: <158155026725.184098.12068858622733995250@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-20 04:10:06)
> Move SAM9X60's PLL register offsets to PMC header so that the
> definitions would also be available from arch/arm/mach-at91/pm_suspend.S.
> This is necessary to disable/enable PLLA for SAM9X60 on suspend/resume.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
