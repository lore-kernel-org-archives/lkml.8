Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC48C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3DE20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SSvyYEEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbgkWDc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgCOIWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 04:22:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54531 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgCOIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 04:22:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6988921F92;
        Sun, 15 Mar 2020 04:22:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 15 Mar 2020 04:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=yhVD4YjMEGo73j5yyKXYwzhDOUL
        Ne+T9MsqpqJ23H20=; b=SSvyYEEK7kUmhyt6/NeE6ekB7FNynWoy0q8Ey2ij6qs
        nyqCsIMtEg6ZmZhZlluyOP+Poxktnz0pV5p1KLcIOBPTsazK6gJeVQCyMvMv4F2v
        mDO2I/l9aeb1xSfAwPZ2oGznIFBecuX/IPP70XRzLM3NmkSnRCZBgXomQ3PYL4eF
        BMJIMUWCXbD3FKCfoLuTEtVSrHBuyPp72Bro53a94SqcVbFLXwWdqigm+ZfWIQGl
        Psq8aS6EDiBZYd37GqFWBYvvABYCM4mgegIaL977+WSeO3NFIqLFcrTwsI0f1OmJ
        nVv2CsVI0UgTibC9RDMFvjItEiMKmeba69IT+tNSa0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yhVD4Y
        jMEGo73j5yyKXYwzhDOULNe+T9MsqpqJ23H20=; b=CbgkWDc0GVHkme2NCpR0fw
        rZl9oCXQ+yVStQk5jDix0zWlkbUTxqeRfumg39TLt7N5ZrsnuV8fINdzNlAIfovu
        t1wL3vqVT4/nILjAU5m0+6P7u/eeX+P8Ib1FOMQHxWwCf55Z9APvKJ5agT+wy/K7
        p3ANltlZAO0L7440vNdDJY+cOQNBWAQ9Fv8Qiaw6Yc3KRYM8eCYUS4U99p8s63Uv
        b8WLG4CV5d6V7umKPWG314HHeUUwjdM0jVoFHjJSVvD+6ENcAJYw4CxKLz8TNo84
        pyTgAqP/mvLU1uT7mS+Ha6kIUEyUrkVbKepLJnZMErentPsoLABMcdIldHo5dJ6w
        ==
X-ME-Sender: <xms:vOVtXrK4JePVYAkT-RQQhwp4CMtoAkPFZZdxJtU6ptHzzPo_kL3JtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeftddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:vOVtXqrZ5m86tdFgm4Qr-q4xO4sVQUIJklK5UU7eO_s0t-iEwkrFXA>
    <xmx:vOVtXqusZXF_2G66ZxV_u8btuU93dWaRB5kDfnu2J9vYuZ97vzkXVg>
    <xmx:vOVtXtUs5ZGpxoQEd4mLLZFRYmLyTDXWXm3rYMEZrrFbSnCO7HZ_gQ>
    <xmx:vOVtXhXwuh7FWggq1LSChDl2lQWhAn-JX07k1ETxhCZfYwJshendfA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F21583060F09;
        Sun, 15 Mar 2020 04:22:19 -0400 (EDT)
Date:   Sun, 15 Mar 2020 09:22:18 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     olga.kornievskaia@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "NFSD fixing possible null pointer derefering in copy
 offload" has been added to the 5.5-stable tree
Message-ID: <20200315082218.GB132056@kroah.com>
References: <20200314003523.A4F1B20753@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314003523.A4F1B20753@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 08:35:22PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     NFSD fixing possible null pointer derefering in copy offload
> 
> to the 5.5-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      nfsd-fixing-possible-null-pointer-derefering-in-copy.patch
> and it can be found in the queue-5.5 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit a264e7b209f248f59b4fee0d1ed3fbde014a942e
> Author: Olga Kornievskaia <olga.kornievskaia@gmail.com>
> Date:   Wed Dec 4 15:13:54 2019 -0500
> 
>     NFSD fixing possible null pointer derefering in copy offload
>     
>     [ Upstream commit 2e577f0faca4640348c398cb85d60a1eedac4b1e ]
>     
>     Static checker revealed possible error path leading to possible
>     NULL pointer dereferencing.
>     
>     Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Fixes: e0639dc5805a: ("NFSD introduce async copy feature")
>     Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 4798667af647c..91b64c15556e6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1223,7 +1223,8 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
>  {
>  	nfs4_free_cp_state(copy);
>  	nfsd_file_put(copy->nf_dst);
> -	nfsd_file_put(copy->nf_src);
> +	if (copy->cp_intra)
> +		nfsd_file_put(copy->nf_src);

And shouldn't this patch just be:
	if (copy->nf_src)
instead?

