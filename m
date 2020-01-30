Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECABC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF5120707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580404769;
	bh=P16QSKE8ku4fF+SjmfmNSNgJGXbxNh+qk4h1QxfDtRg=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=z2uqzadYM0u7Zh6e6+IubQnQwtydgkrIzQxewLehn4FkoK5IEbbahpuSI0DMlLVaT
	 xSYmJixxdu2CurSJVhpHbhbaAXmzgdKzF/VCTi6bqXPhqWVqN3epncw3TbvEjI5X79
	 XiccZV87e5yPYebl6cn28a8gas6qAoff6isU8Gyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgA3RT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgA3RT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:19:28 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9ECF206F0;
        Thu, 30 Jan 2020 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580404767;
        bh=P16QSKE8ku4fF+SjmfmNSNgJGXbxNh+qk4h1QxfDtRg=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=XspM3mAH2XZiehQ/9QxiSTvZzS36uR/CHiXvMz9GgglifpeVLNqLLri/kfx3L0KuK
         pEQCgVVbzlmWi2rfB0omxlId9lF8fqnZwSj14LtiPA4wcPXo2POdX4g3LlFKdK4jJy
         PYuUAdOsHeu487wns6oqVRfnKSTACILGOnkywm/8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200129163821.1547295-1-heiko@sntech.de>
References: <20200129163821.1547295-1-heiko@sntech.de>
Subject: Re: [PATCH v3 1/3] clk: rockchip: convert rk3399 pll type to use readl_poll_timeout
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        robin.murphy@arm.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 09:19:26 -0800
Message-Id: <20200130171927.C9ECF206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-01-29 08:38:19)
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>=20
> Instead of open coding the polling of the lock status, use the
> handy readl_poll_timeout for this. As the pll locking is normally
> blazingly fast and we don't want to incur additional delays, we're
> not doing any sleeps similar to for example the imx clk-pllv4
> and define a very safe but still short timeout of 1ms.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

