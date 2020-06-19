Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A2EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D2920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic8WHFaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgFSOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbgFSOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:41 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DBC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:36:41 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q2so5724245vsr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p64fS/M7iBclbiXTSpgx3EjtiGyRATOfe8ygdOBbL8k=;
        b=Ic8WHFaX1OgEjYWYHCaiPKgCONLHc18JvsQw7PDHNkGvuc4vqW3jWk5o/ob138BjEQ
         Zd229mEfPxOZ6iEbirc+I2meMJZTOwHcmZX/z0AfYOP8sFKP3qvqOMSVdoKmXKGjc5bZ
         MU/NuLF+0kRrF1hZUakchQh8oM3d9zkPkoBLEtS846kWCFIHrOs82affjmruJmcXLSmv
         tRc646pgixkWl7ooq5shgp9bqq4wjX15wOyWepOeZMrMSNXfSr3edJt7NlVEpwhn9B+H
         yY9hvHl6EwXt7zqiUlZlijpnOrTK7Py93/GxGHtgmaXVkJbkGzJT4YIBwmQnoupCpq9q
         59Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p64fS/M7iBclbiXTSpgx3EjtiGyRATOfe8ygdOBbL8k=;
        b=fZARC2zLkGpOo47k6fA6zjafiswL1eagzrFtAY42/BwgI1602p4JbxjaYmKkS7M1w2
         pbt/cShHlQAqHc2zkxIYFDZb6yzkkC9smMYRgdIabHxgyV06wcCZNYZFxj1JbUSMDB3d
         vDkRB97h+UsrkuUuF08H8RVXhiPm2LKHZ7XkFucPXWswxGKtuxIqgCV3ifJB9zSjPQH9
         UD0Ei5cGeHVqmzcUEYMwNq4e+zYInXpxutc77VDeWUs/Oe7+qMha53eKHp5rYNhzECze
         2Rz7LVttdr8pUEfDlLstNsiCPfZReT2e2MS7WQH2MJJlPo1mMEjIx15nNmGvpGNeVQal
         5a5A==
X-Gm-Message-State: AOAM531BkHfmFto10f2QnqTaZA9JMP+y47+N86i20PWuItg547V9x2Kd
        iLwQk9A5YZ5zY2sz95+85VrMc+d4plHKAu2iHeI=
X-Google-Smtp-Source: ABdhPJyo4v3gLO2yZSZ2qxIhlB2KbZ+4o+ZP77/7ro9oJa7nh1bjHaeq6ChnElhdq4f5/zHWAX+1/ai1AwE3lrPAeCQ=
X-Received: by 2002:a67:f595:: with SMTP id i21mr7915748vso.3.1592577400075;
 Fri, 19 Jun 2020 07:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com> <CAD2FfiFbGdf5uKmsc14F4ZuuCUQYFwfnirn=Y0fu2F0=njvWug@mail.gmail.com>
 <80578b72-cb6f-8da9-1043-b4055c75d7f6@intel.com> <CAD2FfiG1BgYvR6wkeXGro8v6FQtVjKemmAOOf2W14z5KUWLqhw@mail.gmail.com>
 <d55f94bc-3b26-a556-f7e6-43e9b1007e13@intel.com> <CAD2FfiHCi2MfShGWaYWk_GcXW4xVr6chsLPZs78OJE+2_GErVg@mail.gmail.com>
 <3d454068-fd4e-4399-4bf5-2d010bb2ba7d@intel.com>
In-Reply-To: <3d454068-fd4e-4399-4bf5-2d010bb2ba7d@intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 15:36:28 +0100
Message-ID: <CAD2FfiF8QEarhyFD1GkfnaR+spyH86sChgRZm37ab_gzS2m_wg@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 15:23, Dave Hansen <dave.hansen@intel.com> wrote:
> Last night, I asked my kids if they brushed their teeth.  They said:
> "Dad, my toothbrush was available."  They argued that mere availability
> was a better situation than not *having* a toothbrush.  They were
> logically right, of course, but they still got cavities.

I don't see how that's comparable, sorry. Surely Intel wants to sell
hardware advertising TME as a security feature?

> > So my take-away from that is that it's currently impossible to
> > actually say if your system is *actually* using TME.
> Not in a generic way, and it can't be derived from cpuid or MSRs alone.

Well, it seems not in any way at the moment.

> I'm pretty sure I'm using TME, but I didn't become sure from
> poking at sysfs.

How do you know that Lenovo didn't disable TME without looking at
dmesg? I don't think "pretty sure" is good enough when TME is
considered a security feature.

Richard
