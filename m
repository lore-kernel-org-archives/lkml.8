Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B478208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583399050;
	bh=/6hF5scP1zvZeyIU0B87IO/MHTgoe9Adm/F7cTCYpYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XwMziTKdDrGeKyysVM43FtTIKL297/xthuBpSI3r+npDmoalp7exiIVLV0YkWUxTG
	 +NMc0LlvzwqTxMqGaQZ+Df/CldmhbG7hL9bkAZQf9+WorysDlsBTzKWMJ9IQtj3DXR
	 3O2GvuOzg+St2pgtw+BePBFoBZXONhfmuJXJaOag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCEJEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCEJEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:04:08 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B5B2073D;
        Thu,  5 Mar 2020 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583399048;
        bh=/6hF5scP1zvZeyIU0B87IO/MHTgoe9Adm/F7cTCYpYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQ2cd7ZCPN5x1ut2556O2IwBvL2MV5hGs8f3FzN8+RLKaN89TV60Sq6vbuzpSa6ZG
         fxpaOhNaW6swzZ6Ef02WvH3HetHoW9v2oIWmjb9ewYhZmSk4S6l1PDQwhDeVYfC+Eb
         1iUifiF75fln9brFMB2ZyKjfenhb0PivuyJ1Wkos=
Date:   Thu, 5 Mar 2020 18:04:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 03/13] kprobes: Add symbols for kprobe insn pages
Message-Id: <20200305180402.cf9aa40f57880616d8c8d811@kernel.org>
In-Reply-To: <CAADnVQL1nDy4Fa5Y02r0Mg89nhRTf81ow5tCQxuyHeAztTvj8g@mail.gmail.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
        <20200304090633.420-4-adrian.hunter@intel.com>
        <20200305145852.5756764a9ffe5da10ae71c3e@kernel.org>
        <CAADnVQL1nDy4Fa5Y02r0Mg89nhRTf81ow5tCQxuyHeAztTvj8g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 22:10:10 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Mar 4, 2020 at 10:01 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > >       # perf probe __schedule
> > >       Added new event:
> > >         probe:__schedule     (on __schedule)
> > >       # cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
> > >       ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
> > >       ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]
> > >
> > > Note: This patch adds "__builtin__kprobes" as a module name in
> > > /proc/kallsyms for symbols for pages allocated for kprobes' purposes, even
> > > though "__builtin__kprobes" is not a module.
> >
> > Looks good to me.
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > BTW, would you also make a patch to change [bpf] to [__builtin__bpf]?
> 
> Please do not.
> There is nothing 'builtin' about bpf.

Hmm, so, would we reject bpf.ko to be loaded ?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
