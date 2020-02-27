Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03663C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8131246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582817160;
	bh=0Um56LZn+Eug4ig5/+OURujfUw6c+7iD9sXZ0x9rmqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uKn1LCq/IZ4L2WNBmoCuDSsglGTqkHkxC2Peh4CpgpIVaNFjs7sWZ1erZDV9pHkt+
	 AaFn0/3MccaNZdzHvLs2d6/7m3jmuCkA3bebhX7LrH4rWvpjn1Ig1ML+AnqWg0Nzoc
	 RdczM9sU0YxZpyXY/rT394SVtBorQUFmr6IOcFEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgB0PZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgB0PZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:25:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6271D2469F;
        Thu, 27 Feb 2020 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582817159;
        bh=0Um56LZn+Eug4ig5/+OURujfUw6c+7iD9sXZ0x9rmqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U6+3TTCtYbKdZtBOSfvQW4vDH39yx9L6h3RRLC9UGYXZMRvoXWHT6C2cPpBrJRWTP
         7MqfgZuiFG87s6XpCvLIR6jH+6Z6NFu3No2CalNOLiTTht/+Yes4DlAsds4wy1MUta
         C5lfRqEW8x3GzEizIFmKKGRgMsFLIhS1ZcdOaDjs=
Date:   Fri, 28 Feb 2020 00:25:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Perf tool regression from 07d369857808
Message-Id: <20200228002553.31b82876b705aaabbd717131@kernel.org>
In-Reply-To: <2bb02f9b-1413-97c3-684b-104a0fab9144@ghiti.fr>
References: <2bb02f9b-1413-97c3-684b-104a0fab9144@ghiti.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Feb 2020 13:23:19 +0100
Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi Masami,
> 
> The commit 07d369857808 ("perf probe: Fix wrong address verification) 
> found its way in kernel 4.19.98 (and debian 10) and I observed some 
> regressions when I try to add probes in shared libraries.
> The symptoms are:
> 
> $ perf probe -f --exec=/home/aghiti/lib/libdpuhw.so --add 
> 'log_rank_path=log_rank_path rank path:string'
>    Failed to find symbol at 0x3bf0
>      Error: Failed to add events.

Hm...

> 
> Whereas when I revert this patch, on the same shared library:
> 
> $ perf probe -f --exec=/home/aghiti/lib/libdpuhw.so --add 
> 'log_rank_path=log_rank_path rank path:string'
> Added new event:
>    probe_libdpuhw:log_rank_path_4 (on log_rank_path in 
> /home/aghiti/lib/libdpuhw.so.2020.1.0 with rank path:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_libdpuhw:log_rank_path_4 -aR sleep 1
> 
> Actually, I noted that this patch reverts a previous patch that stated 
> that dwfl_module_addrsym could fail on shared libraries 664fee3dc379 
> ("perf probe: Do not use dwfl_module_addrsym if dwarf_diename finds 
> symbol name").

Ah, OK. Hmm, actually, the reason why reverted it was the actuall
address of symbol is unclear if the DIE only has address range.
OK, at first try to find entrypc and if not, try dwlf_module_addrsym().
That will be better idea.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
