Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D423C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23661246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBFnR84q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB1RUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:20:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50761 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgB1RUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582910417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SLpeFMA4sRAI4ECcBIIKWdo+aICNDL5CSmKLK+F8+i0=;
        b=eBFnR84qp5/7CxRDW1BsPyA7JbI6JC2d/XkXncu2AEDGLZqBtWJS3+eFO3ayL0nfhuLUNG
        w510p31Yb+jZ46ByFRLZb2pFhpNQeVVYFXmDOafos+tNuBTYEHRdQcP5RhABQ+yws56MYj
        juhhKqcIKWiaHaG2VWUlPlTTAnNK3VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-lAPqJ_M1Og6n7jJs4daPvg-1; Fri, 28 Feb 2020 12:20:13 -0500
X-MC-Unique: lAPqJ_M1Og6n7jJs4daPvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DACB610CE7A3;
        Fri, 28 Feb 2020 17:20:10 +0000 (UTC)
Received: from krava (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 437568AC39;
        Fri, 28 Feb 2020 17:20:07 +0000 (UTC)
Date:   Fri, 28 Feb 2020 18:20:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200228172004.GI5451@krava>
References: <20200228135125.567-1-adrian.hunter@intel.com>
 <20200228135125.567-4-adrian.hunter@intel.com>
 <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:36:00PM +0900, Masami Hiramatsu wrote:
> Hi Adrian,
> 
> On Fri, 28 Feb 2020 15:51:15 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> > Symbols are needed for tools to describe instruction addresses. Pages
> > allocated for kprobe's purposes need symbols to be created for them.
> > Add such symbols to be visible via /proc/kallsyms.
> 
> I like this idea :)
> 
> > 
> > Note: kprobe insn pages are not used if ftrace is configured. To see the
> > effect of this patch, the kernel must be configured with:
> > 
> > 	# CONFIG_FUNCTION_TRACER is not set
> > 	CONFIG_KPROBES=y
> > 
> > and for optimised kprobes:
> > 
> > 	CONFIG_OPTPROBES=y
> > 
> > Example on x86:
> > 
> > 	# perf probe __schedule
> > 	Added new event:
> > 	  probe:__schedule     (on __schedule)
> > 	# cat /proc/kallsyms | grep '\[kprobe\]'
> > 	ffffffffc0035000 t kprobe_insn_page     [kprobe]
> > 	ffffffffc0054000 t kprobe_optinsn_page  [kprobe]
> 
> Could you make the module name as [kprobes] ?
> BTW, it seems to pretend to be a module, but is there no concern of
> confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> module name?

note we already have bpf symbols as [bpf] module

jirka

