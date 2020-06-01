Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC22F20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgFASxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFASxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:53:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB4C061A0E;
        Mon,  1 Jun 2020 11:53:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7503E11D53F8B;
        Mon,  1 Jun 2020 11:53:15 -0700 (PDT)
Date:   Mon, 01 Jun 2020 11:53:14 -0700 (PDT)
Message-Id: <20200601.115314.1252090110544162221.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     doshir@vmware.com, pv-drivers@vmware.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: vmxnet3: fix possible buffer overflow caused by
 bad DMA value in vmxnet3_get_rss()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200530024150.27308-1-baijiaju1990@gmail.com>
References: <20200530024150.27308-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jun 2020 11:53:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Sat, 30 May 2020 10:41:50 +0800

> The value adapter->rss_conf is stored in DMA memory, and it is assigned
> to rssConf, so rssConf->indTableSize can be modified at anytime by
> malicious hardware. Because rssConf->indTableSize is assigned to n,
> buffer overflow may occur when the code "rssConf->indTable[n]" is
> executed.
> 
> To fix this possible bug, n is checked after being used.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thanks.
