Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4981820672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGITg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGITg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:36:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EEC08C5CE;
        Thu,  9 Jul 2020 12:36:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B92112794C20;
        Thu,  9 Jul 2020 12:36:27 -0700 (PDT)
Date:   Thu, 09 Jul 2020 12:36:26 -0700 (PDT)
Message-Id: <20200709.123626.261284515556787924.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: fix genlmsg_put() failure handling in
 ethnl_default_dumpit()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200709101150.65DBB60567@lion.mk-sys.cz>
References: <20200709101150.65DBB60567@lion.mk-sys.cz>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 Jul 2020 12:36:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu,  9 Jul 2020 12:11:50 +0200 (CEST)

> If the genlmsg_put() call in ethnl_default_dumpit() fails, we bail out
> without checking if we already have some messages in current skb like we do
> with ethnl_default_dump_one() failure later. Therefore if existing messages
> almost fill up the buffer so that there is not enough space even for
> netlink and genetlink header, we lose all prepared messages and return and
> error.
> 
> Rather than duplicating the skb->len check, move the genlmsg_put(),
> genlmsg_cancel() and genlmsg_end() calls into ethnl_default_dump_one().
> This is also more logical as all message composition will be in
> ethnl_default_dump_one() and only iteration logic will be left in
> ethnl_default_dumpit().
> 
> Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Applied and queued up for -stable, thanks.
