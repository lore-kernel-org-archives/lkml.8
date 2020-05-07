Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F89C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E990A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588859058;
	bh=A65o93oA659l57qzQi9fqA4AboQSPcBGUlmqBXf4idw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=0OoqbI5nVar+0w631LiQJvEvK4McICDZyKdXeLY5DaSc75DHGWZualTa/qIfXGCz6
	 pl0uS82yLeD8Bk4fel7EDsqc+zujYec0abMe8kOmFLdczNOcBQ9mwJDvOe7q9wHxUm
	 +h2exZvtJISbuijZuefp++6AkMDwKstv+cfOioD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEGNoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgEGNoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:44:15 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C4720708;
        Thu,  7 May 2020 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588859054;
        bh=A65o93oA659l57qzQi9fqA4AboQSPcBGUlmqBXf4idw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PewNcwmRKjnGMBjIGfgAnKwirjB3T4i2ZPq+UeTHSwJQwbXh5D3eAat83UthrFHFA
         GgU+4LBi8mKBn9RN2Nr2bEr4e6Iui63bMoKOore/wu7ZPocv0QNnLLvHol2uE9KFz0
         aZ0HBjg7k/kb77cVdL71h1LNh5Q0ihWOcrdaVGIE=
Message-ID: <e5839bffe4939c6290d74ca2fb39310bd4916c16.camel@kernel.org>
Subject: Re: [PATCH] ceph: demote quotarealm lookup warning to a debug
 message
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory Farnum <gfarnum@redhat.com>,
        Luis Henriques <lhenriques@suse.com>
Date:   Thu, 07 May 2020 09:44:13 -0400
In-Reply-To: <20200505125902.GA10381@suse.com>
References: <20200505125902.GA10381@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 13:59 +0100, Luis Henriques wrote:
> A misconfigured cephx can easily result in having the kernel client
> flooding the logs with:
> 
>   ceph: Can't lookup inode 1 (err: -13)
> 
> Change his message to debug level.
> 
> Link: https://tracker.ceph.com/issues/44546
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> Hi!
> 
> This patch should fix some harmless warnings when using cephx to restrict
> users access to certain filesystem paths.  I've added a comment to the
> tracker where removing this warning could result (unlikely, IMHO!) in an
> admin to miss not-so-harmless bogus configurations.
> 
> Cheers,
> --
> Luís
> 
>  fs/ceph/quota.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index de56dee60540..19507e2fdb57 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -159,8 +159,8 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
>  	}
>  
>  	if (IS_ERR(in)) {
> -		pr_warn("Can't lookup inode %llx (err: %ld)\n",
> -			realm->ino, PTR_ERR(in));
> +		dout("Can't lookup inode %llx (err: %ld)\n",
> +		     realm->ino, PTR_ERR(in));
>  		qri->timeout = jiffies + msecs_to_jiffies(60 * 1000); /* XXX */
>  	} else {
>  		qri->timeout = 0;
> 

Ilya,

We've had a number of reports where people get a ton of kernel log spam
when they hit this problem. I think we probably ought to mark this patch
for stable and go ahead and send it to Linus for v5.7 -- any objection?

-- 
Jeff Layton <jlayton@kernel.org>

