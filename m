Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C15C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2547208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593804303;
	bh=GDS3ISNK5CTBY0IdVs1u8xzxVJCI3gVyHLbeigacmxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PH2DxcLAgJttoiYhSGhZOnPxL/VwN3OkvUeQ5rN6UYy1HS+gkiOHqAw+f4TT4seRE
	 YJ/b/yuIxs5eIjXVRTwtxy4zoiwnIKDsWbOpszjNy5fE/xZdYv9l7+u0r4X2XMpNnf
	 sPMjcxakmcErgdAaHdajN10DVpipKFyQfSkr8H5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGCTZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:25:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25949C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:25:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so19083473lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEMPMKHktF+3GiPNxFWdeLrXOxNE07nmroDOEVThA4A=;
        b=EhC1qDxGOcHnqhdTefcfYAg7Ihgd+dyuCofQ5oRzGgTrAnhAQqF7OzcfuyTH4ovLGg
         lVeESWYyUkkno7e5pvU5gocokHSLu0r0EG8L+u7jkct0aI3QhIpJFf9k8NwIciFyX7/7
         9XeVBI0g2czxapfWKmluX0h7W/Jh645iHYlCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEMPMKHktF+3GiPNxFWdeLrXOxNE07nmroDOEVThA4A=;
        b=YEmNwsKFRhP3/NqTrwGWMYH53c8de+Lm7+81Mgexj67BZsJu5AgZ6nLqJ66Ba+2p3C
         dx14fUC+jRCtmm8kx90soFjN1xs8a8cbi2FcWXxouf44kYK644ydhswGSN3vlvymWe0F
         8Gc6rxbhj6ZdDI1u1SGOm1X/QE0WHJW/mEgbfdZn3rVlrAfQOxazQNsKaYCnPelDdQk4
         BtoWiW9WbznuLHoxDEobsMl02Ksq9xR2BLdgUnqnIoZ/T7gmHIm7zxL0k4xC5vZkiN2H
         dMln8W9sbGPpEz163oa0vdkywq+9nDgYxtmzbmCAMZjW7UQcaUard9v3V2nWoWrjFYc2
         c7Tw==
X-Gm-Message-State: AOAM5308KoBYywfWY3zINWZvF1Iifo3iJ2lpzeT1ODYpn2IYlRUstyhW
        JpfkwWflP5sf5lJ1MfRB7hAzLy+3+OU=
X-Google-Smtp-Source: ABdhPJwHPoZWNduliotGJmEPBPr4GJW3aSMV5KO1WXDxS7PoNCfM0fizpkN5/Hn0MVfPyC91pExr/w==
X-Received: by 2002:a19:7f55:: with SMTP id a82mr22933417lfd.112.1593804299288;
        Fri, 03 Jul 2020 12:24:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k7sm4983225lfd.67.2020.07.03.12.24.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id n23so38240845ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr20104619ljj.314.1593804298028;
 Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com>
In-Reply-To: <20200703095325.1491832-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 12:24:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
Message-ID: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
Subject: Re: [RFC v2 0/2] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 2:53 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Here's an improved version.  If the IOCB_NOIO flag can be added right
> away, we can just fix the locking in gfs2.

I see nothing wrong with this, and would be ok with getting the
patches as pulls from the gfs2 tree despite touching generic code.

Maybe wait a bit for others to comment (I see Willy already did), but
it seems like a fairly straightforward improvement, and the IOCB_NOIO
flag conceptually seems to match well with the IOCB_NOWAIT one, so
this all makes sense to me.

              Linus
