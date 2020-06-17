Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A36EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EDD207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVjdG0xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFQALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFQALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:11:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03281C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:11:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so83683plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kmhNDfQNJXO7hJjKTrMFRtUAQoboP57XjXJsRdtwLc=;
        b=KVjdG0xGsNAP+iBrZQFtPpU2KZSHZCCjm3KBV/jssT/5iobGKg3jpwP8jT6qN/sBoO
         gZIoEPF4VR/E6AqWPrkzP5L8RRdbEtNB2B4BgOj9qcksqrirQzCXaa5jcWoHZImWv+S9
         gkyg7/BC0+6Wpg0zIphK4G2PD3XKJAbpJycMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kmhNDfQNJXO7hJjKTrMFRtUAQoboP57XjXJsRdtwLc=;
        b=EaqbiQJJCS3O1wCnqK/lBL8urBq8O5XM2BzOHDh1i8AQKv/J94FFaSMSTgamjrvtol
         KY/XyU5tTF6+ob2GECxI7kNmRqAvLatc6kSvjheH2xpcj76xqVoUwvvi5UbvKSBeI0dx
         ZjBF+QNEbAlOSGpg+JxPk1JtePq1t6vtCz7xCS+MhYZ7dD60I7u5xE5rK68nQGbGf0Ri
         Yc2aeotKrRHz2qC0QS8tEUZnSgx9Z/ZrGJ49EjGMYfMrPIjHJSa+zMSSuS+ciEEHL6Of
         AGAl9Lww8cwHv6eUKB8u5Z3U6X3nZ4MTvx/rQF/HovZi48fOH1jGD4iGNlM8gSBuF2RS
         lsLg==
X-Gm-Message-State: AOAM5323FX0TEFxtgpWrPpmj76UJf6kr9/Wayg4s9+0ERSouM9njt45G
        MRJqT0520nzN0HV8r9TY6FzA6g==
X-Google-Smtp-Source: ABdhPJxNcrIoyau+3OONR7kGcda1pQTKvdJb7jjXMH3fna2AEp/BvXQRIc+lCG/st65ey5B4ks8M3Q==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr4077107plp.50.1592352691138;
        Tue, 16 Jun 2020 17:11:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oc6sm3816845pjb.43.2020.06.16.17.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:11:29 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:11:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Use sh_info to find the base for
 .rela sections
Message-ID: <202006161708.8CC6F4974@keescook>
References: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
 <202006161057.E6D5D84@keescook>
 <20200616192749.GB2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616192749.GB2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:27:49PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 11:00:59AM -0700, Kees Cook wrote:
> > On Wed, Apr 22, 2020 at 10:24:44PM -0000, tip-bot2 for Sami Tolvanen wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > > 
> > > Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > > Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > > Author:        Sami Tolvanen <samitolvanen@google.com>
> > > AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
> > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00
> > > 
> > > objtool: Use sh_info to find the base for .rela sections
> > > 
> > > ELF doesn't require .rela section names to match the base section. Use
> > > the section index in sh_info to find the section instead of looking it
> > > up by name.
> > > 
> > > LLD, for example, generates a .rela section that doesn't match the base
> > > section name when we merge sections in a linker script for a binary
> > > compiled with -ffunction-sections.
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Hi!
> > 
> > Where did this commit end up? It seems to have vanished (404 on the
> > Gitweb link) and isn't in -next nor Linus's tree.
> > 
> > This is needed for LTO, FGKASLR, and link speed improvements[1]. Is it
> > possible to get this landed in -rc2 so all the things depending on it
> > can rebase happily?
> 
> I can't remember why this happened, however I think this patch is in
> josh's objtool tree that I was going to stick in objtool/core
> tomorrow-ish.

Okay, thanks!

> Are those things you mentioned still slated for this release?

No, the three things I mentioned aren't for v5.8 (they're still under
development), but sending their respective series without the -tip
patches in -rc2 will result in redundant patches. (So, it's hardly the
end of the world, but it's just a confusing state to be in since they
appeared in -tip and then never ended up in the merge window. It'd be
helpful to have them in place for things that will base their latest
tree on v5.8-rc2.)

-- 
Kees Cook
