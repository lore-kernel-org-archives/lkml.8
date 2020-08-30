Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60152C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED7120776
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598752211;
	bh=9lA1Qqp+XUdPeSwNbDpMNb70lYHeu0RbmQcP2hyivJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxsR3PWvQCmVpHYy1vbnX2MXdITTWW7fRRWdGJ1gyufReWDcBHy15feyMTvXPiuwA
	 vJoCf0mgB02xz0yxnAmXOrqwwBTwKNdnYOTL0A2vMOO85NbSmpqeA3Ls3ICcXHcAp8
	 J8SEm+/UTBR2B2gKKn/1ByXyTTgu8WQzTfmFh5ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgH3BuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 21:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgH3BuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:50:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905F02075B;
        Sun, 30 Aug 2020 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598752208;
        bh=9lA1Qqp+XUdPeSwNbDpMNb70lYHeu0RbmQcP2hyivJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOGIjE16n3Akmg1tYC0XRlkzojwJB4e6d8rYbipofze1jlVNHl0ZK6H5oSVeg7MPq
         D6NWYOZwVh89hnsDEO6Ti1SNsRRn5epNlenTiXqwLbIQQrSLnj6q73agOo5yu14LV8
         uIazvgm2053lK+1eMAjzx7gbAVttW8JRsaccb00s=
Date:   Sun, 30 Aug 2020 09:50:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm-evk: remove orphaned
 pinctrl-names property
Message-ID: <20200830015002.GE32096@dragon>
References: <20200823090505.5579-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823090505.5579-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 11:05:03AM +0200, Krzysztof Kozlowski wrote:
> The "pinctrl-names" property in iomux node does not make sense on its
> own (without "pinctrl-X").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
