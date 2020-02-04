Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9CCC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B95B2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBDK6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:58:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgBDK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:58:36 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2EC6A133A87CD;
        Tue,  4 Feb 2020 02:58:34 -0800 (PST)
Date:   Tue, 04 Feb 2020 11:58:32 +0100 (CET)
Message-Id: <20200204.115832.852019347761501397.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     hayeswang@realtek.com, kuba@kernel.org, pmalani@chromium.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8152: Add MAC passthrough support to new device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200204053315.21866-1-kai.heng.feng@canonical.com>
References: <20200204053315.21866-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Feb 2020 02:58:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue,  4 Feb 2020 13:33:13 +0800

> Device 0xa387 also supports MAC passthrough, therefore add it to the
> whitelst.
> 
> BugLink: https://bugs.launchpad.net/bugs/1827961/comments/30
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use switch case to match device id.
>  - Use macro instead of hex for device id.

Applied, thank you.
