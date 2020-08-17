Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20129C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE74B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+bxGWQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgHQTg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbgHQTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:36:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B9C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:36:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so8731385pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSda/maq1kyFlmgdc9lPucbhxB4Rs/n3Ulbz/u//5ko=;
        b=E+bxGWQ4aloHMCGvC/C88Lm/LjqBzqUeliCrcozBEZMRKbyg+1uq3MbJHRL+u+fAgy
         rcfLJVPQZ9kKIBkXB0xoAGLmBb+lgoPAZlnS4ffebwSge6AqZOPLud4MtAVsUxyNCwLs
         808/MgaEYfc7LQRe31GlclDrcC3duq6vYQwQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uSda/maq1kyFlmgdc9lPucbhxB4Rs/n3Ulbz/u//5ko=;
        b=cYvyQ3wEtEjw55G6zrs5eoUmzfl9vam13HoOGUNuWegUalp1MnA7Ny1FErbdupXsw1
         K3lVvxnVgdvjD99aRqdH0ixYXgIeCHEdNLhR/cyJ+6nJaJP3V7zK0Lc76AvwdvcG0ox1
         6aQZXZwpGaaaXHEg/E6I4dq/NVXv/9V+e0vtsmXZmop7Kb77nn5edvKtsKqmv7Nkq2mK
         V1TKAMKyi8A/tYLr7dOrpd3lmcAi56StxXo7WpmA9GBjIlowG0oZs8SGZx/QTC0Q3q/Y
         eMQabnMGjce548MtPX+MOBM1vA6F1tqVsmXCJDKw6IQlcMY3LsH2FHNSwA5ZJJWp3bXf
         z57A==
X-Gm-Message-State: AOAM532U4zNA2Dv3fo763R5MU43ppyrqEdtx6ekuoHJea3ZjJUgfWw4L
        jar2wBRordCIangBst/Kf3TrcQ==
X-Google-Smtp-Source: ABdhPJzvvoBV3hMQrSf1AK6MLwM3KhYjHVP7hewssO8T6Pva04uXO9tD4vj9ZMjY0m+FhHm8dDndNg==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr11219632pgv.252.1597693014022;
        Mon, 17 Aug 2020 12:36:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm19415044pjh.32.2020.08.17.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:36:52 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:36:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     dsterba@suse.cz, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] overflow: Add __must_check attribute to check_*()
 helpers
Message-ID: <202008171235.816B3AD@keescook>
References: <202008151007.EF679DF@keescook>
 <20200817090854.GA2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817090854.GA2026@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:08:54AM +0200, David Sterba wrote:
> On Sat, Aug 15, 2020 at 10:09:24AM -0700, Kees Cook wrote:
> > +static inline bool __must_check __must_check_overflow(bool overflow)
> > +{
> > +	return unlikely(overflow);
> 
> How does the 'unlikely' hint propagate through return? It is in a static
> inline so compiler has complete information in order to use it, but I'm
> curious if it actually does.

It may not -- it depends on how the compiler decides to deal with it. :)

> In case the hint gets dropped, the fix would probably be
> 
> #define check_add_overflow(a, b, d) unlikely(__must_check_overflow(({	\
>  	typeof(a) __a = (a);			\
>  	typeof(b) __b = (b);			\
>  	typeof(d) __d = (d);			\
>  	(void) (&__a == &__b);			\
>  	(void) (&__a == __d);			\
>  	__builtin_add_overflow(__a, __b, __d);	\
> })))

Unfortunately not, as the unlikely() ends up eating the __must_check
attribute. :(

-- 
Kees Cook
