Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C46C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXQkBIHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbgF3PCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgF3PCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593529374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVqdDUMAVaPMx+jj87jZtZveQ6A0HvSwgZ1JzvOfqMI=;
        b=SXQkBIHOaONiDOCkB5vEgcgLDxyZaSQcdmEUWy0pS+saZgi+GWP675z1GqPFL/uDLDid0a
        JEDxagFqPXUZz4AAdQxGFvpZvStEqCukZ0UcDsffNFqGNZ+yPsP1MRXPQ/hS3MybeZ77uk
        JIe8qKwd3InxRS9wavdsAEHjK41rnmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-lqlA-EagO560bmAOpN5WUQ-1; Tue, 30 Jun 2020 11:02:48 -0400
X-MC-Unique: lqlA-EagO560bmAOpN5WUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C539100CD14;
        Tue, 30 Jun 2020 15:02:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 295CA10016DA;
        Tue, 30 Jun 2020 15:02:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05UF2Jxv024072;
        Tue, 30 Jun 2020 11:02:19 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05UF2Jpw024068;
        Tue, 30 Jun 2020 11:02:19 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 Jun 2020 11:02:19 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dm writecache: reject asynchronous pmem.
In-Reply-To: <20200630145335.1185-1-msuchanek@suse.de>
Message-ID: <alpine.LRH.2.02.2006301101210.24028@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200630133546.GA20439@redhat.com> <20200630145335.1185-1-msuchanek@suse.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jun 2020, Michal Suchanek wrote:

> The writecache driver does not handle asynchronous pmem. Reject it when
> supplied as cache.
> 
> Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

OK. I suggest to move this test before persistent_memory_claim (so that 
you don't try to map the whole device).

Mikulas

> ---
>  drivers/md/dm-writecache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 30505d70f423..1e4f37249e28 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -2271,6 +2271,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  			ti->error = "Unable to map persistent memory for cache";
>  			goto bad;
>  		}
> +
> +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> +			r = -EOPNOTSUPP;
> +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> +			goto bad;
> +		}
>  	} else {
>  		size_t n_blocks, n_metadata_blocks;
>  		uint64_t n_bitmap_bits;
> -- 
> 2.26.2
> 

