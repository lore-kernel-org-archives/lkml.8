Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E190F207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfgeTZn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHKVZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHKVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:25:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8DC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so141530pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFlBMPyt7J0RGkVcjHVECvZh9R+qJQmjTnftMhGc9oE=;
        b=GfgeTZn6K1IcL3MUGkyDVnbBmlavOTF/EaRjtJeJ24UF15Z/QRUGKapNcftg7Gs1dW
         dEaFRpGiRfLdrrjt1v8cCnkr8mj8Ckn7apw8aTpY6h0D6qiRCfGz0RgjqZUWAlH6UYdd
         4mFx3stCMztBu3Iu47TOCSaTckzQx8+5DY1NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFlBMPyt7J0RGkVcjHVECvZh9R+qJQmjTnftMhGc9oE=;
        b=B1b06FcwM3kIeBtmF9ir2npFF16/S/QJAU49EP/qoAZX0VnN/AP06W/9l9hV77wgl3
         7N9DyBy74AWLqDhojY0EtjbHJSwEUShBv3s+p8SjKF2VXl9KbzIgCFn/HUa3bj8cpN63
         DeUgnv+4cIFotd6qmMiEfKWwNz/TKiPSmBKKJwvbPEfUQ6TuGnjXHB0oMrCa4PTbRJIw
         CHpcKshKvdw5m9pFJC6tyNiiNe6R3t/lgLj8DkhnSUsKjez9wizrNxlw74Z0aug5zKFh
         nV3UydzkCavkhkmVhrSAuSxw3bZJBMqBRRJu9Q7GwMWcuU79Vp93Z6zH/a1uA4xatEVG
         Nt0g==
X-Gm-Message-State: AOAM532/cFUYJcJSMyl94wt2F7zkNhhqTOyoi0Anjom5Z3G6bFPnkI2Z
        s6luo6glrxZXvpNqXqop9/Nnbg==
X-Google-Smtp-Source: ABdhPJxCPu5w1GCWEQMd5TdYawx2fktZItPPByTDo8uB/XfG/L7TDaJjOPvHnm5z/E7MUGh3RG0OYQ==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr3005244pjb.91.1597181099549;
        Tue, 11 Aug 2020 14:24:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm11871pfi.161.2020.08.11.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:24:58 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:24:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] docs: Fix function name trailing double-()s
Message-ID: <202008111424.91AF109DCB@keescook>
References: <202008072348.3BA3DD14E@keescook>
 <20200811104834.5f5ff007@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811104834.5f5ff007@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:48:34AM -0600, Jonathan Corbet wrote:
> On Fri, 7 Aug 2020 23:49:59 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > I noticed a double-() after a function name in deprecated.rst today. Fix
> > that one and two others in the Documentation/ tree.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Documentation/RCU/lockdep.rst                           | 2 +-
> >  Documentation/process/deprecated.rst                    | 2 +-
> >  Documentation/translations/it_IT/process/deprecated.rst | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> This one doesn't apply, and it crashes b4 outright.  The problem seems to
> be some sort of encoding confusion...?

Hmmm. Weird. Something in the translation file? Let me try to re-send.

-- 
Kees Cook
