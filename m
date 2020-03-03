Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5331BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A6620637
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583231759;
	bh=/zMw2q7ULuAGKPfuZ9bQk/oOfY11qHXyuqXWfDzlkVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EVq0u4/eUOGGbEaj65MPAkpGXmBdxJcAIZFbos5GDa0dOK8jhnIU0ny78btyr/9XY
	 IoI+TYV5QqSTPjT6lnVZCJX2Ry/iz9Vz9CqBvU2JS/EFaTp7LmWIEttDkk6w1/UszZ
	 hCzTxcFPq9Hag/ALrMxpvZnAyWSjKBXuvqRNwrc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgCCKf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgCCKf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:35:57 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1F220409;
        Tue,  3 Mar 2020 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583231757;
        bh=/zMw2q7ULuAGKPfuZ9bQk/oOfY11qHXyuqXWfDzlkVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JYWTPz/zRcNERJktYI8HnUz6UuozjhxnH5EQ/4UaZZ2Dnojffn1OjGpzq44+X+0eF
         EITtpC+eKeRmHEv8cz36F0vTDb4ahlJPb27pGheZmw1Le9tJhNOlpSaHKN36yl1YYm
         uytS2CbICjflzbg8H7GeRbXOpozPt9wLLCYd8jgc=
Date:   Tue, 3 Mar 2020 19:35:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] Introduce Control-flow Enforcement opcodes
Message-Id: <20200303193550.692bf2be0ee800c21bd05215@kernel.org>
In-Reply-To: <20200204171425.28073-1-yu-cheng.yu@intel.com>
References: <20200204171425.28073-1-yu-cheng.yu@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  4 Feb 2020 09:14:23 -0800
Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> Control-flow Enforcement (CET) introduces 10 new instructions [1].  Add
> them to the opcode map.  This series has been separated from the CET
> patches [2] for ease of review.
> 
> [1] Detailed information on CET can be found in "Intel 64 and IA-32
>     Architectures Software Developer's Manual":
> 
>     https://software.intel.com/en-us/download/intel-64-and-ia-32-
>     architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4
> 
> [2] CET patches:
> 
>     https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
>     https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Sorry, somewhat I've missed this series...

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thank you,

> 
> Adrian Hunter (1):
>   x86/insn: perf tools: Add CET instructions to the new instructions
>     test
> 
> Yu-cheng Yu (1):
>   x86/insn: Add Control-flow Enforcement (CET) instructions to the
>     opcode map
> 
>  arch/x86/lib/x86-opcode-map.txt              |  17 +-
>  tools/arch/x86/lib/x86-opcode-map.txt        |  17 +-
>  tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 112 +++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 196 +++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-src.c | 236 +++++++++++++++++++
>  5 files changed, 566 insertions(+), 12 deletions(-)
> 
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
