Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E196FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8074206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjrvZ3+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgEMKbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:31:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50511 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgEMKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:31:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 448A65C00BC;
        Wed, 13 May 2020 06:31:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 May 2020 06:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=j0g83N
        IEHiipiQgYyDDRZc71uODT2YrU4dc1Zjf2a/8=; b=bjrvZ3+hSsatu1j9KkuhVD
        yXwKpC3TUhj4dmS2DTTGYl7oQHnfTVGJLaxwVak8ZXO2UpItAFmlTrCHuXrMO48l
        7Bxs/SHAFu+YruV+HJl2/8erODBnGYM6AcE8N+zEEfQs72cwifl042+dTCEFICHA
        KpEKEfLVNyb6CLGunW5s7H8fvhcmzjifkGbzdd82jRePgUC+t4iLeRQlkHXwsdwa
        uG6PUmBqi6Dq8yxe0Y9q7Ig+sLAZvHv1etenM7AZ3bNYTpW4s7RSgU4VCei5RX28
        Sb4H9Idm6UdKaQRDLTzVyK2z4zoOkKrMjp2pgqrM0QlvGYaAMnep6sjRl/JSh+pw
        ==
X-ME-Sender: <xms:kcy7XkiqyH6e1h_3b7NEZDe3bNB6_dbNquzLYjzQoEmB11R1jyPRmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnheptdffkeekfeduffevgeeujeffjefhtefgueeugfevtdeiheduueeukefhudehleet
    necukfhppeejledrudejiedrvdegrddutdejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:kcy7XtBMw_bpZEB6ljIQdoLke-sx_p-AfiAVidUveOp1qXIHNSrbGQ>
    <xmx:kcy7XsHsSq_GxxkSkJeuiK55Qb9iiny_S6rm-Wo8iWvkdrbutrGFcg>
    <xmx:kcy7XlSga9gJF4e7rP4pqzz5HmJXrAun-1Zf-D-ps4nO34yq3R96bg>
    <xmx:ksy7XvaA5mBcNWRytLaND3aAMU1qKhbD9_DI8RHD2nKQh1Zl5oNDgw>
Received: from localhost (bzq-79-176-24-107.red.bezeqint.net [79.176.24.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5DD433066314;
        Wed, 13 May 2020 06:31:45 -0400 (EDT)
Date:   Wed, 13 May 2020 13:31:43 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net/scm: cleanup scm_detach_fds
Message-ID: <20200513103143.GA599365@splinter>
References: <20200511115913.1420836-1-hch@lst.de>
 <20200511115913.1420836-3-hch@lst.de>
 <20200513092918.GA596863@splinter>
 <20200513094908.GA31756@lst.de>
 <20200513095811.GA598161@splinter>
 <20200513101037.GA1143@lst.de>
 <20200513101751.GA1454@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513101751.GA1454@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:17:51PM +0200, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 12:10:37PM +0200, Christoph Hellwig wrote:
> > Ok.  I'll see what went wrong for real and will hopefully have a
> > different patch for you in a bit.
> 
> Can you try this patch instead of the previous one?

Works. Thanks a lot!

> 
> diff --git a/net/core/scm.c b/net/core/scm.c
> index a75cd637a71ff..875df1c2989db 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -307,7 +307,7 @@ static int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
>  		sock_update_classid(&sock->sk->sk_cgrp_data);
>  	}
>  	fd_install(new_fd, get_file(file));
> -	return error;
> +	return 0;
>  }
>  
>  static int scm_max_fds(struct msghdr *msg)
