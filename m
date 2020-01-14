Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C165824655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah95R4c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgANPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:47:23 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43059 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgANPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:47:22 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so5855733qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ydg9rjTRJx093ZmuyYebNC6cIBjfP5GhCUaH6S9Qs/4=;
        b=ah95R4c8BckXDaQp1A5GyVlX/lF/jX5lKP7FyWcOA4hzJU6abCY4WdbghjCwqV5kwh
         BrJmqltCtPzPVzT22AZo9sGI3b0THvn6B+4d9i1TzjOpsKNV8yWR0a81gXmHGlUyF4PS
         0TA+xbLO4LBeY2WKuSxoRyxsHV/TFRbNtDuTqMdSxccpDbtGwyDDaQMt/C1EpaTAOHG6
         TYKdX4Bh5IMeU+nKx/ZrJpRDewqdHjnNbyyph8emH8dynjhMFRRHEi83h+XnwB8lBJf/
         UV5VG/78kT40G4reOQEeSILEXvr/wE/jSKssbJMUeBBjIwnTwexs7uD/cVSEx3UkgDZq
         v+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ydg9rjTRJx093ZmuyYebNC6cIBjfP5GhCUaH6S9Qs/4=;
        b=gBuYGtGSxYwccoem36gaOK5dSui0JRUHKPG3MMUKSAT+lEh1wX46RmTvhttg6IuhHd
         hoZWBBuAmm88P+7u6zWA4Fe/4T8h7EG6cPieZcuYzhajh3kA6OD98V+fPI5qI0XPs793
         3s5DeQiWhX/w2xMWrpUTtiA+vBNbggJpeHxyJVScDnywlQyPqgGLjU1Z0BLaqlHQlPe5
         2v66uG/slWjuVgM6l96jHELnxyt3A3mH0ucqdp1rrpkKVMxwS/eNDzY03nWMaxSoJtR2
         G0MlX3ICwnF9s/5LhP130LIcwXjjkbymXqYXAPCDlnC8NdMTib/J/tFjMezGjapou1XR
         68Ug==
X-Gm-Message-State: APjAAAXOsa5Fn598VLtHrpJJST34JlDIIcbUR94Trt6QPzqK97l/wFFx
        E0JUWSKDSL4/8cDUFtvFORc=
X-Google-Smtp-Source: APXvYqwblfeiEfVJ6qt2nVdfeENIWDMHFwXXzfkg1d/OaxDCHQqk6oyNhPAuzOEXJaCfcKiJ8hOytA==
X-Received: by 2002:a05:6214:1348:: with SMTP id b8mr17283773qvw.137.1579016841502;
        Tue, 14 Jan 2020 07:47:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n3sm6788632qkn.105.2020.01.14.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:47:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D124E40DFD; Tue, 14 Jan 2020 12:47:18 -0300 (-03)
Date:   Tue, 14 Jan 2020 12:47:18 -0300
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: perf: fix augmented syscall format warning
Message-ID: <20200114154718.GC20569@kernel.org>
References: <20200113174438.102975-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113174438.102975-1-cengiz@kernel.wtf>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 13, 2020 at 08:44:39PM +0300, Cengiz Can escreveu:
> sockaddr related examples given in
> `tools/perf/examples/bpf/augmented_syscalls.c` almost always use `long`s
> to represent most of their fields.
> 
> However, `size_t syscall_arg__scnprintf_sockaddr(..)` has a `scnprintf`
> call that uses `"%#x"` as format string.
> 
> This throws a warning (whenever the syscall argument is `unsigned
> long`).
> 
> Added `l` identifier to indicate that the `arg->value` is an unsigned
> long.

arg->val is a 'unsigned long', so yeah, we can make that lx to make it
work in more places,

In fact it should be fallbacking to this, that does just like you did
here:

size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg)
{
        return scnprintf(bf, size, "%#lx", arg->val);
}

It is in tools/perf/builtin-trace.c

Thanks,

-  Arnaldo
 
> Not sure about the complications of this with x86 though.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  tools/perf/trace/beauty/sockaddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
> index 173c8f760763..e0c13e6a5788 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
> @@ -72,5 +72,5 @@ size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg
>  	if (arg->augmented.args)
>  		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
> 
> -	return scnprintf(bf, size, "%#x", arg->val);
> +	return scnprintf(bf, size, "%#lx", arg->val);
>  }
> --
> 2.24.1
> 

-- 

- Arnaldo
