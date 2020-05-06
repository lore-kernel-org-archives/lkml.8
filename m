Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7FC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5AF2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FENCxi3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEFD2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEFD2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:28:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479FC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 20:28:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so164972pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBAVzMpCY0Y8uJEsRMriUJxeCCF4JeeEJiGgIvD8X0M=;
        b=FENCxi3ReJZ0gKk+LtiGIX2UjlE+flSUzje4ZMY9NMdOsA2LHSXc2kz5zV2yUHBU+1
         04IU0Tw7udK1MsLhdhU7PYbVuaCWk72gZiazdN9DmYVkTbgECvIaTjGhPq5fFvFfQj5u
         l07RFAoDrc8VUCV4aIPf+7IH/EslTY7qqVgr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBAVzMpCY0Y8uJEsRMriUJxeCCF4JeeEJiGgIvD8X0M=;
        b=AEEqI4m15zyhUh/qbYTFXnY5XfpJYr+W0dRdjiqtKC4+RS8MjBt4my1nqhQGKWMqUy
         hIqtzJuUUz30a+RGLGX6kOjyloq4rAavjoc0D1Xqi2Sys09tkBYPQH/Ur6veuS7y4TYz
         lg4PYN1qkOch922Cc6YOWrxs1mQShpp5R78dOSoKx5bUOHFP0EZ6oH/uXCyvxGev88G2
         OEWE40OElmziik1qzQX8/0vSqHe81V/N8yNcOdHd/w7W6Ruwm195vzk1WTl/TXp9JelB
         ZPGnJjCuiWggCP8X//EWUry1IJMi79uit1Ss2VetKenAzTnjN4EePYPJhrY+mkUbR00L
         tLJQ==
X-Gm-Message-State: AGi0PuaghM8BkwCshavefOf+mycTTlSpBJytHT/SknyvYvI6g3M5GrGY
        bucUVn8BOKMC7rcOpIYsm+pAtA==
X-Google-Smtp-Source: APiQypJKKztIs9DHPSBC82BR6U0gnEfdCOO6ZOaCk8oWY0mZVWpzI9MKxzqW5D0iCN1rwvUpXReGMg==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr6250905pfj.263.1588735715277;
        Tue, 05 May 2020 20:28:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x193sm312260pfd.54.2020.05.05.20.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 20:28:34 -0700 (PDT)
Date:   Tue, 5 May 2020 20:28:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <202005052024.2D7626C742@keescook>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506011431.GB23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:14:31AM +0100, Al Viro wrote:
> On Tue, May 05, 2020 at 04:40:35PM -0700, Kees Cook wrote:
> > After using simple_unlink(), a call to d_delete() is needed in addition
> > to dput().
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Is this correct? I went looking around and there are a lot of variations
> > on the simple_unlink() pattern...
> > 
> > Many using explicit locking and combinations of d_drop(), __d_drop(), etc.
> 
> Quite a few of those should switch to simple_recursive_removal().  As for
> securityfs...  d_drop() is _probably_ a saner variant, but looking at the
> callers of that thing... at least IMA ones seem to be garbage.

Hmm, I dunno. I hadn't looked at these yet. I'm not sure what's needed
for those cases.

Is my patch to add d_delete() correct, though? I'm trying to construct
the right set of calls for pstore's filesystem, and I noticed that most
will do simple_unlink(), d_delete(), dput(), but securityfs seemed to be
missing it.

-- 
Kees Cook
