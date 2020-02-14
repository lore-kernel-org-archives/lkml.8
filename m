Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0941EC3B1BD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0742467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RFGYsJLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWVluJ9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbgBNUCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:16 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57589 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389275AbgBNUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5E94B408;
        Fri, 14 Feb 2020 15:02:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 15:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1okpojO4xYlA0j6CifzZLDi+V9+
        mlopXKCZM0KhaRSM=; b=RFGYsJLLY7XERGO7wgMa96FNd66KRG5GnmnSTAN+PbG
        6w5+k9dGuutIpyBLMKHe6hJEDzzV4fkM8hO4GtwX56lDiTx7LSDHkXb/y3yTWpDH
        JnPYieB4eHCsyxxraEbjvHPsavvkCqlAclRWhpuDG1ZqYXO/ApyDcJ4sp8Hh52OD
        PE6MVlrUJ1sEMqVL7FHjynaVCD/vsOytge3y8PDMiCRInqodmiKS3MWu630uPn33
        4OrHAoew5ok3qV8varXP4Ld/mam0/nZjr7pCH4jEWBZ/gg1YL5T4x+p+V3LTtB+S
        WYVqR8MYctqR+8KS870MCdvbKCECkh2xZpuc7NjOR0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1okpoj
        O4xYlA0j6CifzZLDi+V9+mlopXKCZM0KhaRSM=; b=nWVluJ9k8cF0M16tmUQJEn
        739nlisx90479S5C3gXEIxtmEvI6J/jJEed361qm/NZPmfPBvm3RzVyXGs4J1pbq
        u7/SqRaPSJnN5vlFi2k1usqzTYcAkT7AwhpghVkYWxDyF6vS0u8uAqnSPa0Jl5uZ
        CfYKFX88Enxnxgp3YAexqST320kVmhUZ1vg9f4dnCm337DfbZseJJ6Lwm44/1LCB
        mbKPCM6a1QO983Kblb54M1BOjj/RfLA5ubSu+21LlZzIJ91T8ymPVK7c04N81sfb
        p3wgL4kXeJ3BB5JGnaBZnsREcZh6v5ajljZgeFl7wicMrKfvn/cEC9v8CZf57NXg
        ==
X-ME-Sender: <xms:wPxGXpXFd96ZciuCIg-AOeliI3llcwvW9HcUItJSFH2zLa-gbpSpsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepuddvrddvgeeirdehuddrud
    egvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:wPxGXjAgct4uIxPGq3mz32fA8H8CpwF2jh8SN8mmhkMYwIpYLgaKOQ>
    <xmx:wPxGXgkmoveOOViHxzk3Csk0fGhk3duTp824q_ddS-6gxU9oi3BUuA>
    <xmx:wPxGXjRsqSmaS7ySoJvYAinJQJD5I0k8nNxKEUB6BiMWtWNDQHuCdQ>
    <xmx:wfxGXrl8qma4syfAG584BUvaUJWakPoZ3kguY4ftC8aCV1T97SdRsA>
Received: from localhost (unknown [12.246.51.142])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED6D13060C21;
        Fri, 14 Feb 2020 15:02:07 -0500 (EST)
Date:   Fri, 14 Feb 2020 07:30:01 -0800
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 char-misc.current tree
Message-ID: <20200214153001.GA3960639@kroah.com>
References: <20200214105519.70a7f6a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214105519.70a7f6a2@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:55:19AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   95ba79e89c10 ("MAINTAINERS: remove unnecessary ':' characters")
> 
> from the char-misc.current tree and commit:
> 
>   caa6772db4c1 ("Staging: remove wusbcore and UWB from the kernel tree.")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index a9a93de6223c,9a4c715d1e50..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -17118,12 -17089,7 +17113,7 @@@ S:	Maintaine
>   F:	drivers/usb/common/ulpi.c
>   F:	include/linux/ulpi/
>   
> - ULTRA-WIDEBAND (UWB) SUBSYSTEM
> - L:	devel@driverdev.osuosl.org
> - S:	Obsolete
> - F:	drivers/staging/uwb/
> - 
>  -UNICODE SUBSYSTEM:
>  +UNICODE SUBSYSTEM
>   M:	Gabriel Krisman Bertazi <krisman@collabora.com>
>   L:	linux-fsdevel@vger.kernel.org
>   S:	Supported

Thanks for this, I'll handle the merge issue when one of the branches
gets to Linus in a day or so.

greg k-h
