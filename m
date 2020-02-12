Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2894DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1932082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgBLQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:03:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:32922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E478AF3E;
        Wed, 12 Feb 2020 16:03:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 204E8DA8DB; Wed, 12 Feb 2020 17:03:42 +0100 (CET)
Date:   Wed, 12 Feb 2020 17:03:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: linux-next: build warning after merge of the btrfs tree
Message-ID: <20200212160341.GL2902@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200212091028.718ca6dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212091028.718ca6dc@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:10:28AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> fs/btrfs/volumes.c: In function 'btrfs_scratch_superblocks':
> fs/btrfs/volumes.c:7338:3: warning: ignoring return value of 'write_one_page', declared with attribute warn_unused_result [-Wunused-result]
>  7338 |   write_one_page(page);
>       |   ^~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   d19ec014a46b ("btrfs: use the page-cache for super block reading")

Known and fix is in the patchset revision that will be in the next
for-next branch update. Thanks.
