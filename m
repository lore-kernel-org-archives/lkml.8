Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D09920724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR0rPtaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgGMFKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:10:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EDAC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:10:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y2so12129620ioy.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=u7V5THkrB6yzF4MUKuL2FvUyzEqNXVmvsb51ktC+rUc=;
        b=IR0rPtaOfVNnncC4AETW8zpepUqNiWptqbZ0nztTAgNji91kx4Xe8hXpPMiQKIlg/B
         O1e8fZnoyI/2UEH8HQCE/Cj3/7dl0X14zPV5a3Cq2yMpyxI2vh+HkI4Dz3sQfEpiNBOQ
         koBphOgyASm9hWav3Jmk93O1oxMigl3X94LzdyxRjHTqfastZntEkgJge9Bnbqo6tuQV
         dFMnTUjnwwHjWozVEgTH4YL565HHSRgmLAK5Rto4Pko90YNNOrp65AnwhYPRjh54fjld
         EtAcQFGjxEV/RLs9HmHC7kwY38dkBNltlN5UvjxyvhxzYnpYhdmu0MUvzRNtG07kal4y
         pzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=u7V5THkrB6yzF4MUKuL2FvUyzEqNXVmvsb51ktC+rUc=;
        b=g4tYteaVs+L604FharSBs6CcEo4Z6CI6URB3wsNTOVhTI+IDGUgtQRuc31Mr49J17X
         8YbPPxQj4pK1rb7QqPpHfEpeR/L6b9EYwZhdsUvWX8fHKDe3bM798JvdhPEBrD5/jQaq
         CjrJ0mey0Dj+RlejT4oIBsPvl05BDZjLvAATG4p1RSIxGuaGwNZ9YsFQE0vA0fXVPPmv
         jWKFqoMenvF0nShE4yMGFRkmlTotJjW0wZTljC3KPMQDNK0KlJcwYxWhb0pRIKvhkyFk
         KyV7X9w0QN/L9jRfYOmTBLHKF9/iKVCRC9HMpwmx+6rweDHE6Suy2Gv2wZfsn4m5FKPB
         5Fjg==
X-Gm-Message-State: AOAM531w+TynuOZwzQR0/Z/IGRha0izWXPgbsZ6hg8C20sc7w+QL3by0
        9Boftn4uS9QBWT4zjywJ+bbx8P9D3n5mvIzSf/I=
X-Google-Smtp-Source: ABdhPJxYYBMrPb5TEjCKe3Mckf7q9egCRL99OeaeI0JnqMsZd6lDZI00bnaTQ+L0TmmS78YQ9ZVxDa9c//+vnCvDhp8=
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr60923903iow.70.1594617016973;
 Sun, 12 Jul 2020 22:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200712231050.5147-1-sedat.dilek@gmail.com>
In-Reply-To: <20200712231050.5147-1-sedat.dilek@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 Jul 2020 07:10:05 +0200
Message-ID: <CA+icZUUYxbfKz2VnkUVL5ZwT7XcwGKJFzbDyoy9cg2h3vr+hkw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Cc:     Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 1:11 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
> ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a fix.
>

Just FYI: Patch submitted by Jian.

- Sedat -

[1] https://lore.kernel.org/patchwork/patch/1271455/
[2] https://lore.kernel.org/lkml/20200713012428.1039487-1-caij2003@gmail.com/
