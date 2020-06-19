Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7BE2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+Q5WK32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394512AbgFSQRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390753AbgFSPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:31 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3CDC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:02:31 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y123so5760683vsb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA1YYiLoYecDSXE7VUrhPC0pwfaz8HP7Uv5Pt43IOGY=;
        b=s+Q5WK32U7x677VRiwsxq5vLGWbQmVm3qU5gzbBqxiAwaSVsdmV07dmcuRGlhrvRgG
         gN3uVtClNBaOwGDGW+v0DnBXSP4Zm9FtdpKu5SXMFi4L23Y8wXEH0zoKon8G5VxoicCO
         OzqH3UQ+Z2/HQSudWwlKu8rM/8m4nffPcAsiaxJmupRD9QjVSJZyQ5THFvZ2ZPnFT4Bf
         wh4G66yucWvORbH60yEO2YLbaesEfRiyQPh8KrTmU8Ml/nuiYAFjgzhvlR4HXx3tmo61
         i9w/weX5MHfrvqUltQMp55oet6EA22B754bpfiWu6Wdg0ExgKWQBRiYLmJ9AfH8Ys6ZT
         tD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA1YYiLoYecDSXE7VUrhPC0pwfaz8HP7Uv5Pt43IOGY=;
        b=Azo0GXGrXyCtlDa7kYLXUY/QA4fdPzWmX9PNS1JolYkkHl8P0kloTULyry08/E3QKc
         LTuc6PWgxrJNc6Oe4iV/dufs44XNm6+YJVxw6T7F1HjLyK2BUnb48I/iFh4LGrD/bUAr
         6fcfkwO/g0p17b31iwJtUWJBHYjFlht1Etjw/11GaF+rBweA6d/2u5fnpE/qlb7zzroy
         Ep3CSLnKkwIOFgkKALItiz7RuBwwjoIR2FopFZs1Fwm0A3rUjczj+C7azf2wbQPv7O38
         3ZIdizdceR0ZlgqzKBb+6Qx12xhsu8CH3dDCNGybjfsrNRhClvhdFaS280oqcXHF9CsY
         53gg==
X-Gm-Message-State: AOAM532Q88GAUPrlcaa6HujkUxU58lfLjRO4azQ2NxPpNOjNNPr/oEMS
        UiMG8eM29wOgaYeSRPsBaIBau05msCwsD9ClY98=
X-Google-Smtp-Source: ABdhPJz0U06vlRhoVb1EWe/pOvxcbD9a9RtgKCo3ANqJYbtqd6LdQTJsOKMaiouqkGcQgFgC7XuHVltyeyzAvVYDw70=
X-Received: by 2002:a67:684f:: with SMTP id d76mr7813592vsc.66.1592578950686;
 Fri, 19 Jun 2020 08:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com> <CAD2FfiFbGdf5uKmsc14F4ZuuCUQYFwfnirn=Y0fu2F0=njvWug@mail.gmail.com>
 <80578b72-cb6f-8da9-1043-b4055c75d7f6@intel.com> <CAD2FfiG1BgYvR6wkeXGro8v6FQtVjKemmAOOf2W14z5KUWLqhw@mail.gmail.com>
 <d55f94bc-3b26-a556-f7e6-43e9b1007e13@intel.com> <CAD2FfiHCi2MfShGWaYWk_GcXW4xVr6chsLPZs78OJE+2_GErVg@mail.gmail.com>
 <3d454068-fd4e-4399-4bf5-2d010bb2ba7d@intel.com> <CAD2FfiF8QEarhyFD1GkfnaR+spyH86sChgRZm37ab_gzS2m_wg@mail.gmail.com>
 <aef4ff03-3a98-4425-2b01-203a88401370@intel.com>
In-Reply-To: <aef4ff03-3a98-4425-2b01-203a88401370@intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 16:02:19 +0100
Message-ID: <CAD2FfiEit9HR_ikc3WQXg9c_hyNHtk6b0rVnYJd-R8gJ7tbQOw@mail.gmail.com>
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

On Fri, 19 Jun 2020 at 15:48, Dave Hansen <dave.hansen@intel.com> wrote:
> You cut out the important part.  The "pretty sure" involves a bunch of
> preconditions and knowing what your hardware configuration is in the
> first place.

Totally agree.

> Let's take a step back.  We add read-only ABIs so that decisions can be
> made.  What decision will somebody make from the ABI being proposed here?

The question of "is my memory encrypted" is what I'm trying to decide.
To the end user (or the person marking a compliance ticksheet for a
government contract) all they want to know is the end result. At the
moment for AMD SME this seems much simpler as there are less
"preconditions".

> Someone does 'cat /proc/mktme' (or whatever) and it says "1" or
> whatever, which means yay, encryption is on.  What do they do?

I think "is my memory encrypted" for Intel has to be a superset of:

1. TME in CPU info
2. not disabled by the platform
3. not using unencrypted swap
4. not using a memory accelerator
5. entire DRAM area is marked with EFI_MEMORY_CPU_CRYPTO

It seems the only way to answer the questions and make it easy for the
consumer to know the answer is to ask the kernel for each of the 5
different questions. At the moment we can only get 1, 3, maybe 4, soon
to be 5, but not 2.

Richard.
