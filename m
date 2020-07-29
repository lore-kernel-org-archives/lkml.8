Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28432C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004B3206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG2U11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2U11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:27:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE49C061794;
        Wed, 29 Jul 2020 13:27:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E97812786F12;
        Wed, 29 Jul 2020 13:10:41 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:27:25 -0700 (PDT)
Message-Id: <20200729.132725.1930680593526585407.davem@davemloft.net>
To:     brianvv@google.com
Cc:     brianvv.kernel@gmail.com, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] fib: fix fib_rules_ops indirect calls wrappers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200729181018.3221288-1-brianvv@google.com>
References: <20200729181018.3221288-1-brianvv@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Jul 2020 13:10:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Vazquez <brianvv@google.com>
Date: Wed, 29 Jul 2020 11:10:18 -0700

> This patch fixes:
> commit b9aaec8f0be5 ("fib: use indirect call wrappers in the most common
> fib_rules_ops") which didn't consider the case when
> CONFIG_IPV6_MULTIPLE_TABLES is not set.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: b9aaec8f0be5 ("fib: use indirect call wrappers in the most common fib_rules_ops")
> Signed-off-by: Brian Vazquez <brianvv@google.com>

Applied, thanks Brian.
