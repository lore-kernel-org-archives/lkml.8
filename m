Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DDA2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590549268;
	bh=PynX9X8Dg61OyKJvDmLbdZVz48aDooArvp0ns3vPzSg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vz7Stlu2CBxC4bkRb/djSnySekVcjzy0oMuq9r+kN6KdLkk57pDQzpW9azSyNstSC
	 gayE7dikbDLBqPcdBnkyuN4IJUC75mNMlpl/4OrFenddfOuYBiBP4GVb7L4GQg7c6D
	 JT1NpigbkwDxfbsiEnRGN591+7zPuBX5l99r0ZlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgE0DO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:14:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A04207D8;
        Wed, 27 May 2020 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590549265;
        bh=PynX9X8Dg61OyKJvDmLbdZVz48aDooArvp0ns3vPzSg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hOBIAoy3bIBJHczZ/clkOzo2CfkLsCq4Y1psFWsx51T6Snwa0wL7/2e2Ugg4gRTyS
         ynH8uUUUDajxsCvbwj/I2pENof4sl3sKeKfTGiLJlf8aOUYcaM93pP1ir9/RfXq0OK
         t73eFYRHUErsXXfabQqpbOHuJto43yZ73cFKAcKI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519030036.1785-2-zhang.lyra@gmail.com>
References: <20200519030036.1785-1-zhang.lyra@gmail.com> <20200519030036.1785-2-zhang.lyra@gmail.com>
Subject: Re: [PATCH 2/2] clk: sprd: return correct type of value for _sprd_pll_recalc_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 26 May 2020 20:14:25 -0700
Message-ID: <159054926519.88029.994346075664159353@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-05-18 20:00:36)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> The function _sprd_pll_recalc_rate() defines return value to unsigned
> long, but it would return a negative value when malloc fail, changing
> to return its parent_rate makes more sense, since if the callback
> .recalc_rate() is not set, the framework returns the parent_rate as
> well.
>=20
> Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-next
