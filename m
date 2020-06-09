Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B97C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565CD206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgFIU1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgFIU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:27:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD4C05BD1E;
        Tue,  9 Jun 2020 13:27:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 771AE12782877;
        Tue,  9 Jun 2020 13:27:37 -0700 (PDT)
Date:   Tue, 09 Jun 2020 13:27:36 -0700 (PDT)
Message-Id: <20200609.132736.1760843725831249479.davem@davemloft.net>
To:     wanghai38@huawei.com
Cc:     kuba@kernel.org, gerrit@erg.abdn.ac.uk, posk@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dccp@vger.kernel.org
Subject: Re: [PATCH] dccp: Fix possible memleak in dccp_init and dccp_fini
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200609141816.33467-1-wanghai38@huawei.com>
References: <20200609141816.33467-1-wanghai38@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 09 Jun 2020 13:27:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>
Date: Tue, 9 Jun 2020 22:18:16 +0800

> There are some memory leaks in dccp_init() and dccp_fini().
> 
> In dccp_fini() and the error handling path in dccp_init(), free lhash2
> is missing. Add inet_hashinfo2_free_mod() to do it.
> 
> If inet_hashinfo2_init_mod() failed in dccp_init(),
> percpu_counter_destroy() should be called to destroy dccp_orphan_count.
> It need to goto out_free_percpu when inet_hashinfo2_init_mod() failed.
> 
> Fixes: c92c81df93df ("net: dccp: fix kernel crash on module load")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied and queued up for -stable, thank you.
