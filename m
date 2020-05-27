Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C5E2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541286;
	bh=7HwgQxVbxeDNjkFpYDIO+vMeXrVkj8rNi6w8tqtSoxg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DZ2cKlDQFTRaX1LJZdSowvkJpDxJAoHvFk4X/oVYLA6DquwdUNVilltGoK55b47W2
	 iDp5jCV+bqTQ/tfRXYWBv+L8JrluW3AUBO1fRzjZX13R0fMGcsu3j4cP+dy05sTGSm
	 UffGYe3P1S1v7yaEgC2wzNrg/bHNmkdlg0yho3nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgE0BBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgE0BBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:01:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429A12089D;
        Wed, 27 May 2020 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541284;
        bh=7HwgQxVbxeDNjkFpYDIO+vMeXrVkj8rNi6w8tqtSoxg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r9ZaXpZyVctNKBY9sKwr9ta+onwSWey67y1GzMg0lXOxZCHbRs1a0xX9pmzTsVUiU
         sdn1ksPevmgdSmxMfIgno0i43GPN8Hle2Mrd9nDboaW81GOXNnjW8+c8Q2+Q/zycLA
         ZFSal+keSpHvrzRAL6GVPPu02w7uLnradcIh0Aw4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583185843-20707-3-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com> <1583185843-20707-3-git-send-email-jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 2/4] drivers: clk: zynqmp: Fix divider2 calculation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Tue, 26 May 2020 18:01:23 -0700
Message-ID: <159054128348.88029.11223617733496629973@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-03-02 13:50:41)
> From: Tejas Patel <tejas.patel@xilinx.com>
>=20
> zynqmp_get_divider2_val() calculates, divider value of type DIV2 clock,
> considering best possible combination of DIV1 and DIV2.
>=20
> To find best possible values of DIV1 and DIV2, DIV1's parent rate
> should be consider and not DIV2's parent rate since it would rate of
> div1 clock. Consider a below topology,
>=20
>         out_clk->div2_clk->div1_clk->fixed_parent
>=20
> where out_clk =3D (fixed_parent/div1_clk) / div2_clk, so parent clock
> of div1_clk (i.e. out_clk) should be divided by div1_clk and div2_clk.
>=20
> Existing code divides parent rate of div2_clk's clock instead of
> div1_clk's parent rate, which is wrong.
>=20
> Fix the same by considering div1's parent clock rate.
>=20
> Fixes: 4ebd92d2e228 ("clk: zynqmp: Fix divider calculation")
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---

Applied to clk-next
