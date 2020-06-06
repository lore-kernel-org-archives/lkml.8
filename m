Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30212073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0AJy4N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgFFO2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgFFO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:28:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C40C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:28:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so4057155pje.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7u1qVPU8ei3Ef7PZLfQaMsYcgDjM67BObJJlV4teDsI=;
        b=D0AJy4N72uYwm4MSASFUmBk8WSw+xgGVFWP57bN3TPQiidVi9aLBNSHW1dliH0Lye1
         xEldqYN3wu6vLC7U5KuDsWVls3H/egWaKEwQGhQbWrffxZOdSuUiI9IUv6iyhbW5TOIE
         mKEWRbF8KK8JNCDemCXkBmwxwvXhVaRZBuX2zwBJKn/zDVgb73DM5nFsQfUF50/ArBbK
         xVLe3Zgz+EG9buV63bmI1GwM9UwXwtqm/dV0fLbPBn4xlhm53lDgPyFSkbeSv5vZdMXd
         JdxW8jXrAW/7EpPhCdRp8HU/E9ewuQVGcWsNn3A1eg8hCrFcfr4b6JnGCSxQbp7y1KTq
         4LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7u1qVPU8ei3Ef7PZLfQaMsYcgDjM67BObJJlV4teDsI=;
        b=N7MxC7BQ/Xz+CGH7JlMmTTpurTvf8pN/0gZ1HPkV1pomwwjxuWeBv5T6tgjcBm7bP5
         KSISzZt6VshyY6LPdVaagc5XQvVeZYGDgNIQvAFH5lnSxjsSWlvrZlBaQM5YGlWzEzHD
         v5dFjcfumpg9LemwQKtAE1N2twBSktCrW53sQldbbyDrtoCwz+kwX1N7l4IQftWnHPwM
         EXG5hNnpIOjcXuxBti1nSRyy382XBQkzB6IWxU9nH0Fmcw4ipZe7v5ZgC+iXlqnT+npe
         bVwKwUy1VmFkWaYvkzQAGgeAvcDrOLH3GBk5vxQu9aN4catCG+iNsNABDs0L89Lhghpx
         yQew==
X-Gm-Message-State: AOAM531+4/HEy8JDnAgdsmTi9sXLOxyicKaVB+U8rXKQpSXp8M8pCaF6
        BCCCtbGvol6rGeWY6thUEDU=
X-Google-Smtp-Source: ABdhPJx9Rex2A48ogQjENkeA/gN0MTEOJ7QMrczLx6REP4r0h/8ohSVU6PloDrxxnmcSv7/iAbK/2g==
X-Received: by 2002:a17:902:6804:: with SMTP id h4mr13843016plk.135.1591453721681;
        Sat, 06 Jun 2020 07:28:41 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q201sm2471637pfq.40.2020.06.06.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:28:40 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:28:33 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/19] perf ftrace: select function/function_graph tracer
 automatically
Message-ID: <20200606142833.l5amhvmvpi26d6g3@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-4-changbin.du@gmail.com>
 <CAM9d7cgAxg_=1ZZHh0JPCRJpH1mpfcR50vu8MAGnQP7WThBpqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgAxg_=1ZZHh0JPCRJpH1mpfcR50vu8MAGnQP7WThBpqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 02:52:23PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Mon, May 11, 2020 at 12:07 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > The '-g/-G' options have already implied function_graph tracer should be
> > used instead of function tracer. So the extra option '--tracer' can be
> > killed.
> >
> > This patch changes the behavior as below:
> >   - By default, function tracer is used.
> 
> Why?  You also removed -t/--tracer option.
>
To save typing. By this way, we do not need the -t/--tracer option which is redundant.
When -G is given, it means graph tracer should be used. If not, function tracer.

> >   - If '-g' or '-G' option is on, then function_graph tracer is used.
> 
> I'm ok with this.
> 
> >   - The perf configuration item 'ftrace.tracer' is removed.
> 
> Why?
> 
As explained above, we don't need this option any longer.

> >   - The default filter for -G is to trace all functions.
> 
> There's no reason to use -G option then.  Also It might be confusing
> if it sees an argument - whether it's a function or a workload.
> 
> I just don't know why you want to change this as we have a way to
> change the default tracer already.
> 
> Thanks
> 
> Namhyung

-- 
Cheers,
Changbin Du
