Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DED7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633002068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXlQ8REG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHNWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:47:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD60C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:47:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r19so5029632qvw.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=izofqD96IqVUm+LHPkT/jRy6CdiXfWWuN+a7nrXnhfk=;
        b=XXlQ8REG5VDx5RpkufqkvCUduwfCGtxtAFyT4QUv7N356mPV6qexB3cu5FGm7DgUQI
         7Gr3+bWt/Ii2s6XBuMMJeB+L08w2D+BmoE/zcYozeEyt/tIxpmpDF+sI4EDAkCalH0GS
         cJV8j6NbmaUBOSnGY+p81QRs+gT7vAmYCmTvD0LbpqnW1junbyjD+sjgA6Nr2FzPhZoR
         sP7G0PGoFG8Xgtv8Y9I+nQ0163dAd3uwj/yFVvOViAPPh8m6rRQROO74/n//+2z3CDwp
         u/1ImTA+H57YEa1mGzgLdL/Bn1QyWbdiYegESvSeRioZaqtJsf/Gg7usXReaLgb5mjwq
         BEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=izofqD96IqVUm+LHPkT/jRy6CdiXfWWuN+a7nrXnhfk=;
        b=C2zo0MRGxofuDVTi57C4uStpslDx5M6OyBqfImmKmQjReLqnNaFhMwkmdVaDmL3e2P
         Sfm9Nl3bxoL+u3z6j/O5XDwqqM7PSfE6lKUJvitPGSiL8q3GZKyLu1Py4jLEPJr8EknO
         ID7v2LP63pP/PsxB50pHh9Q3P88AkLL9Dge6BT7lVvRqHl78j5jPvopDnHmxIWOFKwQS
         HINyL5Q69wEejfyBRhtFsjNcHNxovu8KikObCA2ssN8rReHLoUgWSYXDeMkYbRqvYqgG
         9PaGMsLj4yVIwT2cy8QR3lD1Px+lb/9ObSbJQDOTc80q1leY/XEF/wkOYlKa10FnbbWD
         V5Dw==
X-Gm-Message-State: AOAM533rlC5zeCG3xqhjBBTfvyZMIo5NQz5BgRu9AKaKGmQXQ7RZmpcw
        Vh7n/mOhQXSZX7JTUcZZit0=
X-Google-Smtp-Source: ABdhPJx5AptfpOzIrRmVf8fyLJkwO2YXA39sEzV1qgYlI9abg7JDC/NhmNy/JsRHlaTGGoBVw7B7vw==
X-Received: by 2002:ad4:4b0b:: with SMTP id r11mr4747051qvw.94.1597445252170;
        Fri, 14 Aug 2020 15:47:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 15sm9709864qkm.112.2020.08.14.15.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:47:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 14 Aug 2020 18:47:29 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] x86/kaslr: Cleanup and small bugfixes
Message-ID: <20200814224729.GB4106860@rani.riverdale.lan>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
 <20200728225722.67457-1-nivedita@alum.mit.edu>
 <20200730180224.GA1203420@rani.riverdale.lan>
 <20200731092146.GB2956@gmail.com>
 <202007311632.54A7554192@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007311632.54A7554192@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 04:33:35PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 11:21:46AM +0200, Ingo Molnar wrote:
> > 
> > * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > 
> > > On Tue, Jul 28, 2020 at 06:57:01PM -0400, Arvind Sankar wrote:
> > > > v2->v3:
> > > > - Fix the first patch: command line size should be strlen + 1 to account
> > > >   for terminating NUL. Avoid calling add_identity_map if cmdline was
> > > >   NULL, though it should do nothing in that case anyway.
> > > 
> > > Hi Ingo, I noticed that WIP.x86/kaslr and x86/kaslr both have the v2
> > > version of the first patch. That has a bug in the cmd_line_size
> > > calculation (missing the +1).
> > 
> > Indeed, well spotted. I rebased the affected 4 patches in x86/kaslr 
> > and used the opportunity to add Kees's Reviewed-by to the first 4 
> > patches as well.
> > 
> > I've zapped tip:x86/kaslr for now and put the whole series into 
> > tip:WIP.x86/kaslr, will move it into tip:x86/kaslr for a v5.9 merge 
> > once Kees is happy with the latest version.
> > 
> > Kees, AFAICS your type truncation and patch split-up review 
> > suggestions were resolved in v3?
> 
> I need to double-check, but I think so. I'm hoping to get to that on
> Monday. My orphan section series work took MUCH longer than I thought it
> was going to. :P
> 
> -- 
> Kees Cook

Hey Kees, did you get a chance to review?

Thanks.
