Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70270C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9D7221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738806;
	bh=0j/Gs+HBIfouG9/zhyHY47+RDgMJzkzUWkX/o6OMrro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gQH4mbuGrrpyHHCvwFhW0ME5l0cqs0UvoFgRV7aRATWvMRlY+i7EcCoVJXfAeB1q6
	 bz2ik80BP3DOrhC2ptLevBlmYP99lJOJPt7mSow1hJak9yjMmLWe8rvIEhmmIflm1D
	 lb801jtOz6OAokUoG0p0Vv2uHgQEd7klp8uKfsOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHFSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgHFSbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:31:12 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE27E221E3;
        Thu,  6 Aug 2020 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738630;
        bh=0j/Gs+HBIfouG9/zhyHY47+RDgMJzkzUWkX/o6OMrro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I+OXd6pPB0yUX7nf+Xu+8HYNDCXGzahILClI6a/xnXVm2yFkVypzmMi0jgo6k4KB8
         eyAC++GbawumtRkuQ5JAY0yk4r6DEPb8zZpgDKPLe5xbFORRxFXru59lgOabQCrufM
         g1RnGbbbLaU6CieM3JvArku0QjxQwVa0+LXDrqtE=
Date:   Thu, 6 Aug 2020 11:30:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Qingyu Li <ieatmuttonchuan@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: enforce CAP_NET_RAW for raw sockets When creating
 a raw AF_NFC socket, CAP_NET_RAW needs to be checked first.
Message-ID: <20200806113026.64b7f755@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200806022808.GA17066@oppo>
References: <20200806022808.GA17066@oppo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 10:28:08 +0800 Qingyu Li wrote:

Commit message is required. Perhaps shorten the subject and put more
info here.

> Signed-off-by: Qingyu Li <ieatmuttonchuan@gmail.com>
> ---
>  net/nfc/rawsock.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> index ba5ffd3badd3..c1302b689a98 100644
> --- a/net/nfc/rawsock.c
> +++ b/net/nfc/rawsock.c
> @@ -332,8 +332,11 @@ static int rawsock_create(struct net *net, struct socket *sock,
>  	if ((sock->type != SOCK_SEQPACKET) && (sock->type != SOCK_RAW))
>  		return -ESOCKTNOSUPPORT;
> 
> -	if (sock->type == SOCK_RAW)
> +	if (sock->type == SOCK_RAW){
> +		if (!capable(CAP_NET_RAW))
> +			return -EPERM;
>  		sock->ops = &rawsock_raw_ops;
> +	}

please run checkpatch.pl --strict and fix the issues.

>  	else
>  		sock->ops = &rawsock_ops;
> 
> 
> 

