Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE0C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BC6246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1LqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:46:23 -0500
Received: from elvis.franken.de ([193.175.24.41]:42092 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgB1LqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:46:22 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1j7e5y-0008UT-00; Fri, 28 Feb 2020 12:46:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9D8EAC0EC0; Fri, 28 Feb 2020 12:45:44 +0100 (CET)
Date:   Fri, 28 Feb 2020 12:45:44 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ralf@linux-mips.org, paulburton@kernel.org, tglx@linutronix.de,
        sboyd@kernel.org, geert+renesas@glider.be, f4bug@amsat.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: pic32mzda: Drop pointless static qualifier
Message-ID: <20200228114544.GA10905@alpha.franken.de>
References: <20200227070502.106762-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227070502.106762-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:05:02AM +0000, YueHaibing wrote:
> There is no need to have the 'struct device_node *node' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/mips/pic32/pic32mzda/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
