Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD4B206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgHETYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgHETXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:23:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88943C061575;
        Wed,  5 Aug 2020 12:23:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E90E3152F10C7;
        Wed,  5 Aug 2020 12:06:57 -0700 (PDT)
Date:   Wed, 05 Aug 2020 12:23:42 -0700 (PDT)
Message-Id: <20200805.122342.187021203440253984.davem@davemloft.net>
To:     po-hsu.lin@canonical.com
Cc:     kuba@kernel.org, skhan@linuxfoundation.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: rtnetlink: Fix for false-negative
 return values
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200804101803.23062-1-po-hsu.lin@canonical.com>
References: <20200804101803.23062-1-po-hsu.lin@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Aug 2020 12:06:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue,  4 Aug 2020 18:18:01 +0800

> This patchset will address the false-negative return value issue
> caused by the following:
>   1. The return value "ret" in this script will be reset to 0 from
>      the beginning of each sub-test in rtnetlink.sh, therefore this
>      rtnetlink test will always pass if the last sub-test has passed.
>   2. The test result from two sub-tests in kci_test_encap() were not
>      being processed, thus they will not affect the final test result
>      of this test.

Series applied, thank you.
