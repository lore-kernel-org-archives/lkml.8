Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1640C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF65B2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tykPZ8QP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgDBPPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:15:41 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40099 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbgDBPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:15:41 -0400
Received: by mail-qv1-f66.google.com with SMTP id bp12so1821206qvb.7;
        Thu, 02 Apr 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7DOnlMAmUGrvuNJe9zRYvf+vBCh6g5Wg70XvECaItbA=;
        b=tykPZ8QP/Lz82M2xLKPH0CjS8kdpF4ZkBbWYRzd9VH4EMM39PGBnDa6u702X42gjkI
         n8wirJpSKbJWcwkwQhfZdYdg591Cb8MYQ8ZV+jB6BPxEqHKDuD97SMiIy3NfJxQUPMM+
         mX9HtMgcnmIVbSXEXOktfB1/3YANrldGHXkH6UJtfczPYi2OFZ9CidYkEUNTPVixl9eH
         Us6fXD2l3I4OTsmHC4XHhJcNpnM4PIyVz/icbU/qocAQ5G819CVQaILl0RO9YH/DHDez
         zihbK9DfCpbTHIxXFEWbJxVoHH5suZr8rZzO1XlWEDV8ZTwfA0y+dVxKs5EdIMReHnu/
         +v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7DOnlMAmUGrvuNJe9zRYvf+vBCh6g5Wg70XvECaItbA=;
        b=FUPioPyh6nUsmL2vPLOloLGjlFjZcv5d3eDdDCY3Fq69JGWEgRTl9nTR5ei78qrzx6
         uAONyc+rPReoRSoPsuoSbUVXaV4aS8SF5wHSJbNWyOG+nDKEQCURgqTCy3s50tJGc1Nj
         SiJXqBliQLCSOdL45gGYgP9EBdvqLE49P4/n2AmTVhbx8SclYpkEC78kqjSoor9LopNU
         tEZwiGzpgj1jUHDSKMJIfJSky7GDpr9ZTBxQZU1tBZK9m13YndHWJyh5ZKgnJbjVfeZU
         TkLfSZd2Uh4u2j6hSxr+8qFUb+BbQqaqcRC07mHr31ZantVqr62W/TD3hmWH0QOnDJYt
         DSCw==
X-Gm-Message-State: AGi0PuZmG/nwYXfd9gR7BynKc9EpNQC912h8XA9P4ORHQVm+389ny380
        3anyBYXT9DobPDsfA2c1AQE=
X-Google-Smtp-Source: APiQypKmobzRx81GlxEVwO0k/EB6fdHppAxDO0vypCVX8lQihYI1OzWB8sjMfiOPRqBZg4cSMdEihQ==
X-Received: by 2002:a0c:f684:: with SMTP id p4mr3598084qvn.172.1585840540410;
        Thu, 02 Apr 2020 08:15:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f11sm1460510qkh.41.2020.04.02.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:15:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 981C9409A3; Thu,  2 Apr 2020 12:15:37 -0300 (-03)
Date:   Thu, 2 Apr 2020 12:15:37 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: fix invalid read
Message-ID: <20200402151537.GA8736@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402124337.419456-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402124337.419456-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 02:43:38PM +0200, Andreas Gerstmayr escreveu:
> closedir(lang_dir) frees the memory of script_dirent->d_name, which
> gets accessed in the next line in a call to scnprintf().
> 
> Valgrind report:
> 
> Invalid read of size 1
> ==413557==    at 0x483CBE6: strlen (vg_replace_strmem.c:461)
> ==413557==    by 0x4DD45FD: __vfprintf_internal (vfprintf-internal.c:1688)
> ==413557==    by 0x4DE6679: __vsnprintf_internal (vsnprintf.c:114)
> ==413557==    by 0x53A037: vsnprintf (stdio2.h:80)
> ==413557==    by 0x53A037: scnprintf (vsprintf.c:21)
> ==413557==    by 0x435202: get_script_path (builtin-script.c:3223)
> ==413557==  Address 0x52e7313 is 1,139 bytes inside a block of size 32,816 free'd
> ==413557==    at 0x483AA0C: free (vg_replace_malloc.c:540)
> ==413557==    by 0x4E303C0: closedir (closedir.c:50)
> ==413557==    by 0x4351DC: get_script_path (builtin-script.c:3222)

Thanks, applied to perf/urgent.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 656b347f6dd8..170af13b4d53 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3218,10 +3218,10 @@ static char *get_script_path(const char *script_root, const char *suffix)
>  			__script_root = get_script_root(script_dirent, suffix);
>  			if (__script_root && !strcmp(script_root, __script_root)) {
>  				free(__script_root);
> -				closedir(lang_dir);
>  				closedir(scripts_dir);
>  				scnprintf(script_path, MAXPATHLEN, "%s/%s",
>  					  lang_path, script_dirent->d_name);
> +				closedir(lang_dir);
>  				return strdup(script_path);
>  			}
>  			free(__script_root);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
