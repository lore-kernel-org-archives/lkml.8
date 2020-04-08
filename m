Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB027C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205A2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgDHVd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:33:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgDHVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:33:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F363C127D38B8;
        Wed,  8 Apr 2020 14:33:27 -0700 (PDT)
Date:   Wed, 08 Apr 2020 14:33:27 -0700 (PDT)
Message-Id: <20200408.143327.2268546094613330028.davem@davemloft.net>
To:     wenhu.wang@vivo.com
Cc:     akpm@linux-foundation.org, kuba@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        bjorn.andersson@linaro.org, hofrat@osadl.org, allison@lohutok.net,
        johannes.berg@intel.com, arnd@arndb.de, cjhuang@codeaurora.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH RESEND] net: qrtr: support qrtr service and lookup route
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200408104833.6880-1-wenhu.wang@vivo.com>
References: <20200408104833.6880-1-wenhu.wang@vivo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Apr 2020 14:33:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Wenhu <wenhu.wang@vivo.com>
Date: Wed,  8 Apr 2020 03:46:35 -0700

> QSR implements maintenance of qrtr services and lookups. It would
> be helpful for developers to work with QRTR without the none-opensource
> user-space implementation part of IPC Router.
> 
> As we know, the extremely important point of IPC Router is the support
> of services form different nodes. But QRTR was pushed into mainline
> without route process support of services, and the router port process
> is implemented in user-space as none-opensource codes, which is an
> great unconvenience for developers.
> 
> QSR also implements a interface via chardev and a set of sysfs class
> files for the communication and debugging in user-space. We can get
> service and lookup entries conveniently via sysfs file in /sys/class/qsr/.
> Currently add-server, del-server, add-lookup and del-lookup control
> packatets are processed and enhancements could be taken easily upon
> currently implementation.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

New features are only appropriate for net-next which is closed right now.
