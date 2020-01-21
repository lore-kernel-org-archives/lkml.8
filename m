Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B1CC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018FC207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgAUMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:25:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgAUMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:25:43 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FB5914EFC235;
        Tue, 21 Jan 2020 04:25:42 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:24:53 +0100 (CET)
Message-Id: <20200121.132453.376626555109959388.davem@davemloft.net>
To:     andreas@gaisler.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc32,leon: Stop adding vendor and device id to prom
 ambapp path components
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200113160147.9254-1-andreas@gaisler.com>
References: <20200113160147.9254-1-andreas@gaisler.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 04:25:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 13 Jan 2020 17:01:47 +0100

> These extra fields before the @ are not handled in of_node_name_eq,
> making commit b3e46d1a0590500335f0b95e669ad6d84b12b03a break node name
> comparisons for ambapp path components, thereby making LEON systems
> unable to boot.
> 
> As there is no need for the tacked on vendor and device ID fields in the
> path component, resolve this situation by removing them.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied, thanks.
