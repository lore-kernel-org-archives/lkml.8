Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5A207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589941109;
	bh=4rtD3N8khDuN3AOxFgFEWSzKLjfa7x3K1Z0gTxhZxKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/eUjEkcPXt9a7Um/9JcenbT7uBMF754IaGpr1Zj9y708TgO/oMSw5MjTDr3h1c9x
	 qWcYHk+LI5Ztu38EckiXvcZY+BFyKFKvVRC/mu0aKaR3waUg1nJbwjjkgavy0btFx1
	 yWGHN1yd/WhI9CTLnrpsOZ4B2Hc3j9Nuioo9jZIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgETCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETCS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:18:28 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F4F2070A;
        Wed, 20 May 2020 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589941108;
        bh=4rtD3N8khDuN3AOxFgFEWSzKLjfa7x3K1Z0gTxhZxKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vv1DssV90209oWSoindhPF8ot011Y4aq4jKUBLvsp44cYgtZqsX/dwoJCSVMUEULB
         a50FgC3BkPEo5e7880BVhQCOEwX5WqQHOyCXoeaGcTQFCTt6qs0ou56F5SSk4PO05G
         xN38XnXOJyYMPW+irONdPntwkGiInUtRVLynA52A=
Date:   Wed, 20 May 2020 10:18:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw5904: add lsm9ds1 iio imu/magn
 support
Message-ID: <20200520021822.GO11739@dragon>
References: <1589317196-8864-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589317196-8864-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 01:59:56PM -0700, Tim Harvey wrote:
> Add one node for the accel/gyro i2c device and another for the separate
> magnetometer device in the lsm9ds1.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
