Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64703C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3932A20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583250057;
	bh=g+1uGhmXpNeGk4q36N6lI30U5NhLEsvqrrTBmPZe9bc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w8S1NmjVLYvjqwlURnr9O7h5qAq0Mir9dLRRTA21j/XEQOHo/aBmfzzxb+6HdBsKR
	 Rc2MDlvkvZHGGH2PIzVGCnsNKarfWudjT9LKbhtDsdtGs7qiSKmkrDKt2yY/aySPQ5
	 pRvRumJkZU8xQt2g2LB/MA8iZBDTmsg7W+3RPVww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgCCPk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgCCPkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:40:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F59720842;
        Tue,  3 Mar 2020 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583250055;
        bh=g+1uGhmXpNeGk4q36N6lI30U5NhLEsvqrrTBmPZe9bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEpoH3rHZt8C7hFld4jc3qyGJTLrNrEVph4djIXCuFEfqtLj7Okrohn0VSfTveuIl
         LzCTqn/6n9J4g+vesZe0w6BJATA5m/eWmtWaSV+KGkyMXgQpjTfn2ClBrJSrY5WyUJ
         9hoPhRLWBfAwfb6bZ97o7gcukIG4U42MvGYbl7xc=
Date:   Wed, 4 Mar 2020 00:40:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Pseudo module name in kallsyms (Re: [PATCH V3 03/13]
 kprobes: Add symbols for kprobe insn pages)
Message-Id: <20200304004049.cadb2294191fc67adea42f62@kernel.org>
In-Reply-To: <20200303092123.7d398adf@gandalf.local.home>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
        <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
        <20200228172004.GI5451@krava>
        <20200229134947.839096dbc8321cfdca980edb@kernel.org>
        <20200229184913.4e13e516@oasis.local.home>
        <20200302144307.GD204976@krava>
        <20200303194700.5810cbaf49bc6eacdffa7fa4@kernel.org>
        <50754470-7675-c0b0-0931-9a6024e8eb90@intel.com>
        <20200303092123.7d398adf@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 09:21:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Mar 2020 12:55:24 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> > If special characters are a problem, modules also do not start with '-' or
> > '_', so would "_kprobes" and "_ftrace" be acceptable to everyone?
> > 
> 
> Or just be blunt about what it is, and append: "__builtin__" to it:
> 
>  [__builtin__kprobes]
>  [__builtin__ftrace]
>  [__builtin__bpf]

Good idea! It clearly states what it is.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
