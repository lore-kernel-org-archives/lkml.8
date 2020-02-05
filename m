Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB2C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C762085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJayuJpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgBEF0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:26:40 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50186 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:26:40 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so467828pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 21:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVCuHJnMuCmwTfOue9M7b3xZrfn6U2mf9Vp/kH0JJOs=;
        b=cJayuJpZmhN21d7X3rkS5Tr+K3EfQSzoT/0HJFSLNt66wGfiKSP0FyG6cTfzM/7oVF
         o8IpmfXRopueRDlU+qbkKLmIr9BLAJqgHU9SmiyJ9vi7AQ1ML9uzAs7buBBaa4oRPKxE
         hOTsjE0M6zFrn+PmyJiu0+8YwHmlGDBbxSzzzvemYGLOe2OMTgm25HXzn73akKPnO9Lk
         XJ9uGmJv8gsSv57jfVJxHXKLEA1hLu1mhbMixuxv79EgW0dYC38C5uyXgBVEyePyaGJ2
         ilP1rvkY0dAGud8omj3cVnS64RFlkFHW63Zji/Qot9oxZkkoje0tGdx+58HmO1/9nBx6
         +jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVCuHJnMuCmwTfOue9M7b3xZrfn6U2mf9Vp/kH0JJOs=;
        b=nwO/oKHyrw7LBPSETDUuu2gZvVDJQX9dNB4+n0TVty0SRtQYKKEnIQy7oPVYCWoMpg
         jN+T5tXTrWKlI/KOMQq4aJeqZIyaAhOCZIAbAsNnAKh8UJ02IVU4degskNhkYnnvIMHW
         3QLuWs/idTNA7EzChiEYKaknQMWcot8JWwt0qIIK5pxCiJ5yjw3OClgr+O2ob+O24/8A
         LqEYKzofeLWz1uM2v2BVObqsHoJm28UZYUIOu2Et+9lhrkQ4jcaF5TWqs3dqvdP8Wat0
         qHFO38tAXT67V3vzJfBYPlKXoG8Sjoier5D9CEcG2fkyTMviziFetChZ47hZ2PfQolIS
         CLDw==
X-Gm-Message-State: APjAAAWA61xqJUzm60ZIqJ48O8gGdnyuE6u3KQ64DnJUazqTRwThdSXF
        AmiOtYsaIEQJ2ko1GYzO1QI=
X-Google-Smtp-Source: APXvYqyzZSifvglSEHY4SkdDLNx4HtPkcV2z8C35LMbuNY7OjP2JjNstBX4Mb8HDYkB6XQD165h0jg==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr34234329pla.245.1580880399635;
        Tue, 04 Feb 2020 21:26:39 -0800 (PST)
Received: from workstation-portable ([103.211.17.109])
        by smtp.gmail.com with ESMTPSA id i3sm26130751pfg.94.2020.02.04.21.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 21:26:38 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:56:32 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200205052632.GB1540@workstation-portable>
References: <20200201072703.17330-1-frextrite@gmail.com>
 <20200203163301.GB85781@google.com>
 <20200204200116.479f0c60@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204200116.479f0c60@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 08:01:16PM -0500, Steven Rostedt wrote:
> On Mon, 3 Feb 2020 11:33:01 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
> > >  				 unsigned long flags, int pc);
> > >  
> > >  #ifdef CONFIG_DYNAMIC_FTRACE
> > > -extern struct ftrace_hash *ftrace_graph_hash;
> > > +extern struct ftrace_hash __rcu *ftrace_graph_hash;
> > >  extern struct ftrace_hash *ftrace_graph_notrace_hash;
> > >  
> > >  static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
> > >  {
> > >  	unsigned long addr = trace->func;
> > >  	int ret = 0;
> > > +	struct ftrace_hash *hash;
> > >  
> > >  	preempt_disable_notrace();
> > >  
> > > -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> > > +	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());  
> > 
> > I think you can use rcu_dereference_sched() here? That way no need to pass
> > !preemptible.
> > 
> > A preempt-disabled section is an RCU "sched flavor" section. Flavors are
> > consolidated in the backend, but in the front end the dereference API still
> > do have flavors.
> 
> Unfortunately, doing it with rcu_dereference_sched() causes a lockdep
> splat :-P. This is because ftrace can execute when rcu is not
> "watching" and that will trigger a lockdep error. That means, this
> origin patch *is* correct. I'm re-applying this one.
> 

Something new to learn, thank you for the information Steve!

Thanks
Amol

> -- Steve
