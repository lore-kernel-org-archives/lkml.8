Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EAC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538CE208B3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599293138;
	bh=swlplrjI3QNfeMVuhTr1PFxCION4Fl0IQNgnXjcUKG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RA3EWBzdU2UNfdKC2nswoKn/Z2oRpUt487pxR7h7WXP2kpcPk0wcGYlV9Vc6NEKqh
	 jCQzXS4/3AUtbFlbXY1mId7FJZI5Q+p9ZPjzGYPDp8mTvhhGTHjhXRyrffWitnOvP7
	 UD1gaewX9J8gI88QAe29mhYUv6cLgc1Bgtq9Hxbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIEIFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgIEIFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:05:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388852087C;
        Sat,  5 Sep 2020 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599293135;
        bh=swlplrjI3QNfeMVuhTr1PFxCION4Fl0IQNgnXjcUKG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XEfOM2eudn6bZaY8YpnGTlYkQLWl8PnhK6x1lc4kVLdtlos6ErofC6cEeIdQcHVO
         rlw7s8rWQoX2e6bx4D1r7D7s4Rn2FG6reosPTMYDPUuDTbyuMog+PNd2r2MFnfk9cG
         EBEpFyo0epOHE9fu7zbpNf/ydVZxDL+f2t9xn7/Y=
Date:   Sat, 5 Sep 2020 16:05:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] ARM: dts: imx28-m28: Align GPMI NAND node name
 with schema
Message-ID: <20200905080529.GS9261@dragon>
References: <20200904062743.6273-1-krzk@kernel.org>
 <20200904062743.6273-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904062743.6273-14-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:27:43AM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects NAND controller to be named
> "nand-controller", otherwise dtbs_check complain with a warning like:
> 
>     arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
>         $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks. 
