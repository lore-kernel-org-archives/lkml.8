Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4CC4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0820920786
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgCVDVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 23:21:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34468 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCVDVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 23:21:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19C0015AC429C;
        Sat, 21 Mar 2020 20:21:04 -0700 (PDT)
Date:   Sat, 21 Mar 2020 20:21:03 -0700 (PDT)
Message-Id: <20200321.202103.682709364176957538.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mptcp: Remove set but not used variable
 'can_ack'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200318020157.178956-1-yuehaibing@huawei.com>
References: <20200318020157.178956-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Mar 2020 20:21:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 18 Mar 2020 02:01:57 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> net/mptcp/options.c: In function 'mptcp_established_options_dss':
> net/mptcp/options.c:338:7: warning:
>  variable 'can_ack' set but not used [-Wunused-but-set-variable]
> 
> commit dc093db5cc05 ("mptcp: drop unneeded checks")
> leave behind this unused, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
