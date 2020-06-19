Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50538C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283A920DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4hvC2zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgFSNuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbgFSNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:50:52 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:50:51 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id p187so2305450vkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cs9rHN+ukMIaMJlUYaI39CwkiITSRhR5qkZwx/24CtA=;
        b=f4hvC2zgvY/9Xm1sUqc4FA7w5Er1wnYUj1EeTMHfYU9puCuHxVqQH7WrSj7k3ufm5t
         cgagqX8+cUX2XNbdblQPQLhRScPrzxVRizVgSKIG3oAFX4UhuiWScrJd95vkJJ1MdpRm
         yZS0c39FT1PVKug2z7NsJn+qqrwkC9RA+Tm6gYKsuqgpuFX2ahdGVRzcryYFBtdKKVgt
         DQgMHPZmnq/ll189Oprw11+YkufOB9QBCal1Puh6e1wXZwI67wNJGgp/ucPEIAQheZRi
         mW+/C2rpQItGCItdBjqZeKN1Oko5lbX7eQbUGMjPb8mxN9JRZWuXCuFXXWPkWBfStHXH
         f3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs9rHN+ukMIaMJlUYaI39CwkiITSRhR5qkZwx/24CtA=;
        b=PTBmaeOnYCQG3h42t+tZbIeZi1dA8c7Tq56TEhydwuk8t0xsfz+riF4/d1kTVoJvR+
         MJIqHvQ08a6hM1uf2X4rTB62Y/ejfd6X+O5aRdCu34uG/6FoealMWm6/DOWAIi9ANSbo
         5s0t/uWEQAmhYIHssa28io8ZJor3gX+OttvUAIVD6Y/KlGfvz/sEDY96SfTL2USQHWGl
         AXdLXi7d+W7jqlf3ZJQ7aEb/aqevlKubWcTynRM60hHtHpMJx1A97NVnUtnlV6jrMA9D
         SE9D+Ii8QPXaw1bXDfyX+SuUzf1uiv2LPq8sbyXq6J0DLWxIHPq7h58i6u5WHN5Kzoe8
         qfLA==
X-Gm-Message-State: AOAM533shpJLHdI0gFgWQFsCW/zSgKnVlOI2Zg2OlZdu4KX7BpghihlT
        4LJ2SnEjpougeMlXt71oN5nAShxW6EDW7AOgVsE=
X-Google-Smtp-Source: ABdhPJxA0hgv7n00F0TDM8wy+W7eiypFgaYlek8S5vuGB0Kw2yBYud72M+PLRngkDXz897D3kyMArML53zSLkC2Ky/o=
X-Received: by 2002:ac5:ccf0:: with SMTP id k16mr7343756vkn.95.1592574650355;
 Fri, 19 Jun 2020 06:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic>
In-Reply-To: <20200619134432.GE32683@zn.tnic>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 14:50:39 +0100
Message-ID: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
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

On Fri, 19 Jun 2020 at 14:44, Borislav Petkov <bp@alien8.de> wrote:
> Yes, this is what I'm proposing with clearing the flag in /proc/cpuinfo.
> The needed information is there:
> 1. TME in CPUID
> 2. TME *not* in /proc/cpuinfo

No, it's not a boolean at all. If the platform disable is a BIOS
configuration we don't know if TME isn't available because the CPU
doesn't support it or because the firmware has disabled it. In the
latter case, a firmware update or firmware configuration change might
actually enable it. If the user installs a CPU with TME support and
then we tell the user "your system doesn't support TME" then we're
going to have some very confused users unless we can differentiate the
two cases.

> Along with proper ABI definition, design,
> documentation and all that belongs to a proper interface with userspace.

I don't think Daniels patch was a "final version" and I'm sure
follow-ups can add this kind of thing. At the moment it's just people
telling him "you don't need this" when as a potential consumer I'm
saying we really do.

Richard.
