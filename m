Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E806C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F33206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597754690;
	bh=r7c1fjd16+AVQMuN7nXJ5UVWTq0jGTKJdJiFf7ffPWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWNsPxSpQEzX4Fv14ARLBkA040rhGugDXJhesK+gJGvqFvEmPuCA9HA8cfmdTB75V
	 LMdySmZInvcavl/wkVsalNpMeKk3vHrteXqGfXzKhLuMLnoygLvINzWovR99wwBQP0
	 FVIbKKGyUE0vctUEDuWGFhKAwpV4e8oSwQNOvttA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHRMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgHRMor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:44:47 -0400
Received: from quaco.ghostprotocols.net (179.176.9.68.dynamic.adsl.gvt.net.br [179.176.9.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FBD206B5;
        Tue, 18 Aug 2020 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597754687;
        bh=r7c1fjd16+AVQMuN7nXJ5UVWTq0jGTKJdJiFf7ffPWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbwH2LHVgagPDI+1DFHp6p510rDEm15bVLN5Uj6sG37cW5L1AOFcuJ3LOMDuFJLOT
         X4ILCCCCdUPJzB1lCXPyj9AtUbJooz3Rq+hs31R33J0AQNhoc/YLtLS3XyT6JWdSdC
         2qkv5nrleGpB85i+a/O3xX2BICSzlMiNuKdEtQUo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F37CB40D3D; Tue, 18 Aug 2020 09:44:43 -0300 (-03)
Date:   Tue, 18 Aug 2020 09:44:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] perf top: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200818124443.GB2667554@kernel.org>
References: <1597753837-16222-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597753837-16222-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 18, 2020 at 08:30:37PM +0800, Tiezhu Yang escreveu:
> When I execute perf top without HAVE_LIBBPF_SUPPORT, there exists the
> following segmentation fault, skip the side-band event setup to fix it,
> this is similar with commit 1101c872c8c7 ("perf record: Skip side-band
> event setup if HAVE_LIBBPF_SUPPORT is not set").
> 
> [yangtiezhu@linux perf]$ ./perf top
> 
> <SNIP>
> perf: Segmentation fault
> Obtained 6 stack frames.
> ./perf(sighandler_dump_stack+0x5c) [0x12011b604]
> [0xffffffc010]
> ./perf(perf_mmap__read_init+0x3e) [0x1201feeae]
> ./perf() [0x1200d715c]
> /lib64/libpthread.so.0(+0xab9c) [0xffee10ab9c]
> /lib64/libc.so.6(+0x128f4c) [0xffedc08f4c]
> Segmentation fault
> 
> I use git bisect to find commit b38d85ef49cf ("perf bpf: Decouple
> creating the evlist from adding the SB event") is the first bad
> commit, so also add the Fixes tag.
> 
> Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Yeah, thanks, applying.

- Arnaldo

> ---
>  tools/perf/builtin-top.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 994c230..7c64134 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1746,6 +1746,7 @@ int cmd_top(int argc, const char **argv)
>  		goto out_delete_evlist;
>  	}
>  
> +#ifdef HAVE_LIBBPF_SUPPORT
>  	if (!top.record_opts.no_bpf_event) {
>  		top.sb_evlist = evlist__new();
>  
> @@ -1759,6 +1760,7 @@ int cmd_top(int argc, const char **argv)
>  			goto out_delete_evlist;
>  		}
>  	}
> +#endif
>  
>  	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
>  		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
> -- 
> 2.1.0
> 

-- 

- Arnaldo
