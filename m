Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AE62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7scir09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgG3H5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgG3H5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:57:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5CC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:57:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so16110013pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLytLfNJfSE4npit+WfMUiTCNuCsA9nLQ+28JMe84cQ=;
        b=V7scir09GesmEMDyiXGBs+i3JD8071veQRPmc8wPVvS9UfGeA0sHql06/qAKtlrKmn
         af1jO1lFP5S9Hq51z+u7R9aP0vgpl37fxgKB3y43myZb4Irzr0mLUgdAJyQYamD0+LoH
         oQPGYdttwbLTptWgaJTjYhoQTPeUDbvSwciQn/JIPI+bUrm0A58yWxBP8Oq3HHvZLos5
         o4FNcThykWcHNCZXFwXTgZjmUgE538VLDj/gwFI9vGLkAkagTnC+znBaJTg29/Dxf46A
         iP6pP3kiEOKkvekhfgVaAEM0THnwa2Xa7fdvGHIEYy1Bm3MYnjYvzK97ScPbUybVfnEC
         cgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLytLfNJfSE4npit+WfMUiTCNuCsA9nLQ+28JMe84cQ=;
        b=PwbgUOWkPNGdKTG1o1BXLOi2iyoSsdXamGY/wZYdg6BOXUbN/tYPwk2VJalgJu2xON
         3ftnpIQsZskfw0djz2/Jwsyq4krwVSt6BYwhFsurZnd0iteE1v2MwoLdAI2oZeK+yjEr
         vaESAg5fGI+geA1UUTuweli1z9UluJmsMGxy/JSkFdbIvDBpCZjbh4HG8Cz2AHRNBdqn
         dV88scFx9fdhEZUK6WnL1lnyqmqHps2MqodMStosJqa3J7oc0cAouMP0x1t+arMxQqZB
         qILMb5kHO549bo7ePqmEgpt8kAD6PgDWPYdYh1JuEDewUBSUUWIiQZ6eBDp5fHo9Y674
         aTNQ==
X-Gm-Message-State: AOAM532e4ceC2qUFnPGe4ZUSYj5BWLF/iQkEHqPjECLXvOnhMFSRtw6I
        Fu3lR0U8IdlK0EEQLDOP+fOK4S47Za6qEcOUN98=
X-Google-Smtp-Source: ABdhPJzawuNdx4P5mxPzUiovnQP3MZL/mgKgM8K4SnMFpbK2vJUoHtOljwxhNay0UMVql0YVsi7ddDy/e7kWyawrfTc=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr2006799pfc.130.1596095853682;
 Thu, 30 Jul 2020 00:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <4fcf09a0786550f5510ec3d9a8628baf7326dd39.1596084248.git.eswara.kota@linux.intel.com>
In-Reply-To: <4fcf09a0786550f5510ec3d9a8628baf7326dd39.1596084248.git.eswara.kota@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jul 2020 10:57:18 +0300
Message-ID: <CAHp75VdJc58PSjgnL48jeae+=pHw28sMj3m+HTcVUZZ8kJTYqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/tsr: Fix tsc frequency enumeration failure on
 lightning mountain SoC
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 9:16 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Frequency descriptor of Lightning Mountain SoC doesn't have all the
> frequency entries so resulting in the below failure causing kernel hang.
>
> [    0.000000] Error MSR_FSB_FREQ index 15 is unknown
> [    0.000000] tsc: Fast TSC calibration failed
>
> So, add all the frequency entries in the Lightning Mountain SoC frequency
> descriptor.

While at this, can you confirm (with maybe good description and
documentation reference) that the numbers in that array are all
correct?

-- 
With Best Regards,
Andy Shevchenko
