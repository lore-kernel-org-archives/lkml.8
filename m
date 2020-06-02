Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6916C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D3720772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCruQkWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFBHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:38:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgFBHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591083489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSlpXWkdenCoS8Vggi65kLvpKKRyegY2MHdYGB2V1Mg=;
        b=YCruQkWo2UsyMXeJOVl9RZ1bdApZs5dhB5PRZnbrVVZpJtbfmbKDfeOrTftTKltF66t+R4
        nSmHVJV2PmfX1yAnKwDpIRPdoo3WFeENz/Bict8RPEn5xf6ku69lHPLoA0hwd/LwK63xqN
        O3zddoNpAH9uI63pdJM0mux0U0t3utA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-1miAQknoOuiCWtiUVJoR4A-1; Tue, 02 Jun 2020 03:38:04 -0400
X-MC-Unique: 1miAQknoOuiCWtiUVJoR4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D127107ACCA;
        Tue,  2 Jun 2020 07:38:03 +0000 (UTC)
Received: from T590 (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE35478EF4;
        Tue,  2 Jun 2020 07:37:56 +0000 (UTC)
Date:   Tue, 2 Jun 2020 15:37:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, wenwen@cs.uga.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] block/bio-integrity: don't free 'buf' if
 bio_integrity_add_page() failed
Message-ID: <20200602073752.GB1384911@T590>
References: <20200601123856.3895734-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601123856.3895734-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 08:38:56PM +0800, yu kuai wrote:
> commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add a
> kree() for 'buf' if bio_integrity_add_page() return '0'. However, the
> object will be freed in bio_integrity_free() since 'bio->bi_opf' and
> 'bio->bi_integrity' was set previousy in bio_integrity_alloc().
> 
> Fixes: commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug")
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  block/bio-integrity.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index bf62c25cde8f..ae07dd78e951 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
>  
>  		if (ret == 0) {
>  			printk(KERN_ERR "could not attach integrity payload\n");
> -			kfree(buf);
>  			status = BLK_STS_RESOURCE;
>  			goto err_end_io;
>  		}

Looks correct, and it relies on the fact the 1st 'page' is always added
successfully, so 'buf' is always attached to the bip since then:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks, 
Ming

