Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C291C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFAE2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bn2FT8BM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ix98sw+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCSIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:30:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33573 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:30:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D0CC5C01DC;
        Thu, 19 Mar 2020 04:30:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Mar 2020 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=gajfaTL3PAKHDhRdTc7KNDL7rvV
        RUvBpFsfEaLk0fuQ=; b=bn2FT8BM3J90FCyXgaed34O39nzCV5Iatt61RvHgYfg
        ZcSneD2mrZkSD6GVyieygvphEFFwMtDQruxmF5MFGMlMWJWmJ17VGI675yK9bPxY
        +rHNsmQdwCdCtpOQO8ypUldnsbccZYKyyM11dJKdeDJplCMJ5LkeJcZzJeGaux6k
        m4SDvr2qj+it7khepYU8s78vMndDFcf1eXt8S+euSyn+pXeHDKB/JIciw7RmYljq
        3rVvCTL1lBjYOVap8+tZ2422akHHecRKY6HUVV0EVDTYnIuPKWXeemOtVOsFm8+p
        Db/xnJ2Uy5SMJFY8gUgkuwkQPhOOS4bDstljxrz0LCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gajfaT
        L3PAKHDhRdTc7KNDL7rvVRUvBpFsfEaLk0fuQ=; b=Ix98sw+2aqXclPNpszFS0L
        IvpTHajWKlaz2gXoiHoQuzf6EtRyHQiUnj1jOC+rCSfxfPjT4u3Wm4DfKqSJ0kWz
        FwPcOnu5X3Y/CKq11qtrLcc6JetiRVktZybkb3vnThGsaimUoquu5jhufOhUYfgJ
        Dtc69Z+ab4moPZ6nZHrQpYSZh6z5OCGbMFsA0ylenTVEXQ0Wk4mMgwLFiV0mXT2S
        /Kl+twpAtRiQj1PvH4O1yMeRClJG0ie1Ro/Rj1kffpmo9xg9m3+6YCeAeTd3q2HX
        lYdebdOp/FJ3o7EHgM0FVYixpGFgvCn884cxre4RD/p2W2/zjqRSmDxY6lyyBSWg
        ==
X-ME-Sender: <xms:nC1zXk0FuwzJGkSFf-qQ7H3UEa3cuAnfShR45G3jqscBKHkJzXYrjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:nC1zXkI-Ygiggx3ephSW8hQEoqnepZufl3x3MRxmqLF5NsGzoIbBGA>
    <xmx:nC1zXp4TwmH1ibbA43V6q1XOrIardJjie4GEVhp2eO_uIzu2AUQGAw>
    <xmx:nC1zXrjvGIxiWMTEJQozuJpOeVMe7zhCI7krw47hnGmV8ZjdNYuPzg>
    <xmx:ni1zXrUwoh-X0z4rGEjKLxm7m7uoAnEMD6MX1NUJwJm1AuanAvHLwg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B42CA328005A;
        Thu, 19 Mar 2020 04:30:19 -0400 (EDT)
Date:   Thu, 19 Mar 2020 09:30:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <20200319083018.GB3489391@kroah.com>
References: <20200319144411.47150f3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319144411.47150f3b@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 02:44:11PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/media/allegro-dvt/allegro-core.c
> 
> between commit:
> 
>   cc62c74749a3 ("media: allegro: add missed checks in allegro_open()")
> 
> from the v4l-dvb tree and commit:
> 
>   e3d21cbfa978 ("staging: media: allegro: align with parenthesis")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks good, thanks!

greg k-h
