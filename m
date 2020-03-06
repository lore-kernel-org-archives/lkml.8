Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFEBC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25A12073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNrX6AM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCFHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:54:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33643 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgCFHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:54:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id o21so3212727pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWIoMeEB2CUV9mwiKAX71h5fko7k2os2QipVNvf6bCo=;
        b=PNrX6AM0uaL/bBdobe7dNADUo+F4/G1hUMaxudkNpBcH04picEhD9scb8esJBu6Q8a
         A7NTB9tyLFjUqB0Vb41KIuF5FxaKvLvWhw+T3Vo62B3dpWk75cmacDwHBt3zF1aizmPG
         N6NQ0FxUXTlZL+gPZkCLmVzv/rkU2ShqN9g8ELn3yjtOxdhMkq8ZuTaMeuEEjZNG+KZj
         qPvK7hZhtn27i/JgwlrAdko9a3PCR3Eq7bYcoaTGUGV/FdXuzzbksDpnqZK+fe0HFbD5
         3bwKi8/YJ227AsaLnnoEwW575gt7UXxRPjLV4V8wyTXWk+4KsQFkWq2K8S72dKjhXnVV
         XQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWIoMeEB2CUV9mwiKAX71h5fko7k2os2QipVNvf6bCo=;
        b=Uz1mVLY2yecjFGy0Bd0rHVkzJMx+GSa9enmgwaYyWuVG0NQj38VN8NPavkfRAqg2Fa
         fy+gxy0tuwSsxt/9FPJgklsEfqA4Ma0b9u8iyFCaMSS8JvLeF2KMvUwm1yR92qdDiIW4
         quUyB4YiznA/rpJWp5SH9V2MhFMflaa/I2Ba6pY9SwmKk6MnlxOeV8Yrn6RKUtnLC8tJ
         0r1ScxGE0id0B/TupzX/FHFB1CnKvcV4mLHuMDjpGh93eArz03nHc1gQUBYwdnt9TZOk
         Yl5skBDvZ69/q2NJiJHu9r/9JCZ2kM1jOy1qwjBEs91bi21YY6pY/ADPL+IRR7jUMIj0
         1g9g==
X-Gm-Message-State: ANhLgQ10sCfJx0jbKGPU1CzgPbKoqV0j9tsiyv+MV1rcCzOJzitRfezm
        YjCWbMxakI70NLNzbtn1Y2e/naXjKHhgOeqxps5UQwpW
X-Google-Smtp-Source: ADFU+vvQFehPqcFAEG48yvZ7aCbXwYyl9wcrvV8Hrk3L/zkur4PN0je35ufuF1mZ6Z0WKNa8hjuWx2TxU5yX8MAX2j0=
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr2271425pju.46.1583481251417;
 Thu, 05 Mar 2020 23:54:11 -0800 (PST)
MIME-Version: 1.0
References: <202003021038.8F0369D907@keescook> <20200305151144.836824-1-nivedita@alum.mit.edu>
In-Reply-To: <20200305151144.836824-1-nivedita@alum.mit.edu>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 5 Mar 2020 23:54:00 -0800
Message-ID: <CAMo8BfKDF+6uw_jxMa2BuNScJS=PMiwFhb9YhH4DWD+jo4+dyg@mail.gmail.com>
Subject: Re: [PATCH] xtensa/mm: Stop printing the virtual memory layout
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 7:11 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> For security, don't display the kernel's virtual memory layout.

Given that primary users of xtensa linux kernels are developers
removing this information, and even disabling it by default doesn't
sound reasonable to me.

-- 
Thanks.
-- Max
