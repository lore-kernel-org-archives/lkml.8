Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071BA2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAJT1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:27:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgAJT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:27:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EA861577F516;
        Fri, 10 Jan 2020 11:27:37 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:27:36 -0800 (PST)
Message-Id: <20200110.112736.1849382588448237535.davem@davemloft.net>
To:     nikolay@cumulusnetworks.com
Cc:     horatiu.vultur@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        roopa@cumulusnetworks.com, jakub.kicinski@netronome.com,
        vivien.didelot@gmail.com, andrew@lunn.ch,
        jeffrey.t.kirsher@intel.com, olteanv@gmail.com,
        anirudh.venkataramanan@intel.com, dsahern@gmail.com,
        jiri@mellanox.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next Patch 0/3] net: bridge: mrp: Add support for
 Media Redundancy Protocol(MRP)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
        <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Jan 2020 11:27:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 10 Jan 2020 16:13:36 +0200

> I agree with Stephen here, IMO you have to take note of how STP has progressed
> and that bringing it in the kernel was a mistake, these days mstpd has an active
> community and much better support which is being extended. This looks best implemented
> in user-space in my opinion with minimal kernel changes to support it. You could simply
> open a packet socket with a filter and work through that, you don't need new netlink
> sockets. I'm not familiar with the protocol so can't really be the judge of that, if
> you present a good argument for needing a new netlink socket for these packets - then
> sure, ok.

With a userland implementation, what approach do you suggest for DSA/switchdev offload
of this stuff?
