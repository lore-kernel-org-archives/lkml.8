Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EAC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4A520731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCgeodhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD2MXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:23:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgD2MXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588163013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9+wT3J9tc1Yx0D3CddYx87MnOuJxaf9qh3qg4rBhso=;
        b=gCgeodhdiPhDkHYGBCASnJxMn17zy6KX5G+1mo8w1x7VlPgxXCjCnGcp6UpCFGqF7w7v+J
        qFl5PSNM071zl2USdVC8fZQwL/SXmV2S2L34jh6VIwYLBlKZsrVyLVGrlrsj2HZKEuoJy+
        2NC+5LQkjxNs2fuIJUWfHKtLT9fDq7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-RW2kRNRNObqk4EpI2qBYJg-1; Wed, 29 Apr 2020 08:23:32 -0400
X-MC-Unique: RW2kRNRNObqk4EpI2qBYJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C443F107ACCA;
        Wed, 29 Apr 2020 12:23:30 +0000 (UTC)
Received: from [192.168.1.10] (unknown [10.40.193.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9365D9E5;
        Wed, 29 Apr 2020 12:23:23 +0000 (UTC)
Subject: Re: [dm-devel] [PATCH -next] md: dm-ebs-target: fix build errors &
 Kconfig entry
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Cc:     Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>
References: <d33b3bfb-c38d-9770-e6a6-929519dc21d4@infradead.org>
From:   Heinz Mauelshagen <heinzm@redhat.com>
Message-ID: <980b6b95-6e18-40ff-f71c-058917c5b6ee@redhat.com>
Date:   Wed, 29 Apr 2020 14:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d33b3bfb-c38d-9770-e6a6-929519dc21d4@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/20 5:03 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors by selecting DM_BUFIO.
>
> Fix Kconfig entry formatting by using tabs instead of spaces,
> using "help" instead of "---help---", and
> indenting help text with one additional space.
>
> Fixes these build errors:
>
> ld: drivers/md/dm-ebs-target.o: in function `__ebs_forget_bio':
> dm-ebs-target.c:(.text+0x1bc): undefined reference to `dm_bufio_forget'
> ld: drivers/md/dm-ebs-target.o: in function `ebs_dtr':
> dm-ebs-target.c:(.text+0x2fe): undefined reference to `dm_bufio_client_destroy'
> ld: drivers/md/dm-ebs-target.o: in function `__ebs_rw_bio':
> dm-ebs-target.c:(.text+0x4c4): undefined reference to `dm_bufio_get_block_size'
> ld: dm-ebs-target.c:(.text+0x4f1): undefined reference to `dm_bufio_read'
> ld: dm-ebs-target.c:(.text+0x504): undefined reference to `dm_bufio_get_block_size'
> ld: dm-ebs-target.c:(.text+0x519): undefined reference to `dm_bufio_new'
> ld: dm-ebs-target.c:(.text+0x567): undefined reference to `dm_bufio_mark_partial_buffer_dirty'
> ld: dm-ebs-target.c:(.text+0x56f): undefined reference to `dm_bufio_release'
> ld: drivers/md/dm-ebs-target.o: in function `__ebs_process_bios':
> dm-ebs-target.c:(.text+0x6bf): undefined reference to `dm_bufio_prefetch'
> ld: dm-ebs-target.c:(.text+0x72d): undefined reference to `dm_bufio_prefetch'
> ld: dm-ebs-target.c:(.text+0x783): undefined reference to `dm_bufio_prefetch'
> ld: dm-ebs-target.c:(.text+0x7fe): undefined reference to `dm_bufio_write_dirty_buffers'
> ld: drivers/md/dm-ebs-target.o: in function `ebs_ctr':
> dm-ebs-target.c:(.text+0xa82): undefined reference to `dm_bufio_client_create'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heinz Mauelshagen <dm-devel@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> ---
>   drivers/md/Kconfig |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> --- linux-next-20200428.orig/drivers/md/Kconfig
> +++ linux-next-20200428/drivers/md/Kconfig
> @@ -338,12 +338,12 @@ config DM_WRITECACHE
>   	   to be cached in standard RAM.
>   
>   config DM_EBS
> -       tristate "Emulated block size target (EXPERIMENTAL)"
> -       depends on BLK_DEV_DM
> -       default n
> -       ---help---
> -	 dm-ebs emulates smaller logical block size on backing devices
> -	 with larger ones (e.g. 512 byte sectors on 4K native disks).
> +	tristate "Emulated block size target (EXPERIMENTAL)"
> +	depends on BLK_DEV_DM
> +	select DM_BUFIO
> +	help
> +	  dm-ebs emulates smaller logical block size on backing devices
> +	  with larger ones (e.g. 512 byte sectors on 4K native disks).
>   
>   config DM_ERA
>          tristate "Era target (EXPERIMENTAL)"


Thanks, fine with me for the most part.

We mainly use '---help---' for dm/md though, so lets's keep it. Mike?

Heinz


>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

