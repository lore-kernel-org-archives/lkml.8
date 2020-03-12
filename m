Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAFE2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Ka1odxjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLRQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:16:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33773 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCLRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:16:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id r7so5982409wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQJ5s9eoNFBhar1wZ/+BMG+x4PEp7qiKoL1BTIgIvvA=;
        b=Ka1odxjcRRSsZ1+P6Rn0WoEFDUeURVfcilak6U3iuZHIxRHE32ImI96XvKGoiCT0Y7
         zOYxfW2tFhqwc83KnA9LRE9Y/bECcG7knYp4dAlJcuSZ+I7KEIaRB3wcsXhJxjfiXysU
         AfHFRHk0Ue+Vz6LtljNNVf05jOc3/U5XBXJs6yw4uB8pzEy5of9iCcDQ/+jsEKLk1Rdn
         I1SB61RY0n8txp2+PVnprLtCRZmOpBLDdFcO8eT6UQTFnaNKh8ECGg5RZsdHoMNNnSau
         dBV330hv6bac+puft7f4osu2jlwoU3uhEYQAeObG+QQQvrgkMs1w3Q2AWx8CLl0tP3ud
         fSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQJ5s9eoNFBhar1wZ/+BMG+x4PEp7qiKoL1BTIgIvvA=;
        b=iiy+/TI5pSiEZiYFk+r9mshY5sfbM1aBQt4TISp3vsK3lzWCZ+gs6PxlFCroBcgwmJ
         3zXuoYojGaNytFEi8S2bIe5aJniCLD8D3biqO27tiUqNaoH+dTajdlTD+q/c9h3bcwHP
         OyRtGPFYLlaVSzRCXC9akenSgGszrgf7iP4YWE6gLHbUEDaT6awoj8vSDIa3fJXmg93M
         4PT9bGCmKIO+lBL3QiJPByP5sIQyBHwJuwuPU13tr6w3TKbNZoXAtaMcKtZJB7h0tza7
         V91j33GYryq50mHMlFToGquODxhwjLpPltuYIPDSsctg/Fkd/DCpmGG3Nnt5NofQYYEe
         ds/w==
X-Gm-Message-State: ANhLgQ2rHuOhcX79GfVkgSjclIBM5AWAukl/LbqjZYSAvh8hS2JD7qUN
        MbsazXhxRY7pFa2jIs8BzDCQevsyrEjvwlp1ytjWlw==
X-Google-Smtp-Source: ADFU+vu9dcCqLenemNcAbEsZxGNAgsL5dkMGe56iFZ3uiRQSP35P55TvBH1Ty/uEmKNJhGhG9PF3mjvXjiunAlHs0ls=
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr6133594wme.83.1584033411490;
 Thu, 12 Mar 2020 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1583941433-15876-1-git-send-email-tharvey@gateworks.com> <CACRpkdb3VzOFmnZkXXopsbKAAiQ9nzsqm6fMpcsCfmuvmaeOmg@mail.gmail.com>
In-Reply-To: <CACRpkdb3VzOFmnZkXXopsbKAAiQ9nzsqm6fMpcsCfmuvmaeOmg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 12 Mar 2020 10:16:40 -0700
Message-ID: <CAJ+vNU0U9jKDoZLBdC2aRrCCQkKmWATk6G6XAzQcF03tQY9r8g@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: fix irq_request_resources
To:     Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
Cc:     Robert Richter <rrichter@marvell.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 6:42 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Mar 11, 2020 at 4:43 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> > If there are no parent resources do not call irq_chip_request_resources_parent
> > at all as this will return an error.
> >
> > This resolves a regression where devices using a thunderx gpio as an interrupt
> > would fail probing.
> >
> > Fixes: 0d04d0c ("gpio: thunderx: Use the default parent apis for {request,release}_resources")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> This patch does not apply to the mainline kernel or v5.6-rc1.
>
> Please verify:
> 1. If the problem is still in v5.6 (we refactored the driver to
>    use GPIOLIB_IRQCHIP)

Linus,

Sorry, another issue was keeping me from being able to boot 5.6-rc but
that's now understood and I can confirm the issue is not present in
v5.6-rc5

>
> 2. If not, only propose it for linux-stable v5.5 etc.
>

Yes, needs to be applied to v5.2, v5.3, v5.4, v5.5. I cc'd stable. If
I need to re-submit please let me know.

Cc: stable@vger.kernel.org

Tim
