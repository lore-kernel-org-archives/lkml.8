Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5713C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C2A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XEYCKlpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgEDREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729851AbgEDREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:04:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:04:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so10480606ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylw/rVQ5uqDbHMoBEoqRYKRrSFsR0xjBGTCKci2YdMA=;
        b=XEYCKlpcxCa4Yj1hBe1EPO8dgoDM2lJYKR9mj/CVqv5dDTLl+4T8bazaW1eLrSHqCj
         TourY/FU0op5zaB6vPTBwaemfEu/JcWi7QaTZa5Ay6rctmHyqAQv06t6XNI0saMrXiG/
         Fj8XwttesOC1EtU7rbpbTUZbRpZTDorDCE2og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylw/rVQ5uqDbHMoBEoqRYKRrSFsR0xjBGTCKci2YdMA=;
        b=q2OvzsblU7qw1ukElCLJKmWE5emZuFimLOD4b2ZK3Ww8DXg+cgt6gekDNLelygLJcX
         U93b6cS6H+Y9FjuDvu0VzjAVvywrqdEJ8T8NJOfnRT+/lmMXafiGj4VDyHnD2NhoJJT2
         b3r+MOE3fSLpe2v5xULjTJ/r5ToK0DHWWnM9gI4/46OqQPqTLVVUARPqgCmyGpdMFTEQ
         q0Z590in9+8ZQ9OBopULPP5PGJcNoOgz6gMNDo8f77UXv0cOh85nNhssMWqlcf+0Wthf
         1IPefopfuQ5vYxIroloU6DzeglO30xyvzn4JkwSfeJKUPZnElWMOGJ5dCm76YPzgMJ2/
         5o/A==
X-Gm-Message-State: AGi0Pubq2WnZ3Kx0Gufp3S20zQlArLa/UADUH1FBSv1jWaf4fuOG1SsS
        w3/sYS/KyONfHODqCUP3teeSZpUyQnE=
X-Google-Smtp-Source: APiQypLznb8Y8oku/LTpjUDOzwWYRe+gLFhkZ273phEeuqpNxb7eNlWEdUNwQvvHYQx3wtzjn9gXjw==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr10328427ljj.137.1588611853686;
        Mon, 04 May 2020 10:04:13 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m13sm10336100lfk.12.2020.05.04.10.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:04:13 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f11so10477059ljp.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:04:11 -0700 (PDT)
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr10921197ljp.186.1588611851101;
 Mon, 04 May 2020 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <79591cab-fe3e-0597-3126-c251d41d492b@web.de> <20200504144206.GA5409@nuc8i5>
 <882eacd1-1cbf-6aef-06c5-3ed6d402c0f5@web.de>
In-Reply-To: <882eacd1-1cbf-6aef-06c5-3ed6d402c0f5@web.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 4 May 2020 10:03:59 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOJ2CSzdgos4Y8Wd7iZjRUkrMN=Ma0_-ujG8bihGzPKkQ@mail.gmail.com>
Message-ID: <CA+ASDXOJ2CSzdgos4Y8Wd7iZjRUkrMN=Ma0_-ujG8bihGzPKkQ@mail.gmail.com>
Subject: Re: [PATCH] net: rtw88: fix an issue about leak system resources
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Markus is clearly not taking the hint, but FYI for everyone else:)

On Mon, May 4, 2020 at 8:00 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> > BTW, In the past week, you asked me to change the commit comments in my
> > 6 patches like this one. Let me return to the essence of patch, point
> > out the code problems and better solutions will be more popular.
>
> I would appreciate if various update suggestions would become nicer somehow.

Markus is not really providing any value to the community. Just search
for his recent mail history -- it's all silly commit message
nitpicking of little value. He's been blacklisted by a number of
people already:

https://lkml.kernel.org/lkml/20190919112937.GA3072241@kroah.com/

Some people continue to humor him, but it's mostly just a waste of
their time, as this has been going on for years. Just look at searches
like this, and tell me whether they produce anything useful:

https://lkml.kernel.org/lkml/?q=%22markus+elfring%22&o=5000

Brian
