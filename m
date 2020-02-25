Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECFC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E210521927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Jk1CqHzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgBYCMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:12:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33362 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:12:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so10663599qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 18:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aV1wtzsixyxbIlgwZVMjWFxlrGFi0X1sLLQ6AvkFw1M=;
        b=Jk1CqHzQBnOMrF2X0s+N5OdS4ebnoq+q2+n71ELYrkrblxYD9qjWtUaZmVOHPduZuI
         1L5Va9/zeze48RCRMN+cfSWsT025ckOaGJcLgdDarI76+j27MlzRzUgRajMIR4ctLzy+
         QqWW4Tq+WqrKM0qSiXYwvYW+auRw5ETve76eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aV1wtzsixyxbIlgwZVMjWFxlrGFi0X1sLLQ6AvkFw1M=;
        b=CAXObHEhaZ+SgwxRJrCk4jno3+n9a//MXGRcuy8be1ZzW3QGDfIgWhfVFrzshLKwIZ
         f8EnBjgLuf0gxSOQD26T7STukBxBaDCMI3c//n3KPcu8UuJ6ewJxYLPtPF1X6FoeHLEt
         10m24ruzDY2PVCyGQhXXYUMGYqHKWSFbnrz/op62jM9QeHcaKmTrOidB8/1RHq57onDP
         fpTsGQTsOCYqcMk1IzSe4+BJHNWIIHCZdgSzoDav4xs0EHpY20O3cTUny8pSEfVtDK/M
         HgNVH0ejNIcyPJ9hQ1YTTBQqL021lgvGMHMKqbG7NF+v04cVchRuSIxGXsGQvv6GSmBR
         sFRw==
X-Gm-Message-State: APjAAAWOHfvi3KXRpoBS3LJK7s4IdVt/geH+2I7jueMutMON+TjHGI88
        Fb8gM4zmTkGJE7OcFpEZdO9Fvznmti4=
X-Google-Smtp-Source: APXvYqxAJO1y+PRZqaNlPLjpP+h9ynxxQ1fDyUoGCsEl+wBDpiS2urRyLKsL3UMT7hyRdnrkk9GNJw==
X-Received: by 2002:a37:c07:: with SMTP id 7mr53621921qkm.414.1582596741329;
        Mon, 24 Feb 2020 18:12:21 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v7sm6856624qkg.103.2020.02.24.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 18:12:20 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:12:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200225021220.GD253171@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200222030843.GA191380@google.com>
 <20200224101050.GE14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224101050.GE14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:10:50AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 10:08:43PM -0500, Joel Fernandes wrote:
> > On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> > > nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> > > 
> > > And NMI context makes it impossible to do full IN-NMI tracking like we
> > > do IN-HARDIRQ, that could result in graph_lock recursion.
> > 
> > The patch makes sense to me.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > NOTE:
> > Also, I was wondering if we can detect the graph_lock recursion case and
> > avoid doing anything bad, that way we enable more of the lockdep
> > functionality for NMI where possible. Not sure if the suggestion makes sense
> > though!
> 
> Yeah, I considered playing trylock games, but figured I shouldn't make
> it more complicated that it needs to be.

Yes, I agree with you. Thanks.

 - Joel

