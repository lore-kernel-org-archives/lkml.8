Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBE520838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgCCOV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgCCOV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:21:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830602073D;
        Tue,  3 Mar 2020 14:21:24 +0000 (UTC)
Date:   Tue, 3 Mar 2020 09:21:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20200303092123.7d398adf@gandalf.local.home>
In-Reply-To: <50754470-7675-c0b0-0931-9a6024e8eb90@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
        <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
        <20200228172004.GI5451@krava>
        <20200229134947.839096dbc8321cfdca980edb@kernel.org>
        <20200229184913.4e13e516@oasis.local.home>
        <20200302144307.GD204976@krava>
        <20200303194700.5810cbaf49bc6eacdffa7fa4@kernel.org>
        <50754470-7675-c0b0-0931-9a6024e8eb90@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 12:55:24 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> If special characters are a problem, modules also do not start with '-' or
> '_', so would "_kprobes" and "_ftrace" be acceptable to everyone?
> 

Or just be blunt about what it is, and append: "__builtin__" to it:

 [__builtin__kprobes]
 [__builtin__ftrace]
 [__builtin__bpf]

-- Steve

