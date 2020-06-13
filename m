Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED50DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02A22078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC90Bw3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFMMqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 08:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726045AbgFMMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 08:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592052392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+Y7J3vrIRuhf7w0iQGS/ETC+h7nffRfJNVcZzYTZs4=;
        b=RC90Bw3G/Kif+2pQwKgRvpiqdkvr2zfJcVPtuiga5E2Jb1lLNjF9eAyHGchnctxwK9qWeE
        EtAxNeP73EKKtMT9EJHWwu7FLhYSC1tGJFESZIJH4pgFV30u4X+OjNt6VFu6twzFp1g/We
        G/YGjcLlNknJE8qXIMHDTA+IUKCMVbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-pPlHBF-cM0egzexvr-uTdA-1; Sat, 13 Jun 2020 08:46:21 -0400
X-MC-Unique: pPlHBF-cM0egzexvr-uTdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0444E1883600;
        Sat, 13 Jun 2020 12:46:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D5D67FD0A;
        Sat, 13 Jun 2020 12:46:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05DCkDsr028099;
        Sat, 13 Jun 2020 08:46:13 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05DCkDLL028095;
        Sat, 13 Jun 2020 08:46:13 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 13 Jun 2020 08:46:13 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm writecache: skip writecache_wait when using pmem
 mode
In-Reply-To: <20200612155544.90348-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.2006130845530.27500@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200612155544.90348-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jun 2020, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> The array bio_in_progress is only used with ssd mode. So skip
> writecache_wait_for_ios in writecache_discard when pmem mode.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-writecache.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 66f3a3b..4367cc7 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -849,8 +849,10 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
>  
>  		if (likely(!e->write_in_progress)) {
>  			if (!discarded_something) {
> -				writecache_wait_for_ios(wc, READ);
> -				writecache_wait_for_ios(wc, WRITE);
> +				if (!WC_MODE_PMEM(wc)) {
> +					writecache_wait_for_ios(wc, READ);
> +					writecache_wait_for_ios(wc, WRITE);
> +				}
>  				discarded_something = true;
>  			}
>  			writecache_free_entry(wc, e);
> -- 
> 1.8.3.1
> 

