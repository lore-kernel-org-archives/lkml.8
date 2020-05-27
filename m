Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08272C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F632073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgE0DT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbgE0DT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:19:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282AC061A0F;
        Tue, 26 May 2020 20:19:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7843612751D13;
        Tue, 26 May 2020 20:19:26 -0700 (PDT)
Date:   Tue, 26 May 2020 20:19:25 -0700 (PDT)
Message-Id: <20200526.201925.2160949442758094082.davem@davemloft.net>
To:     dvyukov@google.com
Cc:     ubraun@linux.ibm.com, kgraul@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/smc: mark smc_pnet_policy as const
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200525153158.247394-1-dvyukov@google.com>
References: <20200525153158.247394-1-dvyukov@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 May 2020 20:19:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 25 May 2020 17:31:58 +0200

> Netlink policies are generally declared as const.
> This is safer and prevents potential bugs.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Applied to net-next, thanks.
