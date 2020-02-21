Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF170C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7175208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBULdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:33:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgBULdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:33:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 828BFAE07;
        Fri, 21 Feb 2020 11:33:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 30E82DA70E; Fri, 21 Feb 2020 12:33:03 +0100 (CET)
Date:   Fri, 21 Feb 2020 12:33:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the btrfs tree
Message-ID: <20200221113303.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200220092344.2a738574@canb.auug.org.au>
 <20200221113000.GC2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221113000.GC2902@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:30:00PM +0100, David Sterba wrote:
> On Thu, Feb 20, 2020 at 09:23:44AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the btrfs tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > fs/btrfs/extent-tree.c: In function 'btrfs_alloc_logged_file_extent':
> > fs/btrfs/extent-tree.c:4425:20: error: passing argument 1 of 'btrfs_pin_extent' from incompatible pointer type [-Werror=incompatible-pointer-types]
> >  4425 |   btrfs_pin_extent(fs_info, ins->objectid, ins->offset, 1);
> >       |                    ^~~~~~~
> >       |                    |
> >       |                    struct btrfs_fs_info *
> > fs/btrfs/extent-tree.c:2609:49: note: expected 'struct btrfs_trans_handle *' but argument is of type 'struct btrfs_fs_info *'
> >  2609 | int btrfs_pin_extent(struct btrfs_trans_handle *trans,
> >       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
> > 
> > Caused by commit
> > 
> >   4e2c2f96e6a3 ("btrfs: Make btrfs_pin_extent take trans handle")
> > 
> > interacting with commit
> > 
> >   bd727173e443 ("btrfs: handle logged extent failure properly")
> > 
> > from the btrfs-fixes tree.
> > 
> > I have applied the following merge fix patch for today.
> 
> Sorry, I'll fix the branch in the next for-next snapshot.

Actually I can't fix that locally, the next-fixes branch compiles and
for-next also compiles. The merge into linux-next needs to resolve the
conflict, so your fixup will be needed until the next-fixes batch is
merged to master (rc3 or rc4).
