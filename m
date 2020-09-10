Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DF521556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIJTcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgIJT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:29:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE33C061756;
        Thu, 10 Sep 2020 12:29:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA57012A2C1E2;
        Thu, 10 Sep 2020 12:12:43 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:29:29 -0700 (PDT)
Message-Id: <20200910.122929.1460871728363084990.davem@davemloft.net>
To:     geliangtang@gmail.com
Cc:     mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        kuba@kernel.org, pabeni@redhat.com, fw@strlen.de,
        peter.krystad@linux.intel.com, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [MPTCP][PATCH v2 net 0/2] mptcp: fix subflow's
 local_id/remote_id issues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1599532593.git.geliangtang@gmail.com>
References: <cover.1599532593.git.geliangtang@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 12:12:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geliang Tang <geliangtang@gmail.com>
Date: Tue,  8 Sep 2020 10:49:37 +0800

> v2:
>  - add Fixes tags;
>  - simply with 'return addresses_equal';
>  - use 'reversed Xmas tree' way.

Series applied, thanks.
