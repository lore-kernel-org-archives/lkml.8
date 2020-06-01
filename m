Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6221D206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oOq/2y6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFAJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:13:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:13:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so9940921wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnDv9mKhgisjuUv4442s3oBzMirNjfvFW3husMjpwxI=;
        b=oOq/2y6dQ/vmouv3c8dq7KDNJz3DGi7rYIuZx9O+hzxd7n4l9dCfjHnhgK4bpieJp/
         GjSWLrt9LbXQrH2KudbYjHeDcO6w4P/RMQYwleAvubwph6FFQdDVxOOlLPH5oIo1VBTO
         m7Ahf6aZZoUci0XOd5JOPf+JZrQ2CtQhPoLs4A6qUxlAbgFYgyqJ/JQD2Sp+WAv7dXTh
         zZ2eTZiU5BeCIiWQuJCAjquA361uVlXxZkWmQ5Ms3DNlx++5gwKP3jw68q+dl11EAVu/
         yQD/pOiRWgUvMV/1QSpFg6TN3uAALILOmnBwenQRJJEjo4epyXRjh02RkA6Hwjw0Yj63
         ZNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnDv9mKhgisjuUv4442s3oBzMirNjfvFW3husMjpwxI=;
        b=kAX9nRFxNOH5ge6g3z54eRy3CTRHkJsxzgFpJqkBqubNd5u6ohO/rPJxNN4l+ZmXp1
         tGPSxc8PTMSpf52Zw1/1wLeHo9ItYaySvxX5MkUVPyeBy8y5v7fGAlHbneFCga/3qAxz
         KwQSe/ri9D9mt/TTK1d51vKuYHQ+hVXVVQgiJLGBdBH3WYZx4bby4x2EDRvBB1d6b85t
         Lmq3Vx5mhTeAQ4ofXG53wbFRb6+LxnhoApKVB8xqzmd0bwuwyWk0zdt8wvBM/UPE1Yv5
         4xaweRdPPR4Z2YhGSgOb1zylL8C781pzZpGAC8RjnM0Pah2KNTStzGYZekBbCyqobFXl
         00qQ==
X-Gm-Message-State: AOAM531GL+IYnGNYZNlrEfOkw8Ae/nD6JRdwgfjmi0tm8edZcAlddkvN
        lccnpFcLdKh7FY1QDt0LPL7zWr9hduAmfum+tW1lcg==
X-Google-Smtp-Source: ABdhPJyo2ugkmrpuJC16gnUTQoZ8Arf2Zn+UHfcMhlT4623YsylyPuxvgGg9UpSADEofhWrmPk2CiIr5b+dLwVBb/aE=
X-Received: by 2002:a7b:c5d7:: with SMTP id n23mr22311332wmk.185.1591002828890;
 Mon, 01 Jun 2020 02:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200530100725.265481-1-anup.patel@wdc.com> <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org> <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org> <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
 <e315f76b06b7b0935ebee867c04f364e@kernel.org> <CAAhSdy3-dr1URn1mGu3n9D-h+wjsU18nbWPYMRNAtitMa58rwA@mail.gmail.com>
 <ffeba9a68e72cf2cb97759c5fb496fac@kernel.org>
In-Reply-To: <ffeba9a68e72cf2cb97759c5fb496fac@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 Jun 2020 14:43:37 +0530
Message-ID: <CAAhSdy0LA13us3+tz6k2OBj6P7m4v0nQSQyGwF5O4NEdei=d6Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 1:11 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-06-01 05:09, Anup Patel wrote:
> > On Sun, May 31, 2020 at 4:23 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-05-31 11:06, Anup Patel wrote:
>
> [...]
>
> > Also, the PLIC spec is now owned by RISC-V foundation (not SiFive) so
> > we will have to rename the driver to "irq-riscv-plic" and will have a
> > new
> > generic compatible string "riscv,plic-1.0.0". One of us (me or Palmer)
> > will
> > send separate patches for this renaming. I hope you will be fine with
> > this??
> > (Refer, https://github.com/riscv/riscv-plic-spec)
>
> Do we really need the churn of a renaming? A new compatible, and maybe
> a new config option should be enough, no? What does the renaming give
> us?

I thought renaming the file would be good to reflect ownership of RISC-V
PLIC spec but I guess renaming just Kconfig option and new compatible
string is fine as well.

Regards,
Anup
