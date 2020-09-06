Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F120759
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599417720;
	bh=F0mk1QO0HqDSARTtYtap/jH8rSgeDmoL5AM/fRQZRQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xcJK/P4yRst5hngo5Ss5rKtXr4LZQvOnlawHQy9MTgn6bjBNS/aczOwKgE5VDG49y
	 xfdtzcYeBdKWkHddTl4oYR/Vw+IkVLoGadV4jp4lJaUvuy0UEDdYNAQZPuC/rdWJWj
	 LxFIXqQ6hdneYTGlZm0r5XM7e0kT/dEMOdVm1oF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgIFSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbgIFSlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:41:55 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA74120759;
        Sun,  6 Sep 2020 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599417715;
        bh=F0mk1QO0HqDSARTtYtap/jH8rSgeDmoL5AM/fRQZRQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0LSOGShtMWu6ib6qChbBeINrYqL0BHuXV4S3A8cXFMvPC3r4cwXqodmNpjK/bfSga
         SwH969PRX7XlH6fKLz8CV8pWvYRiQ7fmhyHdgsZoOjioq8yEbq0vJF51W+oM8rskYV
         eo9QfjUdhfviKLybhwf3bI0qIETTb8e6qlVtOMko=
Date:   Sun, 6 Sep 2020 11:41:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 0/2] net: two updates related to UDP GSO
Message-ID: <20200906114153.7dccce5d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com>
References: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 14:11:11 +0800 Huazhong Tan wrote:
> There are two updates relates to UDP GSO.
> #1 adds a new GSO type for UDPv6
> #2 adds check for UDP GSO when csum is disable in netdev_fix_features().
> 
> Changes since RFC V2:
> - modifies the timing of setting UDP GSO type when doing UDP GRO in #1.
> 
> Changes since RFC V1:
> - updates NETIF_F_GSO_LAST suggested by Willem de Bruijn.
>   and add NETIF_F_GSO_UDPV6_L4 feature for each driver who support UDP GSO in #1.
>   - add #2 who needs #1.

Please CC people who gave you feedback (Willem). 

I don't feel good about this series. IPv6 is not optional any more.
AFAIU you have some issues with csum support in your device? Can you
use .ndo_features_check() to handle this?

The change in semantics of NETIF_F_GSO_UDP_L4 from "v4 and v6" to 
"just v4" can trip people over; this is not a new feature people 
may be depending on the current semantics.

Willem, what are your thoughts on this?
