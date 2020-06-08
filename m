Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE933C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31D02076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgFHGOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:14:10 -0400
Received: from verein.lst.de ([213.95.11.211]:35985 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:14:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE28268AFE; Mon,  8 Jun 2020 08:14:05 +0200 (CEST)
Date:   Mon, 8 Jun 2020 08:14:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH] Fix build failure of OCFS2 when TCP/IP is disabled
Message-ID: <20200608061405.GA17366@lst.de>
References: <20200606190827.23954-1-tseewald@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606190827.23954-1-tseewald@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 02:08:26PM -0500, Tom Seewald wrote:
> After commit 12abc5ee7873 ("tcp: add tcp_sock_set_nodelay") and
> commit c488aeadcbd0 ("tcp: add tcp_sock_set_user_timeout"), building the
> kernel with OCFS2_FS=y but without INET=y causes it to fail with:
> 
> ld: fs/ocfs2/cluster/tcp.o: in function `o2net_accept_many':
> tcp.c:(.text+0x21b1): undefined reference to `tcp_sock_set_nodelay'
> ld: tcp.c:(.text+0x21c1): undefined reference to `tcp_sock_set_user_timeout
> '
> ld: fs/ocfs2/cluster/tcp.o: in function `o2net_start_connect':
> tcp.c:(.text+0x2633): undefined reference to `tcp_sock_set_nodelay'
> ld: tcp.c:(.text+0x2643): undefined reference to `tcp_sock_set_user_timeout
> '
> 
> This is due to tcp_sock_set_nodelay() and tcp_sock_set_user_timeout() being
> declared in linux/tcp.h and defined in net/ipv4/tcp.c, which depend on
> TCP/IP being enabled.
> 
> To fix this, make OCFS2_FS depend on INET=y which already requires NET=y.
> 
> Signed-off-by: Tom Seewald <tseewald@gmail.com>

Looks good, and this is the same that I did for nfsd:

Acked-by: Christoph Hellwig <hch@lst.de>
