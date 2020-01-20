Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C3C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2C22527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1RiFunv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgATUoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:44:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41562 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:44:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so888504wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCCS+xkufB0QNR51eBW0fDBzy5n2Yxy6YYGIGoFxFjY=;
        b=i1RiFunvaU1pkUAr1jdAQEBuueohAtVroihCJr4V9fb1vnBa4gG5/cAxUd2CioYmeu
         jOOQJgYjl05aQ/LyzpF1vZpyvT6/5XUkkmfW1QzFreSJD21aUci5s7MI1UlJwBN0wwvG
         UHFGCyhlekqTHipTI7JKrkvJ9uj8uafYlaewKSVxtqDtFrzERcRsnR91XD75NBYlhst6
         1mi/uLGZufehNQYTx9JSHgpTXOZy1+yDc9wqcVAmnF82VfGJVZ45V576Jy1pA18g05vP
         Lm4OPEdrL/K9A9JGRZngIBA6vNipWjovT+4hz8Ins1VBqsyK0NQw/4kenVBUFWytyJAO
         fC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCCS+xkufB0QNR51eBW0fDBzy5n2Yxy6YYGIGoFxFjY=;
        b=Y9HUnrM2H8K6uinuSRwxXnPv2etr+1lrD4p/ayIJH6gwzA4H5EOlorgb/E/RvloiFH
         lMAIBEDC/wGqqbNMo00BZv2LprWOHKTGnZwrRmGR3GpCElVt2ryocAJ+3IVX30MBuTKY
         4VRRDwuUauDe7aA+C7rpCX+T7Mp07NUcbvC8Rb+ku15tc3Fj1xeUIreIp3xuiems8oHG
         KXVK+jibGLx4SR4cW2Lp6BKkySyYMUBHcmJduCh1kZAUKL5hYLo9mRpYillPSROtog4a
         tjPByxxq0J0SgRxB/PALm5F9nSqpVG6KrrOU8wUjdnDh+quieqyo9nX/LF99Uhylk8gv
         pjZg==
X-Gm-Message-State: APjAAAXk4kZzq6OY3c34niB0gG93j3C1GRUX2c4JjHytL7QKL6pKkoo/
        jOzI5ugPVJlPrL1IWv+pq/VR4mlKzxWklw==
X-Google-Smtp-Source: APXvYqxCJ0WfiL3WPs+cvGhKPFUiva4SCirEzA9kYvDpa5+v86CMADSwFkrnCBtdC9pf46QCQsRKKA==
X-Received: by 2002:adf:e887:: with SMTP id d7mr1279030wrm.162.1579553076213;
        Mon, 20 Jan 2020 12:44:36 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id n16sm49912696wro.88.2020.01.20.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 12:44:35 -0800 (PST)
Date:   Mon, 20 Jan 2020 21:44:29 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Document (some) memory-ordering properties of
 {queue,schedule}_work()
Message-ID: <20200120204429.GA1473@andrea>
References: <20200118215820.7646-1-parri.andrea@gmail.com>
 <20200120020235.GA8126@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120020235.GA8126@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 06:02:35PM -0800, Paul E. McKenney wrote:
> On Sat, Jan 18, 2020 at 10:58:20PM +0100, Andrea Parri wrote:
> > It's desirable to be able to rely on the following property:  All stores
> > preceding (in program order) a call to a successful queue_work() will be
> > visible from the CPU which will execute the queued work by the time such
> > work executes, e.g.,
> > 
> >   { x is initially 0 }
> > 
> >     CPU0                              CPU1
> > 
> >     WRITE_ONCE(x, 1);                 [ "work" is being executed ]
> >     r0 = queue_work(wq, work);          r1 = READ_ONCE(x);
> > 
> >   Forbids: r0 == true && r1 == 0
> > 
> > The current implementation of queue_work() provides such memory-ordering
> > property:
> > 
> >   - In __queue_work(), the ->lock spinlock is acquired.
> > 
> >   - On the other side, in worker_thread(), this same ->lock is held
> >     when dequeueing work.
> > 
> > So the locking ordering makes things work out.
> > 
> > Add this property to the DocBook headers of {queue,schedule}_work().
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!

>
> An alternative to Randy's suggestion of dropping the comma following
> the "cf." is to just drop that whole phrase.  I will let you and Randy
> work that one out, though.  ;-)

Either way works for me.

I'd give Tejun and Lai some more time to review this and send a non-RFC with
your Ack and this nit fixed later this week (unless I hear some objections).

Thanks,
  Andrea
