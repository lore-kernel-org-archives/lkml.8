Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B464C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3410920409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTmRLYka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgCZLCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:02:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35055 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgCZLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:02:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so5925541ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBYI2pw9sfGjCi0bzv0yJEEWCyqkyjizmfbFD6llCpw=;
        b=wTmRLYkaXfjcDQz+CdaZDxndUCSZxc+ZmhUW90ynmlTOSPwHaSPR/ClhO/nWxAf7KV
         4qbWZyni701zQEPh+GULzYXBJxAUVIBHjJXNvg5C3+il+bmdr2lje+8Fq7GiQ+0JtyfK
         eHrlGTE66PPY62wp1VinlnBxYkMI9JO103TdN/wSPU6ZndMqYfHMyxZNKAJ96zdibjd4
         d6P/2e2ei6EJUpHWQRRHplaPcdSfQB/WJgmBVQ0EF1EJNGJFGusx7B6eHWAMA+66upts
         /8YOfHxZHJrkiw4F/7IWsJMqiYVYzTsmxEJUtQZNq9RvgaoF57MbAqhJQ90NjUkol4Ii
         5+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBYI2pw9sfGjCi0bzv0yJEEWCyqkyjizmfbFD6llCpw=;
        b=bM/LpEmCCq5x/h0e5Kfb0nPflBVXXs0o/bRsrj/BzGW+7YE5ODt+LbdWWdeWy8DmtM
         6bq6UqcouZVm490DKQpx/dEqzag/v3NHMA5ZK3VyfEU7h1MwRKhK0e9trdCf/9wqBnqN
         Ud4E9MsVwscuB5n78s56e0FyQ+VaKMKxk0+fKS1eMacBgOTg+zkR4rwOaT4mDj4rC5iG
         AxRNSOu16lyltuAEl3L6C4dFN9R+CrERhS4bUxSnmxGuMjUK508sM+gsanMw7tX8THdE
         6Y9OhWjjTUyhGc6jEr1d6xZHU+Z0Dd+H9Fgr9QzLz2ge09EeRbw9KtwUUtn065JzQpLJ
         tj4Q==
X-Gm-Message-State: ANhLgQ2R8L1lX0A/5Kfs4t0hIEnjmKMLQTvwb7tQanpHafkRJn44SZXP
        wh1PNky4hFE6UonKuVWp0JEJfiwPLKomke0T9VYIlw==
X-Google-Smtp-Source: ADFU+vuAu4NKjgOw04+YhFG4R26tuG7+/x5c+7Ylo0beaM6wZX++zLVCej8OOV3pch4cA7VonOGw2KOeqtn4XOjj9jY=
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr4725550ljg.125.1585220547769;
 Thu, 26 Mar 2020 04:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113407.26996-1-ulf.hansson@linaro.org> <20200325113407.26996-3-ulf.hansson@linaro.org>
In-Reply-To: <20200325113407.26996-3-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 12:02:16 +0100
Message-ID: <CACRpkdYVTyViFk9CWwQsfLxsNRbinJs=wEX=th6QVH-fL_YQ7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] amba: Initialize dma_parms for amba devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> It's currently the amba driver's responsibility to initialize the pointer,
> dma_parms, for its corresponding struct device. The benefit with this
> approach allows us to avoid the initialization and to not waste memory for
> the struct device_dma_parameters, as this can be decided on a case by case
> basis.
>
> However, it has turned out that this approach is not very practical. Not
> only does it lead to open coding, but also to real errors. In principle
> callers of dma_set_max_seg_size() doesn't check the error code, but just
> assumes it succeeds.
>
> For these reasons, let's do the initialization from the common amba bus at
> the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
