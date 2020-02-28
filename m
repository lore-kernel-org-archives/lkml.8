Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15559C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B3246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582900568;
	bh=GViqnt9aMahJxT9Ojl/PRqucwOXqJ+vehe0XrxcLudM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C3ZnPZAbekOwJZHsk/qKmnZPGb+SLWzku1VoLHgkY6yHZlNqQznSxCO4uux/gsM4Z
	 UvFWSy7vUCco3fyHjVGPOofMfCXlYvdsUPobOErNz7uqSKbrSGGFkEQAf1hdykYYom
	 MCm6jxvfv7lJr4VdMxH9SOP9mhrXOjC6JYwoVKxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB1OgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgB1OgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:36:07 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCE12469F;
        Fri, 28 Feb 2020 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582900566;
        bh=GViqnt9aMahJxT9Ojl/PRqucwOXqJ+vehe0XrxcLudM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pC27lY0obvs7DuaDAxkIjaU5lldxuXYltK4uhKdgZ7MtZTLXKKCR7gYiH2RhT0AZ6
         nZ2KkS8hIXgsok8xRj4nCbY7so2XcNnapubg2+D9Z59N69Gs0MpbjUYhk7h3s4d1HB
         Nn8fx8JjIZVl5xV3SU48LqnWfnCHKVPY/7icTaBs=
Date:   Fri, 28 Feb 2020 23:36:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-Id: <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
In-Reply-To: <20200228135125.567-4-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, 28 Feb 2020 15:51:15 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.

I like this idea :)

> 
> Note: kprobe insn pages are not used if ftrace is configured. To see the
> effect of this patch, the kernel must be configured with:
> 
> 	# CONFIG_FUNCTION_TRACER is not set
> 	CONFIG_KPROBES=y
> 
> and for optimised kprobes:
> 
> 	CONFIG_OPTPROBES=y
> 
> Example on x86:
> 
> 	# perf probe __schedule
> 	Added new event:
> 	  probe:__schedule     (on __schedule)
> 	# cat /proc/kallsyms | grep '\[kprobe\]'
> 	ffffffffc0035000 t kprobe_insn_page     [kprobe]
> 	ffffffffc0054000 t kprobe_optinsn_page  [kprobe]

Could you make the module name as [kprobes] ?
BTW, it seems to pretend to be a module, but is there no concern of
confusing users? Shouldn't it be [*kprobes] so that it is non-exist
module name?

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
