Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B16C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2481C206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598148539;
	bh=KqaGJkp0fDPVOfu5/y/JdgDgT+v8gnzFgIr8EKCMvPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vrdt6fUVFTH923WXAaAfz0c1Ljjh3JMyEkrmZZfL4nY0TayqxtsIRaDGvXlbiuTaS
	 nTfkrFFnZo55hzgAjwVzdZs89Ue/dFmq/4h6i9GJ3cj1BsNipistVkA6hGblScythY
	 jTjW42Iy5J0Stb+tdBR5mqzf0+JZwjRphwPwYwMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHWCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgHWCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:08:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43972206C0;
        Sun, 23 Aug 2020 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598148534;
        bh=KqaGJkp0fDPVOfu5/y/JdgDgT+v8gnzFgIr8EKCMvPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evqNtj/NIvnAhB3WYeLfDzDw9lgulJzv3+3FsTt8M/0/mH8tEfGPUANWhYnellAgv
         qzQRSQco0NT9SdgPMbjgG3rLZurBzeJMl+pJCu04RIpZ1jeb6zh8+ImPLuAIo57PTr
         qIUgt/FhNg1YCTWRNdgHV3bJNtQapXKnUa5p3CJs=
Date:   Sun, 23 Aug 2020 10:08:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: imx: vf610: Add CRC clock
Message-ID: <20200823020848.GL30094@dragon>
References: <20200817151254.11466-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817151254.11466-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:12:54PM +0200, Krzysztof Kozlowski wrote:
> Add the clock for CRC block allowing it to be enabled by consumers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
