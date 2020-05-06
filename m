Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E49C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBED2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsDd2Y6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgEFQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:00:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgEFQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588780807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/1uzcbnd/S3JgnWjmX6EMaNQXRlS5bVy2XyNn0Nvxg=;
        b=QsDd2Y6qPR/HNdzNF5YuTuDIIYaqmQxxY7v8J1XosIcKJ0WohCctfhz7+SNepCHjV3dmyb
        PSknc29YMCXR4bRYDXjdzL7+zHBgiMelrHbbAzhaWO0SsM5Ul2i6a5F7NuXiAm9AaLEgNG
        2aeKaukjvdUwBMuBuq1hB0//SHsutos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-HSYeUyD4O9WI7LQdgxJZmA-1; Wed, 06 May 2020 12:00:02 -0400
X-MC-Unique: HSYeUyD4O9WI7LQdgxJZmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E101009458;
        Wed,  6 May 2020 16:00:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-141.rdu2.redhat.com [10.10.116.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B14E10013D9;
        Wed,  6 May 2020 16:00:00 +0000 (UTC)
Subject: Re: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates
 position index
To:     Vasily Averin <vvs@virtuozzo.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Schwab <schwab@suse.de>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
 <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8e04d756-29f5-9aff-2f0b-61663ecff649@redhat.com>
Date:   Wed, 6 May 2020 11:59:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 2:25 AM, Vasily Averin wrote:
> new_pos should jump through hole of unused ids,
> pos can be updated inside "for" cycle.
>
> Cc: stable@vger.kernel.org
> Fixes: 89163f93c6f9 ("ipc/util.c: sysvipc_find_ipc() should increase position index")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>   ipc/util.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index 7acccfd..cfa0045 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -764,21 +764,21 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>   			total++;
>   	}
>   
> -	*new_pos = pos + 1;
> +	ipc = NULL;
>   	if (total >= ids->in_use)
> -		return NULL;
> +		goto out;
>   
>   	for (; pos < ipc_mni; pos++) {
>   		ipc = idr_find(&ids->ipcs_idr, pos);
>   		if (ipc != NULL) {
>   			rcu_read_lock();
>   			ipc_lock_object(ipc);
> -			return ipc;
> +			break;
>   		}
>   	}
> -
> -	/* Out of range - return NULL to terminate iteration */
> -	return NULL;
> +out:
> +	*new_pos = pos + 1;
> +	return ipc;
>   }
>   
>   static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)

Acked-by: Waiman Long <longman@redhat.com>

