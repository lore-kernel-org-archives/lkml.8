Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6585FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAB120788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P122EjaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgCXPUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:20:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45369 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727547AbgCXPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585063249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPqV8YQEnUqCh5JitavMy788HT8uf23i2uO5Wlz2Xqs=;
        b=P122EjaDfTK2gy0heAIRn0SFv4TTx9veIjwLBsuC+C9isGrAezy8jE9L3bUDn520x83GcB
        hHovkr4Oe6HVcNLxaXw4gAEK/r4boHAq3S9QOMRmLl096RFaaPmtdZghkF/nrqjksNHnr/
        SRSmCu6USy38IErZqxnNdngWEXJX7rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-SHSxYeuyMk2ejESIAuIkig-1; Tue, 24 Mar 2020 11:20:43 -0400
X-MC-Unique: SHSxYeuyMk2ejESIAuIkig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523F51005516;
        Tue, 24 Mar 2020 15:20:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 113F294B4B;
        Tue, 24 Mar 2020 15:20:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2CEB64198B39; Tue, 24 Mar 2020 12:07:07 -0300 (-03)
Date:   Tue, 24 Mar 2020 12:07:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] affine kernel threads to specified cpumask
Message-ID: <20200324150707.GB24352@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <e76aedad-8c55-1651-007d-6e17882403cb@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76aedad-8c55-1651-007d-6e17882403cb@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, Mar 23, 2020 at 09:29:23AM -0600, Chris Friesen wrote:
> On 3/23/2020 7:54 AM, Marcelo Tosatti wrote:
> > 
> > This is a kernel enhancement to configure the cpu affinity of kernel
> > threads via kernel boot option kthread_cpus=<cpulist>.
> > 
> > With kthread_cpus specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus= parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime.
> > 
> > Note-1: this is based off on MontaVista's patch at
> > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> 
> It's Wind River, not MontaVista. :)

Doh.

> > Difference being that this patch is limited to modifying
> > kernel thread cpumask: Behaviour of other threads can
> > be controlled via cgroups or sched_setaffinity.
> 
> What cgroup would the usermode helpers called by the kernel end up in?
> Same as init?
> 
> Assuming that's covered, I'm good with this patch.
> 
> <snip>

 * Runs a user-space application.  The application is started
 * asynchronously if wait is not set, and runs as a child of system workqueues.
 * (ie. it runs with full root capabilities and optimized affinity).
 */
int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
{
	...
        queue_work(system_unbound_wq, &sub_info->work);


And unbound workqueue workers cpumask are controllable:

static void worker_attach_to_pool(struct worker *worker,
                                   struct worker_pool *pool)
{
        mutex_lock(&wq_pool_attach_mutex);

        /*
         * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
         * online CPUs.  It'll be re-applied when any of the CPUs come up.
         */
        set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);

> 
> > +static struct cpumask user_cpu_kthread_mask __read_mostly;
> > +static int user_cpu_kthread_mask_valid __read_mostly;
> 
> Would it be cleaner to get rid of user_cpu_kthread_mask_valid and just
> move the "if (!cpumask_empty" check into init_kthread_cpumask()?  I'm
> not really opinionated, just thinking out loud.

Will get rid of this with Thomas's isolcpus= suggestion.

> > +int __init init_kthread_cpumask(void)
> > +{
> > +	if (user_cpu_kthread_mask_valid == 1)
> > +		cpumask_copy(&__cpu_kthread_mask, &user_cpu_kthread_mask);
> > +	else
> > +		cpumask_copy(&__cpu_kthread_mask, cpu_all_mask);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init kthread_setup(char *str)
> > +{
> > +	cpulist_parse(str, &user_cpu_kthread_mask);
> > +	if (!cpumask_empty(&user_cpu_kthread_mask))
> > +		user_cpu_kthread_mask_valid = 1;
> > +
> > +	return 1;
> > +}

