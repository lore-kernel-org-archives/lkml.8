Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AE3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0272080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbgGWBHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:07:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8BC0619DC;
        Wed, 22 Jul 2020 18:07:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03364126B39BC;
        Wed, 22 Jul 2020 17:50:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 18:07:23 -0700 (PDT)
Message-Id: <20200722.180723.102622644879670834.davem@davemloft.net>
To:     yepeilin.cs@gmail.com
Cc:     jreuter@yaina.de, ralf@linux-mips.org, gregkh@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org, kuba@kernel.org,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH net] AX.25: Prevent
 out-of-bounds read in ax25_sendmsg()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200722160512.370802-1-yepeilin.cs@gmail.com>
References: <20200722160512.370802-1-yepeilin.cs@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Jul 2020 17:50:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Wed, 22 Jul 2020 12:05:12 -0400

> Checks on `addr_len` and `usax->sax25_ndigis` are insufficient.
> ax25_sendmsg() can go out of bounds when `usax->sax25_ndigis` equals to 7
> or 8. Fix it.
> 
> It is safe to remove `usax->sax25_ndigis > AX25_MAX_DIGIS`, since
> `addr_len` is guaranteed to be less than or equal to
> `sizeof(struct full_sockaddr_ax25)`
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Applied.
