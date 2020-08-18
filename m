Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06605C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D9520786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJJrwh3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHROTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHROTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:19:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A93C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:19:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so18462100wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7J/r1E+lQgwxAYRstL7rf8C32+EXOMnod+NMk/hBTHw=;
        b=PJJrwh3oAQCHYtG1D3/AT1wch3gMDb0LnX7tOl5ZAw03jrQv1wjtZ7aq3JFvygskhT
         yKCQx6xLh2ZyFzCCdT7s13ourBuPJqI0znwxo/JMtk46hjxMfSXY2OsR8jHBdTdMyJsQ
         NbjSNCd7MMJPWTuBk6F1DbadYQbVG9LmHt1uQAX5ii3a/b/IH73wobb0eqquCTjZ8ybF
         HpFiUSfJGh7+1hhEMn+VyEwHKWMb8hBWy7XLccGUQjPe9rJCKUluS05i8dikv8mfi1PG
         CtJyBPF2Cxee8db8qdgwaVbB35rLsVFrqA7SO9vsx6XMTkbjUwJTcDbDH6BTvtZ/enXg
         ZZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7J/r1E+lQgwxAYRstL7rf8C32+EXOMnod+NMk/hBTHw=;
        b=U5oLN6EsGrU9RlxL/iQvC/3Tec+Vd6IpqM60bfbZhhOvp9Oy85WUKZTvbPmns5bp7z
         D0P8IWqkITRBqGuzvfZX9hvhAn5cVh9WjYf8x+JV9REgtUpxGR6ZgiX3aWznDTQ0w2Zi
         eyJAIUlWEG755oieOUIk5vaPT9WZlkyukaUbpDIji3f6fLzcz64wBaeg54ISfjaj1sLh
         P26ndpclecRwfS7cNNfXOlved33GVw7OclCFTZ+xATDMAsMO+mrRs3qVfwHs8avCSc+h
         gjxXUAxZJ0FXqqmGDe4YgWtZ7lU8w2gnkkoOQ0LtWqRzYT3shsWIjIdMexLnT3wW9vTr
         /cDw==
X-Gm-Message-State: AOAM533GWA/O9jsBF2h8/mGfWog8zrVfS2TOPCRvDvDBabtmxbKGiTLJ
        blzi9a9Hxaa4/wjHnWdAr7w=
X-Google-Smtp-Source: ABdhPJzxT9GBf8wTWBH60WuPWnbzAmw2HJeyQL0biUOSzv5uQPE/uCUdy9ZeBHEyX5vDda9O2/QZZA==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr21199676wrn.2.1597760384066;
        Tue, 18 Aug 2020 07:19:44 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id t11sm32487327wrs.66.2020.08.18.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:19:43 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:19:40 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 1/4] staging: android: Replace BUG_ON with WARN_ON
Message-ID: <20200818141940.GA357037@tsnow>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <fd55c53cb20c4887a87c05fffa28c28a740cd314.1597602783.git.tomersamara98@gmail.com>
 <20200818141106.GB562377@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818141106.GB562377@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:11:06PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 16, 2020 at 10:23:25PM +0300, Tomer Samara wrote:
> > BUG_ON() is replaced with WARN_ON at ion_page_pool.c
> 
> Why?
> 
> > Fixes the following issue:
> > Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().
> 
> Ideally you can get rid of WARN_ON() too, right?
> 
> Many systems run in panic-on-warn mode, so this really does not change
> anything.  Try fixing this up properly to not crash at all.
> 
You mean by that to just remove the WARN_ON and leave the condition the
same?

> > 
> > Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> > ---
> >  drivers/staging/android/ion/ion_page_pool.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> > index 0198b886d906..c1b9eda35c96 100644
> > --- a/drivers/staging/android/ion/ion_page_pool.c
> > +++ b/drivers/staging/android/ion/ion_page_pool.c
> > @@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
> >  	struct page *page;
> >  
> >  	if (high) {
> > -		BUG_ON(!pool->high_count);
> > +		if (WARN_ON(!pool->high_count))
> > +			return NULL;
> 
> And can you test this that it works properly?
> 
> thanks,
> 
> greg k-h

Will do :)
