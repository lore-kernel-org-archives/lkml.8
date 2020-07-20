Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB082C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C307C20702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr3amyWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgGTRlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbgGTRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:41:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22822C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:41:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j21so10191823lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UphPDJl+kRrCVRabYY8RnE2th0stWf+j9IyyIzXzz4=;
        b=Gr3amyWeN8CJm9nhgL8Q+ANXLLF30j6WnHckJ2NBMsFmlAJtjt3a4TNCA3VrgBNnTS
         EU7fQOi/aSO1yXCDgazjyRaHvBKyfUsES0BTlnaoABW12LwZKN4gV3wNeuPpjm1o48Bc
         7fnMJgZLX8qCXK54U79GuGSoMxYoTaddVXOqRxyTa3niyIuN3HtW41b/LTtlT7dfwjCz
         MuChCtDTVSdM9OJVRe7S3qzO59qEMjk+dvI3LruPpqHgzfjc5Gm8aQ/+5p+7NI0Ciam5
         A31TT4WudQt+w+zCsFRnplHhQiIn+O3VnOKEW33PVc7GWAgzdmg20XvIpCdNRzbXfrBx
         o2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UphPDJl+kRrCVRabYY8RnE2th0stWf+j9IyyIzXzz4=;
        b=oeJ+Kw+/ELdarvNi2cOgpa6nAOaE9C8vc8ewHYoMoV7CwIQZ51mbYim+OMqz2WaGK/
         OTCVd6KL7ksD7+Mbt+t9BhuxyyGetBMQycX09w0ibSefHVyn1VNqjxsSZHfQjdwlemxe
         zwjUUw20BCNlzysxeKH0fcg9EsaFEuBXfSunaiZu8yMzglNsNmtAFK+L+SFlMJLOn8Ac
         9gySmk7dHHArUSuNmthv+R+bK2RSVqW9YxMywVHvhF+DEvXyU7GPWqrT3Wk5pfgx5GDW
         W2HVN7u5Nk5JjgfJd0kn/u3kVzn1LJ3l2q8GlRFqS5wkSk0yBLaY3+wnNC5r25BNTRV9
         zj5A==
X-Gm-Message-State: AOAM533g85W4F5gqmQMGXq6pFbQFQM1ZLiupGripnWTWpdFWF2sV4deo
        O1hWJ2oJ3UXNebPNLcKF7Bq6YqJtiH9DlFXVHEdMBQ47uD/0uQ==
X-Google-Smtp-Source: ABdhPJxnoMlzUP8JRmpCn8cr07MiuozKQG8R6Alqsm+7/pQJBLNNwQNeUfpJgkREmDnNRogkjSwJkQPtL49eaJW7OBo=
X-Received: by 2002:a19:6715:: with SMTP id b21mr3045875lfc.55.1595266892447;
 Mon, 20 Jul 2020 10:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152825.863040590@linuxfoundation.org> <20200720152836.926007002@linuxfoundation.org>
In-Reply-To: <20200720152836.926007002@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Jul 2020 23:11:20 +0530
Message-ID: <CA+G9fYteJs0X1Ctjbt-51Q9J2JHM--cOpYg+02jSdfnbWbwr2g@mail.gmail.com>
Subject: Re: [PATCH 5.7 233/244] RISC-V: Acquire mmap lock before invoking walk_page_range
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux- stable <stable@vger.kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Michel Lespinasse <walken@google.com>,
        Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V build breaks on stable-rc 5.7 branch.
build failed with gcc-8, gcc-9 and gcc-9.

On Mon, 20 Jul 2020 at 21:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Atish Patra <atish.patra@wdc.com>
>
> commit 0e2c09011d4de4161f615ff860a605a9186cf62a upstream.
>
> As per walk_page_range documentation, mmap lock should be acquired by the
> caller before invoking walk_page_range. mmap_assert_locked gets triggered
> without that. The details can be found here.
>
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html
>
> Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/riscv/mm/pageattr.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -151,6 +151,7 @@ int set_memory_nx(unsigned long addr, in
>
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
> +       int ret;
>         unsigned long start =3D (unsigned long)page_address(page);
>         unsigned long end =3D start + PAGE_SIZE;
>         struct pageattr_masks masks =3D {
> @@ -158,11 +159,16 @@ int set_direct_map_invalid_noflush(struc
>                 .clear_mask =3D __pgprot(_PAGE_PRESENT)
>         };
>
> -       return walk_page_range(&init_mm, start, end, &pageattr_ops, &mask=
s);
> +       mmap_read_lock(&init_mm);
> +       ret =3D walk_page_range(&init_mm, start, end, &pageattr_ops, &mas=
ks);
> +       mmap_read_unlock(&init_mm);

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux ARCH=3Driscv
CROSS_COMPILE=3Driscv64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
riscv64-linux-gnu-gcc" O=3Dbuild defconfig
#
#
make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j32 ARCH=3Driscv
CROSS_COMPILE=3Driscv64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
riscv64-linux-gnu-gcc" O=3Dbuild
#
../arch/riscv/mm/pageattr.c: In function =E2=80=98set_direct_map_invalid_no=
flush=E2=80=99:
../arch/riscv/mm/pageattr.c:162:2: error: implicit declaration of
function =E2=80=98mmap_read_lock=E2=80=99; did you mean =E2=80=98_raw_read_=
lock=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  162 |  mmap_read_lock(&init_mm);
      |  ^~~~~~~~~~~~~~
      |  _raw_read_lock
../arch/riscv/mm/pageattr.c:164:2: error: implicit declaration of
function =E2=80=98mmap_read_unlock=E2=80=99; did you mean =E2=80=98_raw_rea=
d_unlock=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  164 |  mmap_read_unlock(&init_mm);
      |  ^~~~~~~~~~~~~~~~
      |  _raw_read_unlock
cc1: some warnings being treated as errors

> +
> +       return ret;
>  }
>
>  int set_direct_map_default_noflush(struct page *page)
>  {
> +       int ret;
>         unsigned long start =3D (unsigned long)page_address(page);
>         unsigned long end =3D start + PAGE_SIZE;
>         struct pageattr_masks masks =3D {
> @@ -170,7 +176,11 @@ int set_direct_map_default_noflush(struc
>                 .clear_mask =3D __pgprot(0)
>         };
>
> -       return walk_page_range(&init_mm, start, end, &pageattr_ops, &mask=
s);
> +       mmap_read_lock(&init_mm);
> +       ret =3D walk_page_range(&init_mm, start, end, &pageattr_ops, &mas=
ks);
> +       mmap_read_unlock(&init_mm);
> +
> +       return ret;
>  }
>
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>

ref:
full build log with default config.
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/647154950

--=20
Linaro LKFT
https://lkft.linaro.org
