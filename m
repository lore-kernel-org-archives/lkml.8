Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15162C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E539D2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598099847;
	bh=9Fnqhama6vxAqm1wL0zVoWvBuGzZSwP8pnL4DRK0KRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DLphIhAoAqaWi3E/aVVQP3ZdaLtALDhCVQYY+yrhgcGCDj6o8GFL/fqkXqqW/y13S
	 nQ075LZe7D+gu3NOA3VJpHynhsbRmV95uXYEOZL3XT0ViibwBoHtId9C5ys68H3jZd
	 voH/qxOUHEc8bjJyKhWcjEB7P4ELi5K7ZopsTrLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHVMhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgHVMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:37:24 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A916B207DF;
        Sat, 22 Aug 2020 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598099843;
        bh=9Fnqhama6vxAqm1wL0zVoWvBuGzZSwP8pnL4DRK0KRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3jKbPaV/COHhKcz9MX5zwsxV0U2uJ+ehVK9gNq6/ZCx20oqTb9ZZpv5vprtfaJxF
         Wbj7FbGVGOF3/9vXQhBRmUIJsjdw6CBvucaepbTX9lz3xTtq27KSBI59JyFst/egW3
         +zxX4m5efxWbE4UyMckOqDErYvUOZWBJ8orhV358=
Date:   Sat, 22 Aug 2020 20:37:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, peng.fan@nxp.com,
        abel.vesa@nxp.com, j.remmet@phytec.de,
        laurent.pinchart@ideasonboard.com, yuehaibing@huawei.com,
        andrew.smirnov@gmail.com, horia.geanta@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: Explicitly include bits.h
Message-ID: <20200822123716.GJ27575@dragon>
References: <1596583049-7305-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596583049-7305-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 07:17:29AM +0800, Anson Huang wrote:
> It is better to explicitly include the required header file rather
> then get it through some recursive include.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
