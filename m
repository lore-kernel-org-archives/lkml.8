Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425BA207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fd75T1FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgHZTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgHZTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598471601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTZBfQJrZmGoOihET1Kwf2wGDuCL4pavAJzlhd2obj8=;
        b=Fd75T1FCRJYv7NasWwkOFUNhoXBot2Vfy0viot5CJZQbfLNWpiC17ydU1DtoMvjL8EWUZV
        1IVtyCLCk0Glzj9Qur3bz4DFeA8sYz7TfCgm87kcOtDAAjfmBmX8chpHNvdy07vjFz1pwC
        bD6i2IblAx3oPE2vWE0Lqwgrj/VUiQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-F0p-GF9QNC20GO3wYDSSDA-1; Wed, 26 Aug 2020 15:53:19 -0400
X-MC-Unique: F0p-GF9QNC20GO3wYDSSDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2139E1074646;
        Wed, 26 Aug 2020 19:53:18 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-36.rdu2.redhat.com [10.10.115.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53B8719C58;
        Wed, 26 Aug 2020 19:53:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A14A6223C69; Wed, 26 Aug 2020 15:53:11 -0400 (EDT)
Date:   Wed, 26 Aug 2020 15:53:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
Message-ID: <20200826195311.GB1043442@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com>
 <20200826173408.GA11480@stefanha-x1.localdomain>
 <20200826191711.GF3932@work-vm>
 <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:26:29PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 26, 2020 at 9:17 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> 
> > Agreed, because there's not much that the server can do about it if the
> > client would like a smaller granularity - the servers granularity might
> > be dictated by it's mmap/pagesize/filesystem.  If the client wants a
> > larger granularity that's it's choice when it sends the setupmapping
> > calls.
> 
> What bothers me is that the server now comes with the built in 2MiB
> granularity (obviously much larger than actually needed).
> 
> What if at some point we'd want to reduce that somewhat in the client?
>   Yeah, we can't.   Maybe this is not a kernel problem after all, the
> proper thing would be to fix the server to actually send something
> meaningful.

Hi Miklos,

Current implementation of virtiofsd reports this map alignment as
PAGE_SIZE.

        /* This constraint comes from mmap(2) and munmap(2) */
        outarg.map_alignment = ffsl(sysconf(_SC_PAGE_SIZE)) - 1;

Which should be 4K on x86. 

And that means if client wants it can drop to dax mapping size as
small as 4K and still meeting alignment constratints. Just that by
default we have chosen 2MB as of now fearing there might be too
many small mmap() calls on host and we will hit various limits.

Thanks
Vivek

