Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32563204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dRSL0lbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgG0DDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgG0DDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:03:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 20:03:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l84so600644oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fkOV/O/kNHZFKdtAVB8sb4T2DKi6scD2vvTjm2Gdfqw=;
        b=dRSL0lbY5nq2kJl32rI3bvbQV7YwZGiMnJZCnZAC+ymE5OAV/PBYKUjE/sv0VnV8yd
         jz9dYbDnPqdLRelkUeTjlqb+iB7EEN4IPEeUXoaTtY+6SPD5k9f2TW05G9pyyvwBsMEZ
         lmWrvPnjy9OplvxE9MgQuEplMRGLY7/1q6qaPUsVK7NqdLI8XNv9/cfyQbtDnfIO/kR7
         5Omng4IZ/VXNvrp0g+6wk4HXWYNWOw1df31SfQvjIYs4iyt4ZW/qaf0QpvlnnMN8WJUU
         DP8GmBpwv6OcdnC01zcG/eLol9h7FehVXEH75FIkGq7EVgHEwTQkVCN8Wy7NBSRUB3Ph
         aSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fkOV/O/kNHZFKdtAVB8sb4T2DKi6scD2vvTjm2Gdfqw=;
        b=apgBobM6sGRCSuFWe+tDF1bvvVXBVCs02RTLO78sz64SL+yON0Iy9cQMUPmSCLEI0/
         WfBQ5b9OpSX2AuufJw38wtPlz0QthgFN1Wz3mfFlAP+6lXnIh8wAuOqSF2P9LxJ6slYM
         r5g7+Uo/KFt9Qh8S/QMvcnSBM9itj3r7IMwRtuNDn11EwD5PEnx+Pxy+NEhtoSUlcVBT
         1b3ovyAuiFbcd8DZrf8HQYYpEVDhVuBhRL4YmmDn0VrXsQwAPZKWxMgu8Kydn4a33jkU
         6v4VtrdJe88JOs5IqV2iVfjgpnOLivQOkRf2KAUtTKS+hjaIYFgGkHX2IBhp2FnuK8U6
         arSQ==
X-Gm-Message-State: AOAM533XUtLibB61ZQJCptn5OzYZUsSJsbBBnDBv/Wgf4ss+6iD879pv
        Im801B2GqE5BkJfgm1AaQsT657HudgqCzx9DgnWHVSjw1E8=
X-Google-Smtp-Source: ABdhPJwtnMrFY5H/y6xGKI6VwNLjMw4MAkz7DUVThi1J8t+gbrS7hX9yAbiMeWdVtKljVjzXjBwGOpfEGYDBXks7/vg=
X-Received: by 2002:aca:d509:: with SMTP id m9mr15724168oig.116.1595819001911;
 Sun, 26 Jul 2020 20:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593766028.git.zong.li@sifive.com>
In-Reply-To: <cover.1593766028.git.zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 27 Jul 2020 11:03:09 +0800
Message-ID: <CANXhq0p7HO=zD7fDyz9O+TFzwFq2tqJva_V6RiFO6PExzuUq=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Get cache information from userland
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 4:57 PM Zong Li <zong.li@sifive.com> wrote:
>
> There are no standard CSR registers to provide cache information, the
> way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
> AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
> could use them to get information of cache through AUX vector. We
> exploit 'struct cacheinfo' to obtain the information of cache, then we
> don't need additional variable or data structure to record it.
>
> We also need some works in glibc, but we have to support the function in
> kernel first by rule of glibc, then post the patch to glibc site.
>
> The result of 'getconf -a' as follows:
>
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_ICACHE_ASSOC                8
> LEVEL1_ICACHE_LINESIZE             64
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL1_DCACHE_ASSOC                8
> LEVEL1_DCACHE_LINESIZE             64
> LEVEL2_CACHE_SIZE                  2097152
> LEVEL2_CACHE_ASSOC                 32
> LEVEL2_CACHE_LINESIZE              64
>
> Zong Li (3):
>   riscv: Set more data to cacheinfo
>   riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
>   riscv: Add cache information in AUX vector
>
>  arch/riscv/include/asm/cacheinfo.h   | 14 +++++
>  arch/riscv/include/asm/elf.h         | 13 ++++
>  arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
>  arch/riscv/kernel/cacheinfo.c        | 92 +++++++++++++++++++++++-----
>  4 files changed, 127 insertions(+), 16 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>
> --
> 2.27.0
>

ping
