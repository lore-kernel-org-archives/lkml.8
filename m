Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75320870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgCCW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:59:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:59:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1EC215A0FF4F;
        Tue,  3 Mar 2020 14:59:16 -0800 (PST)
Date:   Tue, 03 Mar 2020 14:59:16 -0800 (PST)
Message-Id: <20200303.145916.1506066510928020193.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tun: fix ethtool_ops get_msglvl and set_msglvl
 handlers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200303082252.81F7FE1F46@unicorn.suse.cz>
References: <20200303082252.81F7FE1F46@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Mar 2020 14:59:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Tue,  3 Mar 2020 09:22:52 +0100 (CET)

> The get_msglvl and setmsglvl handlers only work as expected if TUN_DEBUG
> is defined (which required editing the source). Otherwise tun_get_msglvl()
> returns -EOPNOTSUPP but as this handler is not supposed to return error
> code, it is not recognized as one and passed to userspace as is, resulting
> in bogus output of ethtool command. The set_msglvl handler ignores its
> argument and does nothing if TUN_DEBUG is left undefined.
> 
> The way to return EOPNOTSUPP to userspace for both requests is not to
> provide these ethtool_ops callbacks at all if TUN_DEBUG is left undefined.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

I agree with your analysis.

But this TUN_DEBUG thing stands outside of what we let drivers do.  Either
this tracing is not so useful and can be deleted, or the tracing should
be available unconditionally so that it can be turned on by the vast
majority of users who do not edit the source.

I suspect making the TUN_DEBUG code unconditional is that way to go here.
