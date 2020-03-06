Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F66C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6520656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N1MT+syi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFTOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:14:12 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36877 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:14:12 -0500
Received: by mail-qv1-f65.google.com with SMTP id w16so1029665qvn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6b2t4A6NGCaXbHtJi6TbMJSxKUKRxcf/wElpt30nY0g=;
        b=N1MT+syilOyNYAUCLRErWmOJboAM6iLImcB6nz23JfiG36LB96/XWtKyfhbDCO2Ocq
         BwKPKLBGw7m/H5OPTzaSB/vIuxbnoGbUxo1jwjFDj1BeEyjMYy/HrHAcwekSeAycYcBZ
         q7m6xe2DF/lhBHGNtZ6XKWYRFVIvKvjQipzP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6b2t4A6NGCaXbHtJi6TbMJSxKUKRxcf/wElpt30nY0g=;
        b=EhxRIvM2i9szgcoOD0w8YDjs1DKW890e0nTwv9pxVI8mAceXYc8h9skaJGIWF6N8KT
         Jg9cgAMwkjrhbWWW5tji0zhdUz5IEjEQN7fucQBvAs+wckdmbSbeJefeJOvPELnETyfl
         okcNcWmGZ3z6bxil8isP7OQMF1po8GzuPH6QfERAvCrcMKkmn0LKi+AVLwOvJG86L++H
         cn/DA/Yv6rD08fXv2kX//uz7I4Y5El4RbieQVnzaQR3BULOuR07nuSuATpGg8ulxcJIS
         b4Aef6FblcmZ3+ue4Bw5vAer5DSpzMKYRU7tMKpfS3Ayalje+g57CAIY4FTCd5jtnVzO
         8iuQ==
X-Gm-Message-State: ANhLgQ2C2dyChTmLmMU1WrhVJxA70bi2cfLJAV8Mjkqs3vJmlMDtxhyf
        YtIpAfN9poPWmReb2qzvC6C4fQ==
X-Google-Smtp-Source: ADFU+vtfHCkqs07wkfQTkSGpc2U+cJSVnNpis/+2j8/iaA6TIBUWgu8YItmwKJlOp+HGWSIFUTA5Kg==
X-Received: by 2002:ad4:4e88:: with SMTP id dy8mr4421977qvb.118.1583522051248;
        Fri, 06 Mar 2020 11:14:11 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f13sm4034043qte.53.2020.03.06.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:14:10 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:14:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306191410.GB60713@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net>
 <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
 <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
 <20200306125500.6aa75c0d@gandalf.local.home>
 <20200306184538.GA92717@google.com>
 <20200306135925.50c38bec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306135925.50c38bec@gandalf.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 01:59:25PM -0500, Steven Rostedt wrote:
[snip]
> > > -			rcu_irq_enter_irqson();				\
> > > -		}							\
> > >  									\
> > >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> > >  									\
> > >  		if (it_func_ptr) {					\
> > >  			do {						\
> > > +				int rcu_flags;				\
> > >  				it_func = (it_func_ptr)->func;		\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					rcu_flags = trace_rcu_enter();	\
> > >  				__data = (it_func_ptr)->data;		\
> > >  				((void(*)(proto))(it_func))(args);	\
> > > +				if (rcuidle &&				\
> > > +				    (it_func_ptr)->requires_rcu)	\
> > > +					trace_rcu_exit(rcu_flags);	\  
> > 
> > Nit: If we have incurred the cost of trace_rcu_enter() once, we can call
> > it only once and then call trace_rcu_exit() after the do-while loop. That way
> > we pay the price only once.
> >
> 
> I thought about that, but the common case is only one callback attached at
> a time. To make the code complex for the non common case seemed too much
> of an overkill. If we find that it does help, it's best to do that as a
> separate patch because then if something goes wrong we know where it
> happened.
> 
> Currently, this provides the same overhead as if each callback did it
> themselves like we were proposing (but without the added need to do it for
> all instances of the callback).

That's ok, it could be a separate patch.

thanks,

 - Joel

