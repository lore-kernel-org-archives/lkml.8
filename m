Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8525A2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgHNXn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHNXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 19:43:56 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063CCC061385;
        Fri, 14 Aug 2020 16:43:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8F5B1277D40A;
        Fri, 14 Aug 2020 16:27:09 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:43:54 -0700 (PDT)
Message-Id: <20200814.164354.1568500831741804705.davem@davemloft.net>
To:     po-hsu.lin@canonical.com
Cc:     kuba@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] selftests: rtnetlink: load fou module for
 kci_test_encap_fou()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200813044422.46713-1-po-hsu.lin@canonical.com>
References: <20200813044422.46713-1-po-hsu.lin@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Aug 2020 16:27:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 13 Aug 2020 12:44:22 +0800

> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 3b42c06b..96d2763 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
>  CONFIG_NET_SCH_NETEM=y
>  CONFIG_TEST_BLACKHOLE_DEV=m
>  CONFIG_KALLSYMS=y
> +CONFIG_NET_FOU

You need to assign it a value, not just add it to the file by itself.
