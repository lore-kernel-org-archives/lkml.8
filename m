Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F7620786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuCVSbSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgCaPmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:42:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727703AbgCaPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585669337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAa6WDZZ4aLer2WizVTUJX1pA0KvjTDINWFlSXq4eNc=;
        b=DuCVSbSbGPoXVP0ZdSeLNSi+QC74OFcDiXvWvkot2pNL8gbNhvS+ox21jjc/Gwfs9DNTo4
        sc1AdwXvzwAKFUeRXelQPVsjS4siBsFT1RQa0wFq3tNmtvlCdcVgJjhZd/5jdiggsuelbY
        G/aZSVnar289q8VaAabqBa4+XVBHjGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-3B-sslRmNVyH_T0pJgEOBA-1; Tue, 31 Mar 2020 11:42:13 -0400
X-MC-Unique: 3B-sslRmNVyH_T0pJgEOBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D56D8017CC;
        Tue, 31 Mar 2020 15:42:11 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E3C19756;
        Tue, 31 Mar 2020 15:42:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 167EF414F66B; Tue, 31 Mar 2020 12:41:46 -0300 (-03)
Date:   Tue, 31 Mar 2020 12:41:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 3/3] isolcpus: undeprecate on documentation
Message-ID: <20200331154146.GA28556@fuller.cnet>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.271570281@redhat.com>
 <20200331152217.GT20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152217.GT20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:22:17PM +0200, Peter Zijlstra wrote:
> On Sat, Mar 28, 2020 at 12:21:20PM -0300, Marcelo Tosatti wrote:
> > isolcpus is used to control steering of interrupts to managed_irqs and
> > kernel threads, therefore its incorrect to state that its deprecated.
> > 
> > Remove deprecation warning.
> > 
> > Suggested-by: Chris Friesen <chris.friesen@windriver.com>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> > +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1926,7 +1926,6 @@
> >  			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
> >  
> >  	isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
> > -			[Deprecated - use cpusets instead]
> >  			Format: [flag-list,]<cpu-list>
> >  
> 
> It's still an absolute horrible piece of crap though. nozh_full piling
> more and more shit on it doesn't make it more shiny.

Hi Peter,

Why do you dislike it? What you think would be a decent approach?

