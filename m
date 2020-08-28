Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE8520848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="w4bavdWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgH1Er3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 00:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgH1Er2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:47:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE8C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:47:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l7so30393wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoHjgG7QKE51iIfhD6VjTDAp7Ojtyk5HJQxEFibU7HM=;
        b=w4bavdWtOQoS3sfGaaTkABme/fmWscqxZ5LrFLLfrldCDaD5j15cu3uS+4KRzGWtAD
         jL5fKfr/VbGOMCueuYkDR/IHdD3S+K2HmqNHE33cZe92yF3E730cfcNfvJRvvjtvpofv
         o4VjvLoEiX/gTqSaMavHf835jiuIHMP9e29nXHVG3LCcfX1ntDV6SrcZNkxl9BbWySpQ
         L0xCcy75cNcozpbzciAGbPd0mlviVTMYGY1OdS6hsy7vPnm4oCc9i0TaN8v5awlLyqP8
         wKvDiHVEv3U0CxqaC7XDBCMfulRckM5RDLbgkftLx/QA7YHy9JcF1QvK7zu0sHK6W0NZ
         GRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoHjgG7QKE51iIfhD6VjTDAp7Ojtyk5HJQxEFibU7HM=;
        b=IFByRBGL2HtqVf6AHO1XTW9E3vKx07mtnrZJYf5TNwC/QSCaiY3r9kTnOQ5bACYHil
         53bp1czJqXxXiXAiNKNCGntQ4/LuMz9FlttiB7nug6qglGc2h5V0QZDTY6xVh3DY/e6F
         vq/edAlOMTpD+RRTLNwNUIvhnJCIEfLu+MXerHAMYg9+aMAyyK5KCeJ1F8PcMHbQ4b8H
         i4KBEkwzGkRRAH1M4a+x2BOCjrPaoPEk/sEwPaJa6wwqiYSXq74moe9VXr3BDiBIl/0n
         9fYTn5iMlmv/KNCZW6GgIvv39DxniPf2csiHFo7hHcw1KoyZUvuXBfglJ+kioi9ZqoZ8
         t61Q==
X-Gm-Message-State: AOAM533viRwta7dr3aOCIqvYgSKwFNTyQ2trld2Hx6NVtEDq6MMXNanX
        INOkr/An5uaxwxYKsEr1HWtouyFNSSkmuV7o+9PrdQ==
X-Google-Smtp-Source: ABdhPJwovIXtCaNH0f/IjP5TwWI+pkvTR7Ji61aZ2sZ97tfrX8pksveSJF1DFwZSGd96+dxbvUTZTnuf4JCJxE9fvBA=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr24852823wrr.390.1598590045816;
 Thu, 27 Aug 2020 21:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200827082251.1591-1-jiangyifei@huawei.com> <20200827082251.1591-2-jiangyifei@huawei.com>
In-Reply-To: <20200827082251.1591-2-jiangyifei@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Aug 2020 10:17:14 +0530
Message-ID: <CAAhSdy2+auxYci5guLqtbEf3bO3At5-6AcB9Wj3AK4=YcR8f6w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] riscv/kvm: Fix use VSIP_VALID_MASK mask HIP register
To:     Yifei Jiang <jiangyifei@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>, deepa.kernel@gmail.com,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "Zhangxiaofeng (F)" <victor.zhangxiaofeng@huawei.com>,
        wu.wubin@huawei.com,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>,
        "dengkai (A)" <dengkai1@huawei.com>,
        yinyipeng <yinyipeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 1:53 PM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> The correct sip/sie 0x222 could mask wrong 0x000 by VSIP_VALID_MASK,
> This patch fix it.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> ---
>  arch/riscv/kvm/vcpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index adb0815951aa..2976666e921f 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -419,8 +419,8 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
>
>         if (reg_num == KVM_REG_RISCV_CSR_REG(sip) ||
>             reg_num == KVM_REG_RISCV_CSR_REG(sie)) {
> -               reg_val = reg_val << VSIP_TO_HVIP_SHIFT;
>                 reg_val = reg_val & VSIP_VALID_MASK;
> +               reg_val = reg_val << VSIP_TO_HVIP_SHIFT;

Thanks for this fix. I have squashed it into PATCH5 of KVM RISC-V v14
series.

Regards,
Anup
