Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E47C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2FC20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/o+wW+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgE3CIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgE3CIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:08:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE417C08C5CA
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d5so1364863ios.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGlgROHSovsEF4bMgP89pW+8Pij7QZBFzzTXzjSt4uE=;
        b=Z/o+wW+Dx/McvSxo/vn8yYtIZxJaH8N6GRqo+aXvlqSz3x/Sjz5OCrDfNKGG46sDy7
         UQcIM2rc7QTjGIlkNqjbuWUw1C5jrHsaieg3xwZ661p3FBA0/+T4A7HggUETi+cLOVi6
         3tw4IE8IXPLbABQFMY7jpp0+QQSBHPE39SiM8XwbUpiO5ej8HtIEax9BruoxUemYOYtE
         GeSQRcgF778oValHxiPKTOTuIdPb0fGdxYrUTau8rh7gcY3BNJMJlIBo+OHjgydEGnjQ
         nLAGc6Or3Q48f6XkxgMqtpifSgHKjr/87Uxf7VYTeV2Q+jFZ4c3XQgqvg+Fd1CJNc+HK
         Re2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGlgROHSovsEF4bMgP89pW+8Pij7QZBFzzTXzjSt4uE=;
        b=EvuphbOzspNFVtOsLl/+lPvJ9xAFIqC/KvGalg4DFnMrVeFjgQVH4eXVebZmzfen1b
         Ngiar/LFVd8GyOLqlxhCKPoz2nxQ9ntuDc4Qjbr8CRNZZ2jOEoy8hPcKk6lB47DdXy/m
         hue6koXMwlYwSV7ZNQPmKxwE6MVXGgMEwizTf2ncb7O5BYc/QW78ffc36WMhU+SYnX6h
         Ztf5uOLwabRnXz4Ph/DYcxZrTZTARe9e/2OxMMqM/DCGrtovl1TyqmS6wXZz0p721Gdp
         h6nQ7Pq9L39t2Fb6hnU0szQEuBqQaBeq8FWQy5LpVY1Z3Ewa4ZytBitluk0bsgXY/Nxx
         tEzw==
X-Gm-Message-State: AOAM533MfUTg8a6xbWJSwKw4mp6HrmxQ0Mwgb2lf+YHcP60fTpBkqfjS
        p5xkwjGGXNNN4IJv4f7wNs7BgbDTQ8SIGL7TwSh6kQ==
X-Google-Smtp-Source: ABdhPJwm1KgZnRuBHWDLttsOH2fpKKstKDUsD4DfLIV7tDl54dh0cp8sxNR+w1vUHA5eY+MpfyrulwEuAxa9nXxiuuw=
X-Received: by 2002:a6b:38c4:: with SMTP id f187mr9015617ioa.205.1590804511839;
 Fri, 29 May 2020 19:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588711355.git.ashish.kalra@amd.com> <abeea5c7dc54cf86e74bc9d658cef9b25a8fac6e.1588711355.git.ashish.kalra@amd.com>
In-Reply-To: <abeea5c7dc54cf86e74bc9d658cef9b25a8fac6e.1588711355.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 29 May 2020 19:07:56 -0700
Message-ID: <CABayD+eFyWG0-Pa6hX1_HLGG6oyq=cVG1skpvJomhfpBhifoHQ@mail.gmail.com>
Subject: Re: [PATCH v8 14/18] EFI: Introduce the new AMD Memory Encryption GUID.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:20 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Introduce a new AMD Memory Encryption GUID which is currently
> used for defining a new UEFI enviroment variable which indicates
> UEFI/OVMF support for the SEV live migration feature. This variable
> is setup when UEFI/OVMF detects host/hypervisor support for SEV
> live migration and later this variable is read by the kernel using
> EFI runtime services to verify if OVMF supports the live migration
> feature.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  include/linux/efi.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 251f1f783cdf..2efb42ccf3a8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -358,6 +358,7 @@ void efi_native_runtime_setup(void);
>
>  /* OEM GUIDs */
>  #define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> +#define MEM_ENCRYPT_GUID                       EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
>
>  typedef struct {
>         efi_guid_t guid;
> --
> 2.17.1
>
Have you gotten this GUID upstreamed into edk2?

Reviewed-by: Steve Rutherford <srutherford@google.com>
