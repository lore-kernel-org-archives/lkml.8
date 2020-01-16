Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D61C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD02075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcUfr3hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPOkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33941 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:40:19 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so12810644vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVQO80ZmgaLsK5SVdN1FDX2hyqLJhElGwfGo54txvt4=;
        b=RcUfr3hUI71dMs9AL+OXED+c49u8UCiFdwxEvywYPAAVapfhnCCvTjFeVRG6syC2J+
         sNK8jVmCRUXOeE9kJj3O+Sbcf97Tb76OD5OIirSobYnj6KQlMk2ho+gCGoJH+RmjYAwY
         i/OUl3HrKUHXC34sg85oKI3sXRMVQjufqKzsawO/o1SI1vEs5VSLmNEFAJF4vUJLn/Qf
         DgXCWLdvBwYVCzBC4MoY3gcfYPmAZNFAX6oyhSvcQOiIJU3sSCZ77+wcw+ugP7EP8wf6
         pB3k81JBuWOAIl+eLfkI67UTi3j5cWIRq2AgIto+7Mhdhf84KDjP3Ab005lMdYZuQPyu
         fLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVQO80ZmgaLsK5SVdN1FDX2hyqLJhElGwfGo54txvt4=;
        b=PKXPIFTEn6mqJgVbeaJvjwApk0mWdMUTdqgXLd9BcAD/ofwlRutC5EeIZwSKUgjPBb
         yDsvRVsjf5T6ZFL5jawupNhxthO2/IW94ISjonkGwo4mRjVBk/hzmiSApH9vDBAc9XLb
         4DtIFdHNOL2qzWZShVAsicYVz6z6SPkPRRzMPhh2w1vWYKN+CR47188KoG1dEBepspOY
         6ZkRsqqjNrl3cNnsdXDdG4UsG3D9HNmMwvo3eZOqDdfdXOzEG5aTTZBjDdm1IcFLLkFO
         jsxC17CVpYvCNyadWcQDK8wLYHXERmdxUcwqjbIQVe6IkgNJVCV4IT0bRfENvaurgwp6
         FdYA==
X-Gm-Message-State: APjAAAUXB0gkfeX9jV7RM2M1L8Kpz8/g6scBWGn4L+iMVCpqH4r3tqMN
        cLVBwi9uppH/Jdyiu7j50A3TMdTnq/Vt/+pwmqIwyw==
X-Google-Smtp-Source: APXvYqz/74oGF530TxKb4QKLNFX7XwlPMg1LAiIfTjE49UAVZ23Wq0kjUgscpGUJBPBJMHgRJCnhpMHEreQKOQzRO48=
X-Received: by 2002:a67:6282:: with SMTP id w124mr1648211vsb.191.1579185618552;
 Thu, 16 Jan 2020 06:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:42 +0100
Message-ID: <CAPDyKFr++v905hz7+DweJNwa5K=yK8AJA=N2KhV6b62QXbdAtw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: use true,false for bool variable
To:     zhengbin <zhengbin13@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 at 08:25, zhengbin <zhengbin13@huawei.com> wrote:
>
> zhengbin (6):
>   mmc: core: use true,false for bool variable
>   mmc: sdhci-tegra: use true,false for bool variable
>   mmc: sdhci-msm: use true,false for bool variable
>   mmc: omap_hsmmc: use true,false for bool variable
>   mmc: davinci: use true,false for bool variable
>   mmc: owl: use true,false for bool variable
>
>  drivers/mmc/core/core.c        | 2 +-
>  drivers/mmc/host/davinci_mmc.c | 6 +++---
>  drivers/mmc/host/omap_hsmmc.c  | 6 +++---
>  drivers/mmc/host/owl-mmc.c     | 4 ++--
>  drivers/mmc/host/sdhci-msm.c   | 4 ++--
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)
>
> --
> 2.7.4
>

This is silly, it doesn't improve anything. So, no thanks!

Kind regards
Uffe
