Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F187C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4822720825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgGWA5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:57:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82323C0619DC;
        Wed, 22 Jul 2020 17:57:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DDCEB126ABE80;
        Wed, 22 Jul 2020 17:40:29 -0700 (PDT)
Date:   Wed, 22 Jul 2020 17:57:14 -0700 (PDT)
Message-Id: <20200722.175714.1713497446730685740.davem@davemloft.net>
To:     yepeilin.cs@gmail.com
Cc:     jreuter@yaina.de, ralf@linux-mips.org, gregkh@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org, kuba@kernel.org,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH net] AX.25: Fix out-of-bounds
 read in ax25_connect()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200722151901.350003-1-yepeilin.cs@gmail.com>
References: <20200722151901.350003-1-yepeilin.cs@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Jul 2020 17:40:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Wed, 22 Jul 2020 11:19:01 -0400

> Checks on `addr_len` and `fsa->fsa_ax25.sax25_ndigis` are insufficient.
> ax25_connect() can go out of bounds when `fsa->fsa_ax25.sax25_ndigis`
> equals to 7 or 8. Fix it.
> 
> This issue has been reported as a KMSAN uninit-value bug, because in such
> a case, ax25_connect() reaches into the uninitialized portion of the
> `struct sockaddr_storage` statically allocated in __sys_connect().
> 
> It is safe to remove `fsa->fsa_ax25.sax25_ndigis > AX25_MAX_DIGIS` because
> `addr_len` is guaranteed to be less than or equal to
> `sizeof(struct full_sockaddr_ax25)`.
> 
> Reported-by: syzbot+c82752228ed975b0a623@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=55ef9d629f3b3d7d70b69558015b63b48d01af66
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Applied and queued up for -stable, thanks.
