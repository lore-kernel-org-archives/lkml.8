Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFCEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695E8206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGwjW1BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgIHQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:12:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731204AbgIHQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599581103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sn9YyaxDlmem+Af35OWOD/fQH327GLoTO2uCzA73Adk=;
        b=bGwjW1BPPiw5JflD5MjOQHFFObFNKDLmoJebD10Sy99PzoSyE9SOxLIosl1yFSBMmIeQkj
        6PU2HcB4Adon+SG1E9/oZ+VlyF/klApjWztQEtitzp9g1reSeFSk9HXxxinOc8sKUFTQ7q
        n3dOZFx0AaSEtssKDRPe7cGrF5bPLm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Ic_nwVryMe-TVrW6fRwG2Q-1; Tue, 08 Sep 2020 09:50:56 -0400
X-MC-Unique: Ic_nwVryMe-TVrW6fRwG2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B221801AE0;
        Tue,  8 Sep 2020 13:50:55 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-76.rdu2.redhat.com [10.10.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC1C319728;
        Tue,  8 Sep 2020 13:50:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1F095223B13; Tue,  8 Sep 2020 09:50:51 -0400 (EDT)
Date:   Tue, 8 Sep 2020 09:50:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dan Williams <dan.j.williams@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200908135051.GC69769@redhat.com>
References: <20200908200950.1368e71b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908200950.1368e71b@canb.auug.org.au>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:09:50PM +1000, Stephen Rothwell wrote:

[..]
> fs/fuse/virtio_fs.c: In function 'virtio_fs_setup_dax':
> fs/fuse/virtio_fs.c:838:9: error: 'struct dev_pagemap' has no member named 'res'; did you mean 'ref'?
>   838 |  pgmap->res = (struct resource){
>       |         ^~~
>       |         ref
> 
> Caused by commit
> 
>   b3e022c5a68c ("mm/memremap_pages: convert to 'struct range'")
> 
> interacting with commit
> 
>   9e2369c06c8a ("xen: add helpers to allocate unpopulated memory")
> 
> from Linus' tree (in v5.9-rc4) and commit
> 
>   7e833303db20 ("virtiofs: set up virtio_fs dax_device")
> 
> from the fuse tree.
> 
> I have added the following patch which may require more work but at
> least makes it all build.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 8 Sep 2020 20:00:20 +1000
> Subject: [PATCH] merge fix up for "mm/memremap_pages: convert to 'struct
>  range'"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/xen/unpopulated-alloc.c | 15 +++++++++------
>  fs/fuse/virtio_fs.c             |  3 +--
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 

[..]
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index da3ede268604..8f27478497fa 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -835,8 +835,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	 * initialize a struct resource from scratch (only the start
>  	 * and end fields will be used).
>  	 */
> -	pgmap->res = (struct resource){
> -		.name = "virtio-fs dax window",
> +	pgmap->range = (struct range){
>  		.start = (phys_addr_t) cache_reg.addr,
>  		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
>  	};

Thanks Stephen. This change looks good to me for virtiofs.

Thanks
Vivek

