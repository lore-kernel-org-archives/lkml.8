Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E3E2077D
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CseYrW+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEaM4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:56:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE3C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 05:56:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so6585295qkb.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6w+lPaiK14o5a19BFGQNbPfTF8+3TEr6N8us2hLTJp0=;
        b=CseYrW+aEy2fsi24CGPA2F4ViD85UXgLGoq5ZuoWQ5xa2WTdDM1uh0nmRyC0DIFE/l
         DMuItVMlq0MmyWJB6RY+ERHKDcAnjuV4HreQzqkqyp48k89/XKKyq8VfUAYPcDc+Mzwy
         2aIMemgZwWk2zMf1z1UYOFfjoEACcVPGBoXkUbJx5NQurHVHwqTZd249qHU0LAvEG8tS
         E+P5CeatJLf/IiOWf0jn1cASu1mwp1IBlaOw6LqS96KPvESUluDdj4NRm3OHJWz3zs+T
         9aTyyc/NcjlHAGfBv7iWqDE8qdu6l+6Al7hzkCahklECHO8jDKwnmMFt1nDpL2lp1vg8
         w/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6w+lPaiK14o5a19BFGQNbPfTF8+3TEr6N8us2hLTJp0=;
        b=cCIwW3Rk9d5sL2PHp1swK6/eQpadlhhz6bIlHD3aAtZorGRLOXihAmxo09c43EmN3C
         RYfzBX4LrGaBbQQkd30HcqcEl4+Ze8G9cwpa2+zfL93vrhtNt4hkCAiM/U7as/yqyzWW
         2oQGAs8zC0D1OJ/VzX4Rv1d6xmSm8Sl+Ta64G4KgNJunH20fjW2mDbk5ceoeKmosnNiy
         DDKDHyuTvhJK7SEJD3wBNPH9O+iQt9+GExy0xsDvipWwrhx8xf5qU2TSU5QRNDPODvPc
         ADm8F2qJ6lgEiX831vGE8yTYR7SYpQqnNMJWeGTlf4nJdAySRCqxkPu9uowasRhvJgoL
         2ycg==
X-Gm-Message-State: AOAM532rutmLcOkOzx/k/onOccx2REWfL7x5OW3hpKSSrtecY7Zb9DEb
        hi7AkCsYAHcXxXxH6hl0o6YxrId7y+2dsw==
X-Google-Smtp-Source: ABdhPJzh+KKPKTSCBRFAEFI4ojCCmx+kKkDGDAZjITTcyDJFPDj/IVG6djXlzqoPNWFVIRT7tJryAw==
X-Received: by 2002:a37:40d3:: with SMTP id n202mr14932465qka.365.1590929782084;
        Sun, 31 May 2020 05:56:22 -0700 (PDT)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id v189sm2813859qkb.64.2020.05.31.05.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 05:56:21 -0700 (PDT)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
To:     Andy Lutomirski <luto@amacapital.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <85367hkl06.fsf@collabora.com>
 <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
From:   Paul Gofman <gofmanp@gmail.com>
Autocrypt: addr=gofmanp@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
Date:   Sun, 31 May 2020 15:56:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 03:59, Andy Lutomirski wrote:
>
> I=E2=80=99m suggesting that the kernel learn how to help you, maybe lik=
e this:
>
> prctl(PR_SET_SYSCALL_THUNK, target, address_of_unredirected_syscall, 0,=
 0, 0, 0);
>
> This would be inherited on clone/fork and cleared on execve.
>
If we are talking about explicit specification of syscall addresses to
be trapped by Wine, the problem here is that we don't have any way of
knowing the exact addresses of syscalls to be redirected. We would need
some way to find those syscalls in the highly obfuscated dynamically
generated code, the whole purpose of which is to prevent=C2=A0 disassembl=
ing,
debugging and finding things like that in it. What we do know is that if
a syscall is executed from any memory which Wine allocates for Windows
application then it should be treated as Windows syscall and routed to
the Wine's dispatch function. Those code areas can be dynamically
allocated and deallocated.

If we are talking about explicit specification of syscall addresses not
to be trapped, it might be technically possible but at the moment looks
so messy so might be considered not feasible. Wine has a great number of
external dependencies. Most of them depends on some other libraries in
turn. Loading of those libraries goes out of Wine control. Linux
libraries are allowed to issue direct syscalls from their code. I am not
sure we can depend on them not doing it and always calling the same
glibc wrapper.


