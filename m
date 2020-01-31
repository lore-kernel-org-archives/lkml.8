Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53AFC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6721734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBTQCCZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgAaIgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:36:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51688 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:36:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so6939416wmi.1;
        Fri, 31 Jan 2020 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9k5Bfs5SLrPsJzI/LbYVUmLiovQ4hXieUcsFHRvOXU=;
        b=oBTQCCZl6HplkcZDKbu3+NzYhXLJuNULp1zS6+CwIRvpDg0xYKFBauS6e8MzA2ZI7A
         i0P21q00Sw9LIbhcI5+7DZ13OmO/1gR99ybGGrjEOBzyoc605fKuYCtXubjy3ENmq+KN
         zZWCCIczHExJ998WPxskWKkHJayjEPMub9F0jmRRVUd+ysils9+WN77w4H7HMX2Ud3fw
         5DLDU0FaCCjcFE3V9x3eCbY9fhiBMmmhl+sahtVAGCM13igj3gyV8eV0Tud6Yx0R4d7Y
         q8kLy8058nALXbUkhsbCWiNz9BfRDIP7JNxp/3NsTfmiLQ3ba5mdRQDvbZ+eARcNMWDG
         y7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9k5Bfs5SLrPsJzI/LbYVUmLiovQ4hXieUcsFHRvOXU=;
        b=EJ56v2NXgKtf4sGvV7EOvIDmouUB/GODRnPjC6SjiTPmunac5hJb1RYOQjfI8eSmey
         CNdDkFFZpqkRs2mbLdeSowTuc8t7Le29RtdRBzXfTwCf3F5Ze9Yjgpbm3f0yExWZsfmM
         tpggF00ZXYdLXj6CKpbZob7rgvy+4RgiJMo08eCTvoPipqGsei/tEtV67CEEeLWsgu3N
         /t1fx0u5NSRAtICsSz7cWQ2Y//9nsYES4G/d6OaEmq2bPquZWodGPrB0wAvXqXCb8weA
         lpJKe7dBtchlNASjzrpjMOk1k7JIsekASTaI3zz9MVrfl7K2EAMAoqOS4K4zlNVqwKHD
         XdJg==
X-Gm-Message-State: APjAAAUe3qj8j7q41b9Iy7pknC567JE86oxzKaWXWCDxrpE/ETd8vG4y
        Humd0cqtZ+BAuV1aDCCYPCs=
X-Google-Smtp-Source: APXvYqyn06/qdNRwbp6v9OznwKKaB4XjqdQ4MBCtVALUWPvoYrd2k6XfESJ5l5yfGK+m6cVK6uaN2w==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr10106792wmg.143.1580459781168;
        Fri, 31 Jan 2020 00:36:21 -0800 (PST)
Received: from quaco.ghostprotocols.net (catv-212-96-54-169.catv.broadband.hu. [212.96.54.169])
        by smtp.gmail.com with ESMTPSA id u8sm9931320wmm.15.2020.01.31.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:36:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E07840A7D; Fri, 31 Jan 2020 09:36:19 +0100 (CET)
Date:   Fri, 31 Jan 2020 09:36:19 +0100
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2] perf test: Fix test trace+probe_vfs_getname.sh
Message-ID: <20200131083619.GG3841@kernel.org>
References: <20200120132011.64698-1-tmricht@linux.ibm.com>
 <20200120132011.64698-3-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120132011.64698-3-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 20, 2020 at 02:20:11PM +0100, Thomas Richter escreveu:
> This test places a kprobe to function getname_flags() in the kernel
> which has the following prototype:
> 
>   struct filename *
>   getname_flags(const char __user *filename, int flags, int *empty)
> 
> Variable filename points to a filename located in user space memory.
> Looking at
> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> the kprobe should indicate that user space memory is accessed.

We can't just replace it, right? I.e. this should continue to work with
older kernels, i.e. the latest userspace tooling version should work
when installed in an older kernel, i.e. please just add more fallbacks
to cover the new cases.

- Arnaldo
 
> Fix this with a patch to specify user space memory access to
> parameter 'filename' and 'string' is replaced by 'ustring'.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 7cb99b433888..7ecf117651dd 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,8 +13,8 @@ add_probe_vfs_getname() {
>  	local verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> -		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
>  	fi
>  }
>  
> -- 
> 2.21.0
> 

-- 

- Arnaldo
