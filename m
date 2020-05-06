Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FA020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwDrngzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEFFdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgEFFdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:33:40 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC37C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:33:40 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e16so364705ybn.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxykVaThalWy+W/RBmeDI+Hdof9R/cQbDKxbUTqIEM0=;
        b=JwDrngzGzQaHxQ3b7w03CpIDP6hDzeFF/0ELYYXK23OXV9/8bqEUeQH6WENg0kY5Sd
         fUMEfJdTMQiX4nGOFOUmAjkgmCo0YXjc2SmAaSFDpn7KbfxhaDsrG1xNLo5tKV6A7jN7
         XHk3phR8JJ4e60twlCo+IKNks2GnKxaJh6Da3xrDn4n9KfKB3Thq8Q9bWCWuu7En0lAB
         vTDKteNupyn+s7mwIwNlJXNfdhlWk6IsW39w/I3fyZfdQhNu7MFC5P5d5yIhL1QiEycU
         LVfxy5TX2yfRRL8KhPTB8TM24KVtF02HBc9zZ6oFn+hfIFc58ZRu/8ZgIdDH9+GgtBXb
         0VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxykVaThalWy+W/RBmeDI+Hdof9R/cQbDKxbUTqIEM0=;
        b=BInskAxY/b7mxrjbihSYqSrx5f1albVAiNqFEgh7N9xVaJgKRwtMO+vzlML7469KVt
         NB5D17e/RHAUZdSXLxn3BXig84P4c+tCQVXDBx/2DiwDsbJTNHIc7njrGJyF0GPOufaT
         WsNjrsVTXM0mD6e/RYXAQN0ElaZFy49O/TlwxkvU1QfbAsUyef/whY1JbpQd4FIIXUrh
         jqYgCvM8zgYEsC8nqBZKvg5SvK0yxsutJEmKx5RWsWcM7fzdMRUf6tCASH7Y6vANKsDu
         0Vus8sT/sJrLNl8QNnnJSQi8QCl2VvpTepvUzzTfSSR/k26CgQ3mfhQ79eS3DVxk9A2Z
         V9VA==
X-Gm-Message-State: AGi0PuZ6WA3Fvjv7m+G0+H78JmyIRq03OO4EEXoKY74AHFIBK/ubyVYB
        lK179RW5r1Q3Ps7PerGPrPvk+TuAL45WGsKUWyE=
X-Google-Smtp-Source: APiQypIS3uec5wwcorLYtSCMzlLufQ7uozL+gS9rxwGKORMmhztVrmFSByYw7WY5wS2AeDkJk+neYOBnz51E/BWUQOY=
X-Received: by 2002:a5b:383:: with SMTP id k3mr10816210ybp.332.1588743218448;
 Tue, 05 May 2020 22:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200505162607.334-1-nsaenzjulienne@suse.de> <20200505162607.334-2-nsaenzjulienne@suse.de>
In-Reply-To: <20200505162607.334-2-nsaenzjulienne@suse.de>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 6 May 2020 13:33:26 +0800
Message-ID: <CAEUhbmWOQNDeStd3oDFTveiugzDG0zf0X1ybSWeCSP4QStNcPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm: rpi: Add function to trigger VL805's firmware load
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     mbrugger@suse.com, U-Boot Mailing List <u-boot@lists.denx.de>,
        Marek Vasut <marex@denx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, May 6, 2020 at 12:26 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On the Raspberry Pi 4, after a PCI reset, VL805's (a xHCI chip) firmware
> may either be loaded directly from an EEPROM or, if not present, by the
> SoC's VideCore (the SoC's co-processor). Introduce the function that
> informs VideCore that VL805 may need its firmware loaded.
>

I still did not get it. Without the firmware being loaded, does xHCI
on RPi 4 still work? What exact functionality does the firmware
provide?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
> Changes since v2:
>  - Correct wrong function name in comment
>  - Add better comment on rpi_firmware_init_vl805()
>
> Changes since v1:
>  - Rename function so it's not mistaken with regular firmware loading
>
>  arch/arm/mach-bcm283x/include/mach/mbox.h | 13 +++++++
>  arch/arm/mach-bcm283x/include/mach/msg.h  |  7 ++++
>  arch/arm/mach-bcm283x/msg.c               | 45 +++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>

Regards,
Bin
