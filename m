Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDDC206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDULra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:47:30 -0400
Received: from elvis.franken.de ([193.175.24.41]:49126 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDULr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:47:29 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jQrN7-0003bj-00; Tue, 21 Apr 2020 13:47:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1B5B4C01C5; Tue, 21 Apr 2020 13:46:56 +0200 (CEST)
Date:   Tue, 21 Apr 2020 13:46:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2 2/3] MIPS: Cleanup code about plat_mem_setup()
Message-ID: <20200421114656.GA12375@alpha.franken.de>
References: <1587468238-24032-1-git-send-email-yangtiezhu@loongson.cn>
 <1587468238-24032-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587468238-24032-3-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:23:57PM +0800, Tiezhu Yang wrote:
> In the current code, plat_mem_setup() is called by arch_mem_init() instead
> of setup_arch() and has been declared in asm/bootinfo.h, so modify the code
> comment to reflect the reality and remove the useless duplicate declartion
> in arch/mips/kernel/setup.c.
> 
> Fixes: 2925aba4223f ("[MIPS] Cleanup memory management initialization.")

this isn't a fix, so please no fixes tag.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
