Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D86C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC67D20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eETmXHMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgHTNlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgHTJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:05 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE79C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:30:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id r7so715594vsq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6apwous/HgYA9e9mDqfrOOmq5wxR8eDdobsnINeJ2Ak=;
        b=eETmXHMWgfN31+kZjG7CG3fcmrCL+QERYJYc7EZzYmZ/iyBm5vlKvOgbCCqNZxA+XN
         10DkxJfP4eEu/UlvRJDammSXb+HlcfLo/fsFf2aSFcRcqIBQ+7RjdJr38r2T4P+8cYKO
         8d/CnJ8R9svj2hUovuPzmNxBKfCNxtu6eLdBKKXWJVho4oL/RoLTArsoGOYd0BIX4/qh
         +UqJMgXb82l+X/lNn+LZEZ6OyBAE3uKibnk1yh8wKFDHh+ShOt7pHuNUpHZjMK/Qj8+B
         5xpyiCvymikyE0YC0aGlESFBcdypcqQY4fBWYVaeZr3tCYVHbpKA/DJkxajl5oNxBOLv
         96Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6apwous/HgYA9e9mDqfrOOmq5wxR8eDdobsnINeJ2Ak=;
        b=BZ8aPMGDXURP4X/M1jM7BlzgTkb1is0eVpQfFLPzgn/E4ZFE6pSVsA2otGcslOjtsm
         11CUTIUAt0pVgaS+8efxEWCWajV6CQUGrtxHkb0wgkFGnoX1vpuopD4tYqfZbGQ6n39M
         nWYyE84+cXlMR2pwk7u9PDECbF5ocnFNeKyu0pRYeSZTJzczQYhphY8ZV8KUAdjJU5C3
         xz8IN3XBlDsyO95rmf4eKeniVsYyu1gDC8nYUmGhWJ8KAyZ1No1zTJilkShMcnNyo4Lg
         fh4pPSmBkdXuHMjnyRpg/1ELiUaQWPfQmoayunQJRNsT478/d8dBxIH84QJ4rpIIbtEM
         kniA==
X-Gm-Message-State: AOAM531+2jQeyja3/qzLW9rgTrDt8f0xtyJGTbFk62nqc3KlZQSIDayU
        pIpbFi/uyfdhXY4dQs4icYqox5aDrvssMw3zVS+phr5Bx1NOtm06
X-Google-Smtp-Source: ABdhPJxnX/aP9f1YYTlY9xogXia5cP6a2JVmyDFGvwr+8ZISnTbDnkGzsLz43KbFCYTyN0PDQwvWxV+jgNeZmbRKM00=
X-Received: by 2002:a67:e45:: with SMTP id 66mr1205335vso.191.1597915803707;
 Thu, 20 Aug 2020 02:30:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 14:59:52 +0530
Message-ID: <CA+G9fYuNS3k0DVT62twfV746pfNhCSrk5sVMcOcQ1PGGnEseyw@mail.gmail.com>
Subject: =?UTF-8?B?bW0vZ3VwLmM6MTkyMjo3OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuYw==?=
        =?UTF-8?B?dGlvbiDigJhpc192YWxpZF9ndXBfZmxhZ3PigJk=?=
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

arm and riscv architecture build failed on linux next 20200820 tag.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabihf- HOSTCC=3Dgcc CC=3D"sccache
arm-linux-gnueabihf-gcc" O=3Dbuild zImage

348#
349../mm/gup.c: In function =E2=80=98get_user_pages=E2=80=99:
350../mm/gup.c:1922:7: error: implicit declaration of function
=E2=80=98is_valid_gup_flags=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
351 1922 | if (!is_valid_gup_flags(gup_flags))
352 | ^~~~~~~~~~~~~~~~~~
353cc1: some warnings being treated as errors

Full build log,
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/695005038
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/695005042

--=20
Linaro LKFT
https://lkft.linaro.org
