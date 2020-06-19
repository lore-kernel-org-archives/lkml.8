Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0423C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0520771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1d7F+0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgFSNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFSNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:31:25 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C43C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:31:24 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r5so3035545vso.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqyPezOe1HuPhCGou395VGi6YIU74rcbqc6EaJGzPTs=;
        b=n1d7F+0loU1Yl61YbuxXDdq4U0erKvI5J7PIcIkTGFIdGNB4vtU5BSbg+Z+qu8gOUC
         ToaVhFgpEB8WR8/KlrF+zrYA5Ljgo/QQrR7K+ktZCJlAjQ36iUR5GTQyl6FxIH7Ar/sl
         8oyPEkPeiQnibIpf5AbiTRDf94Tef6ItH3E4Rg3K6R4GSUbklqAzmDnfCiUBJ4zZhjb3
         cqsnMPbrHKXyCkaq/G6qkBhlpedejXH5SEBuKOP69Byq3zstg63Ho202P4llhCjeaPEo
         Izv/IsRP2d3hgjUPhlUkpbdagc4glaACAxffuRYIdlg9fF7CrZgGG9hmvZpnYoWfyMI/
         pd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqyPezOe1HuPhCGou395VGi6YIU74rcbqc6EaJGzPTs=;
        b=XjixfBLRsCLvnA7Jx1O718pzQTZ0us7yX1/2I6atCOZ8uGfIiKeWRX4Qb795Fbpl2l
         Q6nIHCNfX3Qag5jN8C5ZtbdUfIl4ND+g9aaA9ubCB7yZamWMvCoOpmTn2vOnSM3xCxkO
         f1jwbPZi/RcoqWLT7wuXTzT2AKOUYFnp5GH1KyOVYM5Q3/d7zGJKkYfZp5gfYBgymJkf
         EAUcbXtPghJUPhutdvEI/W7A0OG5u7ipNr6vcPcs4zDUTXrCxxPqpJf/XC/qRYnpDqBV
         FCaj+QABbLhZ3QpJFb+pbBX1QVEks0nkxtVhNPtYYCWF+R5WpVggx/vJ3eFL7ya/tEFO
         ZBIQ==
X-Gm-Message-State: AOAM530TDsUrJhA5A4GujrxLAjAy5bMW1WG7tmO/o/RDbvBI+TmFUrgq
        Zp8Ju9rVYMuRlF0Oxg53DtgEySknFEdlxIHfDeI=
X-Google-Smtp-Source: ABdhPJxJWAUe701UBreBQ1OvixFQekPfJuYPJtleT6ChyEEAiRP07c/73JlntYK1JrYxZvD6lAkMyTHqrxobECS/1Iw=
X-Received: by 2002:a67:d597:: with SMTP id m23mr7746067vsj.209.1592573483327;
 Fri, 19 Jun 2020 06:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic>
In-Reply-To: <20200619132243.GC32683@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 14:31:11 +0100
Message-ID: <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
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

On Fri, 19 Jun 2020 at 14:22, Borislav Petkov <bp@alien8.de> wrote:
> And how is the user going to know from your "module"? AFAICT, your
> module loads on any system - not only on ones which have MKTME in CPUID.

I maintain fwupd, which would be one consumer of this information. At
the moment we already look at the CPUID for the TME flag, which
successfully recognises CPU systems which support the feature. What we
don't know is if the firmware platform has disabled the MKTME feature.
Ideally we would export two things:

1. that the CPU supports TME (->cpuid, already done)
2. that the platform has not disabled TME in some way

The only way we have at the moment to see if TME is supported on the
platform (rather than just the CPU) is by grepping the entire systemd
journal at boot time, grepping for the "x86/tme: enabled by BIOS"
string. With a securityfs/sysfs/procfs file we don't have to do this
expensive operation for reading one tiny bit of data.

Richard
