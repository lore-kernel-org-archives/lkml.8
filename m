Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC97C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FC520756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgHKRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHKRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:21:48 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF23FC06174A;
        Tue, 11 Aug 2020 10:21:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D6F0512880A09;
        Tue, 11 Aug 2020 10:04:52 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:21:37 -0700 (PDT)
Message-Id: <20200811.102137.1449270134661337607.davem@davemloft.net>
To:     ira.weiny@intel.com
Cc:     borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net, kuba@kernel.org,
        ilyal@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: Fix kmap usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200811000258.2797151-1-ira.weiny@intel.com>
References: <20200811000258.2797151-1-ira.weiny@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Aug 2020 10:04:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ira.weiny@intel.com
Date: Mon, 10 Aug 2020 17:02:58 -0700

> From: Ira Weiny <ira.weiny@intel.com>
> 
> When MSG_OOB is specified to tls_device_sendpage() the mapped page is
> never unmapped.
> 
> Hold off mapping the page until after the flags are checked and the page
> is actually needed.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Applied and queued up for -stable, thank you.
