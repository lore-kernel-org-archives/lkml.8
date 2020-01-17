Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FA4C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270F92072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAQQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:24:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:42184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:24:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83812AC44;
        Fri, 17 Jan 2020 16:24:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2026BDA871; Fri, 17 Jan 2020 17:24:09 +0100 (CET)
Date:   Fri, 17 Jan 2020 17:24:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build warnings after merge of the btrfs tree
Message-ID: <20200117162409.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200115093004.1a4a6794@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115093004.1a4a6794@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:30:04AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:
> 
> fs/btrfs/block-group.c: In function 'exclude_super_stripes':
> fs/btrfs/block-group.c:1706:5: warning: 'logical' may be used uninitialized in this function [-Wmaybe-uninitialized]
>  1706 |     kfree(logical);
>       |     ^~~~~~~~~~~~~~
> fs/btrfs/block-group.c:1691:20: warning: 'stripe_len' may be used uninitialized in this function [-Wmaybe-uninitialized]
>  1691 |    if (logical[nr] + stripe_len <= cache->start)
>       |        ~~~~~~~~~~~~^~~~~~~~~~~~
> 
> Introduced by commit
> 
>   767f58cdaf20 ("btrfs: Refactor btrfs_rmap_block to improve readability")
> 
> btrfs_rmap_block() returns zero even if its output arguments are not
> assigned to ... maybe the final "return 0" should be "return ret"?

Yes that's it, thanks. Updated for-next branch pushed.
