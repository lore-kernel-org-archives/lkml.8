Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0354C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C21206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rS9uqXeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFKBc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKBc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:32:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1107C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:32:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l17so4138565qki.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GeSX8BLi/S97GAEC8tAxV2cog3jQBy8w8/D9vd362qA=;
        b=rS9uqXeHK+Xy7MdjS3rdfJl0MwS489Fyt+KGbXqkfZ76nFlpp4WlT+0Q6Q97kN+utD
         NIpm0q2sOcAwnbUVv7kNi2jxljRQFqGythGpcKPox/HNRlSELB7wYnlsoWVxrrBx7Fxm
         3Sl1pM2kSOIktiHNPpHNYjLtzyqg5xBEJY01I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GeSX8BLi/S97GAEC8tAxV2cog3jQBy8w8/D9vd362qA=;
        b=QoY2jyWu9Tt+IND2o+juVN4H+BVYH5ZcG8yAh1ofP0LHjmv0X56F0V5ztEqK9/ooY+
         VYpbWTOso7wgeY7/MJ5paTSgDAHJfDwM6GfeAJbE0hiabUoB2d77h0UvBpeBIVjGrdbL
         n9dhviyh4SkgouL4Z5han/HJGiWuWZtKABPtvNts5CYYpbxz+t2hnzL0DSXrJ/6EnYG9
         pQHLf7hGKiaiZOx8v5/3DcheJy/ztfkXZ4qE8VALhuGEc7zhJzl+KPd7i+bu0W2FB5Op
         6P1hLbhxd3x9pSX/ng0896jtom0AoEge+gU6f9HZQQId+x2I07bOmyLK7Rvs3yabQu08
         A6aA==
X-Gm-Message-State: AOAM533FTKljA3G+/cL3mrz9E0DQl8NsH5ZILSc1Ht00g5umqnrBlrsW
        v475HZLZzGcN7fhgnl6h+loaJQ==
X-Google-Smtp-Source: ABdhPJz6gg55lcd58w3pkrBwmi2gA9J36PIx1Nta5MymXsCxZ5SaU+egNwIauVSxFDB4LuccOVmNJA==
X-Received: by 2002:a05:620a:52d:: with SMTP id h13mr5932452qkh.424.1591839145357;
        Wed, 10 Jun 2020 18:32:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 6sm1054724qkl.26.2020.06.10.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:32:24 -0700 (PDT)
Date:   Wed, 10 Jun 2020 21:32:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200611013224.GA9005@google.com>
References: <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
 <20200608125715.GA30920@lenoir>
 <20200609180227.GR4455@paulmck-ThinkPad-P72>
 <20200610131238.GA26639@lenoir>
 <20200610140210.GT4455@paulmck-ThinkPad-P72>
 <20200610221245.GA3833@lenoir>
 <20200610232142.GA4455@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610232142.GA4455@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:21:42PM -0700, Paul E. McKenney wrote:
[...]
> > > 8.	To softirq 3.  Either GP or CB kthread for the transitioning
> > > 	CPU advances to next.
> > > 	At this point, the no-CBs setup is fully shut down.
> > > 9.	To softirq 4.  Transitioning code advances to next,
> > > 	which is the first, "In softirq".
> > > 	(This one -might- be unnecessary, but...)
> > > 
> > > All transitions are of course with the ->nocb_lock held.
> > > 
> > > When there is only one CPU during early boot near rcu_init() time,
> > > the transition from "In softirq" to "No-CB" can remain be instantaneous.
> > > 
> > > This has the advantage of not slowing things down just because there
> > > is an RCU callback flood in progress.  It also uses an explicit
> > > protocol that should (give or take bugs) maintain full safety both
> > > in protection of ->cblist and in dealing with RCU callback floods.
> > > 
> > > Thoughts?
> > 
> > Agreed. And I really like that it details the whole process in a very
> > explicit way.
> > 
> > Thanks!
> 
> Glad you like it!  And of course please adjust it as needed, up to and
> including doing something completely different that works better.  ;-)

Makes sense to me too, thanks!

 - Joel

