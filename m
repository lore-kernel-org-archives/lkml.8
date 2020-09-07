Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80BAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2876208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzFj48bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIGIUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgIGIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:20:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453ACC061573;
        Mon,  7 Sep 2020 01:20:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so3216263pjd.3;
        Mon, 07 Sep 2020 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu6QuL0UNannScwxHaH4kwF4j0IIHvrqbeNkNin/82s=;
        b=PzFj48bv/qIAhvELdiZ74C5QGUi8+5rjEDPfgRSAsVP8huQiJ4hmO62fJe5bmbJDkE
         36OtFZ/ELEOEOebftMm6KGBY1Tga6KOg0cfxi7Kxm0S4ItilLipzS++C4bFWG8xJ8lKz
         AYtxainz/Wufxx1MPoGahWzHKo3TEw0pQa+7xJWnSSTDPZW9dUKW3k12xs3F8ca6xFp5
         ajjh44fbqt+/FYuYVbk4L85GZ908OK5ZnVQMZB2ioBXEstA1BEmiL40lOnN7nsRhb4jp
         QUTES/cpK+NYyXJOWplYFUzcn9PWpYvdlqLcgEWcrCyoNIqQcOLrh0YdDLsM2MIvDoWG
         VogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu6QuL0UNannScwxHaH4kwF4j0IIHvrqbeNkNin/82s=;
        b=mIaBg66u2r2NCTHsl4GxyXQoKoVY8Lfri3vEN1V+bsEg6WczHbVm9AsOilrAzToXUl
         vVoHmnHKlNXj0kiMvJBx0zqnzm8gvWjktqgON9t6WeyuR7s4g9NPFg6U8BlnQLe8OeGI
         fLn98Okq89+kLaQ34Zwn2r9oLp/S2DXxcvP1ACH3l+PUQbFv1F3G54Hf0rclGcU/Ucv8
         uNapS4dx/o2KnoDacBte6E3+0aCX+lHc/MhNUImq1OOYmn6bCdqjAprndWqyIftcVQek
         2cT9XkhyXUw7pj+WFJJYEMfBAL6TvNH8X4H5Hq696bzdGVxP7ykwPySaaP/B4nNPNwAj
         tl8g==
X-Gm-Message-State: AOAM5316DbAsWhDJb9cFeKBmlk2+/Duah3WSJtjyDUK9uHsMw9FWFdIT
        9PHzkMesPxm9qEfnA9NvIRvUF3MLoVj62t/fC+oHhV/cs5SVpA==
X-Google-Smtp-Source: ABdhPJzBR0PfxIU3vsChdsdh1MJZ6ehARwp8Ek1qsJCsAGcrTrmSpY9faeRJlIDXCBBRtY4qq8HpFXpSWzioimff/pM=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr13356863pjb.129.1599466832876;
 Mon, 07 Sep 2020 01:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200906185039.22700-1-digetx@gmail.com> <20200906185039.22700-14-digetx@gmail.com>
In-Reply-To: <20200906185039.22700-14-digetx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Sep 2020 11:20:15 +0300
Message-ID: <CAHp75Vfm24pNS_OR5m4DSuxLfH_XA+uzGhC_egk+41gCPchNjg@mail.gmail.com>
Subject: Re: [PATCH v5 13/36] i2c: tegra: Clean up probe function
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 9:51 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The driver's probe function code is a bit difficult to read. This patch
> reorders code of the probe function, forming groups of code that are easy
> to work with. The reset_control_get() now may return -EPROBE_DEFER on
> newer Tegra SoCs because they use BPMP driver that provides reset controls
> and BPMP doesn't come up early during boot, previously rst was protected
> by other checks error checks in the code, hence dev_err_probe() is used
> now for the rst. The probe tear-down order now matches the driver-removal
> order.

Seems that partially this can be done in the patches that converted to
new/better APIs.

Also consider the use of a temporary variable for struct device
pointer. It might make your life easier.

-- 
With Best Regards,
Andy Shevchenko
