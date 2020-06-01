Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12CB20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgFASw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgFASwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:52:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7705C061A0E;
        Mon,  1 Jun 2020 11:52:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6048120477C4;
        Mon,  1 Jun 2020 11:52:22 -0700 (PDT)
Date:   Mon, 01 Jun 2020 11:52:22 -0700 (PDT)
Message-Id: <20200601.115222.628560714795578081.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        kuba@kernel.org, gnault@redhat.com, vladbu@mellanox.com,
        lucien.xin@gmail.com, pablo@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: work around stack frame size warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200529201413.397679-1-arnd@arndb.de>
References: <20200529201413.397679-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jun 2020 11:52:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 May 2020 22:13:58 +0200

> The fl_flow_key structure is around 500 bytes, so having two of them
> on the stack in one function now exceeds the warning limit after an
> otherwise correct change:
> 
> net/sched/cls_flower.c:298:12: error: stack frame size of 1056 bytes in function 'fl_classify' [-Werror,-Wframe-larger-than=]
> 
> I suspect the fl_classify function could be reworked to only have one
> of them on the stack and modify it in place, but I could not work out
> how to do that.
> 
> As a somewhat hacky workaround, move one of them into an out-of-line
> function to reduce its scope. This does not necessarily reduce the stack
> usage of the outer function, but at least the second copy is removed
> from the stack during most of it and does not add up to whatever is
> called from there.
> 
> I now see 552 bytes of stack usage for fl_classify(), plus 528 bytes
> for fl_mask_lookup().
> 
> Fixes: 58cff782cc55 ("flow_dissector: Parse multiple MPLS Label Stack Entries")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
