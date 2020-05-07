Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3CC54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD982078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:39:24 -0400
Received: from elvis.franken.de ([193.175.24.41]:43283 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:39:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jWc3t-0006Ql-01; Thu, 07 May 2020 10:39:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A7B1EC03A8; Thu,  7 May 2020 10:37:37 +0200 (CEST)
Date:   Thu, 7 May 2020 10:37:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove dead code in pci.h
Message-ID: <20200507083737.GA8924@alpha.franken.de>
References: <20200506134250.32550-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506134250.32550-1-yanaijie@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:42:50PM +0800, Jason Yan wrote:
> This code has been marked dead for more than 10 years. Seems no need to
> keep it now.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/mips/include/asm/mach-rc32434/pci.h | 3 ---
>  1 file changed, 3 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
