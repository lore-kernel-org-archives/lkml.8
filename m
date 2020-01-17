Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0253320842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="yCgP2tn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAQSp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:45:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45540 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:45:58 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so22052670iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=420/qCDRks1KhueK56gSNAOoSvZ7SEAp1yLAyd/yyFM=;
        b=yCgP2tn8pQLxdsNWd/XN2QqX2CXdZFqGPPFyzspWIdPa9qUzOoE2kzJU1IE0tUdWjL
         4BXq38kFJEGC3fc597AP4qMsw2oTCVb8ODMgBngH5myjiGjB0NOgakVVrF8qkT1jXQCn
         lcO05570Ul45oz3t/HUGQpCHaUiWQZDkcmiWSn7H3n69c4jvAgrogYO2eMwdWaOVw7ly
         kSRJDVqj9ChZDf6ytvSZIzdeVpVR4iAZVONpFwOkRNCMuH4elY7iGxXBZMrL6nTdRyKB
         41MQk98RiEplwZ7uLSd6xiVgOh81zfAfG8v/8tKttjGBjQHuuobYT8OKSbu06Jjjy3ih
         8PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=420/qCDRks1KhueK56gSNAOoSvZ7SEAp1yLAyd/yyFM=;
        b=DuofvHYixXarQ24ShovI671WlKa9OLCJ1JVyE9LVWdcnCLPBYy6RJ+z8tCqSLzaUlk
         Dyx4GuH2x/5szwl47FUFnyk1KvWE9LKT9fa1X/JQsrCGn2yYV/5byufiJZBVWRl/KPGb
         epdpFvV9+KLg2ZjIAnDOFAdmi+rDfLHFDPTGeM7aMc4gYzY3vSQ7JDNLr/hZG6eYkcTK
         dsrvVXV0BgGeX9/3PuIue5GfmUORIQg8/Y+84tqarpSSKVjeAlo5obiFTw3l1BRKptwH
         RPG6Y0GdAxnraWJjghs8MC+KpnZVwIJwCwim6dAOBsvEkkYOXRIHZ4VBYfQ7WA7hjxbf
         Ub8w==
X-Gm-Message-State: APjAAAWhsbgxWinRgRv3/KmJJ6hi2NmTKD1MtvPYMHsITztnbh4C1BAN
        wLilqrvrQ5GU6GglZbAsYzqFYe1PMHqrlWmIQYiGqw==
X-Google-Smtp-Source: APXvYqyD3T0zxOFN2wcBKJ8V0hfXKMNOlDpYBDr5FI3wwBYODV4MtVy/MotlaHesUUq+1J5hAlsR+yalSwQOTCFwfJk=
X-Received: by 2002:a92:5d03:: with SMTP id r3mr3908789ilb.278.1579286757291;
 Fri, 17 Jan 2020 10:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20200113065808.25f28c40@canb.auug.org.au> <CAOesGMifHn6DbNgYm6YUbdKjSL5rNgdWrq+HX9dEusrOr9xX2A@mail.gmail.com>
 <20200113113837.130c3936@canb.auug.org.au>
In-Reply-To: <20200113113837.130c3936@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 17 Jan 2020 10:45:46 -0800
Message-ID: <CAOesGMgiAp=xjpyvXSmuXL493Ki3DvWXf3N5uncP3s08_FpvuQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Yann Gautier <yann.gautier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Jan 12, 2020 at 4:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Olof,
>
> On Sun, 12 Jan 2020 11:59:58 -0800 Olof Johansson <olof@lixom.net> wrote:
> >
> > Thanks for the report. Time to automate this at our end, we've had a
> > few too many of these slip through all the way to you lately.
> >
> > Where do you keep your scripts that you catch these things with? Do
> > you have a writeup of the checks you do? I should add it to my
> > automation once and for all.
>
> I should export my linux-next scripts as a git repo, but I haven't (yet) :-(
>
> Attached pleas find check_commits which I run after fetching each tree
> and pass the changed commit range.  This, in turn, runs check_fixes
> (also attached).

Thanks for sharing these. I'll add some slightly edited versions of
these to our soc-scripts repo and reference this thread and you as the
original author.


-Olof
