Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6CF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598038541;
	bh=NMv4vnG60nEPCES3w4rZb3eZps1TWW80vKrVYEDmURg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JmIUmnQCR5LhaExZKaUWYmzWIyQdJNPyMSnbLgq8+gAQmxm5ZjZhnqqDbxWh3mQO+
	 06t+iemBtDdyArvVJL1rchfVtE4wdmzxPgRI/cWteKC8XJRY3VTd2ckPepSrZZDTZM
	 206qIFvoH7O91r25OlXFWV/s5QuSrbNlQ/T4N2wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHUTfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:35:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:35:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so3087887ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpYvCfsbuFRsxqMSwlesgwmxN2eUawgX7RpVp5hfrDM=;
        b=C295IkxUljYll1HbkYhxEMp3xp6hSjmv/Tdx8HJLRkcuK8a4r0PNmiha4PC7CGZvmd
         9HClEXcf/+XX+P9j6WioxaJNVnsub/fX5hgMate/ImLkubHanJMhrCLhJNOOjbPNe+f+
         JXCwa1tvJQLfSU9Wb2GcJnhYY6XYK3GsG62BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpYvCfsbuFRsxqMSwlesgwmxN2eUawgX7RpVp5hfrDM=;
        b=D6c76Z6Ph9GqdmiESpYO/zHvHxPrsJB02xxZ4qogaKRSL+pYfOfvuIaUuRQg9DtcnZ
         saS8YX6A1HSnuz7daLSrXpEIAJju79x/EyFE2UpWr/mWCs5oLRqXCJ5nd70A6/diwgd3
         vIjWHqAcExruxjSvQPGLJ0BrSa3D+7IZJ5Hy3JIix+cl4kVvt9stQCh3RfVkkESV4t7T
         tRVgJnek/il8TqL7pWV2LPCKI6On1NbmtAEJLGX+ailv253gZAkdtGyXTeqNV/TrGAKC
         V2ykwhbC0iFjv1+VUG9eZ0LrtJHXpHCCF6Dyod/QxksgNEQDXKiGucH3ELWaIyfqG/HH
         YbAA==
X-Gm-Message-State: AOAM530GWChUllF6ZxbnUtaMKlc9BUTzl8zauWCRlWi9qsnYI4gGeXWD
        S55MPHmOQwmdAMRRLfLuwZRAxOQ8occw2Q==
X-Google-Smtp-Source: ABdhPJxEQZQfD2ZfZhg5nqIimxRCE4k8ZMqXQMEq5rgq3B63shrKiQUgJ+3kdZ7HCIu4m40di7KKWQ==
X-Received: by 2002:a05:651c:1349:: with SMTP id j9mr2127884ljb.392.1598038537040;
        Fri, 21 Aug 2020 12:35:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h7sm555148ljc.75.2020.08.21.12.35.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:35:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 185so3075594ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:35:36 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr2060856ljh.70.1598038535798;
 Fri, 21 Aug 2020 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
Message-ID: <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:26 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> * The CLINT driver has been split in two: one to handle the M-mode CLINT
>   (memory mapped and used on NOMMU systems) and one to handle the S-mode CLINT
>   (via SBI).

This looks more like development than fixes.

I guess I don't care deeply enough about it, but please don't do this.

            Linus
