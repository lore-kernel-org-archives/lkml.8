Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78662C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6B20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgEDSU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729958AbgEDSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:20:57 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33846C061A0E;
        Mon,  4 May 2020 11:20:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C311711F5F61A;
        Mon,  4 May 2020 11:20:56 -0700 (PDT)
Date:   Mon, 04 May 2020 11:20:56 -0700 (PDT)
Message-Id: <20200504.112056.1400711844642835898.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: Report speed and duplex as unknown when device is
 runtime suspended
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200504173218.1724-1-kai.heng.feng@canonical.com>
References: <20200504173218.1724-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 May 2020 11:20:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue,  5 May 2020 01:32:18 +0800

> igb device gets runtime suspended when there's no link partner. We can't
> get correct speed under that state:
> $ cat /sys/class/net/enp3s0/speed
> 1000
> 
> In addition to that, an error can also be spotted in dmesg:
> [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
> 
> Since device can only be runtime suspended when there's no link partner,
> we can directly report the speed and duplex as unknown.
> 
> The more generic approach will be wrap get_link_ksettings() with begin()
> and complete() callbacks. However, for this particular issue, begin()
> calls igb_runtime_resume() , which tries to rtnl_lock() while the lock
> is already hold by upper ethtool layer.
> 
> So let's take this approach until the igb_runtime_resume() no longer
> needs to hold rtnl_lock.
> 
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'm assuming I will get this from upstream via Jeff K.
