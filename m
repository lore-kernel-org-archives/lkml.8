Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E0AC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE6207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vc55/O8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgEEXXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729641AbgEEXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:23:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2743C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:23:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so49679pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F4zJ2Wyns0vWJ/VWVLN8p0gKZwpMoM7NNXMOTPjWGo8=;
        b=Vc55/O8Hn/65Ur4l0r7kF61Ee72u7Mj2dHcVB8s5vddf1pRLtKJ+SSUOSoa2lEuC83
         CtDyJZy6EL9hSjfTI6jsk2VFGvkSJJdGAJwyoEVcJ+htyASspxPGM7k7FAFlYfIr21tO
         QcEPgHEYgTGpxY4PQYbfhNAYRULqlS6zzszQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4zJ2Wyns0vWJ/VWVLN8p0gKZwpMoM7NNXMOTPjWGo8=;
        b=nDGkWtg+KG4vzCWjkpcTaeFQMK/jmu4nc+OBWOgYaZ62vxDwLF8JHQWPwWkVxAmb0Z
         PR5W1XzVaVN2acsnmwcVCz+9oAoWyr9YDObWRO5sfqYftNn8ItFrxsSn1f52eRNz+Vz9
         PXCd6sKrFsmzjS48GnokSV3vpQtdVRTHgqaB32drMZhCpZa8+MlVAzbp0EkMgiT+a35a
         9eKGoKZMCWpVjf+3432pmCyK5rhy4vS7SARh8Vm66GRLoPoak4JtMpTpC4wycTsaH+re
         FpbE9hBlhHWQqwMb4fIXwOhxzDL4dWPipbUEHpLI+FAmeGbI3o+lpaAdX7MkAZkOUrKg
         Z5vw==
X-Gm-Message-State: AGi0PuaOAdALyElqYJk6KnA/wF6cCY0Dm7/eHrMtyn98DMX2xr7Wz3U/
        uGt8+qzGXyWL9bKSzoTBcW+AlQ==
X-Google-Smtp-Source: APiQypLvtC8n0a9vwNk9Ryexcufu5OYvbfhZPdrSJ4nmiaOmEQoxagwQrmZnsNARoblWFqiBDRVw7w==
X-Received: by 2002:a63:ff42:: with SMTP id s2mr4812221pgk.410.1588720996544;
        Tue, 05 May 2020 16:23:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k186sm169139pga.94.2020.05.05.16.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 16:23:15 -0700 (PDT)
Date:   Tue, 5 May 2020 16:23:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <202005051621.90DE28B@keescook>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
 <202005041329.169799C65D@keescook>
 <20200504215903.GT11244@42.do-not-panic.com>
 <20200505063441.GA3877399@kroah.com>
 <202005051339.5F1979C4DF@keescook>
 <20200505220327.GV11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505220327.GV11244@42.do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 10:03:27PM +0000, Luis Chamberlain wrote:
> On Tue, May 05, 2020 at 01:41:44PM -0700, Kees Cook wrote:
> > Right -- while it'd be nice if the developer noticed it, it is _usually_
> > an unsuspecting end user (or fuzzer), in which case we absolutely want a
> > WARN (and not a BUG![1]) and have the situations handled gracefully, so
> > it can be reported and fixed.
> 
> I've been using WARN*() for this exact purpose before, so I am as
> surprised as you are bout these concerns. However if we have folks

I don't see any mismatch here: it's not user-reachable, which is what
Greg said. WARN is for non-user-reachable "impossible situations". We
want to know if those can be hit (via bad API usage, races, etc). If
it's reachable from userspace, then it can't be a WARN() any more and
needs to be pr_warn().

> shipping with panic-on-warn this would be rather detrimental to our
> goals.
> 
> Greg, are you aware of folks shipping with panic-on-warn on some products?

People shipping with panic_on_warn are expecting to panic for WARNs like
this. :P

-- 
Kees Cook
