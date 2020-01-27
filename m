Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7176AC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9EB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgA0K1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:27:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgA0K1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:27:51 -0500
Received: from localhost (unknown [213.175.37.12])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C3E41515E22B;
        Mon, 27 Jan 2020 02:27:48 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:27:46 +0100 (CET)
Message-Id: <20200127.112746.775052082096971348.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
        andrew@lunn.ch, f.fainelli@gmail.com, linville@tuxdriver.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] ethtool netlink interface, part 2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200127095744.GG570@unicorn.suse.cz>
References: <cover.1580075977.git.mkubecek@suse.cz>
        <20200127.104049.2252228859572866640.davem@davemloft.net>
        <20200127095744.GG570@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jan 2020 02:27:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 27 Jan 2020 10:57:44 +0100

> On Mon, Jan 27, 2020 at 10:40:49AM +0100, David Miller wrote:
>> From: Michal Kubecek <mkubecek@suse.cz>
>> Date: Sun, 26 Jan 2020 23:10:58 +0100 (CET)
>> 
>> > This shorter series adds support for getting and setting of wake-on-lan
>> > settings and message mask (originally message level). Together with the
>> > code already in net-next, this will allow full implementation of
>> > "ethtool <dev>" and "ethtool -s <dev> ...".
>> > 
>> > Older versions of the ethtool netlink series allowed getting WoL settings
>> > by unprivileged users and only filtered out the password but this was
>> > a source of controversy so for now, ETHTOOL_MSG_WOL_GET request always
>> > requires CAP_NET_ADMIN as ETHTOOL_GWOL ioctl request does.
>> 
>> It looks like this will need to be respun at least once, and net-next
>> is closing today so....
> 
> The problem with ethnl_parse_header() name not making it obvious that it
> takes a reference is not introduced in this series, the function is
> already in net-next so that it does not matter if this series is merged
> or not. Other than that, there is only the missing "the" in
> documentation.

Ok, I'll reconsider, thanks.
