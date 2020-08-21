Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9EAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0220748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHUSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:48:52 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DBEC061573;
        Fri, 21 Aug 2020 11:48:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 599EA128809AE;
        Fri, 21 Aug 2020 11:32:05 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:48:50 -0700 (PDT)
Message-Id: <20200821.114850.193253709080317487.davem@davemloft.net>
To:     trix@redhat.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: b53: check for timeout
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200821135600.18017-1-trix@redhat.com>
References: <20200821135600.18017-1-trix@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Aug 2020 11:32:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: trix@redhat.com
Date: Fri, 21 Aug 2020 06:56:00 -0700

> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> b53_common.c:1583:13: warning: The left expression of the compound
>   assignment is an uninitialized value. The computed value will
>   also be garbage
>         ent.port &= ~BIT(port);
>         ~~~~~~~~ ^
> 
> ent is set by a successful call to b53_arl_read().  Unsuccessful
> calls are caught by an switch statement handling specific returns.
> b32_arl_read() calls b53_arl_op_wait() which fails with the
> unhandled -ETIMEDOUT.
> 
> So add -ETIMEDOUT to the switch statement.  Because
> b53_arl_op_wait() already prints out a message, do not add another
> one.
> 
> Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied and queued up for -stable, thanks.
