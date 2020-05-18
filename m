Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8724B20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTCaHa41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERMvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:51:07 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C970C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:51:07 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l15so3575038vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3BUSKbo828h2E1EKD/0gfSxmOX3Dp5mHkq+oGuT5sI=;
        b=oTCaHa41n3YsHvrUG3Lxk+lujs7RebbyKCNZ3sEbVUV/crDFTEKHeGz6fw9MAX2JfX
         ORwZBLb3PzGSOed7tDwbzYuos6/X0oHYuUCkA6iyZqGIUr5Gsf7g/RP/DTfEIc6HQixT
         HrTYr1bK2AJ8HeZkCpdw4vTP6xA8sFJdQZhhbI9SEy18qjBfCx+vOpG8Wk7iSpg/nH7d
         0IkjOkpuRneLILNLn3TctQD34kabBXD/Badd5aZRjm2dcB0DzpjARh7NpDENhdCYn/tT
         Z7qpWJbhsGthWk7p0ILhMPdetX7sw0fJ1FViHTBDwSDvrldIh0/Mn4JzgPYhkSPnqxHX
         LFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3BUSKbo828h2E1EKD/0gfSxmOX3Dp5mHkq+oGuT5sI=;
        b=EIm8WigGSvIZTBfKKGV32iGjWCMhL9BTcCFtTHK6Fh/jjtPBHw60gQVBlZZV7SHT6V
         +c27wLlYrQxINJxHgn0cZxbn89d8YikpBQWhT/dd27saj8NeoRqTkdJ19YwJhgbJR9TQ
         EDy7I4DMMUy7zvsfz65sLqy6sxe1b65tCNBUuscfkESgTh4lejVYnCrGNne4gZZCGnJ+
         MnwW6WCLUTNEh9wvBQrN1EVgT6CPiz/LD89PIjh4b3/XgYHT+QDpo+dV5DOirNyd9TS6
         zVyIp+3JpqE3TKq2t45LsjJyruCFXfjQr3CNMOCFgMzl97n0IdlPEq+6NfzkolWkZgPz
         K0FQ==
X-Gm-Message-State: AOAM531Ig7jRgFJTdY2/gdkv+pNZkocsEmWnMQ0NxZ0FRCa0fuUUpAaN
        HjLFl0yLAyeJIEkWjKeJkeYwyM5yE42ay2xtUWIUpw==
X-Google-Smtp-Source: ABdhPJy51OGGplkyUbHUeHsNQH1b7HeY7QZvnWmpssXL38U2Xe6u/GNafSzxw8l5wwGBugpr0QHWMT5mAJVAQf8bE48=
X-Received: by 2002:a67:690e:: with SMTP id e14mr4184975vsc.34.1589806266292;
 Mon, 18 May 2020 05:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588772671-19675-1-git-send-email-sartgarg@codeaurora.org>
 <1588772671-19675-2-git-send-email-sartgarg@codeaurora.org>
 <CAPDyKFo0CabC_O-NusH4tUzjnG37_XQhY=QNhgnkQMoTokfaQg@mail.gmail.com> <4db354d7-fff4-048e-dde5-647e8ba89a7d@intel.com>
In-Reply-To: <4db354d7-fff4-048e-dde5-647e8ba89a7d@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 14:50:30 +0200
Message-ID: <CAPDyKFqN8CeniJq5S9zCdYYR38DFyk0vKnCw3fi548tXvwbseg@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: sdhci: Introduce new quirk to use reserved timeout
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Sarthak Garg <sartgarg@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 13:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 18/05/20 12:39 pm, Ulf Hansson wrote:
> > On Wed, 6 May 2020 at 15:53, Sarthak Garg <sartgarg@codeaurora.org> wrote:
> >>
> >> Introduce a new quirk for letting vendor drivers to use reserved
> >> timeout value (0xF) in timeout control register.
> >>
> >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> >> ---
> >>  drivers/mmc/host/sdhci.c | 3 ++-
> >>  drivers/mmc/host/sdhci.h | 5 +++++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 1bb6b67..07528a9 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -967,7 +967,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
> >>         }
> >>
> >>         if (count >= 0xF) {
> >> -               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> >> +               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) ||
> >> +               !(host->quirks2 & SDHCI_QUIRK2_USE_RESERVED_MAX_TIMEOUT))
> >
> > I don't quite get how this can make your variant use 0xF rather than 0xE?
> >
> > To me it looks like an updated conditional check to print a debug message, no?
>
> Probably need to introduce host->max_timeout_count, set it to 0xE in
> sdhci_alloc_host(), and change sdhci_calc_timeout() to use it in place of
> all the 0xE and 0xF constants.

Yep, that seems like a reasonable approach to me as well.

[...]

Kind regards
Uffe
