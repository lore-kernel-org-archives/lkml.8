Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554620780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgC3Fde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:33:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33408 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgC3Fde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:33:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 05BF815C749F1;
        Sun, 29 Mar 2020 22:33:32 -0700 (PDT)
Date:   Sun, 29 Mar 2020 22:33:32 -0700 (PDT)
Message-Id: <20200329.223332.1532078379996258803.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     kuba@kernel.org, netdev@vger.kernel.org, jiri@resnulli.us,
        andrew@lunn.ch, f.fainelli@gmail.com, linville@tuxdriver.com,
        johannes@sipsolutions.net, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/12] ethtool netlink interface, part 4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1585349448.git.mkubecek@suse.cz>
References: <cover.1585349448.git.mkubecek@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Mar 2020 22:33:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Sat, 28 Mar 2020 00:00:58 +0100 (CET)

> Implementation of more netlink request types:
> 
>   - coalescing (ethtool -c/-C, patches 2-4)
>   - pause parameters (ethtool -a/-A, patches 5-7)
>   - EEE settings (--show-eee / --set-eee, patches 8-10)
>   - timestamping info (-T, patches 11-12)
> 
> Patch 1 is a fix for netdev reference leak similar to commit 2f599ec422ad
> ("ethtool: fix reference leak in some *_SET handlers") but fixing a code
> 
> Changes in v3
>   - change "one-step-*" Tx type names to "onestep-*", (patch 11, suggested
>     by Richard Cochran
>   - use "TSINFO" rather than "TIMESTAMP" for timestamping information
>     constants and adjust symbol names (patch 12, suggested by Richard
>     Cochran)
> 
> Changes in v2:
>   - fix compiler warning in net_hwtstamp_validate() (patch 11)
>   - fix follow-up lines alignment (whitespace only, patches 3 and 8)
> which is only in net-next tree at the moment.

Series applied, thanks.
