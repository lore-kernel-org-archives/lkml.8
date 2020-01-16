Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F3C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861CB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlYcEnqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbgAPX2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:28:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47028 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391058AbgAPX2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:28:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so9020830pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 15:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfaClSXaxrCHJAkctZvOsf/dRXQsvoUaGoZqBzPgF88=;
        b=TlYcEnqhfZgeYBjs2eviKJRmRuGeksObgSsXK6erUBxh2WNdlKAQraGXVY1F7EdTnx
         gjItxCeAzGKJBQNbAfXASGsc3KtJ6dXGFcpWnh8tZUQpbRnMQkjPROpFwwKIxooPB6Yo
         Qn7UQoW9OD2cBmkBtT16+ShihFT5Hvsbrn/RXqCtG6tsmzNcTFUQ5lqMYhXVJgI5v1Ku
         79RjLvLRJE8tNnyBW3lOdg3/B4ELU35W0P/hIfCcBeo4Lk3B/0gH+y0QUY+nGF7PqjUA
         1K5+Jq9pcZqT6lE4Z6y8ktFUV1mkzqgZICmb4EREnWJIY9DYppZGSvxXaNEbRx2us6Vz
         vvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfaClSXaxrCHJAkctZvOsf/dRXQsvoUaGoZqBzPgF88=;
        b=jHh5yDNo7Z5EMazdWh0ByMpYYpUUw2CD8C8JsjU/ETtC2UgYtIwCyjrHvCvlY5QCuL
         puaw/2nBlhYS4AlIKVX5k885c5UHc3r6/3RUTp0C+a8R9TMTeJYlP8DdyYk+lO9h7Fce
         m1vYlyJ/NmnuJNqsxhaB1EW2m+kUf9iOUDXdlXlO7yLQQA23XXTcP4ZQLmD20D/rhB9C
         BGJmYrk8sTsAh+ArMtac4veVeHfUpFIw5Oobo8OhFrAP0lZMZMZ7lFI+4EAz94eKb4Vi
         ax2bJ5t6g1KsdQXhQdpNaXakstBNqWPZEboLZukoC9S5X1V3HR6YgwhkgJCO8fRTCo9E
         zyIw==
X-Gm-Message-State: APjAAAXwidWzwgLlxUKLLU+UJDPx/P5JSN8izP+SE+0tACjGCoUovEnB
        uPHxLCCcVqg0zAhCfS/gQSVQtSevxic1dCV9pZchUg==
X-Google-Smtp-Source: APXvYqwgpNCP2WmFVqw3r32SxiAafFLDYrj7zGkZmqerQuJRx2/zxLBjAFAJ2s7jp8Vm6kKHRlrAL+8wXIP+/gVSZmw=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr2121532pjt.131.1579217288135;
 Thu, 16 Jan 2020 15:28:08 -0800 (PST)
MIME-Version: 1.0
References: <1579173451-2439-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1579173451-2439-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Jan 2020 15:27:56 -0800
Message-ID: <CAFd5g47_yrZEHvCHUpc-b-hpMzXzJmaXxevcwpVHhs=2BFR+Bg@mail.gmail.com>
Subject: Re: [PATCH] software node: property entry kunit tests must depend on KUNIT=y
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 3:19 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> property entry kunit tests are built if CONFIG_KUNIT_DRIVER_PE_TEST
> (a boolean) is 'y'; it in turn depends on CONFIG_KUNIT.  However to
> ensure clean merge with linux-next, where CONFIG_KUNIT is tristate,
> we need to explicitly specify KUNIT=y as a dependency, otherwise
> allmodconfig builds will build kunit as a module and fail to build
> the property entry tests.  Later CONFIG_KUNIT_DRIVER_PE_TEST can
> be converted to tristate.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 27f9d7e984d9 ("software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
