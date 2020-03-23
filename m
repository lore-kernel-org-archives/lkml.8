Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6EDC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F21A206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="SvTq/87u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCWDDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:03:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCWDDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:03:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so15137908wrj.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RG8JaLzGTKMyhBP0BlO9r9T3SiXBNV0qtiTHs4NKU/I=;
        b=SvTq/87um7GXn4vBgge1JZc0gbJqbdPlvrcL4EYia/FzG5ezZ/hpp6DKWcvqlCiDE7
         MGT5z9Z60a/Jo3rCZ9eD5uk+UBFPzhcOvqkIPMKJQptN8UaNCrzqO0f7mHu/8WMqfNFd
         /LwMq2FUfbw3Xuxh2TpDpym4meEmuNszBGSmknrwd3spK1ixmlOJpx7X6DxTwJOjRV1q
         bZz4M0fDOPJ15kr4KFBY9m0M/+kBDKacr9v/qWzVoZ+Q8NXsmfDrhDbvtlWyOtyyv+AQ
         ndLbPhxTf885AXhriH2zWZ2zasMTYe1stBM59Kw5xvwRYfYkhxBCrY2k58+Ky/1sOg9O
         l5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG8JaLzGTKMyhBP0BlO9r9T3SiXBNV0qtiTHs4NKU/I=;
        b=IqVUiJLeZOuY59FGzo4o66pdT6KYw87w/QX3y7WM6ZKbU22bMVYh62wabFeK3t3Dgp
         efsqwQPNiDPRY9LI2C2mJyxGvVHuG2Ht76BygGMkYtH6LAFWAKUL2mELPaqbJih2Bn2B
         IgGHpRsvSxF44TsBif3zdhMGQLG9ZnY+M0i6oOiold133HaO2tbv/YMVF+XdtKtH6dUb
         WZ9gx1joUHbKCEKm/EL+9wgW9eekrCPaTIXnmot2lWycy895bJ/ocD+3SGyjnVHWzjKa
         mMoHuRBUyHo56A5aXtj0Ms38un6jUIM+J3C4SPru3GeqjtfzAa0O6v+LlOiy1rqVswcb
         TnLQ==
X-Gm-Message-State: ANhLgQ2mOjZuzLIP6odPlQm/5rRq19DhVaAAc79HH4XraTb53+CbVive
        kRJMiqE8qalGyzvBx+971yAsq8wQYyKt4wsACxU7
X-Google-Smtp-Source: ADFU+vtN2d113HCoAwuCsH276Sf3lrwOu7bapSZpQpVPG1E7Z1lLXx0J8pj7PaR2D7lDwHI0R4g1Arbl6YRmYjEgUJo=
X-Received: by 2002:a5d:4003:: with SMTP id n3mr12335418wrp.176.1584932608778;
 Sun, 22 Mar 2020 20:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <CANBLGcxB7Tf7wmkDnjsiEpmo6djwzN2DEjGqPfCt4LG6wcjLbQ@mail.gmail.com>
In-Reply-To: <CANBLGcxB7Tf7wmkDnjsiEpmo6djwzN2DEjGqPfCt4LG6wcjLbQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 22 Mar 2020 20:03:17 -0700
Message-ID: <CAOnJCULYLBV0O+xrgnCkv6FgFC2wz0U54uYV7S5hkBfQf+7vRg@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] Add support for SBI v0.2 and CPU hotplug
To:     Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mao Han <han_mao@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 10:49 AM Emil Renner Berthing
<emil.renner.berthing@gmail.com> wrote:
>
> Hi Atish,
>
> On Wed, 18 Mar 2020 at 02:12, Atish Patra <atish.patra@wdc.com> wrote:
> >
> > The Supervisor Binary Interface(SBI) specification[1] now defines a
> > base extension that provides extendability to add future extensions
> > while maintaining backward compatibility with previous versions.
> > The new version is defined as 0.2 and older version is marked as 0.1.
> >
> > This series adds following features to RISC-V Linux.
> > 1. Adds support for SBI v0.2
> > 2. A Unified calling convention implementation between 0.1 and 0.2.
> > 3. SBI Hart state management extension (HSM)
> > 4. Ordered booting of harts
> > 4. CPU hotplug
>
> If it's any help I tried this series with both OpenSBI v0.6 and master
> (9a74a64ae08),
> and in both cases Linux found all four cpus. I can test the hotplug
> stuff too if you send
> me instructions. In any case you can add my
>
> Tested-by: Emil Renner Berthing <kernel@esmil.dk>
>

Thanks for testing the patches. Here are the steps to online/offline a cpu.

To mark a cpu offline
$echo 0 > /sys/devices/system/cpu/cpuX/online

To mark a cpu online
$echo 1 > /sys/devices/system/cpu/cpuX/online

Here are the official kernel documentation.
https://www.kernel.org/doc/html/latest/core-api/cpu_hotplug.html

> /Emil
>


-- 
Regards,
Atish
