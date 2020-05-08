Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281A924953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588979672;
	bh=ggeWhiJkgx8aXQBH4eDfcys+JkuNUyxSlnAJtPSjOrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I1ck5fgcCUgLogU3eIsicf07DJx16SnolW9CtDAXuUvl569joVFwnA2WIuT8suWWd
	 TgQymNaimmTRLmdCCXLSgrhtiZfmj0PWvUSv6D3wRYJSD/anYuE00MT12PzosaSnTI
	 XsaSrK3wZ6nYAYdBpDn455lzkyd0t5MRyEzlXRQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgEHXOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgEHXO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:14:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4202184D;
        Fri,  8 May 2020 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588979669;
        bh=ggeWhiJkgx8aXQBH4eDfcys+JkuNUyxSlnAJtPSjOrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HeQmxYheDV2lAzHJtuf1axsqnIfMkCScJ7YbFBSlmc+yjXgeswjFeD4eTTbeItQVa
         G6QkMKYGFC5Hoacnm8gpUdd9DH6sh0uMdsJJvakJYVlq1qvJNYKuvNLcOUcu6i8SSJ
         J5/BVeboqEx6z5oIpTwQKgSm+q1W4r+HvSoMuydc=
Date:   Sat, 9 May 2020 08:14:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tools/bootconfig: Fix apply_xbc() to return zero on
 success
Message-Id: <20200509081424.7d0d21270f1725b5cf9a8535@kernel.org>
In-Reply-To: <20200508111349.3b599bde@gandalf.local.home>
References: <20200508111349.3b599bde@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 11:13:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The return of apply_xbc() returns the result of the last write() call, which
> is not what is expected. It should only return zero on success.
> 
> Link: https://lore.kernel.org/r/20200508093059.GF9365@kadam
> 

Thanks for fixing!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> Fixes: 8842604446d1 ("tools/bootconfig: Fix resource leak in apply_xbc()")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/bootconfig/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 001076c51712..0efaf45f7367 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -337,6 +337,7 @@ int apply_xbc(const char *path, const char *xbc_path)
>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
>  		goto out;
>  	}
> +	ret = 0;
>  out:
>  	close(fd);
>  	free(data);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
