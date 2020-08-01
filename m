Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42807C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C22076B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHASr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHASr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:47:58 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F722C06174A;
        Sat,  1 Aug 2020 11:47:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 81E7A1284DAE7;
        Sat,  1 Aug 2020 11:31:12 -0700 (PDT)
Date:   Sat, 01 Aug 2020 11:47:57 -0700 (PDT)
Message-Id: <20200801.114757.803597202095162623.davem@davemloft.net>
To:     brianvv@google.com
Cc:     brianvv.kernel@gmail.com, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rdunlap@infradead.org, sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] fib: fix another fib_rules_ops indirect call
 wrapper problem
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200801030110.747164-1-brianvv@google.com>
References: <20200801030110.747164-1-brianvv@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 01 Aug 2020 11:31:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Vazquez <brianvv@google.com>
Date: Fri, 31 Jul 2020 20:01:10 -0700

> It turns out that on commit 41d707b7332f ("fib: fix fib_rules_ops
> indirect calls wrappers") I forgot to include the case when
> CONFIG_IP_MULTIPLE_TABLES is not set.
> 
> Fixes: 41d707b7332f ("fib: fix fib_rules_ops indirect calls wrappers")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brian Vazquez <brianvv@google.com>

Applied.
