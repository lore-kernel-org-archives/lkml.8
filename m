Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E34BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6650020721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz5H+K0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437271AbgE1WnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437076AbgE1Wm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:42:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A57C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:42:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c8so286618iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEfGi4dyFMuYwCLRVBWXpuKxbIcboEwlu5YMHVWkvwU=;
        b=Jz5H+K0LECOpJV+x5y5LzisTdw0mBwpNBAWX0ryNwkXHFicCczhJWkTy7cyfBTaoh8
         7UDbLYj2s0zAXp62JNi2RahdJWGo7317KyHjlyBaUQgE26pYk3YCSSvxuPtJ27rvY6Ou
         I5rFFKjOqq1PWOVQhH2jYfo6RftnqRYqgeziTykblZfbmDwphViFy4xXbFc3buPYnEiG
         gN0bGGtBTVt4wrf+MlgHub54Gn6nmsqOXirjbkEUikMqic3jf8wKbVsNGDR8D4f4/dCF
         Dz0zx7E7z4Yc4+ApMbZmdC6bJ+V8YZjpU6BwBA5PQQaZWqREhVbzVhcx5Dj0jvQYFIMS
         eUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEfGi4dyFMuYwCLRVBWXpuKxbIcboEwlu5YMHVWkvwU=;
        b=EMRoer3Lryy1ESYI35z3/nFcvGcLt+g20E4Q7CWE+yt4c+n6wzoDCvsxUlQOUnbmqo
         sq1P1372Teu2ebQDDb7SViyWojQnkZffixWFLw7hQTI+7EXbELCevYoqrt6vV2Fi5aab
         8tHiRC9t724fAyYC/r9HQ7OhkznT8l4+J+9W0a2ufXCiE6AJi5aClpIduvkdX/1V/nWQ
         NX+upmj/ofWUnnpEJDwrRmCbjUd6CHtEDdPXNDIWRdbEPLKr+7mLUB3ZrskoJ0iO03oz
         7N9H+qfht3f1FFTAq5Yv4Ryw4vm8fQxq2dtZZEdL/tPJKihfGIwsBNI2hUJovAw8FUWw
         y5dA==
X-Gm-Message-State: AOAM5316vNScF1wF7kMclZ+BzeUrVJVBGxBhGmGc/QlcLSzBf+HM2rlN
        o/Y+IaXWVVMFuU6MpKLW32XGyM9OuC4gDwEY7+A=
X-Google-Smtp-Source: ABdhPJzcCzO/QPGhPNtHDDVPrWC+c7clNsY2whbfzkyuR1rchvCHcalka6QuFOi1V/bewHNjt9xxf3BMPxYlsBDsrdM=
X-Received: by 2002:a05:6638:112c:: with SMTP id f12mr1888020jar.98.1590705777743;
 Thu, 28 May 2020 15:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200528201937.038455891@infradead.org>
In-Reply-To: <20200528201937.038455891@infradead.org>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 29 May 2020 06:42:46 +0800
Message-ID: <CAJhGHyCua-oTww9U26CJvfojxdfQGewH1T-JUro7gLKucT2+kw@mail.gmail.com>
Subject: Re: [PATCH 0/6] x86/entry: disallow #DB more
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.
>

Hello

Will #DB be allowed in #DF?

Thanks
Lai

> Patch #6 should probably wait until we've got the KGDB situation sorted
> because applying that makes a bad situation worse.
>
>
