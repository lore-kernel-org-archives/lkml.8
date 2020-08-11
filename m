Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64958C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E102076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKWh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgHKWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:37:25 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358AC06174A;
        Tue, 11 Aug 2020 15:37:25 -0700 (PDT)
Received: from localhost (50-47-103-195.evrt.wa.frontiernet.net [50.47.103.195])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52F16128B384E;
        Tue, 11 Aug 2020 15:20:36 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:37:18 -0700 (PDT)
Message-Id: <20200811.153718.832799152733810830.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuba@kernel.org, edumazet@google.com, kafai@fb.com,
        daniel@iogearbox.net, jakub@cloudflare.com, keescook@chromium.org,
        zhang.lin16@zte.com.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix potential memory leak in proto_register()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200810121658.54657-1-linmiaohe@huawei.com>
References: <20200810121658.54657-1-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Aug 2020 15:20:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Mon, 10 Aug 2020 08:16:58 -0400

> If we failed to assign proto idx, we free the twsk_slab_name but forget to
> free the twsk_slab. Add a helper function tw_prot_cleanup() to free these
> together and also use this helper function in proto_unregister().
> 
> Fixes: b45ce32135d1 ("sock: fix potential memory leak in proto_register()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied and queued up for -stable, thanks.
