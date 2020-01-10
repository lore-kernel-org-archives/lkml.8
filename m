Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A1C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333C72051A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgAJTNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:13:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39732 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAJTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:13:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4B51B15741648;
        Fri, 10 Jan 2020 11:13:19 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:13:16 -0800 (PST)
Message-Id: <20200110.111316.1791698410658592877.davem@davemloft.net>
To:     niu_xilei@163.com
Cc:     tglx@linutronix.de, fw@strlen.de, peterz@infradead.org,
        pabeni@redhat.com, anshuman.khandual@arm.com,
        linyunsheng@huawei.com, bigeasy@linutronix.de,
        jonathan.lemon@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: create packet use IPv6 source address between
 src6_min and src6_max.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200110102842.13585-1-niu_xilei@163.com>
References: <20200110102842.13585-1-niu_xilei@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Jan 2020 11:13:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niu Xilei <niu_xilei@163.com>
Date: Fri, 10 Jan 2020 18:28:42 +0800

> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -254,6 +254,111 @@ struct flow_state {
>  /* flow flag bits */
>  #define F_INIT   (1<<0)		/* flow has been initialized */
>  
> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
> +
> +__extension__ typedef  unsigned __int128 u128;
> +

This does not belong in pktgen.c but rather in a generic kernel header, and such
facilities should be posted for general review on lkml.
