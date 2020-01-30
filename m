Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D3C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2037320661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwvN15vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgA3Kzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:55:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Kzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:55:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3674476wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kt7HAhJ250QKlm+prfn9G61LylW+yIqwv6cj/bQWNRo=;
        b=VwvN15vfAc3KV+UVggIL9kXNiYk1m/kHlQ+rc+giZckCEkmUrH4z86Q9sRuh38KKzE
         6n9f+xAQNyC54akdxXh76ENZvcjPt2jlJhKiYCsaqcOIeuB8MGp+eUq1xcX8UJ+IPzdy
         ys3ppW6ohDf2fhc8w9IKvHZR2K90A728zl1lWs2tPaSm7lqwJd/B54shFn0kWHdrfsCH
         ts5SUv5n/LMuqX41Cq1JKEiL3zjttqBQ6sy1BZ1HRMLxq11o4EmimJCbgSX+ycf3nqIr
         /obTQo2Sbbl+gdvxjhgLpy0j+8VX31nxKc/HKHeiBgtAu6flEtOgZVV8qV4AeT4goN1T
         +orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kt7HAhJ250QKlm+prfn9G61LylW+yIqwv6cj/bQWNRo=;
        b=iFW54KUd/FAZzbhG8M51os3PP0Yk3Wx88vx92Fpzx1299M2Og3SzLed2alfSAo7Ien
         MLpsHOn4mBcfhUzP6D4mGtSIEfd9i+M0753bS09pycyI63x5q2lD3d8MbCgwE3DDu7NI
         BRX56C4qcm3kr5/HAScEPqrkvcm+Zqe60I0sATXG/WfVodiZcm13UtvFA8WgT5E5XDqz
         j+2a1ScZcPV5pUT7pYIunEuKVEtynrpBbDYKvX/e4no6OguYYl888wa5oQKMwShYkYa4
         AlS/MjS3m4IAv5zQC3PMKZDi9vaOj3bv8Qsk6kSlsbFHqRd/gJ1R49AIqvCwPM9hH3tc
         bJVg==
X-Gm-Message-State: APjAAAUleFTq4l2TfemW36vWBHmBG+4kwF5q0rwPqbKR0Kjrh//iVGxv
        D7iTKQVG10BOirWtXC6WkxQ=
X-Google-Smtp-Source: APXvYqyb5iKo8leWq7gU8O3XAk6/h9oyj1KhnBZz5KEOnzSSCs/Xzm5hMWopzCLd3W0rvOThz4lgtw==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5002060wml.138.1580381750651;
        Thu, 30 Jan 2020 02:55:50 -0800 (PST)
Received: from quaco.ghostprotocols.net (20014C4D19C29300C4AE62814D0D5430.dsl.pool.telekom.hu. [2001:4c4d:19c2:9300:c4ae:6281:4d0d:5430])
        by smtp.gmail.com with ESMTPSA id m21sm6049457wmi.27.2020.01.30.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:55:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1EBC40A7D; Thu, 30 Jan 2020 11:55:48 +0100 (CET)
Date:   Thu, 30 Jan 2020 11:55:48 +0100
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Make perf able to build with latest libbfd
Message-ID: <20200130105548.GC3841@kernel.org>
References: <20200128152938.31413-1-changbin.du@gmail.com>
 <20200129075829.GB1256499@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129075829.GB1256499@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 29, 2020 at 08:58:29AM +0100, Jiri Olsa escreveu:
> On Tue, Jan 28, 2020 at 11:29:38PM +0800, Changbin Du wrote:
> > libbfd has changed the bfd_section_* macros to inline functions
> > bfd_section_<field> since 2019-09-18. See below two commits:
> >   o http://www.sourceware.org/ml/gdb-cvs/2019-09/msg00064.html
> >   o https://www.sourceware.org/ml/gdb-cvs/2019-09/msg00072.html
> > 
> > This fix make perf able to build with both old and new libbfd.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> 
> > ---
> >  tools/perf/util/srcline.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 6ccf6f6d09df..5b7d6c16d33f 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -193,16 +193,30 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
> >  	bfd_vma pc, vma;
> >  	bfd_size_type size;
> >  	struct a2l_data *a2l = data;
> > +	flagword flags;
> >  
> >  	if (a2l->found)
> >  		return;
> >  
> > -	if ((bfd_get_section_flags(abfd, section) & SEC_ALLOC) == 0)
> > +#ifdef bfd_get_section_flags
> > +	flags = bfd_get_section_flags(abfd, section);
> > +#else
> > +	flags = bfd_section_flags(section);
> > +#endif
> > +	if ((flags & SEC_ALLOC) == 0)
> >  		return;
> >  
> >  	pc = a2l->addr;
> > +#ifdef bfd_get_section_vma
> >  	vma = bfd_get_section_vma(abfd, section);
> > +#else
> > +	vma = bfd_section_vma(section);
> > +#endif
> > +#ifdef bfd_get_section_size
> >  	size = bfd_get_section_size(section);
> > +#else
> > +	size = bfd_section_size(section);
> > +#endif
> >  
> >  	if (pc < vma || pc >= vma + size)
> >  		return;
> > -- 
> > 2.24.0
> > 
> 

-- 

- Arnaldo
