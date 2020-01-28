Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21046C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0902465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580245573;
	bh=e1/XxJeK0Rii27xiuHRXszUSO+kWCgAZKPcYe8Ep09Q=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=bqIzJhTIU3AOa0rDrZn9jd7vGwDlScch1TzTh8dX8qs7FuDRMIQwHzNKKBQjE/egb
	 hwcZKFLKfr8DWlFUDopXQVP65b8GQeXUueKpykocTdrdLhutypgMpkUe49i26PmQOR
	 fQLHvgYU+DYnQ4ZxM4IBIC/fauPW+5es41krVoCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA1VGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1VGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:06:11 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414012087F;
        Tue, 28 Jan 2020 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580245571;
        bh=e1/XxJeK0Rii27xiuHRXszUSO+kWCgAZKPcYe8Ep09Q=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=0pdZAc9dYvmMJ6/vvSSGVT0f9Z7j6zSlJc7YD4Yxk/sWiDcjvB0DCJiLf2SGhMp5Z
         ui0H/fAM2hwGsn3lgCa8jCPMRQO3zW9NxU6wBcXI0/Qy/f/t5eR6FeYrIHPAD3oRv8
         KtIjD2wPEEDcE66WOUMtkNk508KP8X697PjoinG8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200107075340.14528-1-mike.looijmans@topic.nl>
References: <20191205115734.6987-1-mike.looijmans@topic.nl> <20200107054837.DB91F2075A@mail.kernel.org> <20200107075340.14528-1-mike.looijmans@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk, clk-si5341: Support multiple input ports
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 13:06:10 -0800
Message-Id: <20200128210611.414012087F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2020-01-06 23:53:40)
> The Si5341 and Si5340 have multiple input clock options. So far, the driv=
er
> only supported the XTAL input, this adds support for the three external
> clock inputs as well.
>=20
> If the clock chip isn't programmed at boot, the driver will default to the
> XTAL input as before. If there is no "xtal" clock input available, it will
> pick the first connected input (e.g. "in0") as the input clock for the PL=
L.
> One can use clock-assigned-parents to select a particular clock as input.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next

