Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51989C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB662076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGJLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:12:49 -0400
Received: from nautica.notk.org ([91.121.71.147]:48350 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgGJLMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:12:49 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A3B2DC009; Fri, 10 Jul 2020 13:12:47 +0200 (CEST)
Date:   Fri, 10 Jul 2020 13:12:32 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/9p: validate fds in p9_fd_open
Message-ID: <20200710111232.GC17924@nautica>
References: <20200710085722.435850-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710085722.435850-1-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote on Fri, Jul 10, 2020:
> p9_fd_open just fgets file descriptors passed in from userspace, but
> doesn't verify that they are valid for read or writing.  This gets
> cought down in the VFS when actually attemping a read or write, but a
> new warning added in linux-next upsets syzcaller.
> 
> Fix this by just verifying the fds early on.
> 
> Reported-by: syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me, I'll pick it up shortly.

-- 
Dominique
