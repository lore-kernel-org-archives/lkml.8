Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724302078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586570833;
	bh=msr6kOk9H+Hn1CM+VHTPOlsFMX9ExKOvN9kfyNtrqgM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vc+kUCNDU0zpwzCOXHRVhFMNlKKXV/IqQuhm9YAMhx+EqGoxJWwXFVz+acCGj/LRn
	 ad+s9sl+NR/UPmqL3JaTuAHyRI8N40gPbV/nNhwTn4hmaQ7tE/NQucUrzCdwtpO31I
	 JsKZNbpVFBZCe7ibr5/v+z6tKCNKW7T9nQLDNWko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDKCHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDKCHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:07:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253622078E;
        Sat, 11 Apr 2020 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586570828;
        bh=msr6kOk9H+Hn1CM+VHTPOlsFMX9ExKOvN9kfyNtrqgM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mllIgSXlIBMe2pjK9rRZNfdqOxIT9GgvZGUB/L8QwYXW7ssWEq34H6Sz94l0mlIt9
         36zDkyFspAeXTr3mPMnkD8SH1dqZXmChazTLhUY10eo13pPZgQEChrC3Sbm0GFRYE4
         YHa+jRAkdN2Y53rrwfyoBybPa7S+yIiVbLEkGFuQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408160518.2798571-1-arnd@arndb.de>
References: <20200408160518.2798571-1-arnd@arndb.de>
Subject: Re: [PATCH] clk: mmp2: fix link error without mmp2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@arndb.de>, Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 10 Apr 2020 19:07:07 -0700
Message-ID: <158657082740.199533.4162944132011256737@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-04-08 09:05:07)
> The newly added function is only built into the kernel if mmp2
> is enabled, causing a link error otherwise.
>=20
> arm-linux-gnueabi-ld: drivers/clk/mmp/clk.o: in function `mmp_register_pl=
l_clks':
> clk.c:(.text+0x6dc): undefined reference to `mmp_clk_register_pll'
>=20
> Move it to a different file to get it to link.
>=20
> Fixes: 5d34d0b32d6c ("clk: mmp2: Add support for PLL clock sources")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-fixes
