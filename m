Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABDCC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D5820727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbxRNMC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCIMtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:49:00 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43703 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCIMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:49:00 -0400
Received: by mail-qv1-f65.google.com with SMTP id c28so798703qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SoganfhT/6kmEF7NdyeYTuLLQky225D7XquJINa2klo=;
        b=mbxRNMC5nCU6PxmjoR1povA7LMJYLLU4AQeOzNZBXS+/jgRG4+GMnrNijvUtRZHD6i
         8pFjW68OK2PlyhPmMqZdpqwGTePVx8Mg7xguB+dPQcqv2vCAOns7Qf4sKrW4GfBql0QW
         7QdSpeqUDUclu2P6VV48YBXZxuUSJJ8Y3k6dX5SEB+5u/jPTUOpyV+qaKul7v6e4TeNu
         mDYB/3Ag2m4G+VEdneqGLSbZz4aUJVoikDPLh1/wT5u3oi2qUyUqfiokZdcXYqrf9GVD
         TeLV/ZfGOWqEOtaFlgloSowXL1POXSrYiPs/n/xYOeEoAlLT69JI2vfcY6QeLQZZ91n3
         HYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoganfhT/6kmEF7NdyeYTuLLQky225D7XquJINa2klo=;
        b=Eo6hqu4ENoC15CrJ8J4pYjZbPDw8q5PS/aYMVD8xIa8WSaIjdlQ9Vq11Q6haFU/j9v
         zdhKAeibSepnbnqksLTBKqY0gYBOCzzQbzr7/9ImK8JCcJY68U1/44aurb182HwGTgXk
         UXfnYA9fSJqJirbwx8+z3B39iPh6nzZffYZch3+GZGgwje4QqM+a+8v4mqhnWc3eH/ah
         C/oHN6IrsBq2Yr/AqYdDBbH9GK4euGwdo7om7dJus2VL53WXJb8y0/iw3MEsazn47jEw
         tV2K3mC1WZKeFuLvXYU6VjeNgnJxXCV9b4sBEu/zowb2SfsdRYJHwEscn7LzMKbz6+Cl
         fvMA==
X-Gm-Message-State: ANhLgQ1wz2tJ0GjDHTVPihMpi2nDGPTYkCRcOxs0epzaHsj3TnXw81aO
        RFgONtl5l+XWpWa1B2PCxX8=
X-Google-Smtp-Source: ADFU+vsN5Dq3NqzlpTuAnY1dRkkpY5zzhlYz2TNaKIm70hcGssWjZvUKr5RerptGt5rhdh/+XdkFXg==
X-Received: by 2002:a05:6214:421:: with SMTP id a1mr9436305qvy.185.1583758139165;
        Mon, 09 Mar 2020 05:48:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g19sm351454qka.95.2020.03.09.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:48:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E6F040009; Mon,  9 Mar 2020 09:48:56 -0300 (-03)
Date:   Mon, 9 Mar 2020 09:48:56 -0300
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
Message-ID: <20200309124856.GB29841@kernel.org>
References: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
 <20200309123940.GA29841@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309123940.GA29841@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 09:39:40AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 09, 2020 at 11:48:53AM +0100, Dominik 'disconnect3d' Czarnota escreveu:
> > From: disconnect3d <dominik.b.czarnota@gmail.com>
> > 
> > This patch fixes an off-by-one error in strncpy size argument in
> > tools/perf/util/map.c. The issue is that in:
> > 
> >         strncmp(filename, "/system/lib/", 11)
> > 
> > the passed string literal: "/system/lib/" has 12 bytes (without the NULL
> > byte) and the passed size argument is 11. As a result, the logic won't
> > match the ending "/" byte and will pass filepaths that are stored in
> > other directories e.g. "/system/libmalicious/bin" or just
> > "/system/libmalicious".
> > 
> > This functionality seems to be present only on Android. I assume the
> > /system/ directory is only writable by the root user, so I don't
> > think this bug has much (or any) security impact.
> > 
> > Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
> > ---
> > 
> > Notes:
> >     I can't test this patch, so if someone can, please, do so.
> >     
> >     The bug could also be fixed by changing the size argument to `sizeof("string literal")-1` but I am not proposing this change as that would have to be changed in other places.
> 
> So, there are parts of this tools/perf/util/map.c that uses the idiom
> you mention, for instance:
> 
> static inline int is_anon_memory(const char *filename, u32 flags)
> {
>         return flags & MAP_HUGETLB ||
>                !strcmp(filename, "//anon") ||
>                !strncmp(filename, "/dev/zero", sizeof("/dev/zero") - 1) ||
>                !strncmp(filename, "/anon_hugepage", sizeof("/anon_hugepage") - 1);
> }
> 
> So I think we should make all cases use this idim to avoid these
> problems.
> 
> So I'll add your patch, then another, on top, that fixes the other
> off-by-one errors introduced by the android specific code in this patch:

This is the only such off-by-one in that file, and I remembered we have
strstarts(), that we adopted from the kernel sources, so I think its a
better fit, no?

[acme@five linux]$ find . -name "*.c" | grep -v tools/ | xargs grep -w strstarts | wc -l
55
[acme@five linux]$ find tools/ -name "*.c" | xargs grep -w strstarts | wc -l
40
[acme@five linux]$
 
> Fixes: eca818369996 ("perf tools: Add automatic remapping of Android libraries")
> 
> Put this in perf/urgent and then in perf/core move to the more robust
> idiom,
> 
> Thanks,
> 
> - Arnaldo
>      
> >     There are also more cases like this in kernel sources which I am going to report soon.
> >     
> >     Also please note that other path comparisons in this file lack the "/" at the end and it seems they may imply similar issue. I haven't analysed the code deeply to see if that is a real issue.
> >     
> >     This bug has been found by running a massive grep-like search using Google's BigQuery on GitHub repositories data. I am also going to work on a CodeQL/Semmle query to be able to find more sophisticated cases like this that can't be found via grepping.
> > 
> >  tools/perf/util/map.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index a08ca276098e..addd7edb0486 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
> >  		return true;
> >  	}
> >  
> > -	if (!strncmp(filename, "/system/lib/", 11)) {
> > +	if (!strncmp(filename, "/system/lib/", 12)) {
> >  		char *ndk, *app;
> >  		const char *arch;
> >  		size_t ndk_length;
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
