Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EFC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED13E2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD3TVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD3TVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:21:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3687C035494;
        Thu, 30 Apr 2020 12:21:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 705451288F360;
        Thu, 30 Apr 2020 12:21:09 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:21:08 -0700 (PDT)
Message-Id: <20200430.122108.297281216730911159.davem@davemloft.net>
To:     tangbin@cmss.chinamobile.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshengju@cmss.chinamobile.com
Subject: Re: [PATCH] net/faraday: Fix unnecessary check in ftmac100_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200430121532.22768-1-tangbin@cmss.chinamobile.com>
References: <20200430121532.22768-1-tangbin@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Apr 2020 12:21:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>
Date: Thu, 30 Apr 2020 20:15:31 +0800

> The function ftmac100_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Applied.
