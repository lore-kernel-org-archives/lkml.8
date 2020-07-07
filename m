Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D6B206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jdmRppII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:32:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A95C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 02:32:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l63so32939537oih.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UfuIz4UHBMOwSxX1pJVc5YXivVtB5zjr8vmw0wj96hY=;
        b=jdmRppIIVdsnJlbD/8XOFXCflBAVypl8ziuHJdOlL3dIlATUfGDLUbXYFmanXFZVLV
         Tqd7k4K1F2R1YuWJPp71Z76qdEHlyfRWH7niBZiiGEvfNxv4XdSZiYBW3G/3wKq3DFzY
         62so5j0QN+3PyXJ09luDc5ZClhOEF8/BB58+wJlL4cgCocSxZz0T9Uik4uA826+RB0d7
         UF0/tBPLrpEPnfEA3scjKK6/By0DGz/tA+ljQyJKC/GVyt0jvP+BIVDZkddeFnUp1CS+
         d6lCBFU0Oz7itQuAtG4CQEIfkkPBxo9AxltHqVsVGBNYs/Yr797FUUIklumJKTnZStoJ
         nvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UfuIz4UHBMOwSxX1pJVc5YXivVtB5zjr8vmw0wj96hY=;
        b=h6KwUm2agaY5gLPuR1JuQ0eHfKne5+blugglxFTCRRLCXHFckd5BxFi4lUEU/0EUhD
         vIzsSy3OYHDjTJCKmRag4lW2YNLnkzM/Z/E3aSmveN50lWx1gYqesKzccUlC/jLFkqld
         jMiv9z2m7GbufxnA9FJOSbIiA+rBTQgZz9KQa8GydnH+ShfYH1ocsGGUBW7NqcyMUjgH
         V4GfcbmJOS//E0Zg79OeSV+/AnltKI6uASic1rkJ90XKgA89YjZ24nXSTvvVpSqDw7xV
         7pqBcgTN+urBoAsyM4T/+nwEZmsgNiaTfraw2zuxRAViX+4h3+F5mSqa94h56cLUJxB/
         lfJw==
X-Gm-Message-State: AOAM532jJFgTW0OZy0CGKS6wz+xTfDdjUF1kFbXFT+k9STZjd2Z64GB1
        5vvydRbfrH2Iwo+Uo17M+Onp5TQ18/gIkLqAj46D6A==
X-Google-Smtp-Source: ABdhPJz8mqzxYcSmj/jhmer7OTlkiPFwvqhO0vJBWKRwUhaCLX75N66VSDBFxEtVZltncMMmiESeoIizW8L+lU4/n2Q=
X-Received: by 2002:aca:d509:: with SMTP id m9mr2402280oig.116.1594114370298;
 Tue, 07 Jul 2020 02:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200623080238.122973-1-zong.li@sifive.com>
In-Reply-To: <20200623080238.122973-1-zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 7 Jul 2020 17:32:39 +0800
Message-ID: <CANXhq0o6LwkJRrxMXNK5MO9w0CRhrqdtc8+s8pnHPvhXTiGKgQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:02 PM Zong Li <zong.li@sifive.com> wrote:
>
> AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
> NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
> for RISC-V at all even though ARCH_DLINFO will contain one NEW_AUX_ENT
> for the VDSO address.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/auxvec.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
> index d86cb17bbabe..22e0ae888406 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -10,4 +10,7 @@
>  /* vDSO location */
>  #define AT_SYSINFO_EHDR 33
>
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    1
> +
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> --
> 2.27.0
>

Hi all,

I put this patch into other patch series. Please ignore this single one. Thanks.
http://lists.infradead.org/pipermail/linux-riscv/2020-July/000882.html
