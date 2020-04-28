Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84251206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sp3Ct+QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD1EyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgD1EyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:54:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8842C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:54:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so20036668ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JrjPs69r0pUjI4jiWO1HZG/wjkxDutGKz6XBMDQZWzU=;
        b=Sp3Ct+QAOIYkMPPYb8+ZTX2eAupbevFH6R2qOF98spZhleatVY1QJ5fLuRlronmMwm
         eJ5uID4NlgC2K5EJYj0qrbJxoTPTQKcdjYYvdjVM/y6H2WizHrMJe8S1E1MF8Y58vO3s
         T1xbs9g1wJQzLFypE/CfhPnRqv/Pf0uOEy2+KHxGgbd39auv0h/4PNzRvdnufjCCbHiV
         BeXfi54GotFuMkpPxVuR2OMEosQMNPsT7Dpc97ow21KbWQxB2FxXyP5fkZ+Tvuhi8iuJ
         gLCExSq86j5Mt6FIzLYexOxgcZx7LJnWqRrJwgU9+I6UgTRT7ukVrTpeOv4N5XWSKsR9
         Pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JrjPs69r0pUjI4jiWO1HZG/wjkxDutGKz6XBMDQZWzU=;
        b=s17u9h5QS3jI5w2EKj0fAgZenzwuR5E2B5zQcmt3hIKRtCkN1JObE+CUu2CM9YYGWq
         XScKpEccLbevVVstyYq59X8m5XWjRgRXLUa0F4mQ6aVaiWz1hpX35sOadEFJYuVVAb8k
         8/dpOE62RZjWjfsN/kqi3zOYuDCU7ML4Bq4tEINNf4SOU/t8fjaPC2ZwbA46T4zHYQan
         GvNhdQ/hK5beoOBgT+eWpFdR311ksREu0W0don9x1Jy1elt+m8eiFES8IDygVJvMlJDd
         Biz6HHDgd+EE6yvEdPYuJdqAJOjQhcdvtGpwI2wq1DbfACJxiUCDg96/g3oK1SOK+3/F
         3+Dg==
X-Gm-Message-State: AGi0PuaofsxiyO2fXviES7SkpGj6dWN8XDTtJOrO4sKdzLVdo/eMY4Ze
        i5ljrg+OsyzdMaUFHhzpvXAj3smucWsy/5XLoJzSvA==
X-Google-Smtp-Source: APiQypKvYNGeBVV5knWEjW/v/ZM4A/rHwo0I2l0Vy5+M44twiEUahUOzQVF90JHCIA+Oh4khJ4ck8NyNmGTdYOb0qgk=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr16218619ljg.38.1588049643021;
 Mon, 27 Apr 2020 21:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200418144047.9013-1-sashal@kernel.org> <20200418144047.9013-38-sashal@kernel.org>
In-Reply-To: <20200418144047.9013-38-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Apr 2020 10:23:51 +0530
Message-ID: <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 38/78] nvme: fix compat address handling in
 several ioctls
To:     Sasha Levin <sashal@kernel.org>, Nick Bowler <nbowler@draconx.ca>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        lkft-triage@lists.linaro.org, Basil Eljuse <Basil.Eljuse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 at 20:24, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Nick Bowler <nbowler@draconx.ca>
>
> [ Upstream commit c95b708d5fa65b4e51f088ee077d127fd5a57b70 ]
>
> On a 32-bit kernel, the upper bits of userspace addresses passed via
> various ioctls are silently ignored by the nvme driver.
>
> However on a 64-bit kernel running a compat task, these upper bits are
> not ignored and are in fact required to be zero for the ioctls to work.
>
> Unfortunately, this difference matters.  32-bit smartctl submits the
> NVME_IOCTL_ADMIN_CMD ioctl with garbage in these upper bits because it
> seems the pointer value it puts into the nvme_passthru_cmd structure is
> sign extended.  This works fine on 32-bit kernels but fails on a 64-bit
> one because (at least on my setup) the addresses smartctl uses are
> consistently above 2G.  For example:
>
>   # smartctl -x /dev/nvme0n1
>   smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.5.11] (local build)
>   Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools=
.org
>
>   Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Bad address
>
> Since changing 32-bit kernels to actually check all of the submitted
> address bits now would break existing userspace, this patch fixes the
> compat problem by explicitly zeroing the upper bits in the compat case.
> This enables 32-bit smartctl to work on a 64-bit kernel.
>
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/core.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b8fe42f4b3c5b..f97c48fd3edae 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
> +#include <linux/compat.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/hdreg.h>
> @@ -1244,6 +1245,18 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl=
)
>         queue_work(nvme_wq, &ctrl->async_event_work);
>  }
>
> +/*
> + * Convert integer values from ioctl structures to user pointers, silent=
ly
> + * ignoring the upper bits in the compat case to match behaviour of 32-b=
it
> + * kernels.
> + */
> +static void __user *nvme_to_user_ptr(uintptr_t ptrval)
> +{
> +       if (in_compat_syscall())
> +               ptrval =3D (compat_uptr_t)ptrval;

arm64 make modules failed while building with an extra kernel config.

CONFIG_ARM64_64K_PAGES=3Dy


 # make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild modules
70 #
71 ../drivers/nvme/host/core.c: In function =E2=80=98nvme_to_user_ptr=E2=80=
=99:
72 ../drivers/nvme/host/core.c:1256:13: error: =E2=80=98compat_uptr_t=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98compat_time_=
t=E2=80=99?
73  1256 | ptrval =3D (compat_uptr_t)ptrval;
74  | ^~~~~~~~~~~~~
75  | compat_time_t
76 ../drivers/nvme/host/core.c:1256:13: note: each undeclared
identifier is reported only once for each function it appears in
77 ../drivers/nvme/host/core.c:1256:27: error: expected =E2=80=98;=E2=80=99=
 before =E2=80=98ptrval=E2=80=99
78  1256 | ptrval =3D (compat_uptr_t)ptrval;
79  | ^~~~~~
80  | ;
81 make[4]: *** [../scripts/Makefile.build:266:
drivers/nvme/host/core.o] Error 1

full build log,
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/528723851

Kernel config:
https://builds.tuxbuild.com/DeL6EepmdRw6OaOGmg7F_g/kernel.config
