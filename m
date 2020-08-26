Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64768C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397A021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHZOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:30:01 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDFC061574;
        Wed, 26 Aug 2020 07:30:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DB4F713588515;
        Wed, 26 Aug 2020 07:13:13 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:29:59 -0700 (PDT)
Message-Id: <20200826.072959.850785662944644538.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     kuba@kernel.org, masahiroy@kernel.org, bjorn@mork.no,
        miguel@det.uvigo.gal, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cdc_ncm: Fix build error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200826065231.14344-1-yuehaibing@huawei.com>
References: <20200826065231.14344-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Aug 2020 07:13:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Aug 2020 14:52:31 +0800

> If USB_NET_CDC_NCM is y and USB_NET_CDCETHER is m, build fails:
> 
> drivers/net/usb/cdc_ncm.o:(.rodata+0x1d8): undefined reference to `usbnet_cdc_update_filter'
> 
> Select USB_NET_CDCETHER for USB_NET_CDC_NCM to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e10dcb1b6ba7 ("net: cdc_ncm: hook into set_rx_mode to admit multicast traffic")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
