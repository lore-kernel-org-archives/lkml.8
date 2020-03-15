Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20395C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC98F20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Tu4JVj2J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yWILtzst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCOIUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 04:20:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38297 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgCOIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 04:20:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DF1C22008;
        Sun, 15 Mar 2020 04:20:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 15 Mar 2020 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=CQ+GvYs0LDsmdDRzwMbYtJv65jo
        EUCG8pU4OhDjX4vI=; b=Tu4JVj2JzjOKYg/rggITeUkqfNOCrQwQded8ZFDUUis
        rr2hLSaSzncOY68UQG6YuSnhU9rONiE8rD7C0UofqE732xuCzWS+HPYHrXC11B/V
        H05ctiCBF6V26crk/SeNa62cf/nknqAd0NcplgNZfBdlznGjlf78E5rno66Tp9jq
        wF2f1MyHqCWVFTOL4A9/whGorppF9jYV83Dwy4OPE67X1KTz64Np4QoBLnTyv3cs
        VP3fLbC9jpMX9O1qsPIkfdbwWV1DGdkwvAwEh3Z4+fDAaN3ohpCI2uoFazKDBbd0
        dE8zMT+yzdB1uzbc5GGS6DyBHCTtpYb7H+0RDbudFGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CQ+GvY
        s0LDsmdDRzwMbYtJv65joEUCG8pU4OhDjX4vI=; b=yWILtzstb1hJp2Cud3FHY+
        xn4dQvrX/qKYqM7tyakTB+ovZotpUowrP1kVhy3NY4mTHhEiRixzp+LZvHw/jndQ
        RAkt3OhHlz2vCTRI3Y0yzXmDNK+PE5EvQNUnJ6Evi/3Bn8d5dHO1hS8USOZetjuY
        IzwNU21eZlekugue8OD/GkEM78lPmk4JaiG6OCRaNobk0tiwI6Xz0aI7+k0Ednbs
        MBGNdpkXfAuqHPJnc7pU8GDXrgjK/+ut3ZIo0nfRzxLwF8sP9GMEkJ6j9XmxWhdx
        eQIv2u42fg0agXvENz9N1RaDKU01rjNQkwOZigXdAMK1EIb2qDud9eumsv/HXRDQ
        ==
X-ME-Sender: <xms:V-VtXn2kGo8ft3goSSLvRA3D8lD9YPt6KJf9fJXYkHZuE4NNwKrvCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeftddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:V-VtXsAvCfYaxyF3H42qS29Yj_WlOw1X-hbPp1K2diCWnh1lmL37Kg>
    <xmx:V-VtXliNcLcutMpDgj3IBjEyK7OCwAwJufN0xjzDrMVrjgEsA6EIYg>
    <xmx:V-VtXrp4n5JS-c2KisL0zaGedvDI0aIxJri1powYfHccmnudybsxyQ>
    <xmx:V-VtXp6WU3SmWxlF36IxArPOgCQkaOmZGhpAF9BxEedj5ewU2pLZaA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8EFF328005D;
        Sun, 15 Mar 2020 04:20:38 -0400 (EDT)
Date:   Sun, 15 Mar 2020 09:20:36 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     olga.kornievskaia@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "NFSD fixing possible null pointer derefering in copy
 offload" has been added to the 5.5-stable tree
Message-ID: <20200315082036.GA132056@kroah.com>
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
>  	spin_lock(&copy->cp_clp->async_lock);
>  	list_del(&copy->copies);
>  	spin_unlock(&copy->cp_clp->async_lock);

This breaks the build here, and in 5.4, so I'll go drop it from both
trees :(

thanks,

greg k-h
