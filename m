Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1022064B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599488026;
	bh=N4LKR8Dj7LkkKV3XN0I2i6LTJvXHJgZexdZRLBUqLjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DdwPv7lcg9uUnJa9Acw0MF9saD03QnvhjrH+cRZr2ZXrmrMQTjVAIQums5uAeUxFJ
	 i7l5eUIJRIhB/cp492fmVs644QKemCQ08Yly87ku+S0en53miNImRoZG/PYOzSPSwD
	 dR7ud0DDaunPmI1sUyHAfvXxStJAmiiXDWbxBfD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgIGONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbgIGOJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:09:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFED2064B;
        Mon,  7 Sep 2020 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599487746;
        bh=N4LKR8Dj7LkkKV3XN0I2i6LTJvXHJgZexdZRLBUqLjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtWaTOQWKXWzrB4coItpHAaFWiGdPE7qprgC/G+IVP0Cbe0KngR8Q0RWLcne0aBHp
         mI/kbBzT6HyFJQ8Da5iId9BYkStevuRhOVQKdFJbX16f+QnTv8XHj7vGQEBSw3tyV9
         9fWEdXW17m8T+cVtL9MwS5sBt5zCDsiWaXVIFKeE=
Date:   Mon, 7 Sep 2020 16:09:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v8 3/3] binder: add transaction latency tracer
Message-ID: <20200907140920.GC3719869@kroah.com>
References: <20200907070045.GA605692@kroah.com>
 <1599480055-25781-1-git-send-email-Frankie.Chang@mediatek.com>
 <1599480055-25781-4-git-send-email-Frankie.Chang@mediatek.com>
 <20200907122557.GC2029056@kroah.com>
 <1599486675.16905.34.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599486675.16905.34.camel@mtkswgap22>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:51:15PM +0800, Frankie Chang wrote:
> On Mon, 2020-09-07 at 14:25 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 07, 2020 at 08:00:55PM +0800, Frankie Chang wrote:
> > > From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> > > 
> > > Record start/end timestamp for binder transaction.
> > > When transaction is completed or transaction is free,
> > > it would be checked if transaction latency over threshold
> > > (default 2 sec), if yes, printing related information for tracing.
> > > 
> > > /* Implement details */
> > > - Add latency tracer module to monitor transaction
> > >   by attaching to new tracepoints introduced
> > >   when transactions are allocated and freed.
> > >   The trace_binder_txn_latency_free would not be enabled
> > >   by default. Monitoring which transaction is too slow to
> > >   cause some of exceptions is important. So we hook the
> > >   tracepoint to call the monitor function.
> > > 
> > > - Since some of modules would trigger timeout NE
> > >   if their binder transaction don't finish in time,
> > >   such as audio timeout (5 sec), even BT command
> > >   timeout (2 sec), etc.
> > >   Therefore, setting the timeout threshold as default
> > >   2 seconds could be helpful to debug.
> > >   But this timeout threshold is configurable, to let
> > >   all users determine the more suitable threshold.
> > > 
> > > - The reason why printing the related information to
> > >   kernel information log but not trace buffer is that
> > >   some abnormal transactions may be pending for a long
> > >   time ago, they could not be recorded due to buffer
> > >   limited.
> > > 
> > > Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> > > Acked-by: Todd Kjos <tkjos@google.com>
> > > ---
> > >  drivers/android/Kconfig                 |    8 +++
> > >  drivers/android/Makefile                |    1 +
> > >  drivers/android/binder.c                |    6 ++
> > >  drivers/android/binder_internal.h       |   13 ++++
> > >  drivers/android/binder_latency_tracer.c |  112 +++++++++++++++++++++++++++++++
> > >  drivers/android/binder_trace.h          |   26 ++++++-
> > >  6 files changed, 163 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/android/binder_latency_tracer.c
> > > 
> > > diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> > > index 53b22e2..8aadaf4 100644
> > > --- a/drivers/android/Kconfig
> > > +++ b/drivers/android/Kconfig
> > > @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
> > >  	  exhaustively with combinations of various buffer sizes and
> > >  	  alignments.
> > >  
> > > +config BINDER_TRANSACTION_LATENCY_TRACKING
> > > +	tristate "Android Binder transaction tracking"
> > > +	help
> > > +	  Used for track abnormal binder transaction which is over threshold,
> > > +	  when the transaction is done or be free, this transaction would be
> > > +	  checked whether it executed overtime.
> > > +	  If yes, printing out the detailed info.
> > > +
> > >  endif # if ANDROID
> > >  
> > >  endmenu
> > > diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> > > index c9d3d0c9..c2ffdb6 100644
> > > --- a/drivers/android/Makefile
> > > +++ b/drivers/android/Makefile
> > > @@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
> > >  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
> > >  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
> > >  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> > > +obj-$(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)	+= binder_latency_tracer.o
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 0cab900..65ad38c 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -2674,6 +2674,7 @@ static void binder_transaction(struct binder_proc *proc,
> > >  		return_error_line = __LINE__;
> > >  		goto err_alloc_t_failed;
> > >  	}
> > > +	trace_binder_txn_latency_alloc(t);
> > >  	INIT_LIST_HEAD(&t->fd_fixups);
> > >  	binder_stats_created(BINDER_STAT_TRANSACTION);
> > >  	spin_lock_init(&t->lock);
> > > @@ -5177,6 +5178,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
> > >  		   to_proc ? to_proc->pid : 0,
> > >  		   t->to_thread ? t->to_thread->pid : 0,
> > >  		   t->code, t->flags, t->priority, t->need_reply);
> > > +	trace_binder_txn_latency_info(m, t);
> > >  	spin_unlock(&t->lock);
> > >  
> > >  	if (proc != to_proc) {
> > > @@ -5818,4 +5820,8 @@ static int __init binder_init(void)
> > >  #define CREATE_TRACE_POINTS
> > >  #include "binder_trace.h"
> > >  
> > > +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_alloc);
> > > +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_info);
> > > +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_free);
> > > +
> > >  MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > > index 872232f..309d1b10 100644
> > > --- a/drivers/android/binder_internal.h
> > > +++ b/drivers/android/binder_internal.h
> > > @@ -15,6 +15,11 @@
> > >  #include <uapi/linux/android/binderfs.h>
> > >  #include "binder_alloc.h"
> > >  
> > > +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> > > +#include <uapi/linux/time_types.h>
> > > +#include <linux/rtc.h>
> > > +#endif
> > > +
> > >  struct binder_context {
> > >  	struct binder_node *binder_context_mgr_node;
> > >  	struct mutex context_mgr_node_lock;
> > > @@ -524,6 +529,14 @@ struct binder_transaction {
> > >  	 * during thread teardown
> > >  	 */
> > >  	spinlock_t lock;
> > > +	/**
> > > +	 * @timestamp and @tv are used to record the time
> > > +	 * that the binder transaction startup
> > > +	 */
> > > +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> > > +	struct timespec64 timestamp;
> > > +	struct __kernel_old_timeval tv;
> > 
> > As I stated in the 0/3 email, please use the correct in-kernel structure
> > for this.  That structure is _ONLY_ for old userspace api compatibility
> > issues.  Which is not the case here at all.
> > 
> > thanks,
> > greg k-h
> 
> Since it's not proper to use timeval & __kernel_old_timeval.
> The remaining structure with tv_usec that I found is
> __kernel_timex_timeval, but I'm not sure if this is proper one or not.
> All I can see is in
> https://lwn.net/ml/linux-kernel/20180705213604.18883-6-deepa.kernel@gmail.com/
> 
> I'm afraid of using wrong structure again.
> Could you give me some advices about this?
> 
> Or is there another suitable way to replace timeval

What exactly are you trying to measure such that you feel you need a
timeval structure?

thanks,

greg k-h
