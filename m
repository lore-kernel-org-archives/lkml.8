Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E184C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3DF206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="0CJQJp/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CK//fHRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgFGIkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 04:40:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56273 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgFGIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 04:40:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 460045C00A9;
        Sun,  7 Jun 2020 04:40:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 07 Jun 2020 04:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        LEdB9Bo5hxAS0lxQEDRgkwN6u4BWFSF7qj8zTu/DWjs=; b=0CJQJp/F9XO0FSzM
        HoEgDzmwDAlTDgJCypTbAfBykPi7NCxAIK7l9rC3C9o3hAh02uZlQsce0Nw3+sqX
        IjqlDEXwBT2lm4hhhW5D89ZEoMXXkvxrLAI19jcUpFLbLQNyGm8CuCTl2h2raEBq
        s3oebkhq2YuiafZXyS4hPDz9F/K2vLODhngsh89nGn1W5TXS5jNu8VwIDugCKeBa
        FPvxoigJNs8XiWDOhU2tW/HvBFa7GxBkbwlgUhGGITMbuMaguzfDGFdbpJVeGUV7
        cjLN2fCvKDsY84bjNh9bCBTvv0UuK1uPeEHsDoVg3I76RPHml8d0VU6Bz+xMiKES
        YEiNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=LEdB9Bo5hxAS0lxQEDRgkwN6u4BWFSF7qj8zTu/DW
        js=; b=CK//fHRnUtyzutf/dnr25BBM7kKSuEX3QTp3YsfcPDR3a13xwQaCceD0w
        dHahxYVa1uaZdVpM81J+XgNmpd1ZRHerq4rnFmQDfvZil3/60xgMChltn6p0BRKP
        S7swEmiAX+FKk1uv9FLRm2CyESB517nfNo1gIIYvS4vTLGuvm0sVdjLPu5n7dUqu
        Ec5ipRM0lH8NnjnNyciErH+F06pXLioe9xlnUA+/CeHAQxefG/dBhG8Y8jqriT31
        cCSxM1SNK8m7HRruNYuW7AE5OgBqeUks4Xqq9KCCB7YCXgYBCrUzg+GbCm5bAn/s
        UtvuDlrngulIkN4oEWRL6gj/6VKdA==
X-ME-Sender: <xms:CajcXhsyxS7y1RMPqi1Y2U2HU3PBnkGMaNe5XTWqeZ88o-6PWhDOQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepheekrdejrddvvddtrdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:CajcXqez1PdZemylizuJKcu4dPJeyGYuN0xvjzfNXGNFWdYTMo7fJg>
    <xmx:CajcXkzgTAYoi410hVtROe7hKpYG64OtMf2nxXPFjhBgZNLbKxx8jg>
    <xmx:CajcXoM0M7P7HGgOSgk823yedy2gVqoKpz6_rsEb1BAvmImonuS8OQ>
    <xmx:C6jcXknutgXrzIFXkxfV4htF6QotfJ9KUeeDkAo7_MkPwTMhIC4aiA>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29791328005A;
        Sun,  7 Jun 2020 04:40:37 -0400 (EDT)
Message-ID: <36e2d782d1aea1cfbe17f3bfee35f723f2f89c0d.camel@themaw.net>
Subject: Re: [PATCH 1/4] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        l Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 07 Jun 2020 16:40:33 +0800
In-Reply-To: <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
         <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 2020-05-25 at 13:47 +0800, Ian Kent wrote:
> @@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path,
> struct kstat *stat,
>  	struct inode *inode = d_inode(path->dentry);
>  	struct kernfs_node *kn = inode->i_private;
>  
> -	mutex_lock(&kernfs_mutex);
> +	down_read(&kernfs_rwsem);
>  	kernfs_refresh_inode(kn, inode);
> -	mutex_unlock(&kernfs_mutex);
> +	up_read(&kernfs_rwsem);
>  
>  	generic_fillattr(inode, stat);
>  	return 0;
> @@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode,
> int mask)
>  
>  	kn = inode->i_private;
>  
> -	mutex_lock(&kernfs_mutex);
> +	down_read(&kernfs_rwsem);
>  	kernfs_refresh_inode(kn, inode);
> -	mutex_unlock(&kernfs_mutex);
> +	up_read(&kernfs_rwsem);
>  
>  	return generic_permission(inode, mask);
>  }

I changed these from a write lock to a read lock late in the
development.

But kernfs_refresh_inode() modifies the inode so I think I should
have taken the inode lock as well as taking the read lock.

I'll look again but a second opinion (anyone) would be welcome.

Ian

