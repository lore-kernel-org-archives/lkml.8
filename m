Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98933C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3978B21D79
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599824625;
	bh=71D7FwuJXQG5SoQQ3/Wx1gY6oRig9YIzTJYZXg5luTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6WXyJre+zXcwgJXVj+SGx6Q+dBm78pmgvS4/bDyqPM399pZcHlwZcHhugPrAZvxk
	 RDmlVWJZJZrq5E43+1BeeL+qa5bV0Fmque4u3QEOu76LsCh/vnpS3wDQAlmPEmhVHJ
	 LWDf3u6qB7aF08nyt56azLadsY/LQuCEMD07qeyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgIKLne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgIKLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:43:10 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EBD21D79;
        Fri, 11 Sep 2020 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599824589;
        bh=71D7FwuJXQG5SoQQ3/Wx1gY6oRig9YIzTJYZXg5luTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvji4I1MSjVaf/1iGu6g9FspIHC7rCubQqNi6epl3qmtdiw3MwO56wdU533VS5lPP
         ehJE9sY1u6999MQMg3l2Xl0Y2LBpZNwQKkyKrQXni6cJf36CF3BvStrc58A3ldcRA6
         5gfQuFVwnowXJRoJIkRhQee0eiNkuGZJfIpNgv8o=
Date:   Fri, 11 Sep 2020 17:13:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        balbi@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v9 0/2] phy: Add USB PHY support on Intel LGM SoC
Message-ID: <20200911114303.GW77521@vkoul-mobl>
References: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 10:23, Ramuthevar,Vadivel MuruganX wrote:
> The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
> Requires minimal external components, a single resistor, for best operation.
> Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable

Applied, thanks

-- 
~Vinod
