Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8726A21734
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580404781;
	bh=rFDsL3BUlrwi3Q5w/xvsiy0TB0QkGjD2JLhEr2G/vY8=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=QqXgCVljMajLQb1BpLMEr9o12keW6r+6iPe0r3lkc3eH/sLxqY3STY0hAVmrBUl5l
	 W0IORZdToe98QxhtfFeoX+8IdIaFcLOhqXZKQhSqZRKYDvV0wZ7ktEeOQVYD8J+Cnv
	 YUO4w08PEERXKWoTD/vFuig6g8Q45lr0Nuoyxxjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgA3RTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgA3RTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:19:40 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497AC206F0;
        Thu, 30 Jan 2020 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580404780;
        bh=rFDsL3BUlrwi3Q5w/xvsiy0TB0QkGjD2JLhEr2G/vY8=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=XBrYWZAnXajfFQ063HsnBiHdxazTF/AWneCxmVziiHsqcMMVt4JmKAHZugqEBYU0L
         E+EMOgLu66J0YDf7UrK8jiGHTjdsnXNv8PyndaVigmEvEDtL2qnWjXC6jFeb7dHF77
         GxCAZq9wUMmBNP60D0T+PzZ1zD8mBauS9xC+02MA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200129163821.1547295-3-heiko@sntech.de>
References: <20200129163821.1547295-1-heiko@sntech.de> <20200129163821.1547295-3-heiko@sntech.de>
Subject: Re: [PATCH v3 3/3] clk: rockchip: convert rk3036 pll type to use internal lock status
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        robin.murphy@arm.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 09:19:39 -0800
Message-Id: <20200130171940.497AC206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-01-29 08:38:21)
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>=20
> The rk3036 pll type exposes its lock status in both its pllcon registers
> as well as the General Register Files. To remove one dependency convert
> it to the "internal" lock status, similar to how rk3399 handles it.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

