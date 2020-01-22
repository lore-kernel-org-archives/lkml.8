Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692BC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EA624655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdrFopAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAVTR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:17:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:17:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so347614wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oc3W0C7lsxvS0x0G2I86IYLsKBA11xYQkxcUJEmbCxY=;
        b=WdrFopAomh7JbmI6RUhI8I3CefYifoeSrqM7TVn/AoKudKEdcg22mqt6D+tYPGf3EK
         Yqn4oEOmRmxgmba7rePX11kAsyAxplmXOndB20RQC7//TLFdP2qtTGeRoNvre9aPB8wx
         INzq2QvErD0tF4y5iytUqQmCkiCEyjiXmv1PUgfHH8k06uz+3H5GLmjSMMUG0L+SalX/
         6oOoT4Eqsi/ZawCaUZRPsJxcLrGxhwNybepMJHbMc2HfRys6Ugut8T7GWfwC32dipxrk
         2nYH5JaAhRDMp0VHWtgjL/WECUEVPbuTGgjpKR6Q/HFXEab09Y81O392cCVF/K8omcTp
         ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oc3W0C7lsxvS0x0G2I86IYLsKBA11xYQkxcUJEmbCxY=;
        b=iEljsNsBjiELC2uRVOizIFNpAFcEXI4OIPREA23gowu3va86WGl5gqwJmdKMgdNzT+
         LfvwdHgTX1af3D50Jjwfzq0HkbZlQ1qKn2rRqFrsAfRHV/3wScN8nA9R/NLZqfj/FBrj
         v/Z5rDm2N2lYCsYhXi7chZLOdFjxVQ37iSRCYG/HwC2x/Rgfa+fGF7acxdRe6N/LCMgl
         PsAJqYnLCfA8qG/bAPHo/rCk9iHYM8nYH896ub4sAcJlVFnuhFvo7yzSQS7+Z3eCK6fo
         dX3IhITfRuhQhIwaVoTipSK7iaJSV/gthRKP79H5v4SWXoLMGMGlVBuZkyltFpJHNd+O
         OENg==
X-Gm-Message-State: APjAAAUxXJocaWrzUIYTqe9cnM9cLIK/FzHhc5x0lAwjQ/qAoq2Vrz3+
        9Qp3AZipfefBAhtLOYvhxxYuog6tXKNSSlo3mKikKA==
X-Google-Smtp-Source: APXvYqxMawU1ldsi6FPoO3JTCPTYntgGyX0+CDa7A7vgaiLziWk2RktjEmYwCFizwmWK3y1tBTxA9296f3orwKKTmUs=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr12553750wrw.126.1579720648100;
 Wed, 22 Jan 2020 11:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20200122191430.4888-1-cai@lca.pw>
In-Reply-To: <20200122191430.4888-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Jan 2020 20:17:17 +0100
Message-ID: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
To:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
>
> x86_64 EFI systems are unable to boot due to a typo in the recent commit.
>
> EFI config tables not found.
>  -- System halted
>
> Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/boot/compressed/eboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 82e26d0ff075..287393d725f0 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
>  {
>         if (IS_ENABLED(CONFIG_EFI_MIXED))
>                 return efi_is64;
> -       return IS_ENABLED(CONFIG_X64_64);
> +       return IS_ENABLED(CONFIG_X86_64);
>  }
>
>  static efi_status_t

Apologies for the breakage - your fix is obviously correct. But I did
test this code, so I am curious why I didn't see this problem. Are you
booting via GRUB or from the UEFI shell? Can you share your .config
please?
