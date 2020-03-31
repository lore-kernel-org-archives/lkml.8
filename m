Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA3C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1972072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="je25YuKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgCaTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:42:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33231 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:42:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so26701082ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eFUT43ck5+5R1qbPUjuBcQdIh9wgFblamWMErw9KKfs=;
        b=je25YuKe3GdVdtwLOJijqDoBjgC4vcbMmwqpJBL7TftLf5Rf2uF6T28QN6UMibZRR/
         q3tIy09alG6RoDm0HtwfJG8wHEXCMnryizTVYiyQFGq3zUfj5W5ILRAcM2FqfkUlyBOJ
         Wihp9iwjComgRQpBvDEi+Tk7jz10b26UVroo31SMO+2ktSkZnbjiwRuUnEbEn/x/bYOn
         3qZALbEK3VGxUlFPkmkzvSeqRYruhXFuK/HJ7HE+VIsEUlUg+/glj/tAejPoe0QLvTiM
         7UJ/xVyWbstvIZcgdDe4zc3c6Iggoc0Dy9/QZYkZDh5t589XtzXCtP+kB/SK5xreo5dq
         PjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eFUT43ck5+5R1qbPUjuBcQdIh9wgFblamWMErw9KKfs=;
        b=cjSIo0zXRLxp4RY1B6/WXk9YN/qCK8viDpgUGzdYsOzE0WrzPiw9obBjSPpw0tHHmH
         gxcB53s0UOX3h+TFag996yGNYEy1MvsdZJTcc0LgvEJFOtXS5Uudt2jrdycD1Tm3PjKw
         JrfdZAVBHZ+waRS5ZN3la+/TFOC/hnFRw37mbXi3hmOOXmtGiDGEC34wAZfPqoJKgp9u
         YvJ89Fox/X7GLi94iN4j5WLMkEU2Vy7FeMmAE8YGYVyjdl8gFUR9TRphvWT6Kmz9kQV9
         Z1PFMIa+1yLzMEFVPvRswomyvQRWXMxfEs4nxdwmx6XfrVEIAJGlmJbXL9sqJhMOcUx8
         42Hg==
X-Gm-Message-State: ANhLgQ1khgI0pB280VlA500pR2Y5N2OD5lOfpwSeZRwZTynwMTysgyYb
        yCYN/EQByvLSNgW3gRMYKFzIbYJPKklLyms2jRkEnA==
X-Google-Smtp-Source: ADFU+vtgud1DPhJvy8MROSuueMDBRjBInsn6e61/cbeRbUBWdx+oWjjB73XjMAzsgm2c9WauM9poEgqR2PS/m48qJOs=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr16428941ejj.317.1585683759433;
 Tue, 31 Mar 2020 12:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200330141943.31696-1-yuehaibing@huawei.com> <20200331115024.31628-1-yuehaibing@huawei.com>
In-Reply-To: <20200331115024.31628-1-yuehaibing@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Mar 2020 12:42:28 -0700
Message-ID: <CAPcyv4i=vyAFiAkGRaRx=+fnGOq9Eebo8szobBDD2AZ+vy877A@mail.gmail.com>
Subject: Re: [PATCH v2 -next] libnvdimm/region: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        jmoyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 4:52 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> On CONFIG_PPC32=3Dy build fails:
>
> drivers/nvdimm/region_devs.c:1034:14: note: in expansion of macro =E2=80=
=98do_div=E2=80=99
>   remainder =3D do_div(per_mapping, mappings);
>               ^~~~~~
> In file included from ./arch/powerpc/include/generated/asm/div64.h:1:0,
>                  from ./include/linux/kernel.h:18,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/powerpc/include/asm/bug.h:109,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/scatterlist.h:7,
>                  from drivers/nvdimm/region_devs.c:5:
> ./include/asm-generic/div64.h:243:22: error: passing argument 1 of =E2=80=
=98__div64_32=E2=80=99 from incompatible pointer type [-Werror=3Dincompatib=
le-pointer-types]
>    __rem =3D __div64_32(&(n), __base); \
>
> Use div_u64 instead of do_div to fix this.
>
> Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: use div_u64_rem and code cleanup

Looks good now, thanks, applied.
