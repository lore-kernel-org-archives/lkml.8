Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD82A2177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHHAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHHAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:43:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A4C061756;
        Fri,  7 Aug 2020 17:43:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 649FA1276FD65;
        Fri,  7 Aug 2020 17:26:58 -0700 (PDT)
Date:   Fri, 07 Aug 2020 17:43:42 -0700 (PDT)
Message-Id: <20200807.174342.2147963305722259387.davem@davemloft.net>
To:     ahabdels@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.mayer@uniroma2.it
Subject: Re: [PATCH] seg6: using DSCP of inner IPv4 packets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <7f8b1def-0a65-d2a4-577e-5f928cee0617@gmail.com>
References: <20200804074030.1147-1-ahabdels@gmail.com>
        <20200805.174049.1470539179902962793.davem@davemloft.net>
        <7f8b1def-0a65-d2a4-577e-5f928cee0617@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Aug 2020 17:26:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <ahabdels@gmail.com>
Date: Thu, 6 Aug 2020 08:43:06 +0200

> SRv6 as defined in [1][2] does not mandate that the hop_limit of the
> outer IPv6 header has to be copied from the inner packet.

This is not an issue of seg6 RFCs, but rather generic ip6 in ip6
tunnel encapsulation.

Therefore, what the existing ip6 tunnel encap does is our guide,
and it inherits from the inner header.

And that's what the original seg6 code almost certainly used to
guide the decision making in this area.
