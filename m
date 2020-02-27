Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB93C54FD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOvxEUD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgB0OLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:11:22 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45996 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388676AbgB0OLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:11:15 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so1558220qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLr0ZAwrO1mv1uzfnhw0tAaDfT0XQ1i/nVn5S42DxGA=;
        b=nOvxEUD+oAOLn9Sm/1KnVy17oeAhV/GzYfJ5fTgj/DwHvgL8OD1QaPwDS1TV5cp8q9
         IKjr49ROwLGj8GZWRMANPRLD6DuzMGvoKhvjv4Jf7+5S1ulG+1I2/MwoXuAOLLTwVMeO
         2vJ+q6voNgjE3xMsDDAxRJ79JoclIaMyn6g4EN8hqjljc/Dg4NkLmSOag/RWEuBFdIIs
         tPXvmYqIn0ycczi5RoSaj9jMzFiCnMk7VkdlfQDcVMYqNQkXjzBeU0NW/jFugpkQ3Cxq
         limHqCevatoynv24lvMPruyE4lFf8YXd8O+KIwWWaQMUsgOTRCwK0njYnsvn/sPYzzlh
         zahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLr0ZAwrO1mv1uzfnhw0tAaDfT0XQ1i/nVn5S42DxGA=;
        b=ctiYVHTWmTsK0zre9cWUyre/rOGrf1G8xe0Wk9i5lE+zLWpkAPBtkh8Ydwl+fD/FnK
         clBEGhSt5+dmAfvV8jd5EkfyjOSESJN1u3dr5LlF3Rsyxsx5CAdj6XpRy43eWhjGWj77
         LCyhBjdUmKQZN1O88AUa/aCqxP+gjLMdGG8gnXHKvbfga5LwLlvKmSaeB2xv9QmNknP2
         UdQKcQlJa51eDjsOHy+EKjJGe9vxxEd7138N6FUdgxCx8GJk1Pc8YesP8VkpYd9mEWV7
         SOo72X3/7YsHGj6yaS/XVeAKI/yBAWbGpGnIOgILwxnlDCcGyInWFWYWUbCnxG75IRAY
         vGIg==
X-Gm-Message-State: APjAAAX6tgfdq4+9IOifNAqtGvO6woG/OursMTJ1OzTWlIv9NYnkMrdj
        fweYSyoXLoqC4F0ICVQ7jfE=
X-Google-Smtp-Source: APXvYqwBStL+b0Z0v+Q1EI4wHJ/9f9/po04jkKPFbG5MD2yI7XTyGuAhQ0CgZ4TeZZf37ekbw+dTAg==
X-Received: by 2002:ad4:4511:: with SMTP id k17mr4866897qvu.135.1582812673342;
        Thu, 27 Feb 2020 06:11:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n32sm3225222qtk.66.2020.02.27.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 06:11:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 697C4403AD; Thu, 27 Feb 2020 11:11:10 -0300 (-03)
Date:   Thu, 27 Feb 2020 11:11:10 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, namhyung@kernel.org,
        irogers@google.com, songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
Message-ID: <20200227141110.GF10761@kernel.org>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
 <20200206190412.GD1669706@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206190412.GD1669706@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 06, 2020 at 08:04:12PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 04, 2020 at 10:22:27AM +0530, Ravi Bangoria wrote:
> > Few fixes / improvements related to perf annotate.
> > 
> > v2: https://lore.kernel.org/r/20200124080432.8065-1-ravi.bangoria@linux.ibm.com
> > 
> > v2->v3:
> >  - [PATCH v3 2/6] New function annotation_line__exit() to clear
> >    annotation_line objects.
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks applied the series to perf/urgent as it contains a fix.

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > v1: http://lore.kernel.org/r/20200117092612.30874-1-ravi.bangoria@linux.ibm.com
> > 
> > v1->v2:
> >  - Split [PATCH v1 1/3] into two patches.
> >  - Patch 5 and patch 6 are new.
> > 
> > Ravi Bangoria (6):
> >   perf annotate: Remove privsize from symbol__annotate() args
> >   perf annotate: Simplify disasm_line allocation and freeing code
> >   perf annotate: Align struct annotate_args
> >   perf annotate: Fix segfault with source toggle
> >   perf annotate: Make few functions static
> >   perf annotate: Get rid of annotation->nr_jumps
> > 
> >  tools/perf/builtin-top.c     |   2 +-
> >  tools/perf/ui/gtk/annotate.c |   2 +-
> >  tools/perf/util/annotate.c   | 115 ++++++++++++++---------------------
> >  tools/perf/util/annotate.h   |   8 +--
> >  4 files changed, 49 insertions(+), 78 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
> 

-- 

- Arnaldo
