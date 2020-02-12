Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08AC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7A4218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581540748;
	bh=IyBLJs7u+s1RqfuILL8EHYI9KQ31ezat17YVqp0mnJE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=eCSvFz8fazHvPMc/CujDvwAETICt6GdckJkIlndNn2ag8CAa2zWOuRAdiEZSJTr22
	 1VITvAFUQLw2zGA9TyhqIMayHkfA/9XDsyAjTycHYq950Z642QVWmXRI0abY3UibL/
	 Mg+4l+RvEsXjVxO3w+3HHEGQe17PcHRSyPyes/i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgBLUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLUw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:52:26 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 244FD2173E;
        Wed, 12 Feb 2020 20:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581540746;
        bh=IyBLJs7u+s1RqfuILL8EHYI9KQ31ezat17YVqp0mnJE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yHHoK4jnA1pMtbfXvN+Rd+0Dhpmtdd6EEmDrQ2FiBdkmc5ouIZJfcTMj+mwiEdSze
         pM4jRSSzpiVGRKbzKkWp6l1k7st5Tl3iypLw1zODU3c+sLmN9Bp4+/obQ9rwWft+BQ
         N5m40RGAGq1Oi6+Jc2qY+YxccQvXHY5l13MYvN5U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101544.8793-4-geert+renesas@glider.be>
References: <20200212101544.8793-1-geert+renesas@glider.be> <20200212101544.8793-4-geert+renesas@glider.be>
Subject: Re: [PATCH 3/7] MIPS: generic: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Hartley <james.hartley@sondrel.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paulburton@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Wed, 12 Feb 2020 12:52:25 -0800
Message-ID: <158154074529.184098.8557310539914705485@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:15:40)
> The generic MIPS platform code is not a clock provider, and just needs
> to call of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
