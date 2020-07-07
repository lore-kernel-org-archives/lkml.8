Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6E620663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqIm4JMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGPdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:33:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730120AbgGGPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594135976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fI6zyW/Q6dQ0mgMSvs1HAB1XmZOZ4PZvn8vJbh28b3s=;
        b=MqIm4JMiikXrfVdHaAcc+wsRCjvTyKlxoX/4Ixm2+u2cyLkT1wTLj/fP0F954sedKqzWPh
        JzxVDsE/YaZJ3u1EzRICOA+GLT56tSLcDeIcZQ2qXeMRmYmwf1LqsBKOOrZ4EZxpXmtIb5
        P1xUs/UQYr85BOv5b2XhSm+Fj9FWOh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-F94UkfFIPM6ewwm_MEYMXg-1; Tue, 07 Jul 2020 11:32:52 -0400
X-MC-Unique: F94UkfFIPM6ewwm_MEYMXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A5BC1005510;
        Tue,  7 Jul 2020 15:32:51 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-172.phx2.redhat.com [10.3.114.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2E2A10013D7;
        Tue,  7 Jul 2020 15:32:50 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id F26701202DC; Tue,  7 Jul 2020 11:32:49 -0400 (EDT)
Date:   Tue, 7 Jul 2020 11:32:49 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5.7 070/112] kthread: save thread function
Message-ID: <20200707153249.GC171624@pick.fieldses.org>
References: <20200707145800.925304888@linuxfoundation.org>
 <20200707145804.332402326@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145804.332402326@linuxfoundation.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NACK to this and following patch.--b.

On Tue, Jul 07, 2020 at 05:17:15PM +0200, Greg Kroah-Hartman wrote:
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
> index 8bbcaad7ef0f4..c2a274b79c429 100644
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
> index bfbfa481be3a5..b84fc7eec0358 100644
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
> @@ -244,6 +260,7 @@ static int kthread(void *_create)
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

