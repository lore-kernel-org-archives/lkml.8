Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F55DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D345C20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTSzaIKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCIMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:39:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40718 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCIMjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:39:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id n5so3189265qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2NUl3yrbQMxKNLJjdgvlZi/g1m/GP4ot7BaIAJGUOzg=;
        b=iTSzaIKWJ08tN9fWrKisSHUVW0d8NW5U31Otm5yZ2cuWtq+hRz3Q6+C+Ts2+AzPFPC
         ObCs9k5H2kENl5Uis9cneZsOLFMuA12Zacpndkm9CTKgIcEtEVPIoMTSDsjZVmwwLH2E
         npzJpL91D+8bT213jF036zQL1krJTqAPHqIq3y2Jni4T18Zvq74l/zcJ4inD82GjCtZc
         jOKXikBeLPUfe9EOB0wkzn4HPR9T3ACRV4M5BNOBZ0GSNyHsHI3UaYcg16ej+wBubKPw
         0fnOb/vFyPtmx8VvW4hB4bo56HQVS+4bgtDGj9Koj1Tl+c6evhFiyLEeX3rb2vI/9LyX
         ia3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2NUl3yrbQMxKNLJjdgvlZi/g1m/GP4ot7BaIAJGUOzg=;
        b=FsC0LolSqm0g9mzbDukjhOxqnIiV4zaP3KChQ5QRi+mwVdvhpsbfnv5CU2sbCr86x0
         ArT1E5LRwHsxf6IMIYNnMfsXy+ls4iYlO35LFaG8VeRZvWT82eOQxBS5rfh0bJYY6tR6
         re0VQo1VZHXvr//o9ld/KVYDhNuQthtqQw9dFplmzVsj+PB2hsXPYAJxvx40pSTB3VWM
         oi4dIHHIeMFySVAPGcdReRWIVV56athhV/FiyVPY1hfzZKBgupWm5kWn75q4I1yq5TkB
         r5OA1329m/i+1N32IrN4Y5wwaGuHVvYvOH++IE+QaEnUQN4pO2Vrt1Oa+B6/UoHsRFEX
         a4QA==
X-Gm-Message-State: ANhLgQ0G7r0ViPKVEZmqIKtWx+aYMXIDHBodX7GUSyVwv96jgB8vmOc5
        NRtVf/hFO3WGdpOD1CIVsOw=
X-Google-Smtp-Source: ADFU+vvJawnqeiSgXufKNH5S9Cr5eYKK3q9/iTAb6WZeHSrfSkRfZEk2RWee+fpjuf7/PE3lf2KkNw==
X-Received: by 2002:ac8:5208:: with SMTP id r8mr14446761qtn.131.1583757584220;
        Mon, 09 Mar 2020 05:39:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v59sm1800434qte.19.2020.03.09.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:39:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD09C40009; Mon,  9 Mar 2020 09:39:40 -0300 (-03)
Date:   Mon, 9 Mar 2020 09:39:40 -0300
To:     Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Michael Lentine <mlentine@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] Fix off by one in tools/perf strncpy size argument
Message-ID: <20200309123940.GA29841@kernel.org>
References: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 11:48:53AM +0100, Dominik 'disconnect3d' Czarnota escreveu:
> From: disconnect3d <dominik.b.czarnota@gmail.com>
> 
> This patch fixes an off-by-one error in strncpy size argument in
> tools/perf/util/map.c. The issue is that in:
> 
>         strncmp(filename, "/system/lib/", 11)
> 
> the passed string literal: "/system/lib/" has 12 bytes (without the NULL
> byte) and the passed size argument is 11. As a result, the logic won't
> match the ending "/" byte and will pass filepaths that are stored in
> other directories e.g. "/system/libmalicious/bin" or just
> "/system/libmalicious".
> 
> This functionality seems to be present only on Android. I assume the
> /system/ directory is only writable by the root user, so I don't
> think this bug has much (or any) security impact.
> 
> Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
> ---
> 
> Notes:
>     I can't test this patch, so if someone can, please, do so.
>     
>     The bug could also be fixed by changing the size argument to `sizeof("string literal")-1` but I am not proposing this change as that would have to be changed in other places.

So, there are parts of this tools/perf/util/map.c that uses the idiom
you mention, for instance:

static inline int is_anon_memory(const char *filename, u32 flags)
{
        return flags & MAP_HUGETLB ||
               !strcmp(filename, "//anon") ||
               !strncmp(filename, "/dev/zero", sizeof("/dev/zero") - 1) ||
               !strncmp(filename, "/anon_hugepage", sizeof("/anon_hugepage") - 1);
}

So I think we should make all cases use this idim to avoid these
problems.

So I'll add your patch, then another, on top, that fixes the other
off-by-one errors introduced by the android specific code in this patch:

Fixes: eca818369996 ("perf tools: Add automatic remapping of Android libraries")

Put this in perf/urgent and then in perf/core move to the more robust
idiom,

Thanks,

- Arnaldo
     
>     There are also more cases like this in kernel sources which I am going to report soon.
>     
>     Also please note that other path comparisons in this file lack the "/" at the end and it seems they may imply similar issue. I haven't analysed the code deeply to see if that is a real issue.
>     
>     This bug has been found by running a massive grep-like search using Google's BigQuery on GitHub repositories data. I am also going to work on a CodeQL/Semmle query to be able to find more sophisticated cases like this that can't be found via grepping.
> 
>  tools/perf/util/map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index a08ca276098e..addd7edb0486 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
>  		return true;
>  	}
>  
> -	if (!strncmp(filename, "/system/lib/", 11)) {
> +	if (!strncmp(filename, "/system/lib/", 12)) {
>  		char *ndk, *app;
>  		const char *arch;
>  		size_t ndk_length;
> -- 
> 2.25.1
> 

-- 

- Arnaldo
