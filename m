Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF1C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9266A2078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598143935;
	bh=fHKSK8wdF749P2iqH1it2zMw2LMD18Kh7O1CA/kPKLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8SKHr3TxxucX4AE2cKB831H7FXkcZctMXkBFgBSoAFKWzNDkP2zow2RBGnaMwTgj
	 l74h50VvytEcjGbcW0NOTcpltVdrzj44IQ3l5DBqaeZK+XB/Us7iN/7LGA7ROzuVEr
	 7IWEop3vFAPJb6aN5SiRtijNEgEkz6qvy5THLrx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgHWAwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 20:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgHWAwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 20:52:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402412072D;
        Sun, 23 Aug 2020 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598143933;
        bh=fHKSK8wdF749P2iqH1it2zMw2LMD18Kh7O1CA/kPKLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GX0WngMrj73Isxo8BzajuGY1NeGUDH9y8qqQwbwcTPgDOviruOgCM4LWLXCkdIwMz
         ygUj0VsFy8mmtC07WgEXEMyXpETytdYKFwRKh/3t7Y+steYARJH2Lvnt16af9IA+ES
         Z/IpqGR5TLfnpCiI3zzSZImi0PegfYLDSAIzF1mU=
Date:   Sun, 23 Aug 2020 08:52:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh@kernel.org,
        marek.behun@nic.cz, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v33 5/6] ARM: dts: imx6dl-yapp4: Add reg property to the
 lp5562 channel node
Message-ID: <20200823005206.GD30094@dragon>
References: <20200812195020.13568-1-dmurphy@ti.com>
 <20200812195020.13568-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812195020.13568-6-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:50:19PM -0500, Dan Murphy wrote:
> Add the reg property to each channel node.  This update is
> to accommodate the multicolor framework.  In addition to the
> accommodation this allows the LEDs to be placed on any channel
> and allow designs to skip channels as opposed to requiring
> sequential order.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: NXP Linux Team <linux-imx@nxp.com>

Applied, thanks.
