Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F3CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A3A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgEMKR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:17:56 -0400
Received: from verein.lst.de ([213.95.11.211]:45564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgEMKRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:17:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 93B3E68C65; Wed, 13 May 2020 12:17:52 +0200 (CEST)
Date:   Wed, 13 May 2020 12:17:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net/scm: cleanup scm_detach_fds
Message-ID: <20200513101751.GA1454@lst.de>
References: <20200511115913.1420836-1-hch@lst.de> <20200511115913.1420836-3-hch@lst.de> <20200513092918.GA596863@splinter> <20200513094908.GA31756@lst.de> <20200513095811.GA598161@splinter> <20200513101037.GA1143@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513101037.GA1143@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:10:37PM +0200, Christoph Hellwig wrote:
> Ok.  I'll see what went wrong for real and will hopefully have a
> different patch for you in a bit.

Can you try this patch instead of the previous one?

diff --git a/net/core/scm.c b/net/core/scm.c
index a75cd637a71ff..875df1c2989db 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -307,7 +307,7 @@ static int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
 	fd_install(new_fd, get_file(file));
-	return error;
+	return 0;
 }
 
 static int scm_max_fds(struct msghdr *msg)
