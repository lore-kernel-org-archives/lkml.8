Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8349206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgFYFFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389833AbgFYFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:04:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB3C061573;
        Wed, 24 Jun 2020 22:04:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CF761288116B;
        Wed, 24 Jun 2020 22:04:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 22:04:57 -0700 (PDT)
Message-Id: <20200624.220457.1703184551117160217.davem@davemloft.net>
To:     po.liu@nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        idosch@idosch.org, jiri@resnulli.us, vinicius.gomes@intel.com,
        vlad@buslov.dev, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        alexandru.marginean@nxp.com, michael.chan@broadcom.com,
        vishal@chelsio.com, saeedm@mellanox.com, leon@kernel.org,
        jiri@mellanox.com, idosch@mellanox.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        kuba@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        simon.horman@netronome.com, pablo@netfilter.org,
        moshe@mellanox.com, m-karicheri2@ti.com,
        andre.guedes@linux.intel.com, stephen@networkplumber.org
Subject: Re: [v2,net-next 4/4] net: enetc add tc flower offload flow
 metering policing action
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200624093631.13719-4-po.liu@nxp.com>
References: <20200623063412.19180-4-po.liu@nxp.com>
        <20200624093631.13719-1-po.liu@nxp.com>
        <20200624093631.13719-4-po.liu@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jun 2020 22:04:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po Liu <po.liu@nxp.com>
Date: Wed, 24 Jun 2020 17:36:31 +0800

> From: Po Liu <Po.Liu@nxp.com>
> 
> Flow metering entries in IEEE 802.1Qci is an optional function for a
> flow filtering module. Flow metering is two rates two buckets and three
> color marker to policing the frames. This patch only enable one rate one
> bucket and in color blind mode. Flow metering instance are as
> specified in the algorithm in MEF 10.3 and in Bandwidth Profile
> Parameters. They are:
> 
> a) Flow meter instance identifier. An integer value identifying the flow
> meter instance. The patch use the police 'index' as thin value.
> b) Committed Information Rate (CIR), in bits per second. This patch use
> the 'rate_bytes_ps' represent this value.
> c) Committed Burst Size (CBS), in octets. This patch use the 'burst'
> represent this value.
> d) Excess Information Rate (EIR), in bits per second.
> e) Excess Burst Size per Bandwidth Profile Flow (EBS), in octets.
> And plus some other parameters. This patch set EIR/EBS default disable
> and color blind mode.
> 
> v1->v2 changes:
> - Use div_u64() as division replace the '/' report:
> 
> Reported-by: kernel test robot <lkp@intel.com>
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/net/ethernet/freescale/enetc/enetc_qos.o: in function `enetc_flowmeter_hw_set':
>>> enetc_qos.c:(.text+0x66): undefined reference to `__udivdi3'
> 
> 
> Signed-off-by: Po Liu <Po.Liu@nxp.com>

Applied.
