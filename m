Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08091C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D220882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAULBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:01:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAULBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:01:50 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ABD1715C19EF6;
        Tue, 21 Jan 2020 03:01:48 -0800 (PST)
Date:   Tue, 21 Jan 2020 12:01:47 +0100 (CET)
Message-Id: <20200121.120147.1198296072172480771.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] wan/hdlc_x25: make lapb params configurable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200121.114152.532453946458399573.davem@davemloft.net>
References: <20200121060034.30554-1-ms@dev.tdt.de>
        <20200121.114152.532453946458399573.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 03:01:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jan 2020 11:41:52 +0100 (CET)

> From: Martin Schiller <ms@dev.tdt.de>
> Date: Tue, 21 Jan 2020 07:00:33 +0100
> 
>> This enables you to configure mode (DTE/DCE), Modulo, Window, T1, T2, N2 via
>> sethdlc (which needs to be patched as well).
>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> 
> Applied to net-next.

I seriously wonder how much you tested this code, because the compiler warned
me about:

diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index 63c9aeed9a34..c84536b03aa8 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -253,7 +253,7 @@ static int x25_ioctl(struct net_device *dev, struct ifreq *ifr)
 			return -EBUSY;
 
 		/* backward compatibility */
-		if (ifr->ifr_settings.size = 0) {
+		if (ifr->ifr_settings.size == 0) {
 			new_settings.dce = 0;
 			new_settings.modulo = 8;
 			new_settings.window = 7;

I'll commit that fix, but this is truly careless especially since the compiler
warns about it.
