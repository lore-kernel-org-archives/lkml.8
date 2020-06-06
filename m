Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76632073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr/OTDIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgFFOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgFFOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:32:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6150BC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:32:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so5482433pfw.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13Bg+r53Hgf+6+xiFNVDDsBz9vyOQUz3FCM2y7AOtgE=;
        b=qr/OTDIP77AagDZPrNCnWY81dxefjRLJvS7YlWLOzEdmZxY/lQMkxk419Zw5yb6yXa
         A+wg0oz9CDM+2/T3X/jZQZBEnj84gU81uqrn1VsR7F3RpLYS/wrZENQjRjtzL46JMLc3
         4u/rFHZpeE5sz7Vcigj/tNLLagOLYNUByI1gZWqfe7ghrtkY60WbBmrCq7JtkeqRVnW1
         ClSxqWMZ5Y5uR6HCViNzPj3nNIKQqBOr18x6qkbOjabI3T/f1MreEE4WZ47gG0hM6xMp
         pUVR8r/TxUKFXiDVUW6Jfn5fMN3XMXlhxcZTrIkvgMnGnDdzKuh5EawBruIPC9ohtQJ6
         eaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13Bg+r53Hgf+6+xiFNVDDsBz9vyOQUz3FCM2y7AOtgE=;
        b=DP2IA506L3+WbvWxT2y0JUvaowAC6gps/X9CC+15GTi+fZbyNTbGwXs0RUyLmHoAvx
         kAC1Fxkdk85EWd9T8+itCcSKLTBBshu2OQ6l/TGWp5bncs9A8Tq+obGnG9rDCF+X+1ZM
         8DtixKhpPKXGVgW3SI2w0Rhv3bcYPOYw+r/0NO2E6H4lADuJPItMKoq1+BU5XpbQyrnh
         DyBTQa1vHKgUwwHKrDGAZreyMu0vJZEoAthWpB55iVl95f9cBIVZyq1D4MPBpX5PoS7O
         8tJC261nXjc2zNAQ/loAo8P8QuLpN+f0DeOqFjf6wD/dcBw1RpfMdqYEkYmGcRfcj7n/
         3Yhw==
X-Gm-Message-State: AOAM530tWimxR40fZJq3I926N1Yay40QvxrO7eeXnge8spw9lbjJPzR4
        qCo84jhQohWu+cZ+9efc+Pg=
X-Google-Smtp-Source: ABdhPJy9NWDzWc9ihQ5mfFsRS0vNfa3QXRYaCvHfdPWBOir5y+RtZ+eOeeHDUc+XHGG72NuwNzhH3Q==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr14678812pfc.286.1591453948970;
        Sat, 06 Jun 2020 07:32:28 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id k101sm11626595pjb.26.2020.06.06.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:32:28 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:32:17 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/19] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200606143217.my254phsg7vv4bnm@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-17-changbin.du@gmail.com>
 <20200520211228.GE32678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520211228.GE32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:12:28PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, May 10, 2020 at 11:06:25PM +0800, Changbin Du escreveu:
> > This allows us to trace single thread instead of the whole process.
> 
> I was going to adjust the patch to add, but you forgot to add the entry
> to tools/perf/Documentation/perf-ftrace.txt,
> 
> Please do so,
>
no problem. I will apend a new patch to update all the documentation.

> - Arnaldo
>  
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 0b39b6a88026..8d04e5afe2d3 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -707,6 +707,8 @@ int cmd_ftrace(int argc, const char **argv)
> >  		    "List available functions to filter"),
> >  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >  		   "trace on existing process id"),
> > +	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
> > +		   "trace on existing thread id (exclusive to --pid)"),
> >  	OPT_INCR('v', "verbose", &verbose,
> >  		 "be more verbose"),
> >  	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
