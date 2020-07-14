Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653DDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EF4208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO8cP3zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGNLPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgGNLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:15:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so16828735ioi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3sxelLKYU4uPXZwq7u6GndiCwDxZdiitpwo4V3Dx4AQ=;
        b=EO8cP3ziMoqPZU7O1KsireLFRLz6kAk5Luk+A83ISKIp3CBYl0BsSNyQ0rlZjMvZvR
         +zVYqLCD7aGysbs6y0BD3HRwas/n0tz+RfF0GjnPTl07rEhw3Gy8dykmAxxThdZWvL5N
         pI2NZybp/nG233RIKpLENbUmVYexGsDI/82K/NAS4mhhJ1DyYtoZc2OYXBds7AJvbiB+
         s244XkGHKWCGEqe2TEhTwAe7QvwwHBjYgYAtDQ5uD9+UokLd5KTfXTPA5LEAcUnRAEs7
         myhVYMZdbnb/FPQ3jvmQVxSjXDX2GGgjmXz4awX0CLC+0KhvZo/92Zw+SfPWWLautAte
         bLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3sxelLKYU4uPXZwq7u6GndiCwDxZdiitpwo4V3Dx4AQ=;
        b=pa/KtenQISsRxszi7GUTVBTTV2u/GD2XSzzEG1hzyVjyKWObNGHQy0XJQ0UIttE2wi
         SLXJTjUQrNfp52joyhas9EyqvVZ0q3Yr0BhQUJsdLODu9njYq2jgRkY+YjUCqeNJZ0sz
         P4hEcyo4IsGLmYiFuPSnbP7urKgcEv63Q3PcuV+Aj/CvS7RKDotYG4eiWsv49U0hFbtg
         0y4egmwchJCfJUwPulmviyW8fd3caoG093Kg5VuC8u7BNOwbkOZ77sGFYR3uHqx80wfc
         WetpgR1i3PeJUH5J3JShVyfPnonLK9a9Uc5bUqrAltivHpVQ/7CE0nACDU0u5MUi9Vlt
         ilqQ==
X-Gm-Message-State: AOAM53128MUkv4S9H5QzRViHN4edzPrJkDEcrua5rRtCEq36cPWIIocv
        7r1WsR76GT4wz0zZ4hMrSlhHILvWJnZg/njzekg=
X-Google-Smtp-Source: ABdhPJzJMB7yH2YaRY4AUR/gh4BWrTR6oOARERQjyhQrxHR088KumcHPTjOjORx96r7wg5w+TwT8CUh1NASuP6DC7a0=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr4307279iow.163.1594725334373;
 Tue, 14 Jul 2020 04:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200712231050.5147-1-sedat.dilek@gmail.com> <20200713111330.kpppbjbjwwij2rgq@liuwe-devbox-debian-v2>
In-Reply-To: <20200713111330.kpppbjbjwwij2rgq@liuwe-devbox-debian-v2>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 13:15:23 +0200
Message-ID: <CA+icZUUx+VmiKKN3saVXaiSj1PwoskScLrgK-UXqUS7Ce-_ZDA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 1:13 PM Wei Liu <wei.liu@kernel.org> wrote:

> > With both fixes applied I was able to build/assemble with a snapshot
> > version of LLVM/Clang from Debian/experimental.
>
> I think the issue found here is independent of the other. This patch
> shouldn't need to wait for the other to land.
>

> Reviewed-by: Wei Liu <wei.liu@kernel.org>
>

Submitted a v2.

- Sedat -
