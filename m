Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C87A2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFDWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFDWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:00:46 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB2C08C5C0;
        Thu,  4 Jun 2020 15:00:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFBDE11D53F8B;
        Thu,  4 Jun 2020 15:00:42 -0700 (PDT)
Date:   Thu, 04 Jun 2020 15:00:40 -0700 (PDT)
Message-Id: <20200604.150040.2131369235290939835.davem@davemloft.net>
To:     joyce.ooi@intel.com
Cc:     thor.thayer@linux.intel.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dalon.westergreen@linux.intel.com, ley.foon.tan@intel.com,
        chin.liang.see@intel.com, dinh.nguyen@intel.com
Subject: Re: [PATCH v3 00/10] net: eth: altera: tse: Add PTP and mSGDMA
 prefetcher
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200604073256.25702-1-joyce.ooi@intel.com>
References: <20200604073256.25702-1-joyce.ooi@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Jun 2020 15:00:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ooi, Joyce" <joyce.ooi@intel.com>
Date: Thu,  4 Jun 2020 15:32:46 +0800

> From: Joyce Ooi <joyce.ooi@intel.com>
> 
> This patch series cleans up the Altera TSE driver and adds support
> for the newer msgdma prefetcher as well as ptp support when using
> the msgdma prefetcher.
> 
> v2: Rename altera_ptp to intel_fpga_tod, modify msgdma and sgdma tx_buffer
>     functions to be of type netdev_tx_t, and minor suggested edits
> v3: Modify tx_buffer to stop queue before returning NETDEV_TX_BUSY

net-next is closed at this time
