Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C30820838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLTXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:23:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39072 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgHLTXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:23:53 -0400
Received: from dynamic-194-228-11-227.ipv4.broadband.iol.cz ([194.228.11.227] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1k5wLk-0000aL-3f; Wed, 12 Aug 2020 21:23:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clk: rockchip: Fix initialization of mux_pll_src_4plls_p
Date:   Wed, 12 Aug 2020 21:23:31 +0200
Message-ID: <1687296.fXXW8n0h3p@phil>
In-Reply-To: <159721875227.33733.9237826555988566719@swboyd.mtv.corp.google.com>
References: <20200810044020.2063350-1-natechancellor@gmail.com> <159721875227.33733.9237826555988566719@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. August 2020, 09:52:32 CEST schrieb Stephen Boyd:
> Quoting Nathan Chancellor (2020-08-09 21:40:20)
> > A new warning in Clang points out that the initialization of
> > mux_pll_src_4plls_p appears incorrect:
> > 
> > ../drivers/clk/rockchip/clk-rk3228.c:140:58: warning: suspicious
> > concatenation of string literals in an array initialization; did you
> > mean to separate the elements with a comma? [-Wstring-concatenation]
> > PNAME(mux_pll_src_4plls_p)      = { "cpll", "gpll", "hdmiphy" "usb480m" };
> >                                                               ^
> >                                                              ,
> > ../drivers/clk/rockchip/clk-rk3228.c:140:48: note: place parentheses
> > around the string literal to silence warning
> > PNAME(mux_pll_src_4plls_p)      = { "cpll", "gpll", "hdmiphy" "usb480m" };
> >                                                     ^
> > 1 warning generated.
> > 
> > Given the name of the variable and the same variable name in rv1108, it
> > seems that this should have been four distinct elements. Fix it up by
> > adding the comma as suggested.
> > 
> > Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1123
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Looks good to me. I can pick it up for clk-fixes if Heiko agrees.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Stephen you can pick this up as suggested


Thanks
Heiko



