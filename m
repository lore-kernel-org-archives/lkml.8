Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF10C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B22F2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgG0I6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:58:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0I6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:58:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CAA13AC1D;
        Mon, 27 Jul 2020 08:58:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 857341E12C5; Mon, 27 Jul 2020 10:58:48 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:58:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Mahoney <jeffm@suse.com>, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: reiserfs.h: delete a duplicated word
Message-ID: <20200727085848.GG23179@quack2.suse.cz>
References: <20200720001431.29718-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720001431.29718-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-07-20 17:14:31, Randy Dunlap wrote:
> Drop the repeated word "than" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jeff Mahoney <jeffm@suse.com>
> Cc: reiserfs-devel@vger.kernel.org

Thanks! Applied.

								Honza

> ---
>  fs/reiserfs/reiserfs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/fs/reiserfs/reiserfs.h
> +++ linux-next-20200717/fs/reiserfs/reiserfs.h
> @@ -1109,7 +1109,7 @@ int is_reiserfs_jr(struct reiserfs_super
>   * ReiserFS leaves the first 64k unused, so that partition labels have
>   * enough space.  If someone wants to write a fancy bootloader that
>   * needs more than 64k, let us know, and this will be increased in size.
> - * This number must be larger than than the largest block size on any
> + * This number must be larger than the largest block size on any
>   * platform, or code will break.  -Hans
>   */
>  #define REISERFS_DISK_OFFSET_IN_BYTES (64 * 1024)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
