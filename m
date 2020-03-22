Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93BCC4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F21120722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Qj1OqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVRtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:49:35 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40764 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgCVRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:49:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id o1so5735229ybp.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBSKyEapNJdFDgkGK5NVnULV3E9a0TwHux4z8qk4QOI=;
        b=A3Qj1OqZur8cYwBAguz7+LJxXHCNgcoFf6ozFJp2nwgiCfdiiRkTL9D9cb4tWvnp+t
         GSTfGkKsyk138anPW2i0ZVOMf+BQ9Xm8zapqod/RnEoCvl6+tFkZ1bfI9gBvL6Qk/odT
         iq0nN3A9WgtlxbbqJd4NFRGBTFE9q5LVwvi72VI90jjCqWOvqU0gwATxg6/MV4Zgu3Db
         tFtMimZEJzH34BeVDwk0YxUT6QLlcZADBs7wPDiR1gon3qScfaSM/UZiucpUk3ri0XC4
         76cBoINyNcg0XSRiHQi3oL4/OQOAxFky/KyEV2WAOT+lf+ql2DyuF7ZOkep80aRP0Ks/
         zqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBSKyEapNJdFDgkGK5NVnULV3E9a0TwHux4z8qk4QOI=;
        b=Rk89DHwceNJ8YEOW/+b3DbgIP82GMr2Pd4pBd64+wzeLTApyQU0q1oaOeVxkEJ2AC2
         PgWCJOGxSUbVg2YfoigM1l24K/wGdvPyAngh9VcjCbitTOhZy4WR6FKv5CcuuV7MnrsS
         oq3fyQCTBApxsyZ976ihOOTDdhW3VQ+kWzAqlHJA8E2uMwX+ULtU3Xmzcc7IfJOLV+1/
         GhbPIFgTbikEPJMS4/+tilo2vzseMciqCwAyoNPfCHLakGwJoAl3p+F6dpXCzFc3cXpy
         6F5k9pEKnNEc5AZIGux1IHQ7mzSg7zyOmOvgJ5jcI+/kT+GvIOzxN1qy9Lrf63hFJA0J
         bPjA==
X-Gm-Message-State: ANhLgQ0IaWFS1iNYYTARavO5QaVHDzIbevEBablCi1/KgBwENY/o4DNm
        V0LRFY322RC/d7S9+cpZ2frQc55y9q/6tU5RPU0=
X-Google-Smtp-Source: ADFU+vujMILMvlk5bbVmuQa0RF4y3Qk57Y571CzlbeXaKgG4dsRXBY/cjgbviAvO4VfuvftXAupG1r53uOLWYnc8X8U=
X-Received: by 2002:a5b:648:: with SMTP id o8mr30066618ybq.471.1584899372689;
 Sun, 22 Mar 2020 10:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Sun, 22 Mar 2020 18:49:21 +0100
Message-ID: <CANBLGcxB7Tf7wmkDnjsiEpmo6djwzN2DEjGqPfCt4LG6wcjLbQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] Add support for SBI v0.2 and CPU hotplug
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Bin Meng <bmeng.cn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mao Han <han_mao@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Wed, 18 Mar 2020 at 02:12, Atish Patra <atish.patra@wdc.com> wrote:
>
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
>
> This series adds following features to RISC-V Linux.
> 1. Adds support for SBI v0.2
> 2. A Unified calling convention implementation between 0.1 and 0.2.
> 3. SBI Hart state management extension (HSM)
> 4. Ordered booting of harts
> 4. CPU hotplug

If it's any help I tried this series with both OpenSBI v0.6 and master
(9a74a64ae08),
and in both cases Linux found all four cpus. I can test the hotplug
stuff too if you send
me instructions. In any case you can add my

Tested-by: Emil Renner Berthing <kernel@esmil.dk>

/Emil
