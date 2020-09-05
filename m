Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8539CC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CDA20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgqW05cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgIEWuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIEWuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:50:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D9C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 15:50:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so6190893pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oc7Sw9TODXu+RVtaJ63M210kvv3yvckdfgVjNswlxpE=;
        b=lgqW05cUjy1MMi4Jy0kgOuPj+YgVNH6kU/e4qLuyVmh1ncMzFemceLZdXd403xr0H5
         SbH+Nv982gn8Y+LQ4XiylleDpIXtgNlS4urfYFOsAdG0Ah++LnmapLF523VGA5o8Z5VE
         Y/P1H1Vm/XBZNQbkD2lfjeolAZeRszxp+EAznWtsNxJs84XLU/yXc6JgATp5dnQOEKu+
         EUxnM2EWaKubZeScGRLgn80lf3lN18ffZ2Z4DVHjRByhDy5A8mIk7/DYU8+tLP0CM6Xa
         E2am5VCMPyGFEK2XK7Y+o2cOpTYl8Sy07NQg50LvLuRlLAtBYEoW3ADYFRDyZjDI7umW
         lxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oc7Sw9TODXu+RVtaJ63M210kvv3yvckdfgVjNswlxpE=;
        b=ennhBvRFct0PqOfJ0CCV2zJ/Z6NfMJf8TTDPg60kkrhM+P3ApD27Q7UiLRwjJ4wUxL
         hqHofExaAFI1fJdkT950/Rc57ZaND12yexN0HvU1w4QLGppvLZMI8FTwd+vITf3GoSPy
         5VgE8cNlBFktUUvicP2nCekq/KsjtKTO/JvK/QqMy3Ar2pgoEkR/y3OL2u4Ze4VO/o7/
         yRwLIZ64T8xaqqfZ/C3oVluxKKouQfQDRhxMfEyxCh8ouC8h7UZ0pDtIgW/6fjufx7b3
         rNFYeymVk38lJQhGiIEobF+LdohTGRNDXoRrcPZcKgZsjbkyjy1/Qq2phjuwrh/+HJ1n
         1aeQ==
X-Gm-Message-State: AOAM53178SMUtkFuIgUShTjDnqGT2OzJNCNzPEHTy8O1UWkzC5lQAsn8
        DTpDQ8J89pj9m7lSMQotZDY=
X-Google-Smtp-Source: ABdhPJxD6b0pucw0zYOLu0asYPtdqi8C9BoRYhKNAFxf7piMXOq4g4M0ZFO/zGdpLdoALJybbtNg8g==
X-Received: by 2002:a62:17c5:: with SMTP id 188mr14362056pfx.148.1599346200002;
        Sat, 05 Sep 2020 15:50:00 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id gl17sm544160pjb.49.2020.09.05.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 15:49:59 -0700 (PDT)
Date:   Sun, 6 Sep 2020 06:49:52 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [RESEND PATCH] perf: ftrace: Add filter support for option
 -F/--funcs
Message-ID: <20200905224952.co4tq37rsguaim5d@mail.google.com>
References: <20200904152357.6053-1-changbin.du@gmail.com>
 <20200904162716.GT3495158@kernel.org>
 <20200904185959.GA3753976@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904185959.GA3753976@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:59:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 04, 2020 at 01:27:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 04, 2020 at 11:23:57PM +0800, Changbin Du escreveu:
> > > Same as 'perf probe -F', this patch adds filter support for the ftrace
> > > subcommand option '-F, --funcs <[FILTER]>'.
> > > 
> > > Here is an example that only lists functions which start with 'vfs_':
> > > $ sudo perf ftrace -F vfs_*
> > > vfs_fadvise
> > > vfs_fallocate
> > > vfs_truncate
> > > vfs_open
> > > vfs_setpos
> > > vfs_llseek
> > > vfs_readf
> > > vfs_writef
> > > ...
> > 
> > I'll process these now, the urgent ones were already sent to Linus, so I
> > will now concentrate on the new stuff for v5.10,
> > 
> > Thanks for working on this!
> 
> Thanks, applied, will go to v5.10, i.e. to my perf/core branch as soon
> as the usual set of tests pass,
> 
> - Arnaldo
Got it. Thank you!

-- 
Cheers,
Changbin Du
