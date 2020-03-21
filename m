Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B9C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2252320732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753891;
	bh=UmHKXTMUzMpNRl9QVJY/I1GCYTb5dCitp7Hy9LqKIT8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=l5ON0Z1ZZalkfTG103gqYlgGreiqb/pKUFwtsYIg+U7WcZn3QcaOTd8hQhmihTvmS
	 Lj07VI6fjLaKszsU8haLD65+XaXBVwjKBVPDA9GBBTuqIB7eGj+UGGYVWTecTNugz5
	 /3Q9nEV/5bk3DkbB/Y9NA0RgTJD5w+2asVF+zZLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCUBYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:24:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9707420752;
        Sat, 21 Mar 2020 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753887;
        bh=UmHKXTMUzMpNRl9QVJY/I1GCYTb5dCitp7Hy9LqKIT8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bTS6UTSiz87KuzlFx2Nbu/rLy91hYrGU4zj4+suGlh8Y+bvM5wK2uPif2+qCrTnqv
         QtKXDKsIx5ydoPIsWRCf82AQpZFcEZTXaWW2oOU7wiFdafM5GkGAP8lt5FB9niqYbn
         BOzCSkORMx7V7ttuuOW7O0Uu/Bt7/ZY8NTG3qtyg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-6-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-6-lkundrak@v3.sk>
Subject: Re: [PATCH v2 05/17] clk: mmp2: Stop pretending PLL outputs are constant
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:24:46 -0700
Message-ID: <158475388687.125146.14592941783278965687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:42)
> The hardcoded values for PLL1 and PLL2 are wrong. PLL1 is slightly
> off -- it defaults to 797.33 MHz, not 800 MHz. PLL2 is disabled by defaul=
t,
> but also configurable.
>=20
> Tested on a MMP2-based OLPC XO-1.75 laptop, with PLL1=3D797.33 and various
> values of PLL2 set via set-pll2-520mhz, set-pll2-910mhz and
> set-pll2-988mhz Open Firmware words.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
