Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CAAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF852065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf95h8/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFAKfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:35:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361FC061A0E;
        Mon,  1 Jun 2020 03:35:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id i17so4109024pli.13;
        Mon, 01 Jun 2020 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21ZKUiitaA/VhyuuR21o/snW4MjwihJIMa0dWGwpQ4I=;
        b=cf95h8/P8RLWELxgMUXot/xVV2Qm8zpk/WRjFXZJchtLMflAlwkn0HVmDmNfmy623M
         x9B+3YHbgZ1PO0Iyf8QndcNTAbtgeZhKTtEw+UTzvdHBadF7RQc4QRHI6LPirfxaz4by
         GF5KQkGkc9WRfDqJXaSLb0Ffc1x3EAy5CiwpwQkZ7hhFQp/YlL3R3kTAtoskNkZcQRtb
         PTf0vgDAYBkq+KqGYqJPG5H7Nn69AxOEVLQ9Qet40Sn14P64WBqUzyEIyegC6hKDvFlx
         Ws3OHclr/nf8BlUexMUqWhVDbydTSJ9PqxD1cJhHayYoqt1RvSagTr6vIKzIq75j8vlG
         frgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21ZKUiitaA/VhyuuR21o/snW4MjwihJIMa0dWGwpQ4I=;
        b=iQdsgng2xm5Ig3LVNT7vUJ/qPSciTdnTNuo+sa186JdHHDCLRcXokkUA5yd0JSRV5z
         xi9swuDcrfKZcxbsuub7hZMSJniqu6UftVG81v0b3iOw1HqYUTHgwgKPeL6ajCHrlm2G
         2oVLZ4vh8TMjnXArpoBM0LQX4TqLOWkEtTIvNmtoOuS01XM/FvdxdFwX+bkNDiShBkNo
         irlF2HwfWeH2E+DblJhPOi8DJuMUHEOS7I8/oZCwI/ysYDFulP7QALh88WA14HDMxdQD
         tihNoC3GNu9orAtzSTa6vWqEfQyX5s8/yL6adHiszI5AIESuTIklJui6/HRsWEjbbXDa
         FAwA==
X-Gm-Message-State: AOAM530tvIszj8oo28OTmKhSSkmkTJ+4aLEDTyc85oFpwY9HTX3M1E3Z
        8zNNB1eJVacI3X2qMK99BTehmiPwntDL9wPv1HMRKu0PRkVJSw==
X-Google-Smtp-Source: ABdhPJwgMTA7CTg/J3O189c9eXdi9xezD6/jnmjsispxqh2tGpuDIdE5UzwbivbO5Alg9BCa5kCstAN/6s2oOmrZCw4=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr8473367pjq.228.1591007735577;
 Mon, 01 Jun 2020 03:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041506.39638-1-jhubbard@nvidia.com> <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com> <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
 <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
In-Reply-To: <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Jun 2020 13:35:24 +0300
Message-ID: <CAHp75VcaXTM86K9vzyxTQJP_oNnzJ8mMHzgm7ybEioVhG6DHDQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 1:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
> On 2020-05-31 14:11, Andy Shevchenko wrote:
> >     ...
> > JFYI, we have history.git starting from v0.01.
> >
> OK, thanks for that note. According to that history.git [1],
> then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
> pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of
>
>      commit 434502754f2 ("[PATCH] SH Merge")
>
> ...and that commit created the minor bug that patch 0001 here
> addresses. (+Cc Paul just for the sake of completeness.)
>
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

I mentioned this one, but I guess content should be the same.

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

-- 
With Best Regards,
Andy Shevchenko
