Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42F1C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADD62082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXcNgDAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGM6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:58:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C92CC05BD43;
        Thu,  7 May 2020 05:58:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so2589964pjb.0;
        Thu, 07 May 2020 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbEhrjjFgOVwIrtyi1Kol8YE8qzx9NjD2Xx5i49yMOk=;
        b=DXcNgDAikMIhemQI0QLE1ZGVymVrit70+w/H2klS0TDyJLlyawor5fyRDFwJA2H87E
         1aS8Q6I1Ro4wblYumbJ34b0TWvcyFC8r6a4+cMUVTSIQGgBcTpvKG/wr/Z9StIWW+Fpc
         GHHnE2drYLFmDwzPCIG3KFXdG63DZN3zEvTZwnU209eZ4r4SJWoLqKEnxUljCgIDy4/z
         BRep6I7lazrg8vT1F8Rt05jGWh3DO0qGSFvKRzgYxKQvNLS4U5WbxaK8q6GoqRo180ZZ
         LeSY+pBg8yxM+ufYskJXXaQ31Z4PQ0dYlB1RRErSrJcljzRezIsCou/8G8ae8j6WNxQU
         UGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbEhrjjFgOVwIrtyi1Kol8YE8qzx9NjD2Xx5i49yMOk=;
        b=h6zhjsipZX6EbHlbBUMUiJpsd5PCvmVRL4LnBZfwJSEWOZTJ5O90TwYUJdNo24yHfy
         53HeM5dgPar5jo3ErRjtxG1UY1GxVzynisq93e44cvh1KWsoDooTGKsjF0K1fPkL/Fju
         0EJe6LlnqORkaUYgAPu4GkGCR6sPJ9EoaOW3mk98okczi0IVd9EFPnO7teFxvFwXhelw
         42vDJDIuKVj5rbbNAbQbQP0+xpVrt9ZmwQAmz/fYqkmeB1lXD4PH47zBg3K0id2FDe5W
         HlWCpfWSnEZv6xojesQjhd1nP8SyLgyhwWVjAVLdDSONLG4oms+fHig+i7s3JbZ1R/kx
         KZRQ==
X-Gm-Message-State: AGi0PuY2r5os5UfqJtaHRj8JtHwEScsbs/LkRsvsosPC6C80iSvIIFD9
        w8s2wZbuG1f6E4fH8+nT7Pp3tKAMtEeZLzINMPE=
X-Google-Smtp-Source: APiQypKMBReYMFY92sBNMrCLRWs7yzrqNZR5HnINyvcmqGRNTb7gikI46Ij4OJqqCz+8OCEAj+lFA+dVdR1Y1cUfXUM=
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr14760232pjb.22.1588856318165;
 Thu, 07 May 2020 05:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200507122703.14617-1-koba.ko@canonical.com> <CAJB-X+XwshJp1ud32kXxRGkE+8WdM+=e1MSewmOUvgERk2yGMw@mail.gmail.com>
In-Reply-To: <CAJB-X+XwshJp1ud32kXxRGkE+8WdM+=e1MSewmOUvgERk2yGMw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 15:58:26 +0300
Message-ID: <CAHp75VcC4sXC7_jbhFM2bE01NGks0zzQBNquAc_Xz6jcmwvkpw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 3:36 PM Koba Ko <koba.ko@canonical.com> wrote:
>
> Hi All,
> I enhanced the patch and refine the commet.
> please check it again.

Thank you.
What you should or shouldn't have done:
- you need to use version in the patch (-v<n>, where <n> is a version)
- you need to write a changelog after cutter line '---' instead of
separate messages or so
- you need to avoid top postings like this very email you send
- you need to wait for a while (usually one day or so) to give a
change for people to look at it

-- 
With Best Regards,
Andy Shevchenko
