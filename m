Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF83C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF292073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588125690;
	bh=f/1DqKlL9kcH1bIup6JMOAlUdBjFxO2nIQviNagNhPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c62eQ9SA4TpC9jxkSUgGLq/5NL0O2Vgl2zHtQjhlB+JVLzWLa4MKXR1t+DofQpPqN
	 pR4oPHz5yn6krvXb/flhtzzj1oGr5rqHg3a/z+FMWh05KpjwPYah9TAjlM1xoXOOIt
	 v3iBR1nM3+15INXFLUxFPtABZcLJh6ZTspK3zwc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD2CBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2CBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:01:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6642520731;
        Wed, 29 Apr 2020 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588125689;
        bh=f/1DqKlL9kcH1bIup6JMOAlUdBjFxO2nIQviNagNhPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blXgUPFpyDOshjuyyqaPphLfhPHQGWDufL+u0Zws3Y0AX2LY18DEiApJWDICZ4+O+
         cj+Z74GQY2Q8RVKf9LZldyvOMFG7r/P3WyxcQbMgst3Lc12QzHn4567715VZzyZVRb
         garWNUwcTEnVqmWjk2kwkjqGBcKGtuIG12nPGGnY=
Date:   Wed, 29 Apr 2020 10:01:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/13] clk: imx: Add helpers for passing the device as
 argument
Message-ID: <20200429020121.GF32592@dragon>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-8-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586937773-5836-8-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:02:47AM +0300, Abel Vesa wrote:
> All the imx clocks that need to be registered by the audiomix need to
> pass on the device so that the runtime PM support could work properly.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
