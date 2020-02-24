Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA016C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBXOev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:34:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:46350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgBXOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:34:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E1D3AD2B;
        Mon, 24 Feb 2020 14:34:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C05C5DA727; Mon, 24 Feb 2020 15:34:29 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:34:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: linux-next: build warning after merge of the btrfs tree
Message-ID: <20200224143429.GR2902@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200224095735.179fe582@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224095735.179fe582@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:57:35AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> fs/btrfs/check-integrity.c: In function 'btrfsic_process_superblock_dev_mirror':
> fs/btrfs/check-integrity.c:916:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   916 |  return ret;
>       |         ^~~
> 
> Introduced by commit
> 
>   5a03d907a555 ("btrfs: remove buffer_heads form super block mirror integrity checking")
> 
> I think this is not a false positive since ret is only assigned is a
> "goto out" is executed.

Yes that sounds correct, will be fixed in next update, thanks.
