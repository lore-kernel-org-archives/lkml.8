Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EE52071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh1uw69R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGQEYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgGQEYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:24:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B8BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:24:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so5972823otv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYRhNeJyMfpc078wL/j31HurR5nJxYBJf2WPWtqv67M=;
        b=Kh1uw69RH6AnDF+LGaQL/TlfB/OoFmyUPwbfUkO50aMlcjf5CR/uR2PYWm7tPKN3fV
         jR7mdlp9am3bRba3SEs4mJ98wUxBm4j2ANKGObN41QYgd+VRpQW4DhrruTPnYQ3z3glV
         OY5crlzGJJfGYp25p7IlnG4R7X17m+302T7QWNmLhESiLM4WbYkDMX2KCYfgRGhkjRuJ
         3t0kqv/fHJB1zQf2vfXSNrkDp/YM2LsW2XiRDXXq2zu7YrIoAu+G2Ill1BAKf03VcY/i
         /5olQ54IGuE99Z71PV7RCYsBFnoPJGHOYD32Q1XVFWl21dG2i54dvNwZZMKgR2jKspFb
         2S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYRhNeJyMfpc078wL/j31HurR5nJxYBJf2WPWtqv67M=;
        b=WEPL46opaGTw/R4nCiwgj+vZwyFnsAzu3xRnwxETuj+f2GeN6UyJ1lkhMSfJQ/HUIU
         aoR+yOA95WJ+Ah11kc6x68YFf4RdLe2RWG3IwHT7meN7IhDoAQxQW0X8m9aR16VBorBa
         j4AZZPz/EUJd2HpyNUWTs4LkOvBg05ZgMp+hKkHgUyb542J5ekx/QvmKxndcUfsD0EOj
         1FXinJHXP2rvK1usiDNyO8KCVB4zrzfatBfM+LAzPDo0b0B/ZZQ6AqbIka7uAZ/vOXT0
         jI3dmsZjcrJ2yyMBn749JO7ImBvXeQoD4T4cPfx4AwNZkA9Nt3GGiuGBHr1QlM23hu3s
         FfXg==
X-Gm-Message-State: AOAM530CiS2zQ+EdVukJMZyr9xeAeHdsSVql8Kc+mLJVINmPpLpIhl4D
        x0z+1jNyPcoHnV3UfUd3bwA8C7+5RstPWsWiyZQ=
X-Google-Smtp-Source: ABdhPJy9Qve7h79FN/Grjt90XmaceRcsY/1aZcCD1+74wKOmBXvf2VJ15Vwm0aB6fQ4xmUck1IdK6oqrCnN+I8ERfv0=
X-Received: by 2002:a9d:6a12:: with SMTP id g18mr7790181otn.155.1594959850557;
 Thu, 16 Jul 2020 21:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-5-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-5-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Fri, 17 Jul 2020 14:23:03 +1000
Message-ID: <CACzsE9py0x7wFyG-FgjK-cF8L02OQyOKbqDzP6agFt-Dxc4ejg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] powerpc/watchpoint: Enable watchpoint
 functionality on power10 guest
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:10 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> CPU_FTR_DAWR is by default enabled for host via CPU_FTRS_DT_CPU_BASE
> (controlled by CONFIG_PPC_DT_CPU_FTRS). But cpu-features device-tree
> node is not PAPR compatible and thus not yet used by kvm or pHyp
> guests. Enable watchpoint functionality on power10 guest (both kvm
> and powervm) by adding CPU_FTR_DAWR to CPU_FTRS_POWER10. Note that
> this change does not enable 2nd DAWR support.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
I ran the ptrace-hwbreak selftest successfully within a power10 kvm guest.
Tested-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/include/asm/cputable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index bac2252c839e..e506d429b1af 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -478,7 +478,7 @@ static inline void cpu_feature_keys_init(void) { }
>             CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
>             CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
>             CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
> -           CPU_FTR_ARCH_31)
> +           CPU_FTR_ARCH_31 | CPU_FTR_DAWR)
>  #define CPU_FTRS_CELL  (CPU_FTR_LWSYNC | \
>             CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>             CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> --
> 2.26.2
>
