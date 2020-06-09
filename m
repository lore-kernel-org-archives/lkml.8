Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D8D2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxV4uRKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgFIVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:25:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEFFC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 14:25:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so78233plv.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZSHPao27jDaviX/CgUO6zfDPdssCrcO3HslKSHh6h0=;
        b=QxV4uRKuGPPTyAvE8pmG+djgl4hq4n/9yAM3mrLlhk/dEHgXYUSStvIs4NhPp+Q38o
         alLylDOM42ECtSoRKYjdc+dSYqccciiquc10woGnL+viYPDGflKr+bA89ovf+0MBlq5X
         vf1q1SZs+ot83CixIR7nXx6vvcKUoJ2dXhL1C1YXrKeamjN41odMMkHvrqqQs/BtpiN5
         bsizwYYdtBGrkGyes9753IaTmx2ZCwQu/hpkljG9/x+m/GXOyAX5lxx0OK58VHJ1MHEY
         qlCKiowvBBuH8r389kBOPFV/4qRfO6CPT6BE0T0FUnZBjmJ33CiMaB3OmjSLyPWQnXjD
         g5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZSHPao27jDaviX/CgUO6zfDPdssCrcO3HslKSHh6h0=;
        b=ZCqnUNJXwDGzLKwXsRxG0PAsROkljZUrhZztu0TR3nvIhwtZEP+hLRnBcxXiECsu0K
         hNKkPoN03gM93Yxy9m78rvOFyKZgp5ZxqEp5I39WLh2mypbviI6rRgtq87oNb9Lq/piS
         5n+PIFzoBLmUKeU+6bdaIRDaVaBCnfVwQHXsoAHy9fHgVc211QfSs12Ub3bsEEBQ6ZM/
         ne+oha2xgQXjyxwtitBWNgMWS4/wTSPx005f1YquC1rckQHz4qDkYzfK46engu9qM2/K
         MDO9odjsNt2f2C3FGakwWhXNov4fBf0KDX/+63PJV1jRezXy4G9TKIyDqxajd1UPCgrq
         6Zqg==
X-Gm-Message-State: AOAM530xvIILqlRqqYcNLGfTpMcjOYTaH/6Yi0I4GjBi00oOHLkP/tYh
        Ie5RwqpaLFC5Ic5mYJ+5wbg=
X-Google-Smtp-Source: ABdhPJxsWbeoc/QGqLgQd/drxZxhd4d/c1/Jl7nbbO2rOXEefzv70Bip7PgpN28hhmMTKZSfUfu8sA==
X-Received: by 2002:a17:90a:cb8d:: with SMTP id a13mr6853219pju.175.1591737912192;
        Tue, 09 Jun 2020 14:25:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5sm3252388pjo.20.2020.06.09.14.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jun 2020 14:25:10 -0700 (PDT)
Date:   Tue, 9 Jun 2020 14:25:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200609212509.GA239889@roeck-us.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609202134.GA1105@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:21:34PM -0700, Eric Biggers wrote:
> On Sat, Jun 06, 2020 at 04:13:33PM -0700, Guenter Roeck wrote:
> > On 6/5/20 9:15 AM, Eric Biggers wrote:
> > > On Fri, Jun 05, 2020 at 09:41:54AM +0200, Peter Zijlstra wrote:
> > >> On Thu, Jun 04, 2020 at 05:24:33PM -0700, Eric Biggers wrote:
> > >>> On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
> > >>>> On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> > >>>>> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> > >>>>> got smp_call_function_single_async() subtly wrong. Even though it will
> > >>>>> return -EBUSY when trying to re-use a csd, that condition is not
> > >>>>> atomic and still requires external serialization.
> > >>>>>
> > >>>>> The change in ttwu_queue_remote() got this wrong.
> > >>>>>
> > >>>>> While on first reading ttwu_queue_remote() has an atomic test-and-set
> > >>>>> that appears to serialize the use, the matching 'release' is not in
> > >>>>> the right place to actually guarantee this serialization.
> > >>>>>
> > >>>>> The actual race is vs the sched_ttwu_pending() call in the idle loop;
> > >>>>> that can run the wakeup-list without consuming the CSD.
> > >>>>>
> > >>>>> Instead of trying to chain the lists, merge them.
> > >>>>>
> > >>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >>>>> ---
> > >>>> ...
> > >>>>> +	/*
> > >>>>> +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> > >>>>> +	 * for task_struct to be on the @call_single_queue.
> > >>>>> +	 */
> > >>>>> +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> > >>>>> +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> > >>>>> +
> > >>>>
> > >>>> There is no guarantee in C that
> > >>>>
> > >>>> 	type1 a;
> > >>>> 	type2 b;
> > >>>>
> > >>>> in two different data structures means that offsetof(b) - offsetof(a)
> > >>>> is the same in both data structures unless attributes such as
> > >>>> __attribute__((__packed__)) are used.
> > >>>>
> > >>>> As result, this does and will cause a variety of build errors depending
> > >>>> on the compiler version and compile flags.
> > >>>>
> > >>>> Guenter
> > >>>
> > >>> Yep, this breaks the build for me.
> > >>
> > >> -ENOCONFIG
> > > 
> > > For me, the problem seems to be randstruct.  To reproduce, you can use
> > > (on x86_64):
> > > 
> > > 	make defconfig
> > > 	echo CONFIG_GCC_PLUGIN_RANDSTRUCT=y >> .config
> > > 	make olddefconfig
> > > 	make kernel/smp.o
> > > 
> > 
> > I confirmed that disabling CONFIG_GCC_PLUGIN_RANDSTRUCT "fixes" the problem
> > in my test builds. Maybe it would make sense to mark that configuration option
> > for the time being as BROKEN.
> > 
> 
> Still occurring on Linus' tree.  This needs to be fixed.  (And not by removing
> support for randstruct; that's not a "fix"...)
> 

How about the hack below ?

Guenter

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d96e3e7fff..df1cbb04f9b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -629,6 +629,15 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+/*
+ * Hack around assumption that wake_entry_type follows wake_entry even with
+ * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
+ */
+struct _wake_entry {
+	struct llist_node	wake_entry;
+	unsigned int		wake_entry_type;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -653,8 +662,9 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
+	struct _wake_entry		_we;
+#define wake_entry		_we.wake_entry
+#define wake_entry_type		_we.wake_entry_type
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
