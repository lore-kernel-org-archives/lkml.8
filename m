Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B8C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EE52084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHZkssv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgAKMad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 07:30:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45190 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgAKMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 07:30:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so3502426lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t06bV6pFS1ud0jboI1ItTQ0ZCaOcEXqW3e26EKOcNH8=;
        b=SHZkssv0g76+UrXxOn45/cin8KPW04fN/ThIY7Ti74qXweOEzCjEwN03nDFaJeSA8/
         HAJiaJpBBUYAhmFjgKk+Kg332X1iP6RaYn5+TFZmAF0yj4maPgQ9yJhaUSQrGbWniBlO
         SPxaXcnZGgz65n3Lf0YSZc6zaNeyIF1+rBgmkkcksbiRQ6X8zY1jx9cdWqdC+5yjqWOK
         jP+Ef3W4Y/dcuup6WqhM9r8iW8PlWlto42PGE/7PV1ZD5sxg9OJUVAyJJoA6lb93zzwN
         llD2RUyeoLhUYJkMyHSdauQmYLerlTbPvsWP2kfDroYYA1AOjKo9yfaToiTUnB9xR51E
         XNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t06bV6pFS1ud0jboI1ItTQ0ZCaOcEXqW3e26EKOcNH8=;
        b=f2NfdVmpzUn6+cxPVRpRwPLKmHcnlfKCsNSrBwtFDl3wEQsMCYs1FJiPl5xtFJaLr4
         H7D9AzTSpKsl7eQOJ4NTy0d0WoyFcvBd4hIJYd6GQUXQ5e1iqgwLSRaOGzAz8/urQYyd
         he9s2fm6JF27xlTIGC4+w36/OEA14VMzYuF7rMrLgUPYToec17AfIonP64NF5uYnGHR4
         lGwLh7BbHPuTNYq88xb3h0XIks1cEC5/GFNNPKuZdPMbdr0tX4za4IUVwDWbX+ZODZS4
         ktzs2MM/R/q0JDkk2zFJ5BpiXBcpLnj9Zfte3ix2MTZaQ9l5doiK93+jgrHbwq/FEyQF
         z1Cg==
X-Gm-Message-State: APjAAAWV2jL0DuuFQ+BoGhXLY6l2uQwUTJ8Q+bOITdiWitB9yp0Heuta
        VGjfhmKhOO8TCAI+EuHJrxwTae4h50RyvJBMsrrREQ==
X-Google-Smtp-Source: APXvYqxv1MsAssRhvJPaipbtV79RRnlzo6mXDhr+gfrW/7xu0BWzYfJFEJ6/eMAsmbaCElhYbPqHc1F3W2r/Q93bL0M=
X-Received: by 2002:a19:c648:: with SMTP id w69mr5302866lff.44.1578745830371;
 Sat, 11 Jan 2020 04:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20200111094845.328046411@linuxfoundation.org> <20200111094910.328555272@linuxfoundation.org>
In-Reply-To: <20200111094910.328555272@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 11 Jan 2020 18:00:19 +0530
Message-ID: <CA+G9fYtfuSAcSURcz+ehqPKXOodmn+SELn2rUKGkG-CUfE-2vg@mail.gmail.com>
Subject: Re: [PATCH 4.19 65/84] arm64: KVM: Trap VM ops when
 ARM64_WORKAROUND_CAVIUM_TX2_219_TVM is set
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2020 at 15:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Marc Zyngier <marc.zyngier@arm.com>
>
> commit d3ec3a08fa700c8b46abb137dce4e2514a6f9668 upstream.
>
> In order to workaround the TX2-219 erratum, it is necessary to trap
> TTBRx_EL1 accesses to EL2. This is done by setting HCR_EL2.TVM on
> guest entry, which has the side effect of trapping all the other
> VM-related sysregs as well.
>
> To minimize the overhead, a fast path is used so that we don't
> have to go all the way back to the main sysreg handling code,
> unless the rest of the hypervisor expects to see these accesses.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On stable-rc 4.19 all arm64 builds failed due to this error,

arch/arm64/kvm/hyp/switch.c: In function 'handle_tx2_tvm':
arch/arm64/kvm/hyp/switch.c:438:2: error: implicit declaration of
function '__kvm_skip_instr'; did you mean 'kvm_skip_instr'?
[-Werror=implicit-function-declaration]
  __kvm_skip_instr(vcpu);
  ^~~~~~~~~~~~~~~~
  kvm_skip_instr
cc1: some warnings being treated as errors
scripts/Makefile.build:303: recipe for target
'arch/arm64/kvm/hyp/switch.o' failed

Full build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/413/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
