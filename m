Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4012C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E182082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGUyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:54:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59690
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgEGUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:54:01 -0400
X-IronPort-AV: E=Sophos;i="5.73,365,1583190000"; 
   d="scan'208";a="348062927"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2020 22:53:36 +0200
Date:   Thu, 7 May 2020 22:53:36 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/probe: reverse arguments to list_add
In-Reply-To: <20200507165239.0264de30@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.2005072253140.2505@hadrien>
References: <1588879808-24488-1-git-send-email-Julia.Lawall@inria.fr> <20200507165053.291ba5ea@gandalf.local.home> <20200507165239.0264de30@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 May 2020, Steven Rostedt wrote:

> On Thu, 7 May 2020 16:50:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu,  7 May 2020 21:30:08 +0200
> > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > > Elsewhere in the file, the function trace_kprobe_has_same_kprobe uses
> > > a trace_probe_event.probes object as the second argument of
> > > list_for_each_entry, ie as a list head, while the list_for_each_entry
> > > iterates over the list fields of the trace_probe structures, making
> > > them the list elements.  So, exchange the arguments on the list_add
> > > call to put the list head in the second argument.
> > >
> > > Since both list_head structures were just initialized, this problem
> > > did not cause any loss of information.
> > >
> > > Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
>
> Julia,
>
> As this doesn't cause any harm (as you state, both lists have just been
> initialized), it doesn't need to go into this -rc release. Would you agree?

No, no need for -rc.

thanks,
julia
