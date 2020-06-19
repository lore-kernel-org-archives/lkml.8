Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0359220809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405482AbgFSQEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:04:15 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:51798 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394225AbgFSQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:04:11 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 2A7C0C0ABA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:04:10 +0100 (IST)
Received: (qmail 28271 invoked from network); 19 Jun 2020 16:04:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Jun 2020 16:04:09 -0000
Date:   Fri, 19 Jun 2020 17:04:07 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs, pseudo: Do not update atime for pseudo inodes
Message-ID: <20200619160407.GL3183@techsingularity.net>
References: <20200617145310.GK3183@techsingularity.net>
 <CAOQ4uxjdTUnA2ACQtyZ95QkTtH_zaKZEYLyok73yjrhuUyXmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjdTUnA2ACQtyZ95QkTtH_zaKZEYLyok73yjrhuUyXmtg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:45:09PM +0300, Amir Goldstein wrote:
> > proxy measure is the proc fd representations of such inodes which do not
> > appear to change once they are created. This patch sets the S_NOATIME
> > on inode->i_flags for inodes created by new_inode_pseudo() so that atime
> > will not be updated.
> >
> 
> new_inode() calls new_inode_pseudo() ...
> You need to factor out a new helper.
> 

You're right, it's broken as it stands. Even though I don't think direct
users of alloc_file_pseudo use simple_getattr, it doesn't matter.

> Either you can provide callers analysis of all new_inode_pseudo() users
> or use a new helper to set S_NOATIME and call it from the relevant users
> (pipe, socket).
> 

Relevant users makes sense as it's less likely to cause surprises.

> How about S_NOCMTIME while you are at it?
> Doesn't file_update_time() show in profiling?

I can look into it, I don't recall seeing file_update_time() in the
profile but maybe it was just too small.

> Is there a valid use case for updating c/mtime of anonymous socket/pipe?
> 

Not that I can think of but that could be a failure of imagination.

-- 
Mel Gorman
SUSE Labs
