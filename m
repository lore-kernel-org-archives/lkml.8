Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04907C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE92521D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rcQkWff2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAWTtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:49:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45023 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:49:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so4653423qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fYWv3gkaBG3PC7KY5b1PI2c9hwBzlBIPCdR2DcObPZc=;
        b=rcQkWff2IxD8g6voBRp5FFJKudPCu2/bWS9vjCC3BTh7jVw1+6wvrXtCMv/eqUU0K8
         Mtn8A4f095sTk9pGH5ytPPFt9+LXqUaeZtE9nMPgEh7FSyeI5cFpiERe1+xuDf8OHOuY
         paJRXyu7SboiwQAj090+qqt+509/rR2xRrOOeTqMuAA7HIpquqWj+5S0c77hRRCyRGYD
         QgBUeJSA4F62UvixJGNUKvET7PAedWRTqTH4ZmU8gmINuZoiXGlm5cu6QZaftJdgOF6M
         xDHukbohrGroDmu8d5773suxH+L7XI19X8EtKpNOT50+cc/lIZ5fEJcQYsnBP9Plr3PU
         io7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fYWv3gkaBG3PC7KY5b1PI2c9hwBzlBIPCdR2DcObPZc=;
        b=IJqlAOaAcA5Mz5qwItig5fzoatTur/RArK0Xt09TYs4NBzeC3FDRYiDNsnRrYW7gnr
         CSw67/UsleQ/9qnNvIuaJe+q908TRBXFwuunJ1cgY8ur5rgQHysphKsvzO7MyJ/Sm9ZE
         6MrFTN5pnodnblxfmWZsdXtoAb6IeCqQcz9SAHacdWLD38rqzANWZMq5xlgEIXzScmzr
         nu8z+1cZaUpMBOL00sOMzHenbX+YLVUdyqiKSbB0yO6Txz9FDHdONBgfNuz0oMRoF0zZ
         cr40To6UTCr1zO0G/EinY3paMRFlOTpBhOqLXCgoEZ3g+y3CONXkKTOoqYVlK7MpTDP9
         IMIA==
X-Gm-Message-State: APjAAAUY74cv9FFtaFRNnFWDAJUnfTv5fCIrV6kcFtOi/lQPtjqgr20e
        o3xhGzbUCp2do0uctH37JKRqZQ==
X-Google-Smtp-Source: APXvYqx5v5NP0kCPnQiptjsW8R3LNoRZLqm+Mf0vqi2X+tunoECrfmNLbYLzVp4sOuFPwKFmDuOOMA==
X-Received: by 2002:a37:4dc4:: with SMTP id a187mr18136788qkb.436.1579808956541;
        Thu, 23 Jan 2020 11:49:16 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i90sm1516366qtd.49.2020.01.23.11.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:49:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
Date:   Thu, 23 Jan 2020 14:49:14 -0500
Cc:     Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10CCB37C-B91A-4A15-B9C0-5DBA5DD0BFD9@lca.pw>
References: <20200122191430.4888-1-cai@lca.pw>
 <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2020, at 2:17 PM, Ard Biesheuvel =
<ard.biesheuvel@linaro.org> wrote:
>=20
> On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
>>=20
>> x86_64 EFI systems are unable to boot due to a typo in the recent =
commit.
>>=20
>> EFI config tables not found.
>> -- System halted
>>=20
>> Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for =
efi_is_64bit()")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/x86/boot/compressed/eboot.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/boot/compressed/eboot.c =
b/arch/x86/boot/compressed/eboot.c
>> index 82e26d0ff075..287393d725f0 100644
>> --- a/arch/x86/boot/compressed/eboot.c
>> +++ b/arch/x86/boot/compressed/eboot.c
>> @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
>> {
>>        if (IS_ENABLED(CONFIG_EFI_MIXED))
>>                return efi_is64;
>> -       return IS_ENABLED(CONFIG_X64_64);
>> +       return IS_ENABLED(CONFIG_X86_64);
>> }
>>=20
>> static efi_status_t
>=20
> Apologies for the breakage - your fix is obviously correct. But I did
> test this code, so I am curious why I didn't see this problem. Are you
> booting via GRUB or from the UEFI shell? Can you share your .config
> please?

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

BTW, this will also trigger a compilation breakage,

ld: arch/x86/platform/efi/efi_64.o: in function =
`efi_set_virtual_address_map':
efi_64.c:(.init.text+0x1419): undefined reference to `__efi64_thunk'
ld: efi_64.c:(.init.text+0x1530): undefined reference to =
`efi_uv1_memmap_phys_prolog'
ld: efi_64.c:(.init.text+0x1706): undefined reference to =
`efi_uv1_memmap_phys_epilog=E2=80=99

Likely due to the commit =E2=80=9Cefi/x86: avoid KASAN false positives =
when accessing the 1:1 mapping=E2=80=9D

Looks like you are in process fixing that one as well.=
