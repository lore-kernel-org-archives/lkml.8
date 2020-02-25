Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FEC4BA00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358BF21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582670091;
	bh=UOlSQxvVm/kBdia7kbMThkXl+l65D3+ArFpNE9ORreA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PJ/sx7JZMTcTumNnOYp/gaQ/6nFJLXKpK/kyIBOVjMPl4J93mt0g2I3kHZj20OKOd
	 MGhKBKhsPBP9BHy0Jm0Q+BX9TSuAVbFIPJ6abGokMPJFJnTI8d1qZUA/gr04iZP1LO
	 FYx6Oq8wTiYJqcuXxP4JAawNE3+39u3Wv3kFA+F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBYWeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgBYWet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:34:49 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9942176D;
        Tue, 25 Feb 2020 22:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582670088;
        bh=UOlSQxvVm/kBdia7kbMThkXl+l65D3+ArFpNE9ORreA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRGgdYGazBdAqAHUDhZdY2pErIwVIT2lcMZdSLXkV+kWU7qtT2as8YYmgDsGJ4OFD
         0Wzjwpux/cGv8aMKNAAjtVooLiPsoFlaSX+zrbp0cWbf4g7hgaNT0zRiNh7BNxp2SR
         Xui5tmBAVCC4hLSdahbgBabO7mu4U1JsLZDlg/Fs=
Date:   Wed, 26 Feb 2020 07:34:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     <zhe.he@windriver.com>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <kstewart@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf: Fix checking of duplicate probe to give
 proper hint
Message-Id: <20200226073443.3f6b44422104873dc0397d0e@kernel.org>
In-Reply-To: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
References: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reporting. This bug has been reported and I should fixed last year...

https://lkml.org/lkml/2019/12/3/136

Arnaldo, haven't you picked it yet?

Thank you,


On Tue, 25 Feb 2020 22:41:42 +0800
<zhe.he@windriver.com> wrote:

> From: He Zhe <zhe.he@windriver.com>
> 
> Since commit 72363540c009 ("perf probe: Support multiprobe event") and its
> series, if there are multiple probes for one event,
> __probe_file__get_namelist would return -EEXIST and cause the following
> failure without proper hint, due to adding existing entry to output list.
> 
> root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
> Added new events:
>   probe_libc:free      (on free in /lib64/libc-2.31.so)
>   probe_libc:free      (on free in /lib64/libc-2.31.so)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe_libc:free -aR sleep 1
> 
> root@qemuarm64:~# perf probe -l
>   probe_libc:free      (on free@plt in /lib64/libc-2.31.so)
>   probe_libc:free      (on cfree in /lib64/libc-2.31.so)
> root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
>   Error: Failed to add events.
> 
> As we just want to check if there is any probe with the same name, -EEXIST
> can be ignored, so we can have the right hint as before.
> 
> root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
> Error: event "free" already exists.
>  Hint: Remove existing event by 'perf probe -d'
>        or force duplicates by 'perf probe -f'
>        or set 'force=yes' in BPF source.
>   Error: Failed to add events.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/util/probe-file.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 5003ba403345..cf44c05f89c1 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -201,10 +201,16 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
>  		if (include_group) {
>  			ret = e_snprintf(buf, 128, "%s:%s", tev.group,
>  					tev.event);
> -			if (ret >= 0)
> +			if (ret >= 0) {
>  				ret = strlist__add(sl, buf);
> -		} else
> +				if (ret == -EEXIST)
> +					ret = 0;
> +			}
> +		} else {
>  			ret = strlist__add(sl, tev.event);
> +			if (ret == -EEXIST)
> +				ret = 0;
> +		}
>  		clear_probe_trace_event(&tev);
>  		if (ret < 0)
>  			break;
> -- 
> 2.24.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
