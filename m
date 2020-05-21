Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C3A20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEUHS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:18:27 -0400
Received: from elvis.franken.de ([193.175.24.41]:32942 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgEUHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:18:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jbfTB-0001b7-00; Thu, 21 May 2020 09:18:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 72FA7C0155; Thu, 21 May 2020 09:17:37 +0200 (CEST)
Date:   Thu, 21 May 2020 09:17:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] MIPS: SGI-IP27: Remove not used definition TICK_SIZE in
 ip27-timer.c
Message-ID: <20200521071737.GD7309@alpha.franken.de>
References: <1589958482-9948-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589958482-9948-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:08:02PM +0800, Tiezhu Yang wrote:
> After commit f5ff0a280201 ("[MIPS] Use generic NTP code for all MIPS
> platforms"), TICK_SIZE is not used in ip27-timer.c for many years,
> remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> Hi Thomas,
> 
> I find this not used definition TICK_SIZE just now, maybe I should send
> these cleanup patches in a patch series, sorry for that if it is noisy.

no problem:-)

>  arch/mips/sgi-ip27/ip27-timer.c | 2 --
>  1 file changed, 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
