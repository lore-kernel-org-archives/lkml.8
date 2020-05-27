Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C391DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F0220835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ks6JOUSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgE0VzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgE0VzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:55:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:55:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t8so2139108pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCGwhiQvKxhSZLsq2F1qp3/RU6AkenpE+aDBKVz2JUI=;
        b=Ks6JOUSLY/44DDz35iht8qEtxDiNWKq/Vj83ZsfNnSv/HFvczafFgOcvm1HMHbvmnM
         a8gSogWiUro72/Cn+cG2ItfwGjxDMP7kRNhtBKhnZESKeps5msUc61BScjjznmCm0lsy
         f4E0dS+zGayB6t8ZjxaFoEEIpyVCvH5Ed7sxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCGwhiQvKxhSZLsq2F1qp3/RU6AkenpE+aDBKVz2JUI=;
        b=QYB4p6PIU7goV8yuEupcRCoxRJGwNtPuXNIz2gDsLfz8RVMM4ewJkyzy/pKL62sTjY
         zMOO1Bhab9vTGPOJJ9qCCOj43YnIs8OqAf+DGJthzBG+HRazzPHlnTOwo7t9mQvdtOBO
         i4+thoBd3QUGjeRCyUXr5AuIMkWJOKPfZZB510CB/PnvkKBm5UBk4efHkIavFIti/Bp2
         /GjN2gTuKu+cHulPZK91H/4jwWYAQ9VC9yNuUz+oKxoQaARCV1bUye5C1aXppLN3Kj9X
         a5/TG1ud2o3AFIj6FyCQtb6bKS36efCg7QvVhNW2Zn7UAoYjx637xNluCYl8qwQgBSwY
         y5RQ==
X-Gm-Message-State: AOAM533P72Pm8iaMGILcQ3aMvh8keD+axbmOlng/mu99oBWuCWr8dnQf
        zllU6lgnZdNAxfP0IJT4s9WwchQPs30VXQ==
X-Google-Smtp-Source: ABdhPJx6J+7UgbfDtEKM237w02+uKLuV0vUd+AIIl6Qb+ZR91mK/DX5ME6gzZky18/b6XNZkP2Ashg==
X-Received: by 2002:a17:902:bc89:: with SMTP id bb9mr421513plb.101.1590616517453;
        Wed, 27 May 2020 14:55:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d67sm2893403pfc.63.2020.05.27.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:55:16 -0700 (PDT)
Date:   Wed, 27 May 2020 14:55:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     glider@google.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, sunhaoyl@outlook.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <202005271450.7468AA95@keescook>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004201540.01C8F82B@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > 
> > > KMSAN reported uninitialized data being written to disk when dumping
> > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > the core file and then read by a non-privileged user.
> 
> Ewww. That's been there for 12 years. Did something change in
> regset_size() or regset->get()? Do you know what leaves the hole?
> 
> > > 
> > > ...
> > >
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
> > >  		    (!regset->active || regset->active(t->task, regset) > 0)) {
> > >  			int ret;
> > >  			size_t size = regset_size(t->task, regset);
> > > -			void *data = kmalloc(size, GFP_KERNEL);
> > > +			void *data = kzalloc(size, GFP_KERNEL);
> > >  			if (unlikely(!data))
> > >  				return 0;
> > >  			ret = regset->get(t->task, regset,
> > 
> > This seems to be a quite easy way of exposing quite a large amount of
> > kernel memory contents, so I think I'll add a cc:stable to this patch?
> 
> Yes please.
> 
> Acked-by: Kees Cook <keescook@chromium.org>

This has been in -next for a while, but we need to get this landed and
into -stable. Can you please send this to Linus for the final release? I
know Al is working on getting the complementary fixes landed too, but
this fix is also sufficient, trivial to backport, and provides some
future-proofing/defense in depth.

-Kees

-- 
Kees Cook
