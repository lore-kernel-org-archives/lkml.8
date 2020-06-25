Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 04:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6202081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 04:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbgFYEwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 00:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389472AbgFYEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 00:52:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD116C061573;
        Wed, 24 Jun 2020 21:52:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0D8B21285667F;
        Wed, 24 Jun 2020 21:52:13 -0700 (PDT)
Date:   Wed, 24 Jun 2020 21:52:09 -0700 (PDT)
Message-Id: <20200624.215209.1396619096930411771.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, kuba@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: bcmgenet: use hardware padding of runt
 frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1593047695-45803-1-git-send-email-opendmb@gmail.com>
References: <1593047695-45803-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jun 2020 21:52:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Wed, 24 Jun 2020 18:14:52 -0700

> Now that scatter-gather and tx-checksumming are enabled by default
> it revealed a packet corruption issue that can occur for very short
> fragmented packets.
> 
> When padding these frames to the minimum length it is possible for
> the non-linear (fragment) data to be added to the end of the linear
> header in an SKB. Since the number of fragments is read before the
> padding and used afterward without reloading, the fragment that
> should have been consumed can be tacked on in place of part of the
> padding.
> 
> The third commit in this set corrects this by removing the software
> padding and allowing the hardware to add the pad bytes if necessary.
> 
> The first two commits resolve warnings observed by the kbuild test
> robot and are included here for simplicity of application.

Series applied, thank you.
