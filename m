Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E909BC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D1721D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDRUSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:18:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6085C061A0C;
        Sat, 18 Apr 2020 13:18:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B70D71273DF21;
        Sat, 18 Apr 2020 13:18:31 -0700 (PDT)
Date:   Sat, 18 Apr 2020 13:18:30 -0700 (PDT)
Message-Id: <20200418.131830.1251168077969815139.davem@davemloft.net>
To:     xiyuyang19@fudan.edu.cn
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, kuba@kernel.org,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, tanxin.ctf@gmail.com
Subject: Re: [PATCH] tipc: Fix potential tipc_aead refcnt leak in
 tipc_crypto_rcv
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1586939996-69937-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1586939996-69937-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 18 Apr 2020 13:18:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Date: Wed, 15 Apr 2020 16:39:56 +0800

> tipc_crypto_rcv() invokes tipc_aead_get(), which returns a reference of
> the tipc_aead object to "aead" with increased refcnt.
> 
> When tipc_crypto_rcv() returns, the original local reference of "aead"
> becomes invalid, so the refcount should be decreased to keep refcount
> balanced.
> 
> The issue happens in one error path of tipc_crypto_rcv(). When TIPC
> message decryption status is EINPROGRESS or EBUSY, the function forgets
> to decrease the refcnt increased by tipc_aead_get() and causes a refcnt
> leak.
> 
> Fix this issue by calling tipc_aead_put() on the error path when TIPC
> message decryption status is EINPROGRESS or EBUSY.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied and queued up for -stable.

This code is harder to audit than it needs to be due to the special
casing of things like -ENOKEY etc.  It should rather explicitly handle
the NULL test on aead in this top-level piece of code, which would
make the validation of aead reference counting much more explicit and
clear.
