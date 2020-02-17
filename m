Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9497CC3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AD208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBQCoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:44:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47922 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgBQCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:44:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA20B153C695C;
        Sun, 16 Feb 2020 18:44:43 -0800 (PST)
Date:   Sun, 16 Feb 2020 18:44:43 -0800 (PST)
Message-Id: <20200216.184443.782357344949548902.davem@davemloft.net>
To:     danielwa@cisco.com
Cc:     zbr@ioremap.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: connector: cn_proc: allow limiting certain
 messages
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200212192901.6402-1-danielwa@cisco.com>
References: <20200212192901.6402-1-danielwa@cisco.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Feb 2020 18:44:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a netlink based facility, therefore please you should add filtering
capabilities to the netlink configuration and communications path.

Module parameters are quite verboten.
