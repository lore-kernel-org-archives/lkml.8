Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D332074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aixah.de header.i=@aixah.de header.b="F7Rn3/52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgHZQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHZQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:29:11 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE5C061574;
        Wed, 26 Aug 2020 09:29:10 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4BcBBp3DBPzQlWV;
        Wed, 26 Aug 2020 18:29:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aixah.de; s=MBO0001;
        t=1598459344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uSOvEcQaqddPwizXQnRzqoFfD6pthJq2HRRXeaGIx8M=;
        b=F7Rn3/52abVlbiyS+9PvjmJ6SOCVWHECo3aqTkkprLLdU93By4s4UXs/jsBBxN1SoCxXrW
        +ySjwsVnkIOD45Bm5JppLMDrvq7lbscCoVXHdW+x43Wd9H3kAdAVK9iwp9Gf2lVvslwEcf
        nH0yWKaapXuXZv+3fkOYoPmpHUwfwpfO4xbsR0SIPK5wZxNmz71L5sOxUq1VLQv8gGiSSe
        9fSu5FMoMJWSWJvtTLiYZ4Y+ur3Nrq8cWHZKSju1tCbsFgaJGsxl8y+0Oa4eI8Te8dIMds
        fPxhOyUGGiZ4GVQf1IpRn79XYY3IOQoJfDAFiSRkK9glUJ4rGNgpU3EKRduJRw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id X6Skw1EjWZS6; Wed, 26 Aug 2020 18:29:02 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:29:01 +0000
From:   Mira Ressel <aranea@aixah.de>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] veth: Initialize dev->perm_addr
Message-ID: <20200826162901.4js4u5u2whusp4l4@vega>
References: <20200824143828.5964-1-aranea@aixah.de>
 <20200824.102545.1450838041398463071.davem@davemloft.net>
 <20200826152000.ckxrcfyetdvuvqum@vega>
 <20200826.082857.584544823490249841.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826.082857.584544823490249841.davem@davemloft.net>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 5F31466D
X-Rspamd-UID: cce744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 08:28:57AM -0700, David Miller wrote:
> From: Mira Ressel <aranea@aixah.de>
> Date: Wed, 26 Aug 2020 15:20:00 +0000
> 
> > I'm setting the peer->perm_addr, which would otherwise be zero, to its
> > dev_addr, which has been either generated randomly by the kernel or
> > provided by userland in a netlink attribute.
> 
> Which by definition makes it not necessarily a "permanent address" and
> therefore is subject to being different across boots, which is exactly
> what you don't want to happen for automatic address generation.

That's true, but since veth devices aren't backed by any hardware, I
unfortunately don't have a good source for a permanent address. The only
inherently permanent thing about them is their name.

People who use the default eui64-based address generation don't get
persistent link-local addresses for their veth devices out of the box
either -- the EUI64 is derived from the device's dev_addr, which is
randomized by default.

If that presents a problem for anyone, they can configure their userland
to set the dev_addr to a static value, which handily fixes this problem
for both address generation algorithms.

I'm admittedly glancing over one problem here -- I'm only setting the
perm_addr during device creation, whereas userland can change the
dev_addr at any time. I'm not sure if it'd make sense here to update the
perm_addr if the dev_addr is changed later on?

-- 
Regards,
Mira
