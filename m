Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E89C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C38206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgGXJPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:15:14 -0400
Received: from elvis.franken.de ([193.175.24.41]:47020 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGXJPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:15:14 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jytnL-0002By-00; Fri, 24 Jul 2020 11:15:11 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 713C1C092F; Fri, 24 Jul 2020 11:10:36 +0200 (CEST)
Date:   Fri, 24 Jul 2020 11:10:36 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     huanglllzu@gmail.com, chenhc@lemote.com, Steven.Hill@cavium.com,
        david.daney@cavium.com, jhogan@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] MIPS: OCTEON: add missing put_device() call in
 dwc3_octeon_device_init()
Message-ID: <20200724091036.GA14059@alpha.franken.de>
References: <20200721134718.1277347-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721134718.1277347-1-yukuai3@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:47:18PM +0800, Yu Kuai wrote:
> if of_find_device_by_node() succeed, dwc3_octeon_device_init() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling for this function implementation.
> 
> Fixes: 93e502b3c2d4 ("MIPS: OCTEON: Platform support for OCTEON III USB controller")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  arch/mips/cavium-octeon/octeon-usb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
