Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52435206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rByIursS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCMQRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:17:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46235 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgCMQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:17:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id r9so2845245lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGKTLdP7NysMTjq7A/r6ibsN/jqrKxZ94DgLRwdxBUU=;
        b=rByIursShxrvJL8x7QUC8Ki6XMcvcoLltmEqaT1zaJzjg/ldGQ85qCtWChh3yi2sha
         XBRpP4/6FVsBNUAiH4b4VO6q85dWLJPVXycc1J97pT/KFfmqu+MBo4cZCFV6GHqOlB5q
         BrIIrIVFiSlB+HFKuCzrn3YM4AVtNWSKf0XsMzCAtwDVGrnAtlas3YS8NwwlXI5Y8BoB
         y8RFRCQ+q7yC3f/+cyMTqTRaWJUpda8IvD/9p1LpSHgRdywz9AJNDsapHW6poAwZQkOF
         aeDggx/IBtDr/w9XwwEj9Yx13onMnTE2VboIsbVBb95Tr4+j9yoTf0Nyoz3oXMvhblsK
         bWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGKTLdP7NysMTjq7A/r6ibsN/jqrKxZ94DgLRwdxBUU=;
        b=U+IAJnCrEPIfCdi4QGyT4oL3bvVi8blFhVxsdBjfC5/+Pj+LEwp2mV3VNCm94jgsSs
         fLXl2pz8kpaf6/+S5sOwFwNroi9uKkwavYcvNJ0Gzv/Seq6IFiVQHWz0mfXQ02WEuqhI
         PYYvlCh61arxn7j57hGb9o6wZ+3q/ojox1T7w4QlZsYCy28Yw3quhsqfsuvFiz+wTved
         TT5KrjRRpQwK9boCsev7VRcTRolTjzBrQnMqreaMxNyhK1k/7NzmDAWKRmEEGbI3xoWZ
         nGzCmE3sLcU6cSvJY8YJ889WgagLyaxuAtm4jkIr+ypGQ+S5oygsbw+WIBmAnnjVcmzy
         wLrg==
X-Gm-Message-State: ANhLgQ2WtyglJjla5rXjDCFmx76qvFFj8nZEniDN6xp9XI7xuQa/X6Zj
        Pe7LF7T/5NkTh6JQ9eQUd6pH066OXs1wVNjJ/IUC4w==
X-Google-Smtp-Source: ADFU+vtValKojWuh4Y5Xd2oyg0PROdnQd5jtfAmUywOUtPoRIjgVc6sIaJFcF6i+ykZj2N1GZzMbUMeIxPPBc8t2pwI=
X-Received: by 2002:a19:f601:: with SMTP id x1mr7277713lfe.55.1584116272680;
 Fri, 13 Mar 2020 09:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310124203.704193207@linuxfoundation.org> <0074ed5d-1c87-4e0c-7d3f-bb5cc4e80366@kernel.org>
In-Reply-To: <0074ed5d-1c87-4e0c-7d3f-bb5cc4e80366@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Mar 2020 21:47:41 +0530
Message-ID: <CA+G9fYvx8q9+VrweEZx4t+-XFEOQLaUJed2ooRUPG8NxjKkkeA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/126] 4.14.173-stable review
To:     shuah <shuah@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah

>
> Compiled and booted on my test system. I have a new alert on my system:
>
> RIP: kvm_mmu_set_mmio_spte_mask+0x34/0x40 [kvm] RSP: ffffb4f7415b7be8

Our system did not catch this alert.
Please share your kernel config file and
steps to reproduce and any extra kernel boot args ?

- Naresh
