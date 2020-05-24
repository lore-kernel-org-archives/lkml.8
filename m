Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC24C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C2C20735
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590279377;
	bh=evnrCkc/+JalUjcB2g+Nu99BYfiUYN+xQl6BPLiQt8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vz+X2483EwNHbog1PWYdZjkxvZhoPuJGktaucuTSB6p/xTDFLig9UswUQsYhfOm4W
	 ZThiV9disT0sQxqi+WiT7QCNOJsfFBpCYgsJ2IysgubyhLrHN/XFGqdUBYtDysIvay
	 fFh4kRPRSD7AWGx39UoZ4Cl/q/KYYhteO5Nr8ZDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbgEXAQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 20:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbgEXAQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 20:16:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C721BC05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:16:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so16931428ljm.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m68u6fbHtBqjSQv0cWxoIcDmwtDvgdO4LpfILQ1PZ0=;
        b=PLeeVDbFE5lth9LtkCyvzFdT69i55fBsQGp6IC8S/ui3poDdGe7l/L1/kH8ez/ROCp
         q6aHohnDM09vUJy9c47/QVG+JyQMj+okxn9lIFq+5JVZhrOvZRs9P2BRPCMImiJCyTdz
         sD3DkwyRgbpKlMHvcWxq5Z3QPIVX/jmzjBSuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m68u6fbHtBqjSQv0cWxoIcDmwtDvgdO4LpfILQ1PZ0=;
        b=UnsjVIUKHugMGo58z7z+beabGEIPXG8uVRJEl2PcLu0iu674Aetba5fJRiZvdXMFL6
         fhW5Nc3Q1N8PIkyYXV/S0mE8FAgJF8aNlw4oG9sdDXwvxaL/3KMeE0/WgLuguSmOFMqN
         ulmOtnOK3S6Uk9CM5RML0Vi1pECLbEd3mUtqXE2btEuO9bWt2XP3omXN+RjcuvBRYL5B
         eNtQ77aOfxIzIIWXvv8lJe5D0SbLabv9UQp+4d5YDdjCZ0cLKu29FGLCo0rkU6iERVFl
         BIlqmV5qcWC+IeZs/HWm6HcobVXXGICiu/Fjh0gejSQOPw3g7Zkvdu+elsx2iaqg49hT
         8doQ==
X-Gm-Message-State: AOAM532G2rGelpRlpC1chq5C9dvhxiNilOWuimSvp2xr6TjgFqjiggUp
        gk/KTgyeq+AY/6JJ2beChfUIqlqWViA=
X-Google-Smtp-Source: ABdhPJyroUnmxdpMj1lGmRcOMoUsE03bWhZWs/vg03YTfBRqMplNctlLbc/FNNS6X7EKAR3ROnXH2w==
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr8398379ljk.445.1590279373328;
        Sat, 23 May 2020 17:16:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d9sm3290333ljc.20.2020.05.23.17.16.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 17:16:12 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l15so16613741lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:16:11 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr8459409ljc.314.1590279371483;
 Sat, 23 May 2020 17:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200523224732.GA243603@roeck-us.net>
In-Reply-To: <20200523224732.GA243603@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 May 2020 17:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnwsRfE_RJLAV8SX465uEmpOOJxyqjsLRwoX-UPH0kQg@mail.gmail.com>
Message-ID: <CAHk-=wjnwsRfE_RJLAV8SX465uEmpOOJxyqjsLRwoX-UPH0kQg@mail.gmail.com>
Subject: Re: [PATCH] sparc32: use PUD rather than PGD to get PMD in srmmu_nocache_init()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 3:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This quite innocent looking patch crashes all my sparc32 boot tests.
> Crash log and bisect results below. Reverting it fixes the problem.

It should also fixed by 0cfc8a8d70dc ("sparc32: fix page table
traversal in srmmu_nocache_init()"). No?

                 Linus
