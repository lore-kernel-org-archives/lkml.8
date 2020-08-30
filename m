Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4FB2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598771507;
	bh=UJJDNUb8eAJ3ZYUQoL89IWQv+JeN3MUlFYCUlMTPEeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y4SanuU59o9z6NDhHwPFOkeOdH0+ioiWd6oHmep5HKpnzW2+Oo/5ed05Qrmdtecd8
	 5zpZPEWwGZo7Fdsl5R+hKWr5vdgMayDm02UX72Q7d3mFHV7nWKrCFOp06Owh671zdf
	 LQLAuheKac2BCSp2uZYS+hLKb6T7YFK62KMXwfPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgH3HLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgH3HLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:11:43 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7B82071B;
        Sun, 30 Aug 2020 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598771502;
        bh=UJJDNUb8eAJ3ZYUQoL89IWQv+JeN3MUlFYCUlMTPEeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFPv4qwZhXERswXEKLmjSEANYeDuKp8M93jVjmll7t4UGJTGgTUGlzLnUGdoMKVlO
         KCo5IZzwWV2fXCPrHy53kBMRLeU/6IZXDAQTl4vPVsw8f5YKJPZCxQ/WqLBZLt+5LQ
         Z7xfyNGxMmCx1KkgFWCtH05EOvXASJCy3iaKv6j8=
Date:   Sun, 30 Aug 2020 15:11:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] arm64: dts: imx8mm-evk: Align regulator names with
 schema
Message-ID: <20200830071137.GK32096@dragon>
References: <20200823172019.18606-1-krzk@kernel.org>
 <20200823172019.18606-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823172019.18606-5-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 07:20:19PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects regulator names to be lowercase.  This fixes
> dtbs_check warnings like:
> 
>     pmic@4b: regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
