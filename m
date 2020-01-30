Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EFFC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BC720CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580404775;
	bh=mQPgzbEOHhaYspRP78UUrq/Qaj0u6VZJGThPXWLnSHY=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=BAAii74icDrA0DlqgCXrVSMsODLs+KcvhXGa93VW61NXXLVB+YXW8/RHyMYK8tvdp
	 PALPFvQjqeTysciQDUVGegSPjUZHIOiD+2bZk7mEddBDzB9nbq2eEcdhkqMQHPJYdd
	 PT7y/WSW5AxrI/yQ+5Vi/zxX19F+Jarjc9UM79ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgA3RTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgA3RTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:19:34 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCB920707;
        Thu, 30 Jan 2020 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580404774;
        bh=mQPgzbEOHhaYspRP78UUrq/Qaj0u6VZJGThPXWLnSHY=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=iK8+443QAwMPpiop0hXq0ubpjolSZrcbUh7mtbQykgaG1gmKQUEzDBUC/8BSTD6mQ
         D8o4opy8HvAFdM4KvFk/LriCjnLyo1E/gn5eVINliW397E7upAPYVbW6BKmFpvc+IP
         XezUIg7rsNgIDFmvBdG/OHAveWUK8a9AGKHRhuq4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200129163821.1547295-2-heiko@sntech.de>
References: <20200129163821.1547295-1-heiko@sntech.de> <20200129163821.1547295-2-heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] clk: rockchip: convert basic pll lock_wait to use regmap_read_poll_timeout
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        robin.murphy@arm.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 09:19:33 -0800
Message-Id: <20200130171934.0CCB920707@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-01-29 08:38:20)
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>=20
> Instead of open coding the polling of the lock status, use the
> handy regmap_read_poll_timeout for this. As the pll locking is
> normally blazingly fast and we don't want to incur additional
> delays, we're not doing any sleeps similar to for example the imx
> clk-pllv4 and define a very safe but still short timeout of 1ms.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

