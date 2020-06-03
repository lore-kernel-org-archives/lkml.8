Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394C420678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiuEXiDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFCSS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:18:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgFCSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591208334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UkKBC6zpB37rxDLDIC+RaxGcnQKeK/Foj3RIordPx/Y=;
        b=LiuEXiDdo7nIMLuNKxS3UVUSAHM0dMvzeoJAbiJtyqH6zbT3hipQMAoN7hMvhHym/wGtiC
        +mxySf+wJTVyHg8xKh5saQlls9TgR/WVDAoGngLSLdHwSg46lOfoeDeGsJgxzKIxJYeekj
        jzgqiz+HPzLrHBUvrDMHVJAu4J65MXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-fmXhd4wzOWqUKzKBFaBrEg-1; Wed, 03 Jun 2020 14:18:50 -0400
X-MC-Unique: fmXhd4wzOWqUKzKBFaBrEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB86C1005510;
        Wed,  3 Jun 2020 18:18:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92BF061169;
        Wed,  3 Jun 2020 18:18:46 +0000 (UTC)
Date:   Wed, 3 Jun 2020 14:18:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dm zoned: fix memory leak of newly allocated zone
 on xa_insert failure
Message-ID: <20200603181845.GA20491@redhat.com>
References: <20200603160254.142222-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603160254.142222-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03 2020 at 12:02pm -0400,
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if an xa_insert fails then there is a memory lead of the
> recently allocated zone object. Fix this by kfree'ing zone before
> returning on the error return path.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 1a311efa3916 ("dm zoned: convert to xarray")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/md/dm-zoned-metadata.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index b23ff090c056..130b5a6d9f12 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -313,8 +313,10 @@ static struct dm_zone *dmz_insert(struct dmz_metadata *zmd,
>  	if (!zone)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (xa_insert(&zmd->zones, zone_id, zone, GFP_KERNEL))
> +	if (xa_insert(&zmd->zones, zone_id, zone, GFP_KERNEL)) {
> +		kfree(zone);
>  		return ERR_PTR(-EBUSY);
> +	}
>  
>  	INIT_LIST_HEAD(&zone->link);
>  	atomic_set(&zone->refcount, 0);
> -- 
> 2.25.1
> 

Thanks, I folded this in.

