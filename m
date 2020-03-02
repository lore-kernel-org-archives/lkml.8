Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6ZOyiWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCBOnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:43:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50197 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbgCBOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583160211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DTh1eeDs28NHEo2dJQ0T28Uq7zqauPX5DAtgIFS8qg=;
        b=V6ZOyiWbp8CmXoaUdfCigu1KW+2XFDngu/3sDN3zXdYw5LYIopH9IgBWTIoquQViWRcAK+
        +23ghfvISnOZTjoqycwBE6mGL4v/HMQoUiQS4eMfoj4o+cIS24vBGux2VHR5eiHi6AgkOP
        wG5nT1RjNkbB7sEng2HxddvAKdkJm/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-StHBW8ivOYK2YTHxoV5-rw-1; Mon, 02 Mar 2020 09:43:27 -0500
X-MC-Unique: StHBW8ivOYK2YTHxoV5-rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8325592422;
        Mon,  2 Mar 2020 14:43:25 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C725C122;
        Mon,  2 Mar 2020 14:43:19 +0000 (UTC)
Date:   Mon, 2 Mar 2020 15:43:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200302144307.GD204976@krava>
References: <20200228135125.567-1-adrian.hunter@intel.com>
 <20200228135125.567-4-adrian.hunter@intel.com>
 <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
 <20200228172004.GI5451@krava>
 <20200229134947.839096dbc8321cfdca980edb@kernel.org>
 <20200229184913.4e13e516@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229184913.4e13e516@oasis.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 06:49:13PM -0500, Steven Rostedt wrote:
> On Sat, 29 Feb 2020 13:49:47 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 28 Feb 2020 18:20:04 +0100
> > Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > > BTW, it seems to pretend to be a module, but is there no concern of
> > > > confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> > > > module name?  
> > > 
> > > note we already have bpf symbols as [bpf] module  
> > 
> > Yeah, and this series adds [kprobe(s)] and [ftrace] too.
> > I simply concern that the those module names implicitly become
> > special word (rule) and embedded in the code. If such module names
> > are not exposed to users, it is OK (but I hope to have some comments).
> > However, it is under /proc, which means users can notice it.
> 
> I share Masami's concerns. It would be good to have something
> differentiate local functions that are not modules. That's one way I
> look to see if something is a module or built in, is to see if kallsyms
> has it as a [].
> 
> Perhaps prepend with: '&' ?

that would break some of the perf code.. IMO Arnaldo's explanation
makes sense and we could keep it as it is

jirka

