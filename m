Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493A120678
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUqK0nlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgIHSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgIHSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:45:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E2C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:45:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so9550450pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTL63hb4ABfz9aMDiSW5T6vRFc5sz9vw32NSYi4u1Ls=;
        b=JUqK0nlOzKc4sE/9EmmT6cw2lPwGjj/5UX4yDSfQmocz5w43Z68PH7MW2fjDpZRHOW
         BB0rZziEQML6mYYTiywYA04s1hyhLLlaowfMop19EAFcYULoKzjccvOtad3vMsDejTfS
         ol0/48qr1AYVXy3bYu+/7tOzgg9sRs9O33ugWsMZD8qgSSpnqT/pjzqOSAZbPPtSeLuB
         zLNUivSQwGz9Iox3Qt/u4EK4PRo84MVpJtj6qHtkCgh1SWSE1EW/50rL7E8UF8ap+TPU
         0mME3JYoLEpPrzrGiIXi/gwdOUncAJUTG4UezSDGFhg9xeQ3gc9ICyRZjPRnSA5PhFIX
         gbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTL63hb4ABfz9aMDiSW5T6vRFc5sz9vw32NSYi4u1Ls=;
        b=hV3n1ZLGdajJS5inRE3YfJM1P7pOMI3JCMqy4B7TJyJgJcuMXi6hAJUlKbgOceFKCW
         752Y/FjKSph4IgB+reIL7Xp3/vOS4N3Y1HQVZu37WlLJTTp/RwB9NcnWvDnwruj6SY+y
         JPnyyU6wf0uH2zm4BB/PDlGTHb6qzCN4MeFs2cPEZJEpIXr4ImX5lfM0hgKNdDMP9xIg
         kPzuNG5cnd6JhJ7qA0ulcInlfmvVV0RyvKbN5TkrM8idAPPN9igUzZ/e+GKSDoJKnCM5
         I5HHP8CRXKeLKzCG3R/cLARBz8c3Ei1Ipg8YG+/9ILczAImkjLJygQVTxS/l7lKOWF0U
         UWEw==
X-Gm-Message-State: AOAM530z1VLeGlkacI2PTMWqgdF3QYvgQshNpr6fp4XOoCGBLNoSEvGV
        s+f2FVkB15NDFtuMwgThOm5mlm8bCSZR8lv3WbY=
X-Google-Smtp-Source: ABdhPJyOMKwDly5eUROA3aXFYuvd7OlfjyP/8VNq0a+5DnECsBY5xz0NihqtA+X5oX1fTYEpm1TK6ywhZlIIMuujY7Y=
X-Received: by 2002:a05:6a00:22c5:: with SMTP id f5mr100976pfj.163.1599590752519;
 Tue, 08 Sep 2020 11:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com> <f96a76a0-1ecb-aa3b-0f8a-d978bb1b1787@infradead.org>
In-Reply-To: <f96a76a0-1ecb-aa3b-0f8a-d978bb1b1787@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Sep 2020 21:45:35 +0300
Message-ID: <CAHp75Ve8yye8qdD1b5FF5KmU=2-xteCEOcR89ZQs3Hrw_Vj+wQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/8/20 5:13 AM, Ingo Molnar wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> >> After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
> >> 32-bit builds using defconfig become broken because on x86_64 build host
> >> with no ARCH provided the default behaviour is to assume 64-bit independently
> >> on the configuration file name. The crucial part is CONFIG_64BIT option
> >> that used to be explicit. Let restore the latter option in order to unbreak
> >> 32-bit builds.
> >
> > So exactly which build method broke due to this? The typical way to do a defconfig build is:
> >
> >   make ARCH=i386 defconfig
> >
> > which still works fine AFAICS.
> >
> > Thanks,
> >
> >       Ingo
> >
>
> Here is a previous patch from someone else:
>
> https://lore.kernel.org/lkml/20200810155943.2583275-1-daniel.diaz@linaro.org/

Thanks for pointing out. Whatever Ingo prefers (though personally I
think the other one requires more work on the shrinking commit
message).

-- 
With Best Regards,
Andy Shevchenko
