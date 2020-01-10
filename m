Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD46C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B39E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbgeDq5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgAJLEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:04:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727670AbgAJLEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578654238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULOVTMVDqAaA1RLSX77fffpqFQaKmKj4WAvS8G6y3qE=;
        b=SbgeDq5p1kxnNkz297l8HUKfFyHonh4szDRrabaJXbcFb5rmJtH28FbcqFXDm3bEK/z7wx
        1iDmzSl1CDpbp9AKIO+S0iMD2FIXR694FMA5aflMfzsudQSSsjGn5zEyZImwUoF0JTcuXy
        BuMDdM3VA9SSmqBY70thpCtYF0PslOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-bOjpQP33O0y0JAu7lB_wGA-1; Fri, 10 Jan 2020 06:03:57 -0500
X-MC-Unique: bOjpQP33O0y0JAu7lB_wGA-1
Received: by mail-wr1-f72.google.com with SMTP id f15so752133wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ULOVTMVDqAaA1RLSX77fffpqFQaKmKj4WAvS8G6y3qE=;
        b=GVLZHykUAlmohB+EdM6cG+wXNjtaWtiWxumuUomSX3nZxw44M/doP1A1qbuDiVCME/
         bYwAAjPorsncO9+h0+6pMAfOn2QUei5JJtHWX3fLLegtu90f0Lx4jbGwD/aN8s0lLsba
         8QQgJ/FpqWTh2blBx6g/OKzL/JhlAseCxo3wIRLQe2GBaxbSabrDRVmfUH8ujbRG8oqZ
         //qabIghFHUoiYny6mQPg9xXUUV8J4txhqioY2wraaOMQojXJYUXs37b8C5ijnO3iniK
         oopBJAnIVdkwFPkHepIHCbtedOYABrQqxbogZ+56AXYS1wxLf+3BjGvxaJzm5d3Wenl7
         HxUg==
X-Gm-Message-State: APjAAAW7UyVZNLbe1wOANtbTx8BLrDnduJWVQJpEHw0CMtRBKvKeMkwL
        t9RAGZrKHD4OG0HHaE7lF5Ty1d6q/60GjPjbXsL+N0vTrEVrbpV0xEf8zCUDVpWzrgYrgrjBruG
        HEicR1pu5J67JrdiTB5f+5MBP
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr3632341wmi.128.1578654236390;
        Fri, 10 Jan 2020 03:03:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxiKRM13Xd1Qan5MRjTjamzFk3V0rFLzaLiX22VRyLN1pQimrtTB1j7dEj52V7YMsGG8cFTA==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr3632307wmi.128.1578654236076;
        Fri, 10 Jan 2020 03:03:56 -0800 (PST)
Received: from orion ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id v3sm1755346wru.32.2020.01.10.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 03:03:55 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:03:53 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20200110110353.klnooeqv4b6ipxid@orion>
Mail-Followup-To: Carlos Maiolino <cmaiolino@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200110175729.3b5d2338@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110175729.3b5d2338@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 05:57:29PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> fs/inode.c:1615:5: error: redefinition of 'bmap'
>  1615 | int bmap(struct inode *inode, sector_t *block)
>       |     ^~~~
> In file included from fs/inode.c:7:
> include/linux/fs.h:2867:19: note: previous definition of 'bmap' was here
>  2867 | static inline int bmap(struct inode *inode,  sector_t *block)
>       |                   ^~~~
> 

Oh, no, that's not the same issue I thought, and the patch applied does have the
dummy function.

/me grabs more coffee...


> ---
>  fs/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9f894b25af2b..590f36daa006 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1598,6 +1598,7 @@ void iput(struct inode *inode)
>  }
>  EXPORT_SYMBOL(iput);
>  
> +#ifdef CONFIG_BLOCK
>  /**
>   *	bmap	- find a block number in a file
>   *	@inode:  inode owning the block number being requested
> @@ -1621,6 +1622,7 @@ int bmap(struct inode *inode, sector_t *block)
>  	return 0;
>  }
>  EXPORT_SYMBOL(bmap);
> +#endif

Eitherway, I am not 100% sure this is the right fix for this case, I remember
some bmap() users who didn't need CONFIG_BLOCK, so we may still need to export
it without CONFIG_BLOCK.
Can you please send me your configuration?

Thanks.





>  
>  /*
>   * With relative atime, only update atime if the previous atime is
> -- 
> 2.24.0
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Carlos

