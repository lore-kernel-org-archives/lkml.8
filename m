Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE54C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D47218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581649539;
	bh=Emphv1LPaR4mUmsyiCMyc6tU2RVlOAdhUtkd2Wzl9yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aTjAEQ5Y+Ftw4c5b6HpLu/+ztNH12VgnPCNZzH7V9vxdAF7Vp55VaQVTe5YUQ9GRb
	 Zdj9lVv8tRsuoaMHwqU34Jr5Jqk9LV+lsEXRhO5PpzXv7NMVsfnWFBGoGh6jS0iu2W
	 30ZQHls3yXSY1h0myuBPawQJm+p55gQqxnCA8vu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBNDFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNDFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:05:38 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494282168B;
        Fri, 14 Feb 2020 03:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581649538;
        bh=Emphv1LPaR4mUmsyiCMyc6tU2RVlOAdhUtkd2Wzl9yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DK1zD/tZjIet+4Aj64cwartxDAZ8dqSSlgfq4c1UZmKs5B5NWR3NrP8kDQGVB+MdF
         QieNq7hZqgKND/iLCYjOQy3Q1AnReRUn5agVVR6nz0jgtdhDMRXj6p5sui/2BUb7A3
         2ohSyBJ53kzzGoxukBVeCqUUpfTEp3nWURajhP5w=
Date:   Fri, 14 Feb 2020 11:05:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio
 imu/magn support
Message-ID: <20200214030530.GK22842@dragon>
References: <20200128221326.11393-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128221326.11393-1-rjones@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:13:26PM -0800, Robert Jones wrote:
> Add one node for the accel/gyro i2c device and another for the separate
> magnetometer device in the lsm9ds1.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Prefix 'ARM: dts: imx6qdl-gw553x: ' should be clear enough.

Shawn
