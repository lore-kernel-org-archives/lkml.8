Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D17C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001AF20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Os677kuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgGaFuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbgGaFuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:50:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE76C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:50:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e22so6777719pjt.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPQTMMuUie6XJgopmwRnDGUbsFO8oXkWbGOWjLGiBQo=;
        b=Os677kuuNvMKQYx2pXT/cjvVadrtcqtx9pUBxd76a5AQsJuD7IXHqglgWnx4ml0RuS
         mgynRnZcACLF6szDB3raYg3Bga416fU/r90Q4NnJlRsPGANHjc7gpdqh+vtxHijU8u0B
         3lTwGRJxqoUfBi7kLAyQ/Z45PXxBCNrQGWu3seGH30CeW5/d7rIqqRprhJAWsqVPbyeq
         zFcT9ljJbdXFRy12xu2ssJYeVyi/1z12UcaN4xszgG4oR3ynQFQkQ8iodBfsQi8mc52Z
         goRLFkCzZQS4w/B8K8n+L8P8k/xtjz9D9p97VQHCHjSrBfDCr3s3IWGyi/O8jADOgVdv
         AjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPQTMMuUie6XJgopmwRnDGUbsFO8oXkWbGOWjLGiBQo=;
        b=NiFjJ0eMginZVfXxyuHKBGI41JbMF1y43ZqG+t3x/Umjbz6b/wRlYuuEfrzAXQCvmS
         kttQU4A0HlLZyf5rbSumKuzNvKOKSibarN9mjrgXg1DRhoCMHEWvKd3KDeLr7PT9NVyq
         B/3Q1heFTpcclF2JDs/P7+ZOm4DHFJVpN3lo7BHEAcDQQYgicYAV2Tc6xAyOfcqxEqYi
         LYi8ikB8u989SZr8LzK6Io6CZm88xjBBq3Ei5JQ9vU2JAnlIJ44E0XOEmucuGhH7Ypi3
         uKkwcmaPZPBabjZ43ZMbZabQgUPN65edJZS9FZM+84v2F5Qc9QMVAjA1xsK8aZg2qUWY
         j4yA==
X-Gm-Message-State: AOAM532LeVcfcpy2D1vTqDw8nn34ZrfCNR+SAQvo2szAha9B6wPOH/h4
        qgvzgSqDwCECDPGb3zbKLxv66JcjXbUQmEI50LjR2g==
X-Google-Smtp-Source: ABdhPJxKv2g8sKZeB55V/Np8ZzNtHyGySCg0eNp27a92WFk7ob3lUVGsyrtY2NRfNBuyj2fhT8mxdMZAjDxcjKfw5VU=
X-Received: by 2002:a63:d501:: with SMTP id c1mr2185919pgg.159.1596174649335;
 Thu, 30 Jul 2020 22:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200730121656.45302-1-98.arpi@gmail.com>
In-Reply-To: <20200730121656.45302-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jul 2020 22:50:38 -0700
Message-ID: <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 5:18 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Converts test lib/test_uuid.c to KUnit

Can you add some more detail to the commit message? Maybe link to
KUnit and say something about why this change is beneficial.

> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>

Change mostly looks good to me.
