Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DBCC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BFA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550092;
	bh=FEw2j+GneIi0Dx9y3pEI1kM+IAZiApbb79VmFYGVCyM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Pe8vcYy3JMNYmqo13fbOA1gOsoGYL1wGTwLnv0HmaeYCbVbgi3nrqovsesEBNss1N
	 r/PNyFJxCdGPzUIJKvBG8WaKmQZFn7ulL/5KdcnNo+XX48J2eGmXipTtbc0hZBZ6Td
	 W2I+uGm0xVxtTwV7fRlaM4O6pvtd66A81tqKlcxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgBLX2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:11 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB12120848;
        Wed, 12 Feb 2020 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550090;
        bh=FEw2j+GneIi0Dx9y3pEI1kM+IAZiApbb79VmFYGVCyM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HQf5rNnVLsmssPLvmhsFGDeJzu7rVdp94seMyeWuLGw4biP21W+tT9a2vLygaZd5Q
         1ISZVhwPTwyuq1KGKe5wG8ZoCr2G3LR1hYIMWmyNZT9zbn5hX+RLb7Rt1uF+4MNK4M
         51Fw38jWUvEV+FOQE5qdxsX1IT73XePz882MYC6Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205232802.29184-2-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-2-sboyd@kernel.org>
Subject: Re: [PATCH v2 1/4] clk: Don't cache errors from clk_ops::get_phase()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 12 Feb 2020 15:28:10 -0800
Message-ID: <158155009011.184098.12535582658927603127@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-05 15:27:59)
> We don't check for errors from clk_ops::get_phase() before storing away
> the result into the clk_core::phase member. This can lead to some fairly
> confusing debugfs information if these ops do return an error. Let's
> skip the store when this op fails to fix this. While we're here, move
> the locking outside of clk_core_get_phase() to simplify callers from
> the debugfs side.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
