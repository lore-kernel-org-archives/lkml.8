Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23314204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7wu/SDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGGPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:32:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgGGPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594135928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuCscFMzbWSIQnwK8DEFhjyLSkPD2wzH+z7HqKxxVuQ=;
        b=C7wu/SDxVaWCVlp5eFkOc/2o+HKWh6Li4S4dPc7FCX4U+nSwnxkPUBJwszLEDFQV23nZzA
        l5djULPS1JRdP/mHN2DZ0vDhynOoSI5XnC9/SVbuR9gnNxoglMWhZvggoG1oVzViEfxk80
        ZrrxDrxDGgnzhz5d1yYqtgMhbBy42Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-bjJEXDCCN2-inYhzImFVYg-1; Tue, 07 Jul 2020 11:32:07 -0400
X-MC-Unique: bjJEXDCCN2-inYhzImFVYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D017804003;
        Tue,  7 Jul 2020 15:31:59 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-172.phx2.redhat.com [10.3.114.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B775E10013D7;
        Tue,  7 Jul 2020 15:31:58 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id BAC3C1202DC; Tue,  7 Jul 2020 11:31:57 -0400 (EDT)
Date:   Tue, 7 Jul 2020 11:31:57 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5.4 34/65] kthread: save thread function
Message-ID: <20200707153157.GB171624@pick.fieldses.org>
References: <20200707145752.417212219@linuxfoundation.org>
 <20200707145754.124544082@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145754.124544082@linuxfoundation.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NACK.--b.

On Tue, Jul 07, 2020 at 05:17:13PM +0200, Greg Kroah-Hartman wrote:
> From: J. Bruce Fields <bfields@redhat.com>
> 
> [ Upstream commit 52782c92ac85c4e393eb4a903a62e6c24afa633f ]
> 
> It's handy to keep the kthread_fn just as a unique cookie to identify
> classes of kthreads.  E.g. if you can verify that a given task is
> running your thread_fn, then you may know what sort of type kthread_data
> points to.
> 
> We'll use this in nfsd to pass some information into the vfs.  Note it
> will need kthread_data() exported too.
> 
> Original-patch-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/kthread.h |  1 +
>  kernel/kthread.c        | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 0f9da966934e2..59bbc63ff8637 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -57,6 +57,7 @@ bool kthread_should_stop(void);
>  bool kthread_should_park(void);
>  bool __kthread_should_park(struct task_struct *k);
>  bool kthread_freezable_should_stop(bool *was_frozen);
> +void *kthread_func(struct task_struct *k);
>  void *kthread_data(struct task_struct *k);
>  void *kthread_probe_data(struct task_struct *k);
>  int kthread_park(struct task_struct *k);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca4..543dff6b576c7 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -46,6 +46,7 @@ struct kthread_create_info
>  struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
> +	int (*threadfn)(void *);
>  	void *data;
>  	struct completion parked;
>  	struct completion exited;
> @@ -152,6 +153,20 @@ bool kthread_freezable_should_stop(bool *was_frozen)
>  }
>  EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
>  
> +/**
> + * kthread_func - return the function specified on kthread creation
> + * @task: kthread task in question
> + *
> + * Returns NULL if the task is not a kthread.
> + */
> +void *kthread_func(struct task_struct *task)
> +{
> +	if (task->flags & PF_KTHREAD)
> +		return to_kthread(task)->threadfn;
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kthread_func);
> +
>  /**
>   * kthread_data - return data value specified on kthread creation
>   * @task: kthread task in question
> @@ -164,6 +179,7 @@ void *kthread_data(struct task_struct *task)
>  {
>  	return to_kthread(task)->data;
>  }
> +EXPORT_SYMBOL_GPL(kthread_data);
>  
>  /**
>   * kthread_probe_data - speculative version of kthread_data()
> @@ -237,6 +253,7 @@ static int kthread(void *_create)
>  		do_exit(-ENOMEM);
>  	}
>  
> +	self->threadfn = threadfn;
>  	self->data = data;
>  	init_completion(&self->exited);
>  	init_completion(&self->parked);
> -- 
> 2.25.1
> 
> 
> 

