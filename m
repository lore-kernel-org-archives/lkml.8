Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F9C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58D82064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lW7Cq00O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgDQMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729053AbgDQMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:43:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:43:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so2862785wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5uGvUBBK13xiGM08N0Ar0f5rTAFRwfmSByaivnK03A=;
        b=lW7Cq00OBPIgaU4boC2NWhBfA/bsU8/tgZ1luVaWA85xijqr+QRcCxBHtn39IQUBcj
         OFSsXpby/C0JSeaqXBR6kqmZyYcAP7kJkDsL4l1OOe3rXkTpmHNpyyCIohBUMjie/xVP
         hUuVSymNynjQw3FMf6ITpkubTII7Y1VKk3GFMUwiYmdOlE3+yjH5lJ1liHB97jqZWbyq
         tgy8/e6Z1erE56HG0eznmdLvtS8YPEh4W7lhkwR5X0PtD/aLwSJUmH7Lm5cLcTklrs6e
         NkjVNQcxZAYKWJymi5N+NlvKRJxhEuSsJ701USslsxbsiCOb6mIiNigLVlXZG7ykeeH0
         nJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5uGvUBBK13xiGM08N0Ar0f5rTAFRwfmSByaivnK03A=;
        b=k/RUQ/Ls3HJjcQ2XgKMJ1T8390dDtIHaV7P6f4JbvFsXY01PpbBGf3O0lv0YGiutvH
         nevJ31qPGnAmnuy6OIq4UJlKtrsz63w2FpNDsKAWafduv2Ox3yyWOb6aSlfltM2lKR7E
         1w7+o0K1Z9vpwM9jSt8B5O4TRCPRBHU9wlIUeNWCH3fIGVsmvrTbxkcKOFIL01D6CWT7
         POQYtAYGpRvIDS0pFSfOv97OYStL7DwJBr5KXQ7WX+PF6Pcx+DPV1ha7Niz2Ume+RvHA
         J9Mt8aVfnQRtHThkOnvFdv1BmR7yndsQ0JRmB8h3xxYYC1FC/bjBcvQ28ebbTxiXZvrI
         O+nw==
X-Gm-Message-State: AGi0Pub1GakzhAEthN52L9EzCRTqYa+Fr8xwrbHfruVAgDMTkaHILXOJ
        UNF+GNo1Jocf6hFPVD6TyQVslxp7l6HD60dbsABCAg==
X-Google-Smtp-Source: APiQypI55lXXZd9uMDkedrEdIWCNpIBCl6PYW/582+5vVyZ761iYDh5v4e2V3mqw5xp5aBwFe4wF0LpJFFnlKYHl7EI=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr4096911wrn.0.1587127395436;
 Fri, 17 Apr 2020 05:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200417121222.156422-1-wangkefeng.wang@huawei.com> <20200417121222.156422-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20200417121222.156422-3-wangkefeng.wang@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Apr 2020 18:13:03 +0530
Message-ID: <CAAhSdy0wQrs3-1R+ovEspmDp6aXYEpJEuv4M_cH9XSjkeo2_8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: sbi: Fix undefined reference to sbi_shutdown
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:40 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> There is no shutdown call in SBI v0.2, only set pm_power_off
> when RISCV_SBI_V01 enabled to fix following build error,
>
> riscv64-linux-ld: arch/riscv/kernel/sbi.o: in function `sbi_power_off':
> sbi.c:(.text+0xe): undefined reference to `sbi_shutdown
>
> Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/sbi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 62b10a16c8d7..f383ef5672b2 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -167,6 +167,11 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
>
>         return result;
>  }
> +
> +static void sbi_set_power_off(void)
> +{
> +       pm_power_off = sbi_shutdown;
> +}
>  #else
>  static void __sbi_set_timer_v01(uint64_t stime_value)
>  {
> @@ -191,6 +196,8 @@ static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
>
>         return 0;
>  }
> +
> +static void sbi_set_power_off(void) {}
>  #endif /* CONFIG_RISCV_SBI_V01 */
>
>  static void __sbi_set_timer_v02(uint64_t stime_value)
> @@ -540,16 +547,12 @@ static inline long sbi_get_firmware_version(void)
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
>  }
>
> -static void sbi_power_off(void)
> -{
> -       sbi_shutdown();
> -}
>
>  int __init sbi_init(void)
>  {
>         int ret;
>
> -       pm_power_off = sbi_power_off;
> +       sbi_set_power_off();
>         ret = sbi_get_spec_version();
>         if (ret > 0)
>                 sbi_spec_version = ret;
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
