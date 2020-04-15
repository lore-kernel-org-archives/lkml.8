Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3832DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BA9206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmifIXPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636392AbgDON7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636377AbgDON7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:59:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B713C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:59:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so19240912wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oNzqr4W0kmnZFd2IVVOD4F7CEhwCqXToSvFcmKkrVR0=;
        b=NmifIXPzQQRWBjxGAW5BAhLCBHn9JlTW+ieIof45VkKm0Uub0UsPAjTLbfz8dPtPKF
         UcKDyE9KTO8YsR8TGRuvuRUvEXasdkAMv9WC9oXt/zBFJOIXwmcu5yB1sj3pkTQD+BPB
         wA1P7dCNNwBS1DgOGBajGerdrOnu2za0DABBdxFg0WkxkKwPFUtFW0t6whdfbX6vztMG
         /w1v9TpyXe49zu3GDyb6FysLgVeCY3LkFXE31RWaWwg+Q0oIT2QoTg1Vm7NbOJXaFETM
         qmdNyXuKW/CZoPX4gRvmcWl4nbVsCoj4V1u6gGE/jrjaHI5NYTNFt/nBqw3i5m8QYs04
         W8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oNzqr4W0kmnZFd2IVVOD4F7CEhwCqXToSvFcmKkrVR0=;
        b=pR3U6vBVkaVZhIW4UIES9JRtlm0vruDR7KVuOGnTo+1j0qqkcN5tzYxhBaLA1S36j/
         lqAiTFfaYTg5tl1/Yn2V1hZ7zedA3dHy5+GSMEKk9wz4hbb/mgILjGAEPjxV5HJTUf/w
         JbkJyzJtlLMQ+ByO0ULPAxUdk4N8NvTDUu3soBRb8GjNZdImHwPjnx6e2FZ7OD7vtJoR
         2zUpRJxHsAuI/rvAs0GD2cxtuKZ+g3Mo78q669/SUyzfDSuAGYbktUH219F4pm7e+U3P
         CQycj2sCmX0p3K555TlYVwnPccRY9DrZ/EAI6VRArla8Vypt4Nqd2/6B9Xa4wZJhjpQ5
         qZFQ==
X-Gm-Message-State: AGi0PuY6egWieCXR292w+LkFmFFN5zSCDN9VzND7ijnefz0Wg0bB45tF
        BntzBiZUbhSAxR8rC28s2KVyEf3nMQjp2cpRG3E=
X-Google-Smtp-Source: APiQypKIKAI4R7MZYat+lp68qYQ24g8WhU9ryf5v0iyzZHRHBMG3LozUhEXKcrW6Q5mF/yvpXM5RIDXu2de0ws5Mpx8=
X-Received: by 2002:a7b:c927:: with SMTP id h7mr5303390wml.122.1586959147836;
 Wed, 15 Apr 2020 06:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205323.44490-1-natechancellor@gmail.com>
 <CA+icZUUTEEZww3qT0jfFP0ZgUPXoF1_uOHMT4ZecrQxumE1Zmg@mail.gmail.com> <CA+icZUWq=_qjvAf40PqQAj3tQ0WAZ2QAR9hojTuYqZH_=RWd_w@mail.gmail.com>
In-Reply-To: <CA+icZUWq=_qjvAf40PqQAj3tQ0WAZ2QAR9hojTuYqZH_=RWd_w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Apr 2020 15:58:56 +0200
Message-ID: <CA+icZUV336Y5YJ3OUYzXGfMZGbPSCt9YBVBRhiOnRCNQzc2z-A@mail.gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 11:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:

[ ... ]

> Feel free to add appropriate credits:
>
>    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>

Re-tested with Linux v5.7-rc1 which shows this warning - with GCC v9.3
and LLVM/Clang v10.0.0 (and snapshot/pre-release of v10.0.1) on
Debian/testing AMD64.

- Sedat -
