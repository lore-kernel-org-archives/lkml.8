Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18845C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06BC20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG8sSY4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAPOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:54:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgAPOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579186447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GewXvgai6oYcv5uu5jT3XLWaUiemLMNm2W6ZLR1T1ko=;
        b=aG8sSY4+zI3lQCmsdSONFAHt8OAveSex062ihLxh7nqGrJz+W9mQThVs3hAk8IPNgVjUiv
        AO7sw2WQgebn0X2aSx+fk99TG8wxmp0VN5wy4ZoXtBdS7lJPAEusbfIjdUCQDYjQfAzSxN
        G42nDomSqXYsFx9LbWlLHdbD+Lz1sFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-KoBNpf3IMQSxaLPYFvWuOw-1; Thu, 16 Jan 2020 09:54:05 -0500
X-MC-Unique: KoBNpf3IMQSxaLPYFvWuOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5406CA0CC2;
        Thu, 16 Jan 2020 14:54:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F8455DA60;
        Thu, 16 Jan 2020 14:54:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id ABB94220A24; Thu, 16 Jan 2020 09:54:03 -0500 (EST)
Date:   Thu, 16 Jan 2020 09:54:03 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     dan.j.williams@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
Message-ID: <20200116145403.GB25291@redhat.com>
References: <20200106181117.GA16248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106181117.GA16248@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> and it can easily use dax_get_by_host() instead.
> 
> IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> the same purpose and hence it looks like fs_dax_get_by_host() is not
> needed anymore.
>  
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Hi Dan,

Ping for this patch. How does it look to you. If you don't have concerns,
can you please take it in your tree.

Thanks
Vivek

> ---
>  drivers/dax/super.c |    2 +-
>  include/linux/dax.h |   10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> Index: rhvgoyal-linux-fuse/drivers/dax/super.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/drivers/dax/super.c	2020-01-03 11:19:57.616186062 -0500
> +++ rhvgoyal-linux-fuse/drivers/dax/super.c	2020-01-03 11:20:08.941186062 -0500
> @@ -61,7 +61,7 @@ struct dax_device *fs_dax_get_by_bdev(st
>  {
>  	if (!blk_queue_dax(bdev->bd_queue))
>  		return NULL;
> -	return fs_dax_get_by_host(bdev->bd_disk->disk_name);
> +	return dax_get_by_host(bdev->bd_disk->disk_name);
>  }
>  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
>  #endif
> Index: rhvgoyal-linux-fuse/include/linux/dax.h
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2020-01-03 11:20:05.603186062 -0500
> +++ rhvgoyal-linux-fuse/include/linux/dax.h	2020-01-03 11:20:08.942186062 -0500
> @@ -129,11 +129,6 @@ static inline bool generic_fsdax_support
>  			sectors);
>  }
>  
> -static inline struct dax_device *fs_dax_get_by_host(const char *host)
> -{
> -	return dax_get_by_host(host);
> -}
> -
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  	put_dax(dax_dev);
> @@ -160,11 +155,6 @@ static inline bool generic_fsdax_support
>  	return false;
>  }
>  
> -static inline struct dax_device *fs_dax_get_by_host(const char *host)
> -{
> -	return NULL;
> -}
> -
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  }

