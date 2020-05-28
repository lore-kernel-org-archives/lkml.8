Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822A520814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fOEq3QDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404300AbgE1PP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbgE1PP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:15:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE66C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:15:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so3411524qkw.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaKHhY3AUa1ooLcsW6eRoTXAlHKgXN40+Hk1wYZjsxc=;
        b=fOEq3QDbXisJKBvI3Hpl13KhU54sO7fqQ6j3+DxR+wqsdYupJymQl32NDKCOaelvZ0
         oIsjxa7BwZEZjymFvh9QR3Fdu/jbngU+cX80GiUQZFmnZLyHIePYQrOwKta1Px5Xc1Km
         Ftg4nK/7fXKT3+KZroRDejIwbzp8A79qJrVKXZhegIffMhDT7xW5SDG4J8/J7zqKM4NN
         zzNDORHUKM9U3CLhwTGYx28k2HQNRgaHe2TS72YsOG5IT4ZJNHh3KfJeg5dQQfs35f77
         2NJvVWjJUUAD12buLaE49w+8Kt/aoiyy/8trL5d6U/IySt8UdPgVa2M54Q2XaRj3zyre
         06nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaKHhY3AUa1ooLcsW6eRoTXAlHKgXN40+Hk1wYZjsxc=;
        b=H1J9U0fPzJmOSq69VC7u5KgWdhSR9PW/Jq5U7DXo6/W8knpXt/vbWllh6dbbc7XiH0
         XUB2/lGeet3Xy9oksjYu90fzM5f6wnS8sijzNrC4OixclnQpsdl1z5ypv4aBIOLNO2ci
         ScyymTJahdBD7e3ym9qnDWFWqVXHJaOE5qWaWOdtbB4h+dO6wyxPpP8MxIFHFGluvjOp
         zIpcsXVnO05DwDD+xEJllO8OBJjxvYKLxB9+vT+fVlvEvTA4Pbm+qDohg3QjMp409zk8
         B1F6GuOaefzYhwp9OHKyCrfIwMNnekj1RfXnA8BcVyZ6/aUFndf6JTaI5Tr+QSq9FPZ2
         szAA==
X-Gm-Message-State: AOAM532WVQKY1rt71CdYVQzWXf9lhIKs57ctD+zAWZ+KVVVfmOZFuq7x
        2/mzHUYqYhcvLEUG9jj4haSUaw==
X-Google-Smtp-Source: ABdhPJzAfuAo/+k5fTkexGPkLNpOanH6an77O+jnuk3g+DIJJrjU7hOHVr0sasprQTbSxfxj62bvKA==
X-Received: by 2002:a37:db11:: with SMTP id e17mr3162812qki.336.1590678956890;
        Thu, 28 May 2020 08:15:56 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x43sm1748343qtk.70.2020.05.28.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:15:56 -0700 (PDT)
Date:   Thu, 28 May 2020 11:15:54 -0400
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
Message-ID: <20200528151554.GC2702@lca.pw>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
 <20200528134913.GA1810@lca.pw>
 <CAAeHK+zELpKm7QA7PCxRtvRDTCXpjef9wOcOuRwjc-RcT2HSiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zELpKm7QA7PCxRtvRDTCXpjef9wOcOuRwjc-RcT2HSiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:00:54PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> On Thu, May 28, 2020 at 3:49 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > > The kasan_report() functions belongs to report.c, as it's a common
> > > functions that does error reporting.
> > >
> > > Reported-by: Leon Romanovsky <leon@kernel.org>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Today's linux-next produced this with Clang 11.
> >
> > mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled
> >
> > kasan_report at mm/kasan/report.c:536
> 
> Hm, the first patch in the series ("kasan: consistently disable
> debugging features") disables stack protector for kasan files. Is that
> patch in linux-next?

Yes, it is there,

+CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)

It seems that will not work for Clang?
