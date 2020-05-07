Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D5C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0993C208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEGUwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgEGUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:52:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A470D20735;
        Thu,  7 May 2020 20:52:40 +0000 (UTC)
Date:   Thu, 7 May 2020 16:52:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/probe: reverse arguments to list_add
Message-ID: <20200507165239.0264de30@gandalf.local.home>
In-Reply-To: <20200507165053.291ba5ea@gandalf.local.home>
References: <1588879808-24488-1-git-send-email-Julia.Lawall@inria.fr>
        <20200507165053.291ba5ea@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 16:50:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  7 May 2020 21:30:08 +0200
> Julia Lawall <Julia.Lawall@inria.fr> wrote:
> 
> > Elsewhere in the file, the function trace_kprobe_has_same_kprobe uses
> > a trace_probe_event.probes object as the second argument of
> > list_for_each_entry, ie as a list head, while the list_for_each_entry
> > iterates over the list fields of the trace_probe structures, making
> > them the list elements.  So, exchange the arguments on the list_add
> > call to put the list head in the second argument.
> > 
> > Since both list_head structures were just initialized, this problem
> > did not cause any loss of information.
> > 
> > Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>  
> 

Julia,

As this doesn't cause any harm (as you state, both lists have just been
initialized), it doesn't need to go into this -rc release. Would you agree?

-- Steve
