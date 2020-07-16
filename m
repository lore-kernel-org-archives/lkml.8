Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9D02070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NybH1tGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGPHNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:13:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23B7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:13:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j80so4643002qke.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zs7Gt4Eki014d88NMjqfrKZvUy4DLds4tQXu4hWnuKk=;
        b=NybH1tGVVKFf52NpJtonWtmx9Ghwj5V3m9qc/kA3NZvKVcjzT44e7AUAaEy3IFlCnA
         UHxMGWaXx+JcfyBceYg4xCzNylxgzNmN1wNgEuXZwOqKRd+UY89DaCNkEbL7kln4/JMv
         RjE4esZa+kgTY3689+NMRU9KFX90c18GJX1oyly8WmLRvDlno656Mo/cq9sFLSZEwxpc
         ROaMxTKI31bgVxquQsGTnNzw0DC8r9PrVJNjYPmYL58bO/D+BPcrh3B0Af/1TnIG/8fZ
         Kk6vZZr/Z64Pn6RekoSzgDYNqc2XhOHdHyysRZ88ARQuxHXM8ANh59PFo+5nA3IKF5x0
         s/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zs7Gt4Eki014d88NMjqfrKZvUy4DLds4tQXu4hWnuKk=;
        b=Of/LgSwcPKvm8GxVF8i8BkysVyD1c/cuDu+DRP6VZfbtHEWVuJde7k7nxipkRBCt+n
         xRSwcNWASBC0uz8RzGCBonirj5h9YpsZCI4Q5+BjbQJ57AVXMtFtolDh7Fc2oTcovU1m
         2D/71v6E0mOE11mBnAaNmgJGvC/39MbVsAiBw7kaycEgBX/BecZq3U3W8hSDbYmKsqGX
         u1sOUKZWTr80ZeXWK0yrlxQoEF5aJDHOaB5T4Ue6TZ2GjkQ0wA27B4k3FTvzkZIN6DrE
         h4LG2nsf6ulpCltYGD95eVYVlpJuhvpRIzypOZ+3VIgc4WBbQ68tW1JgdkhcVd0HxYP2
         +jSg==
X-Gm-Message-State: AOAM530FFtgG5BLjr8Ok08cJwFE+Zd7jNXk8wZ+2xIPtL3P1AbXRfjlo
        UodZmyAurg5R9qPUTPjS+2b/3izyMnVRYrTUgIs=
X-Google-Smtp-Source: ABdhPJz/RGyY7dKIjxqHpS5FW02kHlOUUab894JANmN0pOvxbCQzDnvIpC8zgWRfIas5E721z9IpZNqFD/FCcGBYGXE=
X-Received: by 2002:a37:a68a:: with SMTP id p132mr2689649qke.184.1594883629102;
 Thu, 16 Jul 2020 00:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594880014.git.zong.li@sifive.com> <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
 <CAOJsxLGHNd1DcStOALkQkcg8u25zj8Hpf0uF1kMj+uO127q+yQ@mail.gmail.com>
In-Reply-To: <CAOJsxLGHNd1DcStOALkQkcg8u25zj8Hpf0uF1kMj+uO127q+yQ@mail.gmail.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 16 Jul 2020 10:13:32 +0300
Message-ID: <CAOJsxLGfKzGfmA6kGds=n54SORq_=E+SgCoOPzMcsBJnVFeZRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: fix build warning of mm/pageattr
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:11 AM Pekka Enberg <penberg@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 9:16 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > Add hearder for missing prototype. Also, static keyword should be at
> > beginning of declaration.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Which prototype is missing?

Aah, never mind, you mention them in the cover letter. I think patch
description would be a better place to ensure they end up in git logs.

For both patches:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

- Pekka
