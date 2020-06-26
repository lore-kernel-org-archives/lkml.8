Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F08C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40944208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSrvVyf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgFZLp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFZLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:45:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B486C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:45:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so3954384pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uemf3Wf/R6czU5LxRGz5sapyQc/xnDzfVNcAquTwxq8=;
        b=RSrvVyf3Eb1DB8S5lB2jO3n7h84pb7nmU/W6ydX/b61Gg+ZpFaPJDhOz5kS0lOW4Ci
         WwRHOILqA2kbYdwszqlEV7whL9Srgk7EvCEuzjWpOhrEWE38Yi1jvF0EpmBN3zhnJNf7
         lBcs2+PEze92bpepa4yTtaeKhBzjvqy1sJ/gzRRffVX+KmmF9GG0KZF3za5197kyW6h6
         KOfbeY9zW7/Ulj/DYwG97R80GG4yLiQNXmS40kJrvda1Gujecob6C0h2FnJWTz0Bp1OJ
         wUCs5zb7wLTb24OJ2s6ITXuE8n9rfo47UkLFK6lTxs/y+LE2CUnsBD546Bh3Dn4JDTqF
         hY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uemf3Wf/R6czU5LxRGz5sapyQc/xnDzfVNcAquTwxq8=;
        b=LesiDufWniTfVP2B2HLO7nee9xWzlegfgU5t2spMqMyZKslUXSSzzdEwKCbofIeP2o
         iwVADxHfBIv3s5QaIjvRxgJnZ/gng3i7NS6xUBMEhaDUldQY3iot63iat3Yrxx55wzg0
         G00S17ABOkWyC263XodSPPXeQzovr16D+XcsLm2fGYt9WEC2X1/UJZY00RuG6FbTHf2g
         mH4+Tvov59zSlmqcH4WsSb+f2ZhJjo7v0FqinTDlUsGoAzLDOeaCT6rdqUePk083Ea11
         CUP7iz5mvZyDItAxgOGIe7YxUL8/xmA4S7KDtYHg4vuyXCORhqgt5E9j/DsXw69s8bce
         qjeQ==
X-Gm-Message-State: AOAM532C8ovJu4LHjRripVzEff5jK0KyDvkicvW1GaA6g7Ll2mW33elB
        6Tadxy2cLxPn6YoDCiGWKns=
X-Google-Smtp-Source: ABdhPJyO2JMkUeGmDv7wpJ1KlcGV4zXzbg4L+Lfqx9xR96RS3jtysb0q8Cxo34C23Fo5wmD9whNfnA==
X-Received: by 2002:a63:1104:: with SMTP id g4mr2323128pgl.369.1593171925472;
        Fri, 26 Jun 2020 04:45:25 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id v13sm11679520pjd.9.2020.06.26.04.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 04:45:24 -0700 (PDT)
Date:   Fri, 26 Jun 2020 20:45:22 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] init: Align init_task to avoid conflict with MUTEX_FLAGS
Message-ID: <20200626114522.GI1401039@lianli.shorne-pla.net>
References: <20200625204410.3168791-1-shorne@gmail.com>
 <20200626111208.GD4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626111208.GD4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:12:08PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 05:44:09AM +0900, Stafford Horne wrote:
> > When booting on 32-bit machines (seen on OpenRISC) I saw this warning
> > with CONFIG_DEBUG_MUTEXES turned on.
> 
> > I traced this to kernel/locking/mutex.c storing 3 bits of MUTEX_FLAGS in
> > the task_struct pointer (mutex.owner).  There is a comment saying that
> > task_structs are always aligned to L1_CACHE_BYTES.  This is not true for
> > the init_task.
> > 
> > On 64-bit machines this is not a problem because symbol addresses are
> > naturally aligned to 64-bits providing 3 bits for MUTEX_FLAGS.  Howerver,
> > for 32-bit machines the symbol address only has 2 bits available.
> > 
> > Fix this by setting init_task alignment to at least L1_CACHE_BYTES.
> 
> Whoopsie, sorry about that.
> 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  init/init_task.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 15089d15010a..d2d2af018d0d 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -64,6 +64,8 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
> >  struct task_struct init_task
> >  #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
> >  	__init_task_data
> > +#else
> > +	__aligned(L1_CACHE_BYTES)
> >  #endif
> 
> Why make this conditional? task_struct_cachep (in kernel/fork.c) has
> max_t(int, L1_CACHE_BYTES, ARCH_MIN_TASKALIGN) alignment, so this really
> should be aligned on L1_CACHE_BYTES at least.

I think we can make this unconditional.  The only reason I used the condition is
because the only architecture that sets CONFIG_ARCH_TASK_STRUCT_ON_STACK is ia64
which already has 64-bit alignment.

I can change it to (not incorporating max_t(ARCH_MIN_TASKALIGN) as not sure how):

diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..ab6173f8e6a8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -65,6 +65,7 @@ struct task_struct init_task
 #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
        __init_task_data
 #endif
+       __aligned(L1_CACHE_BYTES)
 = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
        .thread_info    = INIT_THREAD_INFO(init_task),

-Stafford
