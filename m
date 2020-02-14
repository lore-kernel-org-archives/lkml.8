Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9AEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AA5222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucraOnwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgBNNEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:04:36 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38829 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:04:35 -0500
Received: by mail-qv1-f68.google.com with SMTP id g6so4228869qvy.5;
        Fri, 14 Feb 2020 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULuHx4PQiAOs6P6zV7ZtWrkeHQ7LctygzFqa2QpLcO0=;
        b=ucraOnwiLLABpiGdUGKW2SJXBTawsAEj40m7VFzdQMHzlxGYY3ATJFzypD2XaqHeYk
         Smat/9z5Z94ZX8oCr44X1Rx2VEnjU2yL2RzUl61XFJfESYrOiAKiVs3GH0AJJNkT5lDY
         2GGEqEuUAFs0NAnmMwTrWwvpE4W8klzyBm6CR01y08spundv7PY7O5Y4F9Ts4BOKm+Se
         5TuuWPJtbTHR6UlRr/CMN6ITKnfpLMuhzOmZRr2A3U3wFyFBb18uZOP0WRALt2DFqnLE
         cVcASeGtMNbulGjLYxCZq/idm7xZYUDEqxWAiC/wehkjXCfUGg/jB1YP3EoCzPJ4+Mj0
         ZXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULuHx4PQiAOs6P6zV7ZtWrkeHQ7LctygzFqa2QpLcO0=;
        b=gPYPWeJwxxv6tWEaNo21SPXAYMiHzDQkOpSMtmXtsq50ntsAhHmETrt0QR6/KNgOWJ
         LqzGoEFKITWpkgwoq69MwpQuIWIHtiwlnc99Wlf+WqcJh1D6lUbe856nyApZkwwtVXnG
         vhyEW4rABJkFTZJyMyHfKncf+82jaMU1FvZF0xXh1tq8BFP7pjkDa7wuHvmtBMZNl+CQ
         8man3nUbE55cGWyh5QLHyC9aENnvERBZ94/jKoweIdVsI9mEmsAAF4wHRXrKXZtDUiSp
         XOQ4SjZuUzYCXGtdd5bf0IoiyM5Ug7dE9o1RWtuxPipsi/qY2fTrAmwg/GI09pEUR2FA
         TThw==
X-Gm-Message-State: APjAAAVWbnhe/6MC/QrGLOFk2mYKYN/ZNXtsSgusJcnkDFkUX6IboIDV
        sTQWe/Mykc5T8i8POE4cbNY=
X-Google-Smtp-Source: APXvYqySA0Z0UP9qoPSITGU6fyp5N7Z/K7CLUhB6Q+JHILYZpl4OTz4SN+Rs3ULFU5ZlmsA0ehOxTw==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr2069996qvb.122.1581685473218;
        Fri, 14 Feb 2020 05:04:33 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v82sm3242739qka.51.2020.02.14.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:04:32 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6F98403AD; Fri, 14 Feb 2020 10:04:30 -0300 (-03)
Date:   Fri, 14 Feb 2020 10:04:30 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-ID: <20200214130430.GC13462@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
 <20200213143048.GA22170@kernel.org>
 <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
 <20200213181140.GA28626@kernel.org>
 <20200214094550.228422235c7785519c7f24cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214094550.228422235c7785519c7f24cc@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 14, 2020 at 09:45:50AM +0900, Masami Hiramatsu escreveu:
> On Thu, 13 Feb 2020 15:11:40 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
> > > On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >  
> > > > Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> > > > > This test places a kprobe to function getname_flags() in the kernel
> > > > > which has the following prototype:
> >  
> > > > >   struct filename *
> > > > >   getname_flags(const char __user *filename, int flags, int *empty)
> >  
> > > > > Variable filename points to a filename located in user space memory.
> > > > > Looking at
> > > > > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > > > > the kprobe should indicate that user space memory is accessed.
> >  
> > > > > The following patch specifies user space memory access first and if this
> > > > > fails use type 'string' in case 'ustring' is not supported.
> >  
> > > > What are you fixing?
> >  
> > > > I haven't seen any example of this test failing, and right now testing
> > > > it with:
> >  
> > > > [root@quaco ~]# uname -a
> > > > Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > [root@quaco ~]#
> >  
> > > This bug doesn't happen on x86 or other archs on which user-address space and
> > > kernel address space is same. On some arch (ppc64 in this case?) user-address
> > > space is partially or completely same as kernel address space. (Yes, they switch
> > > the world when running into the kernel) In this case, we need to use different
> > > data access functions for each spaces. That is why I introduced "ustring" type
> > > for kprobe event.
> > > As far as I can see, Thomas's patch is sane.
> > 
> > Well, without his patch, on x86, the test he is claiming to be fixing
> > works well, with his patch it stops working, see the rest of my reply.
> 
> OK, let me see.
> 
> 
> > diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > index 7cb99b433888..30c1eadbc5be 100644
> > --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
> >  	local verbose=$1
> >  	if [ $had_vfs_getname -eq 1 ] ; then
> >  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> > -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> > +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
> > +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> > +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
> >  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> >  	fi
> >  }
> 
> This looks no good (depends on architecture or debuginfo). In fs/namei.c,
> 
> struct filename *
> getname_flags(const char __user *filename, int flags, int *empty)
> ...
>         kname = (char *)result->iname;
>         result->name = kname;
> ...
>         result->uptr = filename;
>         result->aname = NULL;
>         audit_getname(result);
>         return result;
> }
> 
> And the line number script, egreps below line.
> 
>         result->uptr = filename;
> 
> However, the probe on this line will hit *before* execute this line.
> Note that kprobes is a breakpoint, which breaks into this line execution,
> not after executed.
> 
> So, I thik at this point, result->uptr should be NULL, but filename and
> result->name already have assigned value.
> 
> Thus, the fix should be something like below.
> 
> > 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> > - 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> > +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> 
> Thomas, is this OK for you too, or would you have any reason to trace
> result->uptr?

Ok, I retract my last e-mail, can you provide a final patch with the fix?

- Arnaldo
