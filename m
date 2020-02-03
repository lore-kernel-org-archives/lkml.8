Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A21C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2162070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfbj3tkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBCJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:16:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgBCJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580721378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwM0beCgjCPR5r64LO4IeZHnq/7JINFKcByX6l+uYrM=;
        b=Dfbj3tkfKNCI394uYhjjjWxTgAgYwpjcOMDAMPOtBdbudM4nIWsVlxJUYTAcRyHQ73xeEr
        GzUY/fj5v1VVaV+HY0+CUNGntOOpgQ4Dj/LDJuzzq9KFu7QTrHIogcDSn8kM5M8E8vsRqu
        WPwYcTSQq1jC4gRJTGoiCfGTzGqqHeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-74eqfedvOLiniJozDcBEjg-1; Mon, 03 Feb 2020 04:16:14 -0500
X-MC-Unique: 74eqfedvOLiniJozDcBEjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64155107ACCA;
        Mon,  3 Feb 2020 09:16:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D88955DA82;
        Mon,  3 Feb 2020 09:16:06 +0000 (UTC)
Date:   Mon, 3 Feb 2020 17:16:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix selecting software ctx for request
Message-ID: <20200203091602.GA31450@ming.t460p>
References: <20200202102004.19132-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202102004.19132-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 06:20:04PM +0800, Hillf Danton wrote:
> 
> Select the current cpu if it's mapped to hardware to make helpers like
> blk_mq_rq_cpu() return correct value.
> 
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -454,7 +454,10 @@ struct request *blk_mq_alloc_request_hct
>  		blk_queue_exit(q);
>  		return ERR_PTR(-EXDEV);
>  	}
> -	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> +	cpu = raw_smp_processor_id();
> +	if (!cpumask_test_cpu(cpu, alloc_data.hctx->cpumask))
> +		cpu = cpumask_first_and(alloc_data.hctx->cpumask,
> +						cpu_online_mask);

How can you know if there is any online CPU available for this hctx?

>  	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
>  
>  	rq = blk_mq_get_request(q, NULL, &alloc_data);
> 

It is really one NVMe specific issue, see the following discussion:

https://lore.kernel.org/linux-block/8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me/#r


Thanks,
Ming

