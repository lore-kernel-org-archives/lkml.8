Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773EC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7268206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584322749;
	bh=UQapXd6fOtM5aDx3KdLu8z/+f4elL63L3+KVbVHC6e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0Sqvty7S+KJLTy8FBfIoSVAbHvslmrw8pq3/BwyZfLObXQ91O9Re3D/82g+rAbB5
	 rNFlMDPCBXSuwUW04a4gWCaMBl+aSwulNTMOjGyEglZy4QQvxmPdCy9upzsWGBS5gg
	 ZekfRgnmmgbR29V9jPf2G4WoUQgPwA20FzgMxxq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgCPBjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgCPBjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:39:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F2D20674;
        Mon, 16 Mar 2020 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584322748;
        bh=UQapXd6fOtM5aDx3KdLu8z/+f4elL63L3+KVbVHC6e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkXlfBOR4O1XMj61sDC9UnxKLuJfK/5j9VbE+c3SzoEZHgzwEx4YiRT/Q5nqGyNhm
         0WeiUtQPcOjK8qpSluQdVDpAijpgRvc4yTH2FlcQ8DG2gQVBk2Do5DPSA10kVcdAdl
         Ou+Vkc8mmGSpWtGxhui2xsPcND60KZFb0SKlruCI=
Date:   Mon, 16 Mar 2020 09:39:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: imx: clk-gate2: Pass the device to the register
 function
Message-ID: <20200316013859.GS17221@dragon>
References: <1584115819-17778-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584115819-17778-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 06:10:19PM +0200, Abel Vesa wrote:
> The device needs to be passed on to the clk_hw_register.
> 
> Fixes: 1f9aec9662566189 ("clk: imx: clk-gate2: Switch to clk_hw based API")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
