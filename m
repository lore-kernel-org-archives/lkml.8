Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B98BC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068E9208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588896165;
	bh=RABDbBls9l0rquFOQ6ZOjxQs3c2PLTi1b71bICyJ9LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ny5k3Ry3BhGfyWGK7F4KSRjRk4IpPqS+fO5KzDbUgQBSLTVDpciDQvFqBVmFLPDl1
	 E6awfs2o8NlYIKavan5o3o1Mkb6anY3+r2ZXYrJE12aQEh7eIOt+79oR0ttQ/3LkCU
	 aKInibbHFgLpimMaEimziLj1uNG2DtE6VrlUasIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHACo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgEHACn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:02:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F4B2082E;
        Fri,  8 May 2020 00:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588896163;
        bh=RABDbBls9l0rquFOQ6ZOjxQs3c2PLTi1b71bICyJ9LY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0MFQAWy486qPwRfsFfPZP/Ol8J7LIIJNa0Sdix9A/QkaXqiBndS/dnAOkDzv4KLff
         KGEMLEkJqZ4OxRgB20i2VL+At0WSFKX5o21m8dPBD5HHhiG18dHlZonMQf0MiEFAp6
         rkj74qkGEu4pT3hjd/RdJk51LbH72np8MrGqoM+g=
Date:   Thu, 7 May 2020 17:02:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Andreas Schwab <schwab@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates
 position index
Message-Id: <20200507170242.6cbb88ae672deed67152e221@linux-foundation.org>
In-Reply-To: <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
        <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 09:25:54 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> new_pos should jump through hole of unused ids,
> pos can be updated inside "for" cycle.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89163f93c6f9 ("ipc/util.c: sysvipc_find_ipc() should increase position index")

This:

> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -764,21 +764,21 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>  			total++;
>  	}
>  
> -	*new_pos = pos + 1;
> +	ipc = NULL;
>  	if (total >= ids->in_use)
> -		return NULL;
> +		goto out;
>  
>  	for (; pos < ipc_mni; pos++) {
>  		ipc = idr_find(&ids->ipcs_idr, pos);
>  		if (ipc != NULL) {
>  			rcu_read_lock();
>  			ipc_lock_object(ipc);
> -			return ipc;
> +			break;
>  		}
>  	}
> -
> -	/* Out of range - return NULL to terminate iteration */
> -	return NULL;
> +out:
> +	*new_pos = pos + 1;
> +	return ipc;
>  }
>  
>  static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)

Messes up Matthew's "ipc: convert ipcs_idr to XArray"
(http://lkml.kernel.org/r/20200326151418.27545-1-willy@infradead.org).

Here's how I resolved things.  Please check?

static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
					      loff_t *new_pos)
{
	unsigned long index = pos;
	struct kern_ipc_perm *ipc;

	rcu_read_lock();
	ipc = xa_find(&ids->ipcs, &index, ULONG_MAX, XA_PRESENT);
	if (ipc)
		ipc_lock_object(ipc);
	else
		rcu_read_unlock();
	*new_pos = pos + 1;
	return ipc;
}

