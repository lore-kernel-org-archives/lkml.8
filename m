Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2345722BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6l7e3aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgHTNLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgHTJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:37:20 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:37:20 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id i129so727597vsi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ST+s1VgrChigIylT4K0fDa+xlZ9DEdl2V2OEw6xk/A=;
        b=Q6l7e3aB6cXvDGQDWPmsO6nE8jKBpLQECvMRYe8Lv0fwF1uKRy3O9LStHPIlg5F1Li
         /ZYJ4VffxOWSR+jebqLcjxeZ/MI36sP7LKWcMWrdV5ggv0+cQ+vAKjNYjB+/UDX0enrQ
         sDH08Zs7pC7hlzdthniOPY45mIpDgq+nEpsSjljUbApMMXuCM4CGv1+crVue021L61Cq
         liSfhbH2oEpNSlhQke/evvT8o1faVARSDooE05p9qbq3/5ZqUtmiA8sWYC6EeFsJnf7j
         REogkKt9AmqYlPlq3n/7tvLM6VGPZrSSoObfENQtxMcyouJ59FIXRXG4iCKJDbI8WkSb
         iT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ST+s1VgrChigIylT4K0fDa+xlZ9DEdl2V2OEw6xk/A=;
        b=s3sBQQ6aHI7nxSnwkqv9OJF18i6GGYORMVJfkXAK7d8T0oZKnw3l1dB4F2L84wqaMU
         UotCFjVkAultJV6++/Vds4YDmFy6yYr73cjMxXzBG3aNIP3mbGYYfEkLIxk73coGfGqz
         YEGeazC+qaF9vMeYBq5XX5VfBYj8KdFbJuoGWQGmhhTHU7vHoogM4YEkA4BuirHeb4ie
         H6XHEb8tsFNYWkY7QCfbINm0rt15s+09lytEkVGmljNMFONdQH9lhNTXYmnj1ho6eHEV
         siFP7WT/z6pg8Q3fVomyL6oeByZWX+h31R2WN3CKTHbB0vgNq/IhapxRaw7+abdQExgU
         Rmmw==
X-Gm-Message-State: AOAM531xvPVZ2ZPNheXMbhkZ63KIyu6BRiQeXZL3vy1n4CI308aFsMA0
        r3hriXJRlk0cvzOs5dJX8ko2IMU2nBo0rNH+jRWyrA==
X-Google-Smtp-Source: ABdhPJykM/Ah+8o5lls+LOP2kgmsthnXq9FjKqghIi9CrMLYv2Lea57WiTqrBpVnWKZxBKh0GsNVTIk/VCu+skb80FE=
X-Received: by 2002:a67:6996:: with SMTP id e144mr1285283vsc.185.1597916239685;
 Thu, 20 Aug 2020 02:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuNS3k0DVT62twfV746pfNhCSrk5sVMcOcQ1PGGnEseyw@mail.gmail.com>
In-Reply-To: <CA+G9fYuNS3k0DVT62twfV746pfNhCSrk5sVMcOcQ1PGGnEseyw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 15:07:07 +0530
Message-ID: <CA+G9fYusZnYMYjKNcjf4cHwFUmV_=fXRHahsbtdsKwUzB98zEQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IG1tL2d1cC5jOjE5MjI6NzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIA==?=
        =?UTF-8?B?ZnVuY3Rpb24g4oCYaXNfdmFsaWRfZ3VwX2ZsYWdz4oCZ?=
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 14:59, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> arm and riscv architecture build failed on linux next 20200820 tag.

The pass with defconfig but failed with tinyconfig and allnoconfig.

> make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm
> CROSS_COMPILE=3Darm-linux-gnueabihf- HOSTCC=3Dgcc CC=3D"sccache
> arm-linux-gnueabihf-gcc" O=3Dbuild zImage
>
> 348#
> 349../mm/gup.c: In function =E2=80=98get_user_pages=E2=80=99:
> 350../mm/gup.c:1922:7: error: implicit declaration of function
> =E2=80=98is_valid_gup_flags=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
> 351 1922 | if (!is_valid_gup_flags(gup_flags))
> 352 | ^~~~~~~~~~~~~~~~~~
> 353cc1: some warnings being treated as errors
>
> Full build log,
> https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/695005038
> https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/695005042
>
> --
> Linaro LKFT
> https://lkft.linaro.org
