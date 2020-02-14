Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5193EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E1A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYbgLjXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgBNNBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:01:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43266 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:01:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so6865143qtj.10;
        Fri, 14 Feb 2020 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INqRxd+8sC97901fxFtdiCwiWAnkOn0AIA7l8xV1mUM=;
        b=hYbgLjXh5gYIIzZFugzw45yUlxd1H/x9PCLdaITfXfQX6sq2ELDQm8cYUGqZKmJitg
         SYuH55OpnJhHy4xM8q/4DkSYx5XzDgO1wY7FHDrXM8Rfv7LQVC4oCQ5jnABH1A0Rd4UB
         yqlPs1xH8Dz3tL6m4xg35MGuWjp+nwbGQaOmP7/c1RFVeXUP5xxH5A4cnAcBLN0TJs82
         wb4QiG/+SKVd67qxa3P80pKs3hA0GsJPpx8TNV0TDX9Qu0jyzM5h1N2YX2OMwU9b/d8W
         ThK/Hj3I8+f1oWy4jDUizS37cD1GlWHl3hC9KXCLGRwvf2WbAM4SMoqZ+cnM5aBsJNxw
         xCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INqRxd+8sC97901fxFtdiCwiWAnkOn0AIA7l8xV1mUM=;
        b=CPW3VOrIQs5ybL9UHSQ5fS2DyMbxcLqSWR12FWorf0Vk7SiLala5s1I+R+17rUZnrn
         LSQa4NKqKzz5mFplkJaYWXrp7N3rrLorKEubTiSMJoIPtu/kRJcgoL+feWalhv0/J1xZ
         qezGyrvncDdHmh7Qh+zdZsv2qR7y3z1fBiAZSDzgTPspq3IxRXQWEN9PrOIH7tVu9f8V
         gxtVZBWIxEar3W6WsEOBfsNF/0o5N3Z6DtxH+Y1cxDNcmUXOeb8g0Gyt5Ycgjne9HUGO
         ju96iq2KQYEexBS1/2UrcuCws3JFaDJlqk0oj3YgiSMsgpuNaNb391ScanIS3A4nldL3
         L28g==
X-Gm-Message-State: APjAAAWFlqZygLntuC+TzZV9yBnsqR4sN/UaYgB1jz+t9J5R88F8U0CQ
        Ggp21SkThedgCMVMKpyYlbZ7ec3m370=
X-Google-Smtp-Source: APXvYqwYTp+wX+BUx3cJsdP/o1uhFSGGi1Xt7wAVkp8uFXagxwEWidkXkqbiQjX4YNXtpc+FF/oW/w==
X-Received: by 2002:ac8:3863:: with SMTP id r32mr2383068qtb.291.1581685260395;
        Fri, 14 Feb 2020 05:01:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x41sm3365677qtj.52.2020.02.14.05.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:00:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E7F4403AD; Fri, 14 Feb 2020 10:00:57 -0300 (-03)
Date:   Fri, 14 Feb 2020 10:00:57 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-ID: <20200214130057.GB13462@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
 <20200213143048.GA22170@kernel.org>
 <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
 <20200213181140.GA28626@kernel.org>
 <20200214094550.228422235c7785519c7f24cc@kernel.org>
 <c249efd1-f705-4739-baad-c94257706489@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c249efd1-f705-4739-baad-c94257706489@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 14, 2020 at 10:44:06AM +0100, Thomas Richter escreveu:
> On 2/14/20 1:45 AM, Masami Hiramatsu wrote:
> > On Thu, 13 Feb 2020 15:11:40 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> >> Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
> >>> On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>  
> >>>> Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> >>>>> This test places a kprobe to function getname_flags() in the kernel
> >>>>> which has the following prototype:
> >>  
> >>>>>   struct filename *
> >>>>>   getname_flags(const char __user *filename, int flags, int *empty)
> >>  
> >>>>> Variable filename points to a filename located in user space memory.
> >>>>> Looking at
> >>>>> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> >>>>> the kprobe should indicate that user space memory is accessed.
> >>  
> >>>>> The following patch specifies user space memory access first and if this
> >>>>> fails use type 'string' in case 'ustring' is not supported.
> >>  
> >>>> What are you fixing?
> >>  
> >>>> I haven't seen any example of this test failing, and right now testing
> >>>> it with:
> >>  
> >>>> [root@quaco ~]# uname -a
> >>>> Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> >>>> [root@quaco ~]#
> >>  
> >>> This bug doesn't happen on x86 or other archs on which user-address space and
> >>> kernel address space is same. On some arch (ppc64 in this case?) user-address
> >>> space is partially or completely same as kernel address space. (Yes, they switch
> >>> the world when running into the kernel) In this case, we need to use different
> >>> data access functions for each spaces. That is why I introduced "ustring" type
> >>> for kprobe event.
> >>> As far as I can see, Thomas's patch is sane.
> >>
> >> Well, without his patch, on x86, the test he is claiming to be fixing
> >> works well, with his patch it stops working, see the rest of my reply.
> > 
> > OK, let me see.
> > 
> > 
> >> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> index 7cb99b433888..30c1eadbc5be 100644
> >> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >> @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
> >>  	local verbose=$1
> >>  	if [ $had_vfs_getname -eq 1 ] ; then
> >>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> >> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> >> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
> >> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> >> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
> >>  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> >>  	fi
> >>  }
> > 
> > This looks no good (depends on architecture or debuginfo). In fs/namei.c,
> > 
> > struct filename *
> > getname_flags(const char __user *filename, int flags, int *empty)
> > ...
> >         kname = (char *)result->iname;
> >         result->name = kname;
> > ...
> >         result->uptr = filename;
> >         result->aname = NULL;
> >         audit_getname(result);
> >         return result;
> > }
> > 
> > And the line number script, egreps below line.
> > 
> >         result->uptr = filename;
> > 
> > However, the probe on this line will hit *before* execute this line.
> > Note that kprobes is a breakpoint, which breaks into this line execution,
> > not after executed.
> > 
> > So, I thik at this point, result->uptr should be NULL, but filename and
> > result->name already have assigned value.
> > 
> > Thus, the fix should be something like below.
> > 
> >> 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> >> - 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> >> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> > 
> > Thomas, is this OK for you too, or would you have any reason to trace
> > result->uptr?
> > 
> > Thank you,
> > 
> 
> Thank you very much for your help!!!
> 
> I started from scratch and just installed linux 5.6.0rc1 without
> any changes and got this failure:
> 
> [root@m35lp76 perf]# ./perf test  66 67
> 66: Use vfs_getname probe to get syscall args filenames   : FAILED!
> 67: Check open filename arg using perf trace + vfs_getname: FAILED!
> [root@m35lp76 perf]#
> 
> Now I applied Masami's patch and this is the result
> 
> [root@m35lp76 perf]# ./perf test  66 67
> 66: Use vfs_getname probe to get syscall args filenames   : Ok
> 67: Check open filename arg using perf trace + vfs_getname: Ok
> [root@m35lp76 perf        
> 
> Can we commit this patch?
> Thanks a lot

So, I'll keep authorship to Thomas but will add a committer note stating
Masami's correction, is that ok?

- Arnaldo
