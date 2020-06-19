Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC69C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311BD20888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgFSDh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFSDh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:37:58 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABC6C06174E;
        Thu, 18 Jun 2020 20:37:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6863C120ED49C;
        Thu, 18 Jun 2020 20:37:57 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:37:56 -0700 (PDT)
Message-Id: <20200618.203756.1164703626188584540.davem@davemloft.net>
To:     alobakin@pm.me
Cc:     kuba@kernel.org, mkubecek@suse.cz, andrew@lunn.ch,
        f.fainelli@gmail.com, richardcochran@gmail.com,
        antoine.tenart@bootlin.com, ayal@mellanox.com,
        steffen.klassert@secunet.com, willemb@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend net] net: ethtool: add missing
 NETIF_F_GSO_FRAGLIST feature string
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9oPfKdiVuoDf251VBJXgNs-Hv-HWPnIJk52x-SQc1frfg8QSf9z3rCL-CBSafkp9SO0CjNzU8QvUv9Abe4SvoUpejeob9OImDPbflzRC-0Y=@pm.me>
References: <9oPfKdiVuoDf251VBJXgNs-Hv-HWPnIJk52x-SQc1frfg8QSf9z3rCL-CBSafkp9SO0CjNzU8QvUv9Abe4SvoUpejeob9OImDPbflzRC-0Y=@pm.me>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jun 2020 20:37:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>
Date: Wed, 17 Jun 2020 20:42:47 +0000

> Commit 3b33583265ed ("net: Add fraglist GRO/GSO feature flags") missed
> an entry for NETIF_F_GSO_FRAGLIST in netdev_features_strings array. As
> a result, fraglist GSO feature is not shown in 'ethtool -k' output and
> can't be toggled on/off.
> The fix is trivial.
> 
> Fixes: 3b33583265ed ("net: Add fraglist GRO/GSO feature flags")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Applied and queued up for v5.6 -stable, thank you.
