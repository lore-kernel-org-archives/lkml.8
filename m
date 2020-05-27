Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0250D20723
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgE0GTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0GTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:19:01 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09CC061A0F;
        Tue, 26 May 2020 23:19:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9CD37127F35C6;
        Tue, 26 May 2020 23:19:00 -0700 (PDT)
Date:   Tue, 26 May 2020 23:18:59 -0700 (PDT)
Message-Id: <20200526.231859.398097568630300979.davem@davemloft.net>
To:     alexander.sverdlin@nokia.com
Cc:     netdev@vger.kernel.org, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macvlan: Skip loopback packets in RX handler
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200526122751.409917-1-alexander.sverdlin@nokia.com>
References: <20200526122751.409917-1-alexander.sverdlin@nokia.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 May 2020 23:19:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Date: Tue, 26 May 2020 14:27:51 +0200

> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Ignore loopback-originatig packets soon enough and don't try to process L2
> header where it doesn't exist. The very similar br_handle_frame() in bridge
> code performs exactly the same check.
> 
> This is an example of such ICMPv6 packet:
 ...
> Call Trace, how it happens exactly:
>  ...
>  macvlan_handle_frame+0x321/0x425 [macvlan]
>  ? macvlan_forward_source+0x110/0x110 [macvlan]
>  __netif_receive_skb_core+0x545/0xda0
 ...
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to net-next, thanks.
