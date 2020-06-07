Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4968CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 12:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219052064C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 12:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iksT6XN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgFGM7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgFGM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 08:59:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B509C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 05:59:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y18so5574234plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=13Yqp6cwkFCZ9XR53+tBkYuICFMznkDxO3gGMIN0iL8=;
        b=iksT6XN5g4yhaxFtLLKlddI7+CySOqTPEAHzw9yQGDPzU4V2r9rA5XS6xSv+2xgKl0
         rqPbFedISCJmLiswEZdbLRJDRVEO5P8GhZqBqt+nxHT7/jpnzDmg7Ah3t3LG3Rh59XT+
         xDlCvdLC54WKOt3K1cwvLAhqpSaazrqw+lquSK/P/dtwLYLybCmDhRnASk8v5SKXEFme
         o2JQkxQxdLcUNrhBCVR8/3QoI8kgLhADVAyESFB+WodtcBAAk8IY/cvQEjxiuosdkpjB
         jD0FgcQ4nYo2XeuaPEzZhOcIk0vnL0kDKMDnbbG8DwT6IdWBY0xaWeMq2aMyuQAHPDCi
         z+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=13Yqp6cwkFCZ9XR53+tBkYuICFMznkDxO3gGMIN0iL8=;
        b=l/Hs0ANqv1XUPC0hRuMbNy3++BzA7wswle7tGNrUVDcqzXrrVstpUSQJ0II/Gy9cj0
         OENAwSo6drbcTPHtK29UqF2SczSCx/iHb/QOQkZH9KHRGPQfls7XYpKIuViHBYToehRT
         Xv25njuQACegq33jrsWRKDd7Dg9g4SunYUkt81BvQMYPw+97UpFQUMu8n1F1tGrnWlnV
         qAASpPTm8nAUCScRqOnDD7aPhiI9l3HqsGxuWD9FLQoEhL4yyr+Y+Q80E04HvQJxM036
         b3oTxbexc938K6w8zZkE7hQYOW9wIhVo6vWrOgnEn/3h/RHP29FJxYi7UCtBYb4RW3D6
         yN2Q==
X-Gm-Message-State: AOAM532jx9qF+kZBbxtPo1knE8A76zRDsj/xHv21jBY9xePG7a6+Yiu2
        9GXoUGxAWTz4o5UImaJNCt7+Tt5v
X-Google-Smtp-Source: ABdhPJxFibV/dZxY6uOTSc5YZxGEi/sbNehCkRkwBNNnmxni3lI0utK+5zrEeYfqoZXWbj4MlibPNA==
X-Received: by 2002:a17:90a:a897:: with SMTP id h23mr12310158pjq.90.1591534780441;
        Sun, 07 Jun 2020 05:59:40 -0700 (PDT)
Received: from localhost ([49.207.54.208])
        by smtp.gmail.com with ESMTPSA id u35sm3656450pgm.48.2020.06.07.05.59.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jun 2020 05:59:39 -0700 (PDT)
Date:   Sun, 7 Jun 2020 18:29:32 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ARM: vmsplit 4g/4g
Message-ID: <20200607125932.GA4576@afzalpc>
References: <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 16, 2020 at 09:35:57AM +0200, Arnd Bergmann wrote:
> On Sat, May 16, 2020 at 8:06 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > Okay, so the conclusion i take is,
> > 1. VMSPLIT 4G/4G have to live alongside highmem
> > 2. For user space copy, do pinning followed by kmap

> Right, though kmap_atomic() should be sufficient here
> because it is always a short-lived mapping.

get_user_pages_fast() followed by kmap_atomic() & then memcpy() seems
to work in principle for user copy.

Verified in a crude way by pointing TTBR0 to a location that has user
pgd's cleared upon entry to copy_to_user() & restoring TTBR0 to
earlier value after user copying was done and ensuring boot.

Meanwhile more testing w/ kernel static mapping in vmalloc space
revealed a major issue, w/ LPAE it was not booting. There were issues
related to pmd handling, w/ !LPAE those issues were not present as pmd
is in effect equivalent to pgd. The issues has been fixed, though now
LPAE boots, but feel a kind of fragile, will probably have to revisit
it.

Regards
afzal
