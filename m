Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED7C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479F206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgA3JDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:03:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgA3JDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:03:53 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17F3F15380194;
        Thu, 30 Jan 2020 01:03:51 -0800 (PST)
Date:   Thu, 30 Jan 2020 10:03:50 +0100 (CET)
Message-Id: <20200130.100350.1147670378193704097.davem@davemloft.net>
To:     joe@perches.com
Cc:     nhorman@tuxdriver.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: drop_monitor: Use kstrdup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2dd59a9ea0ed9029caf1b91fb6758ecc7f1dd695.camel@perches.com>
References: <2dd59a9ea0ed9029caf1b91fb6758ecc7f1dd695.camel@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jan 2020 01:03:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Tue, 28 Jan 2020 11:02:50 -0800

> Convert the equivalent but rather odd uses of kmemdup with
> __GFP_ZERO to the more common kstrdup and avoid unnecessary
> zeroing of copied over memory.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
