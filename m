Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E1C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9552072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgAJCgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:36:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60746 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgAJCgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:36:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4604F15736591;
        Thu,  9 Jan 2020 18:36:38 -0800 (PST)
Date:   Thu, 09 Jan 2020 18:36:37 -0800 (PST)
Message-Id: <20200109.183637.755651104106589448.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        openbmc@lists.ozlabs.org, sdasari@fb.com
Subject: Re: [net-next PATCH] net/ncsi: Support for multi host mellanox card
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200108234341.2590674-1-vijaykhemka@fb.com>
References: <20200108234341.2590674-1-vijaykhemka@fb.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 Jan 2020 18:36:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 8 Jan 2020 15:43:40 -0800

> Multi host Mellanox cards require MAC affinity to be set
> before receiving any config commands. All config commands
> should also have unicast address for source address in
> command header.
> 
> Adding GMA and SMAF(Set Mac Affinity) for Mellanox card
> and call these in channel probe state machine if it is
> defined in device tree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied, thank you.
