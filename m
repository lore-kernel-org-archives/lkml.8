Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB8C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CF2206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDTLeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:34:00 -0400
Received: from elvis.franken.de ([193.175.24.41]:48159 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgDTLd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:33:59 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jQUgX-0003x1-00; Mon, 20 Apr 2020 13:33:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 92A36C01A5; Mon, 20 Apr 2020 13:33:36 +0200 (CEST)
Date:   Mon, 20 Apr 2020 13:33:36 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the mips tree
Message-ID: <20200420113336.GA12078@alpha.franken.de>
References: <20200420200744.620c2782@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420200744.620c2782@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:07:44PM +1000, Stephen Rothwell wrote:
> After merging the mips tree, today's linux-next build (mips gpr_defconfig)
> failed like this:
> 
> arch/mips/alchemy/common/setup.c:99:9: error: implicit declaration of function ‘remap_pfn_range’; did you mean ‘io_remap_pfn_range’? [-Werror=implicit-function-declaration]
> 
> Caused by commit
> 
>   d399157283fb ("MIPS: cleanup fixup_bigphys_addr handling")

I've pushed a fix to mips-next branch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
