Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F2C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553B520848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550104;
	bh=pFVvkBPFiB2L+zzgRSjRW4+fBLizs5kbzxTGDGDowCI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ttM+Hu4sSglpyb4vWsEEEEKKcPEgpewafz35hrhtC6XaEZQalE285KZanQo/KHtyk
	 Ob90Jpy8SkmFVYNvrpbux9szExCAObPnXYc91f46J2ZPDgGGPO7+YgL/Bd1i2CRlNH
	 w9eoYXCt45/ozMS1oIQhWcA+0J3SjYQk/ngcz6kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgBLX2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:23 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0B020848;
        Wed, 12 Feb 2020 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550102;
        bh=pFVvkBPFiB2L+zzgRSjRW4+fBLizs5kbzxTGDGDowCI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pFFZobnvkVOS9QK5BR4uSQPRLIiLrPko7W/u87rDnol7VkGBdALiKVEWVajOqJFOW
         F120zdDVmNY6NSBuM93rp3tHgl79tKBHj0mLO9eTlwDAJbHsVvNK+4ThxdhsigCi/D
         yMr8rVUqwBMBuSahwgbmHMAHj5L0ZTdsZDllD7ws=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205232802.29184-5-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-5-sboyd@kernel.org>
Subject: Re: [PATCH v2 4/4] clk: Bail out when calculating phase fails during clk registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 12 Feb 2020 15:28:21 -0800
Message-ID: <158155010143.184098.4697564193955101731@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-05 15:28:02)
> Bail out of clk registration if we fail to get the phase for a clk that
> has a clk_ops::get_phase() callback. Print a warning too so that driver
> authors can easily figure out that some clk is unable to read back phase
> information at boot.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
