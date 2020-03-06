Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A17C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6080E20716
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCFBeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:34:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:34:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2218F15543ED0;
        Thu,  5 Mar 2020 17:34:14 -0800 (PST)
Date:   Thu, 05 Mar 2020 17:34:13 -0800 (PST)
Message-Id: <20200305.173413.1141876751815244581.davem@davemloft.net>
To:     jianglidong@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianglidong3@jd.com
Subject: Re: [PATCH] veth: ignore peer tx_dropped when counting local
 rx_dropped
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1583286569-144923-1-git-send-email-jianglidong@gmail.com>
References: <1583286569-144923-1-git-send-email-jianglidong@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Mar 2020 17:34:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lidong Jiang <jianglidong@gmail.com>
Date: Wed,  4 Mar 2020 09:49:29 +0800

> From: Jiang Lidong <jianglidong3@jd.com>
> 
> When local NET_RX backlog is full due to traffic overrun,
> peer veth tx_dropped counter increases. At that time, list
> local veth stats, rx_dropped has double value of peer
> tx_dropped, even bigger than transmit packets by peer.
> 
> In NET_RX softirq process, if any packet drop case happens,
> it increases dev's rx_dropped counter and returns NET_RX_DROP.
> 
> At veth tx side, it records any error returned from peer netif_rx
> into local dev tx_dropped counter.
> 
> In veth get stats process, it puts local dev rx_dropped and
> peer dev tx_dropped into together as local rx_drpped value.
> So that it shows double value of real dropped packets number in
> this case.
> 
> This patch ignores peer tx_dropped when counting local rx_dropped,
> since peer tx_dropped is duplicated to local rx_dropped at most cases.
> 
> Signed-off-by: Jiang Lidong <jianglidong3@jd.com>

This makes sense to me, applied, thank you.
