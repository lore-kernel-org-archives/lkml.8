Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1815207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSr3kuRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgHRQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHRQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A4C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:54:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so17666345wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qgCUxq2zGum+5Mwy6CfotNupWJ60SNmbSQebIb04zK4=;
        b=hSr3kuRFEkFHrunhX+xSzbbezbGA98O2P5fx4d0mBCwggFuOQzgsCPTE5CISVVicAF
         294z1FnbkTvVN+MdPSbfPWpqQiXnCGZd7a45jp+X0nq3T96jcFNrzt3PJelCNLR/0hIt
         kgpBY9MqznxziQ9ftFlniRrEuq49cqbyqiz7ecoLMtVPKgKP9anCkK5VcWaLpYhatQba
         JHFnzrn2ngnBCgYQAdd7jgTmP1z96ssvieaZlf8UhDq9X2tai6SuRdAsq0zRzSPozZtC
         SuDEoiEL0TvVXS+07OH2jTRW4kyP5ELSnre60lXAsYVMyBSd/1ZlqarB1hS8z9K0S6mA
         gbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgCUxq2zGum+5Mwy6CfotNupWJ60SNmbSQebIb04zK4=;
        b=r8JEthnLM8wt/zO6pGPnpQu/GNADTx0acNxXrZtqaCQGUFzStNpRbnDkvQRoEABl54
         wmkPJSaNP7/VymCAAJcY7XF46T1+RBsG/xGCIKCqTtMOXZVykZvoBubrQyXIxff0xj0R
         Pfl82+gADWOy+RIa+HqvlLuShJjN9a+0UhInpmvEwTey0HJKLt1EGGD/A1E0FBOMRFuI
         LxOsP+4+jCdJdVAMxUA3N8DGwlhKdUDevuQVG8cLL379z0/6EvZsl6rsXGWHcAESXh4M
         0StkgA1a138KtsKnbLad/Mjim0hkEmUV+OCf1RqWL+Ix0MOb+gKTVUbg+6rgdtOh0ljW
         /cYQ==
X-Gm-Message-State: AOAM531iog4LtyzreiSDh7kUgxunrLUufLgL/qjshs4hxeZ7TcUR8eKn
        zfg77fQVaj8Fxbj8GevUakc=
X-Google-Smtp-Source: ABdhPJwFP22K5i+0E2e98erUvBbzGWpSrmUD0LuQcPdfIqVOlTOr8IXSVWQWFEqOpQSdO+eF+z6raQ==
X-Received: by 2002:a7b:c105:: with SMTP id w5mr778323wmi.146.1597769641884;
        Tue, 18 Aug 2020 09:54:01 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id 15sm618120wmo.33.2020.08.18.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:54:01 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Tue, 18 Aug 2020 17:53:59 +0100
To:     Joe Perches <joe@perches.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clang-format: Fix: Maximum line length is now 100
Message-ID: <20200818165359.jye5ch4uvdvkil36@medion>
References: <20200818162431.696423-1-alex.dewar90@gmail.com>
 <15980e07c369b2cbfc7b06f58f3a521a5495bdf6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15980e07c369b2cbfc7b06f58f3a521a5495bdf6.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:52:20AM -0700, Joe Perches wrote:
> On Tue, 2020-08-18 at 17:24 +0100, Alex Dewar wrote:
> > Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> > warning") the kernel style is now for lines to be a maximum of 100 rather
> > than 80 columns. Update .clang-format accordingly.
> []
> > diff --git a/.clang-format b/.clang-format
> []
> > @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
> >  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
> >  BreakAfterJavaFieldAnnotations: false
> >  BreakStringLiterals: false
> > -ColumnLimit: 80
> > +ColumnLimit: 100
> 
> No thank you.
> 
> 100 is used for exceptional line length, not
> for reformatting all lines up to 100 chars.
> 
> See the previous discussion about the same patch
> submitted earlier in June:
> 
> https://lore.kernel.org/lkml/20200610125147.2782142-1-christian.brauner@ubuntu.com/
> 
> 

Ahh, my mistake. Thanks for getting back to me anyhoo.

Alex
