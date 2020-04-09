Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD3C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD722074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvapQdcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgDIWGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:06:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33886 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgDIWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:06:31 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so260094ils.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CGEzotVnRaQT7yF2QaJvHPaB3shOSQ3vcyNarTslrC8=;
        b=HvapQdcECFWw/ne9zn+KAqOvO4558LNtGEQ4kL6usWUSXTXPck/iGafSzERuAMrQvZ
         yHo2ND8PSweIBvCw6iuIeTZWayhtPOQNMfxxVRsO2yfJCRWh1ZFyhUBtcD4lEJhecHHH
         s/we+ObvnqCd2SjrfkaiF1WCL84JcFvVdq2ubrUvA7lYMp1m+dTJwoKF+XRh6ePzi/3y
         3sL+QirO5q4RGTYAHyG90pflJN/QM8ZeSjJdCwklBzgiPAWPnc14XKcDdXFSup5OgIyC
         Gdy9vIMCbc/Gb3XbVAoA5toHp+AbOnY6TyyN+KciMcgyTVh6NH7ZPg4sanYeV0C+/DU5
         BJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CGEzotVnRaQT7yF2QaJvHPaB3shOSQ3vcyNarTslrC8=;
        b=AAueDYO/U8GUjMXkIsUuyKd5AsVEw5239Byk8VR7eF/TijpsDxbU5dIptbrNWMwz7V
         czKrLPthR6nBliiTJK6hkl6+9Am/7feinW6BZcYlSirtxA705BmSGY+ToUGRwJuL89qu
         BqsN+Rv2rLDBHUDOzMCYyi+eGAYhVAYrPPWJFrKjevndY0ckVxrmvSJcQ9TO0ezuxblu
         87m+Az339SGceHjdINRTIbxSpvKDD99n3WQSeJ5sT7xzyTQ2V/5/7UJZ3poVJd3rN1T4
         AvEtfbNnR5QyQ2OQ5+x6lDPys3SqjZGo42OF71pGiLo/EVpslUp04i84MGu1305MKhYB
         Ltzw==
X-Gm-Message-State: AGi0Pubn6XH0hMETx+DyrdV7JkdLBgfPDc6hsAooAdg2qb8V7202HAUM
        316uBQ4zYKUI9QsBc4sz3p8Yz2aGnQrVWFxKkEk=
X-Google-Smtp-Source: APiQypLnsRlAm0w0mpfuP1UYMQZW3TM7H42jhSIG7Glgjj1GugOTTUrhNbOA3SEOea0zGfzoyJX0coVDtzOrlEHFpS4=
X-Received: by 2002:a92:d407:: with SMTP id q7mr2019917ilm.95.1586469988954;
 Thu, 09 Apr 2020 15:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtfG4nZs0ON=bBNarPaycNOgGNvhXxcdrGzM1epDDBt7A@mail.gmail.com>
 <20200406172525.GA338360@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200406172525.GA338360@carbon.DHCP.thefacebook.com>
From:   Yang Li <pku.leo@gmail.com>
Date:   Thu, 9 Apr 2020 17:06:17 -0500
Message-ID: <CADRPPNTSOJsz3kihZ3vXK0i6zWpUY_C36GxqmMO6ehACPT=aBg@mail.gmail.com>
Subject: Re: mm/hugetlb.c:5580:3: error: implicit declaration of function
 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'
To:     Roman Gushchin <guro@fb.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        andreas.schaufler@gmx.de,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, js1304@gmail.com,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 12:37 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Apr 06, 2020 at 07:48:54PM +0530, Naresh Kamboju wrote:
> > While building Linux-next master for arm beagle board x15 the following
> > build error was noticed.
>
> Hello Naresh!
>
> There was a number of cleanups and fixes to the original hugetlb_cma
> patch, and it looks like some parts were lost.
> I'm going to gather all changes and resubmit a new version later today.
> Sorry for the inconvenience.

Hi Roman,

I'm still getting this compile issue with linux-next tag
next-20200409.  If the current patch set is broken, can we remove them
from the linux-next for now?

Regards,
Leo
>
> Thanks!
>
> >
> > mm/hugetlb.c: In function 'hugetlb_cma_reserve':
> > mm/hugetlb.c:5580:3: error: implicit declaration of function
> > 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
> > [-Werror=3Dimplicit-function-declaration]
> >    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >    ^~~~~~~~~~~~~~~~~~~~~~
> >    for_each_mem_range
> > mm/hugetlb.c:5580:62: error: expected ';' before '{' token
> >    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >                                                               ^
> > Few more details about build test,
> >
> > CONFIG_HUGETLBFS=3Dy
> > CONFIG_HUGETLB_PAGE=3Dy
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> >
> > # CONFIG_TRANSPARENT_HUGEPAGE is not set
> > # CONFIG_CMA is not set
> >
> > Kernel config link,
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__snapshots.linaro.=
org_openembedded_lkft_lkft_sumo_intel-2Dcore2-2D32_lkft_linux-2Dmainline_25=
91_config&d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&=
m=3DUExtNmMVvgxP1D5SQnPuvrZmT1KYfONSBf9zENyfrs4&s=3DO436GE4UqAvqVk0stawAOhO=
Um1bNCFpZzxiVeNSs-ck&e=3D
> >
> > Build log,
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__ci.linaro.org_vi=
ew_lkft_job_openembedded-2Dlkft-2Dlinux-2Dnext_DISTRO-3Dlkft-2CMACHINE-3Dam=
57xx-2Devm-2Clabel-3Ddocker-2Dlkft_743_consoleText&d=3DDwIBaQ&c=3D5VD0RTtNl=
Th3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DUExtNmMVvgxP1D5SQnPuvrZmT1KYfO=
NSBf9zENyfrs4&s=3DnuGZRu4xyY-99ohWh1uNDTo6NeV62n7kSsyoefxEGvI&e=3D
> >
> > --
> > Linaro LKFT
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkft.linaro.org&=
d=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DUExtNm=
MVvgxP1D5SQnPuvrZmT1KYfONSBf9zENyfrs4&s=3DuYemxk7TXD2Qie6H7zY9UjuE7zlN5ILjb=
D_1UD3jo4A&e=3D



--=20
- Leo
