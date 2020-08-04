Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C71F22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596566384;
	bh=1dNokcPTVGRnLWfHOeq4HIOCil+s795+pBiPExY3pyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AdsXrJZt121ueqnOfpZEwrbrAPKVBB58qaJbvoC6tR6/dfjjQdeaDgYMALJZE+hC3
	 V4OP6g55PBbHAGM96Q7Kn8dNu9r77gV/oy1xAjUp6uSnHSWu0V9+maQYAw7hVx9FrG
	 C+Dc/kT26uolAp3lhoHbOiWao5rP6fGmw0mC0+Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHDSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:39:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:39:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so20945322ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkLmvclKDC4NH/baH9VK8NbQ5emijDFqRa7D8TVtths=;
        b=MftHbpqnXQ5Cig7YZqaj4xNohz3zWOfxYlSXieSNZmEPpG+cmx/mU1jMBDg2t+t+WR
         5wh31k/s1R9XNKJEwOcOA6jA/ffc7hdhg7ykGyZsa1eorJ6u99el2r1gDU+nW1mVMyBf
         gYOEsqSC8pHznfc5XiFRm2tag3P79YiWqQEDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkLmvclKDC4NH/baH9VK8NbQ5emijDFqRa7D8TVtths=;
        b=UutvVVql3iN6Pv2SQhhcAGyFvg9NXCqNrJGHGfvLLxVeE3OzmqmkA7kRnIP2ZYe+5c
         51jdmDn4nKnhHApDrQRUZ1SHzgLvGgkVCaqrWH1S0u0DsPk0iilKeyHEfWYp7rOKZVF0
         xq2ng0BRIc4b4REejEiSETEVAW/nqJL0uPpxegriC5M/bn04SAqB7bl5SXuxappQkwSz
         OMLhVGo82Of31AekI+Smv3Ah4lSCJOAKOYIjFuvDgH1b59tIjp31is2HlN8mgaJdPAj3
         LNbY7olLCqfhWjxl2/dHoK6OKmroSVcT9WDwOKnxy+ixS4EBV601OfMl9rpoYIc7RaCK
         lGSQ==
X-Gm-Message-State: AOAM533B7y5FZPrJepIkvrY2AkW5p0kOuwQUpM5jXgfzVK20OwpnopaV
        B5QpI6DyfWxTiFG8w1PGgNSvuEQZHz4=
X-Google-Smtp-Source: ABdhPJw4+vZ/Fkz0HSoRFdrcAC5DDkf4cweiLLaVnbXOEZJOvsMH9989xgiTxXUQ2/3kS9c6S7Vw5A==
X-Received: by 2002:a17:906:e251:: with SMTP id gq17mr22238272ejb.445.1596566380783;
        Tue, 04 Aug 2020 11:39:40 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id qc23sm19030922ejb.97.2020.08.04.11.39.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 11:39:40 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id o18so43560527eje.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:39:40 -0700 (PDT)
X-Received: by 2002:a2e:8008:: with SMTP id j8mr6989403ljg.312.1596566026687;
 Tue, 04 Aug 2020 11:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200804072435.385370289@linuxfoundation.org> <CA+G9fYs35Eiq1QFM0MOj6Y7gC=YKaiknCPgcJpJ5NMW4Y7qnYQ@mail.gmail.com>
 <20200804082130.GA1768075@kroah.com>
In-Reply-To: <20200804082130.GA1768075@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 11:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJ=shbf-guMGZkGvxh9fVmbrvUuiWO48+PDFG7J9A9qw@mail.gmail.com>
Message-ID: <CAHk-=whJ=shbf-guMGZkGvxh9fVmbrvUuiWO48+PDFG7J9A9qw@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/121] 5.7.13-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:21 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> So Linus's tree is also broken here.

No, there's 835d1c3a9879 ("arm64: Drop unnecessary include from
asm/smp.h") upstream.

But as Guenther points out, I have a few other build errors, but they
are (finally!) entirely unrelated.

                Linus
