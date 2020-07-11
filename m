Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB86C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09B72065D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGKKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgGKKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:49:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97957C08C5DD;
        Sat, 11 Jul 2020 03:49:40 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E7A47C009; Sat, 11 Jul 2020 12:49:38 +0200 (CEST)
Date:   Sat, 11 Jul 2020 12:49:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doug Nazar <nazard@nazar.ca>
Cc:     Christoph Hellwig <hch@lst.de>, ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/9p: validate fds in p9_fd_open
Message-ID: <20200711104923.GA6584@nautica>
References: <20200710085722.435850-1-hch@lst.de>
 <5bee3e33-2400-2d85-080e-d10cd82b0d85@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bee3e33-2400-2d85-080e-d10cd82b0d85@nazar.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Nazar wrote on Fri, Jul 10, 2020:
> On 2020-07-10 04:57, Christoph Hellwig wrote:
> 
> >diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> >index 13cd683a658ab6..1cd8ea0e493617 100644
> >--- a/net/9p/trans_fd.c
> >+++ b/net/9p/trans_fd.c
> >@@ -803,20 +803,28 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
> >  		return -ENOMEM;
> >  	ts->rd = fget(rfd);
> >+	if (!ts->rd)
> >+		goto out_free_ts;
> >+	if (!(ts->rd->f_mode & FMODE_READ))
> >+		goto out_put_wr;
> 
> 		goto out_put_rd;
> 
> unless I'm mistaken.

Good catch, I've amended the commit so feel free to skip resending
unless want to change something
https://github.com/martinetd/linux/commit/28e987a0dc66744fb119e18150188fd8e3debd40

-- 
Dominique
