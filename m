Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA93207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGLll7bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgH0Ryv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgH0Ryu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:54:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DFC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:54:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g207so41961pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PM1k7JJM02GdSvpAFjR5Wh14ixeFvqSZ6VxiO5PPv6g=;
        b=AGLll7bZagIWQPwJZQrJsxFztdR+PjXvFIpyaMDqgvbm7ItsLYhJma113kes8A1GCk
         Sz7LpCxHTwDArbiYHHz7B8pv75qdMM73OM5BFvv79tjq5GUWtJpj3eMSgQOrwsiLbIwn
         vYPJeYhr7GXwnLobsti/rF5tqdsBtRWwPfhYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PM1k7JJM02GdSvpAFjR5Wh14ixeFvqSZ6VxiO5PPv6g=;
        b=GvpF0Dzj2fUK8cY+vi70gMwV/u9/p9XAdS6TJ5AszMHNFcVFprMjKtsYU6ncklXO+R
         iNz5ubT7+k9hyMdT/OvoTsqqqizFT6QU6eI1qwfuUrgwBh33GH6tQIVKyL2kSa5w0E3r
         R4LjgFW+lwkqEumMGIQ1X+JjpqMiVleDnYnHh+GZZ+yBy07g3TX5Fn8N4uM4rY8cGP6f
         3G78Qi5o68pqKjplcbmCVdamtgvKww04sZ1KQAi4CxvwS2IZomRPthbvTyqlzyArtGvu
         m/9ZG6q6I+vzk248SBCA4bOqL9HQwrfBlxONhv3LwnieaWcBPXF1263gvJcCWmKioKwh
         a61Q==
X-Gm-Message-State: AOAM5331Jo9CZKVahyfaHGCXLsEjvoLqaP3z/pOWs3CeHW3ZA+b/T94S
        IUlOa+wquJxFCq4SOBAHGf2iQg==
X-Google-Smtp-Source: ABdhPJzt3soFXmwdXTOotipZgoA3KdzPwtdTQWL18Fz0kQoYrhSxuUiem/H4+sVtyllMLMemAk6Zjw==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr10572709plr.37.1598550889086;
        Thu, 27 Aug 2020 10:54:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm615297pgr.62.2020.08.27.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:54:48 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:54:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] docs: admin-guide: Not every security bug should be
 kept hidden
Message-ID: <202008271053.A28980248@keescook>
References: <20200827105319.9734-1-krzk@kernel.org>
 <20200827105319.9734-2-krzk@kernel.org>
 <20200827121123.GC417381@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827121123.GC417381@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:11:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2020 at 12:53:19PM +0200, Krzysztof Kozlowski wrote:
> > --- a/Documentation/admin-guide/security-bugs.rst
> > +++ b/Documentation/admin-guide/security-bugs.rst
> > @@ -78,6 +78,12 @@ include linux-distros from the start. In this case, remember to prefix
> >  the email Subject line with "[vs]" as described in the linux-distros wiki:
> >  <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
> >  
> > +Fixes for non-exploitable bugs which do not pose a real security risk, should
> > +be disclosed in a regular way of submitting patches to Linux kernel (see
> > +:ref:`Documentation/process/submitting-patches.rst <submitting-patches>`).
> > +Just because patch fixes some off-by-one or NULL pointer exception, does not
> > +classify it as a security bug which should be discussed in closed channels.
> 
> I said this on another thread, but almost always, when we get reports
> like this on security@k.o, we do push them back to public lists.
> 
> For the most part, this paragraph is not going to help much (mostly for
> the reason that no one seems to read it, but that's a different
> topic...)  We get crazy reports all the time, and that's fine, because
> sometimes, there is a real issue in some of them.  And for that, we do
> want to be careful.  We also have many docuemented "off-by-one" bugs
> that were real security issues (there's a blog post somewhere about how
> a developer turned such a bug into a root hole, can't find it right
> now...)
> 
> So while I understand the temptation here, based on the current
> security@k.o traffic, I doubt this will really change much :(

And given our relatively low traffic, I'd rather we (the
security@kernel.org folks) make the determination if things should be
public or private. We should be the ones on the hook for those judgement
calls, not the reporter reading our documentation. :)

-- 
Kees Cook
