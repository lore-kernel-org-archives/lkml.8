Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFBF206D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="e8ZFRf5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgEAAR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgEAAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:17:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A50C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:17:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id f12so6039533edn.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcm1TlQpt5t3TCd2yjy0sIUGeLU6kZAnyAeVOLXYjtY=;
        b=e8ZFRf5XzgHqzQWCgg7LdYn6cqPsuHkBcV8hQiRM9fy1nCAleGrU1LduCT7QgDPpR9
         /+vMGUZfMe+wQgkt/2uzF9CUT7tWhv/IOO6sqmbVVVt5vpnmaa6ItB04P0cZvZIUXd+Q
         dEZAfUAaDbvu2vxKb9okHrKC5aYb1F+b0IS3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcm1TlQpt5t3TCd2yjy0sIUGeLU6kZAnyAeVOLXYjtY=;
        b=al1ZBhszutAn/qc0WaSEHKSUwEswQnUuuYOWsMJVK/cwVpvwAhXKGSxCnhMQbo2Q3e
         gpg76y03Q1/ewi6PF6y9fmyr5r5MH3W87DBGhVX3kPUevRWZPzxxVQDEysQt5hYQRPAm
         kK7AXfUVqeNU8/uwbS2I00blMwufUrHtX0AWlfbgKVuaKn9zlMia11PVHSfuhPNwnDt+
         vnr76MgmDJnRGTrGnSQnN60i34F5RHNS3+nvNGBqDQmyehbvZKinUSOgRvdwzUOsD7K3
         NkQ6tsJSXlQK0NhkrS+9YORJiJeKeFuWdt7TEqI8ipPetMshyf0Neta23jeFfDGqBXnP
         /3Yw==
X-Gm-Message-State: AGi0PuYBPYf4w9U7L1AsKYMGDN9AWx4MpPqX367xKwLhtxnEvZVyKF1y
        +qzf6CUyOTOD6YToZNZohJz9Nu/Fvl1UicdBnnk=
X-Google-Smtp-Source: APiQypIA9MuHoa2Mze1RAYr3ZqVBHUJldDWTpcoxtqY/6uKU0RnRUcg9uWGDTOBqJNFZ49Ut+Tajp+cD+G8kMBXsAbw=
X-Received: by 2002:a05:6402:688:: with SMTP id f8mr1439779edy.233.1588292246971;
 Thu, 30 Apr 2020 17:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200128152938.31413-1-changbin.du@gmail.com> <20200129075829.GB1256499@krava>
 <20200130105548.GC3841@kernel.org> <20200217102513.2fb2c691@canb.auug.org.au>
In-Reply-To: <20200217102513.2fb2c691@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 1 May 2020 00:17:14 +0000
Message-ID: <CACPK8Xfk_3Vy4FMzNC5Jb6-exkLVgEm_v-1jqtuH4-v3rXhVzQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Make perf able to build with latest libbfd
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020 at 23:25, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Arnaldo,
>
> On Thu, 30 Jan 2020 11:55:48 +0100 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Jan 29, 2020 at 08:58:29AM +0100, Jiri Olsa escreveu:
> > > On Tue, Jan 28, 2020 at 11:29:38PM +0800, Changbin Du wrote:
> > > > libbfd has changed the bfd_section_* macros to inline functions
> > > > bfd_section_<field> since 2019-09-18. See below two commits:
> > > >   o http://www.sourceware.org/ml/gdb-cvs/2019-09/msg00064.html
> > > >   o https://www.sourceware.org/ml/gdb-cvs/2019-09/msg00072.html
> > > >
> > > > This fix make perf able to build with both old and new libbfd.
> > > >
> > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > Thanks, applied.
>
> Just wondering if this should have been cc'd to stable?

Yes please. We hit this today.

Cheers,

Joel
