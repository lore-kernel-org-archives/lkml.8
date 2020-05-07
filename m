Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F59C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A9C221F7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWz6Vqjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgEGSrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:47:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588877240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fA/ECm0zhQEdUp/fUbA73B0nJs5vbdkbZsQ0b4cogDo=;
        b=TWz6Vqjj8SBvEKBx1vLPZ+I1DGcKCa4G+y4nV2bm5DF3FyqhBCXJtSDWthw1Bn4lfbPPND
        GpvV8mPueQCWwaE0Mv/ySdiuNnJfV+w30W7IpzUQnv/vyglM7fOBwZboc8k5ivv1Aw0oVC
        sjZ3yk1ojO3h0yFMM+x/KLU3jWGVXT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-MgJVVsgDOfqwYGQcSYPLlA-1; Thu, 07 May 2020 14:47:16 -0400
X-MC-Unique: MgJVVsgDOfqwYGQcSYPLlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAF3919200C0;
        Thu,  7 May 2020 18:47:14 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCBBF70559;
        Thu,  7 May 2020 18:47:08 +0000 (UTC)
Date:   Thu, 7 May 2020 14:47:05 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507184705.GG205881@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507184307.GF205881@optiplex-lnx>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:43:16PM -0400, Rafael Aquini wrote:
> On Thu, May 07, 2020 at 06:22:57PM +0000, Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 8a176d8727a3..b80ab660d727 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= SYSCTL_ZERO,
> > >  		.extra2		= SYSCTL_ONE,
> > >  	},
> > > +	{
> > > +		.procname	= "panic_on_taint",
> > > +		.data		= &panic_on_taint,
> > > +		.maxlen		= sizeof(unsigned long),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= proc_doulongvec_minmax,
> > > +	},
> > 
> > You sent this out before I could reply to the other thread on v1.
> > My thoughts on the min / max values, or lack here:
> >                                                                                 
> > Valid range doesn't mean "currently allowed defined" masks.                     
> > 
> > For example, if you expect to panic due to a taint, but a new taint type
> > you want was not added on an older kernel you would be under a very
> > *false* sense of security that your kernel may not have hit such a
> > taint, but the reality of the situation was that the kernel didn't
> > support that taint flag only added in future kernels.                           
> > 
> > You may need to define a new flag (MAX_TAINT) which should be the last
> > value + 1, the allowed max values would be                                      
> > 
> > (2^MAX_TAINT)-1                                                                 
> > 
> > or                                                                              
> > 
> > (1<<MAX_TAINT)-1  
> > 
> > Since this is to *PANIC* I think we do want to test ranges and ensure
> > only valid ones are allowed.
> >
> 
> Ok. I'm thinking in:
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..ee492431e7b0 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1217,6 +1217,15 @@ static struct ctl_table kern_table[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +       {
> +               .procname       = "panic_on_taint",
> +               .data           = &panic_on_taint,
> +               .maxlen         = sizeof(unsigned long),
> +               .mode           = 0644,
> +               .proc_handler   = proc_doulongvec_minmax,
> +               .extra1         = SYSCTL_ZERO,
> +               .extra2         = (1 << TAINT_FLAGS_COUNT << 1) - 1,
							^^^^^^^^
Without that crap, obviously. Sorry. That was a screw up on my side,
when copyin' and pasting.

-- Rafael
	
> +       },
> 
> 
> Would that address your concerns wrt this one?
> 
> Cheers!
> -- Rafael

