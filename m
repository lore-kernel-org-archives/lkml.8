Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FBBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DBE2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHXMyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:54:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B8C061573;
        Mon, 24 Aug 2020 05:54:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D20B812811098;
        Mon, 24 Aug 2020 05:37:28 -0700 (PDT)
Date:   Mon, 24 Aug 2020 05:54:12 -0700 (PDT)
Message-Id: <20200824.055412.154537872989436066.davem@davemloft.net>
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        kuba@kernel.org, hkallweit1@gmail.com, Jason@zx2c4.com,
        snelson@pensando.io, mst@redhat.com, liuyonglong@huawei.com,
        yankejian@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns: Fix memleak in hns_nic_dev_probe
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200824054444.24142-1-dinghao.liu@zju.edu.cn>
References: <20200824054444.24142-1-dinghao.liu@zju.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 05:37:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Date: Mon, 24 Aug 2020 13:44:42 +0800

> hns_nic_dev_probe allocates ndev, but not free it on
> two error handling paths, which may lead to memleak.
> 
> Fixes: 63434888aaf1b ("net: hns: net: hns: enet adds support of acpi")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Applied and queued up for -stable, thanks.
