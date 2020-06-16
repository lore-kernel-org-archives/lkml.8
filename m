Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC02C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A81120A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ti3A4cIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFPNod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgFPNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:44:14 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450FBC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:44:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so15937510otd.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIo+HGK20axijQZBtO3IaHsxbNdFn4EANNOPWtaPaLA=;
        b=Ti3A4cILAHIDDIxgVtqdZ2BML3TZ6f6OLZGrHLBL34GXJRffClZw072wL1Qo4irTRG
         LxLWRixU8D9pdjtFCIEaBQgDWc1eiSXdOQwy7qHCS4Tp4O7FvTR+d+9heh5J1AGxv8ZF
         +uVYoUwMaD5nA7wH+WGhp0SptSU3H8NTwJVag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIo+HGK20axijQZBtO3IaHsxbNdFn4EANNOPWtaPaLA=;
        b=I6+hQBwFpGBVYBP0Rw3W70RSutZ46LKbpCuTEqVMWCmi4I6P5AzVlq2TkWU4WPyTGk
         bo1nHudjyAzYBsmlK/SOnhB20IMFGlvYTrv2wJoyo1BHIYCxOSZ8L6bOj1eXT5aCHVu2
         0Bmc/IJgzLl9Oeag43VMtWkeDmupAXaBzHN0i4IpWCeVXvvm0gkngVfLsjJnNBTuRYol
         OwBeLHrkiYxHmyNjCm+gHkdTsYWzVqkqx7P3HR4qes1bAUkQ1K9BlXxScMauNl+PliBi
         Jb8PktXj36iI/xNCFDXH0k6ZDS6c60JCHTtmhAo7/RxCMKzrNPBhekfb0cyhMnyp02R0
         bzkA==
X-Gm-Message-State: AOAM532Q7uC2Ordkb3pt+qaUr7Dbx9o3iLfZSzwtotBMo1wU1zBF89pe
        01jT6ZoJunIRhTiwLHO3htWUA2qsJO7nYfUJTSLWUQ==
X-Google-Smtp-Source: ABdhPJxAQz7lgJOkgxxD01CXUR5nj9hSTyWiOqMKGx2oXnhmOyOV/5G796JybldjApvIzMDJUn85OazsBmNrocLYiX0=
X-Received: by 2002:a9d:8b8:: with SMTP id 53mr1550777otf.356.1592315050316;
 Tue, 16 Jun 2020 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200612164632.25648-1-nsaenzjulienne@suse.de> <20200612164632.25648-5-nsaenzjulienne@suse.de>
In-Reply-To: <20200612164632.25648-5-nsaenzjulienne@suse.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 16 Jun 2020 07:43:57 -0600
Message-ID: <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dm: pci: Assign controller device node to root bridge
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Matthias Brugger <mbrugger@suse.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
        lk <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Fri, 12 Jun 2020 at 10:47, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> There is no distinction in DT between the PCI controller device and the
> root bridge, whereas such distinction exists from dm's perspective. Make
> sure the root bridge ofnode is assigned to the controller's platform
> device node.
>
> This permits setups like this to work correctly:
>
>         pcie {
>                 compatible = "...";
>                 ...
>                 dev {
>                         reg = <0 0 0 0 0>;
>                         ...
>                 };
>         };
>
> Without this the dev node is assigned to the root bridge and the
> actual device search starts one level lower than expected.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/pci-uclass.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Can you update the tests to handle this case please?

Regards,
Simon
