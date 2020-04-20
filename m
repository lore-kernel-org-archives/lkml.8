Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FCC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E5A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jHw+hnRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDTWlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:41:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:41:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so504462pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOx/Nk4FquXJyWXQfptpC4DSa3mcXsVlsvT6l/XeQck=;
        b=jHw+hnRA6zoSySOMYOCCKdmQTQ1cfELgXOG3Ih3ugNGr6GP3hDbhtn0NUs1uN7CGYx
         ZFs4j8Mc/Y/pPEdRTARWyj+usqUYGY++8v8et5dLO0wsnPoCjEk6nadlBBCbO8ENnU1i
         b8lbCArlNcDy0C9Z1f1lknHGNDWrdN497MMzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOx/Nk4FquXJyWXQfptpC4DSa3mcXsVlsvT6l/XeQck=;
        b=Pi7EwVlQPgvY/UwQRBa2T5DuLbBexRIfuHeCLOnw+R8Bg0ojf+Daq/suXHvK7Rrxpp
         BdSnthilv7DyxO6IkAxobKCWAeX1bU9nIKYSgpvyVch/iDkhwW29a/aT4Mdfrko81sSO
         g61Jt5kZxgAgmlK8393I5G2HtVMJILbkGk0dtCgxIyoFRLMsPjd3eS1AFC27xaEauppr
         1FPTZdHf0U5I4MP+KZWp5n/pED+hP1n/pQj/D4E675cdQsqO07O+jJfFdf5DCk5buq3l
         CGay9ic/iWNufjCB7/IVjz40KW9dYtBL+HtU16OGRpWBsFfSnEO7lNYhM0BNpRKnoWnR
         jTSA==
X-Gm-Message-State: AGi0PuZFduv+J7kCLwUa66T9k0coDmbyF5x7e/E34qiHHYv6qzPhcrVJ
        ZmerXVDKTpNSBWVWXRLo5VMhXA==
X-Google-Smtp-Source: APiQypL5Z6q8UaSwVwqhWKDtZz7B9BBMwHt2OfgW1N+IC7mdxg5XMaIXwNjTPPsuJbbTL58HeQiluA==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr1861715pje.93.1587422502023;
        Mon, 20 Apr 2020 15:41:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm442489pjy.9.2020.04.20.15.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:41:41 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:41:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     glider@google.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, sunhaoyl@outlook.com
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <202004201540.01C8F82B@keescook>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> 
> > KMSAN reported uninitialized data being written to disk when dumping
> > core. As a result, several kilobytes of kmalloc memory may be written to
> > the core file and then read by a non-privileged user.

Ewww. That's been there for 12 years. Did something change in
regset_size() or regset->get()? Do you know what leaves the hole?

> > 
> > ...
> >
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
> >  		    (!regset->active || regset->active(t->task, regset) > 0)) {
> >  			int ret;
> >  			size_t size = regset_size(t->task, regset);
> > -			void *data = kmalloc(size, GFP_KERNEL);
> > +			void *data = kzalloc(size, GFP_KERNEL);
> >  			if (unlikely(!data))
> >  				return 0;
> >  			ret = regset->get(t->task, regset,
> 
> This seems to be a quite easy way of exposing quite a large amount of
> kernel memory contents, so I think I'll add a cc:stable to this patch?

Yes please.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
