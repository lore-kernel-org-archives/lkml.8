Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D01C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71093207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594484895;
	bh=0BMLFhcBsY3+UePEHe/YYHatzZGvCd3WYrfLrpclr0U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=FizLVRv1Yj8XVh6HL8ybJqIFkaKk1kruDGHEsfqrRskNNv2yBxy47r4K1I54RL+Lt
	 768uz+J8ViuJDsIyAk8707YWO7L5/LybydfS3/PhP6t7zTmQuynjYkvY7sUDbWjwI2
	 Dl0A1oJhH4irLmIAGRCi/Xt4qaBhSzlrV3eUDai4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgGKQ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGKQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:28:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5876D207D4;
        Sat, 11 Jul 2020 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594484893;
        bh=0BMLFhcBsY3+UePEHe/YYHatzZGvCd3WYrfLrpclr0U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=exg2a4/a6171Ly8UcmnRQ8kBqGgrFUWdnWxhXwU00VI3eBF3r0+3OW55lr/7VFFdp
         j59vSELLu97OOwjaoJVFeKnlP7juKziAH9INJnESVGl1qmpf7N2nzmlrvKo/eKs1T2
         UHONcAVXr4FI9kMSisew60CFQCSb/s9koK2kNsS0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630043214.1080961-1-davidgow@google.com>
References: <20200630043214.1080961-1-davidgow@google.com>
Subject: Re: [PATCH] clk: Specify IOMEM dependency for HSDK pll driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
To:     David Gow <davidgow@google.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Sat, 11 Jul 2020 09:28:12 -0700
Message-ID: <159448489265.1987609.11760867517036236041@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Gow (2020-06-29 21:32:14)
> The HSDK pll driver uses the devm_ioremap_resource function, but does
> not specify a dependency on IOMEM in Kconfig. This causes a build
> failure on architectures without IOMEM, for example, UML (notably with
> make allyesconfig).
>=20
> Fix this by making CONFIG_CLK_HSDK depend on CONFIG_IOMEM.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Applied to clk-fixes
