Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA3CC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF32F20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqX98UPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgAPB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:29:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36295 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgAPB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:29:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so9391128pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxQur2kQZwvXXhxosa4NMea5BWsU4H46CF2A9E+WOTI=;
        b=dqX98UPE9XuMvwpBOVyAdFYODVEWc6XZCk7xMbstuHVxDrDHB/qf1r+1ukjpCyh788
         IVlkQos3mjlSeNYGqeuShxr+WKe2kbISrevBkRho73kAxsrD+k7GAmjdi1D9s9uQbFtb
         D+MTYVpAvHaD4mhJG0VPGZPmaRV4f0xR4DdVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxQur2kQZwvXXhxosa4NMea5BWsU4H46CF2A9E+WOTI=;
        b=Q24+ie4cez0dJOQ79svGvQqYTYhp8aqaIc92QqoOJ/DhrsmKO3SpYX0bt6zyGWUkUC
         aPwtktnDD5N/D2B/AoH+AzsgzfHxZiWxQ2Lq7ZRSRWRKgBU4COFj8CkuVVXJpDLktvWe
         WmOuqsntz452jsjt0ktXM7PZ4IluHYewKG2JfmusdLPJn0sktwpjJ2oNyk4DOPxqlrnW
         idN20LdPIy67Ch3FrWpqgYizybUBHWRDiM9WhdRM7g+4HGx7XafWsxVBTh8qXfu0EAG9
         IfczG/fI3eaWs6Kw8z+LcJoF0+lqCk8ZMiaB+kNGrQAtfC5zCzmY7QBASLIWWC089cHd
         rRUg==
X-Gm-Message-State: APjAAAV4DetxlbeLugdHpglUTUcj/O4vr1FmV+IrnIZ9E++wigFIL5s7
        mW8zvjkQRlMwGCejDQGHWT4wvg==
X-Google-Smtp-Source: APXvYqyLdhE65mIqloYvqZLlI/TL8h+q3XXWKqgvHbL0JTAE2s0LUtdCMtDZyri8DuhDJPTOFfDlCQ==
X-Received: by 2002:a63:b005:: with SMTP id h5mr35368703pgf.67.1579138173832;
        Wed, 15 Jan 2020 17:29:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k44sm1037131pjb.20.2020.01.15.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 17:29:33 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:29:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
Message-ID: <202001151727.C07DA17@keescook>
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
 <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:37:07PM +0100, Arnd Bergmann wrote:
> On Mon, Dec 30, 2019 at 6:16 PM PMWG CI <pmwg-ci@linaro.org> wrote:
> >
> >
> > The error/warning: 1 drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > ... was introduced by commit:
> >
> > commit c032ace71c29d513bf9df64ace1885fe5ff24981
> > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Date:   Wed Dec 4 10:53:15 2019 -0800
> >
> >     software node: add basic tests for property entries
> 
> This problem is a result of the KUNIT_ASSERTION() definition that puts
> a local struct on the stack interacting badly with the structleak_plugin
> when CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is set in
> allmodconfig:

Geh, BYREF_ALL strikes again. I'm at LCA currently, but I'd like to try
to revisit actually fixing the basic-block splitting in the plugin. This
was looked at before, but I need to dig up the thread.

If a fast fix is needed, I'm fine with disabling BYREF_ALL with KUNIT.
It's not optimal, but I feel it's on the BYREF_ALL code to solve this. :)

-- 
Kees Cook
