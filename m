Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96705C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83095206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUTBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:01:51 -0400
Received: from verein.lst.de ([213.95.11.211]:48364 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgDUTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:01:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A51B68C4E; Tue, 21 Apr 2020 21:01:48 +0200 (CEST)
Date:   Tue, 21 Apr 2020 21:01:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421190148.GA26071@lst.de>
References: <20200421154204.252921-1-hch@lst.de> <20200421154204.252921-2-hch@lst.de> <20200421184941.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421184941.GD23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:49:41PM +0100, Al Viro wrote:
> >  	spin_lock(&ctx->csa.register_lock);
> > -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> > +	__spufs_proxydma_info_read(ctx, &info);
> > +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));
> 
> IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
> the damn thing goes through copy_to_user().  Why bother with separate access_ok()
> here?

I have no idea at all, this just refactors the code.
