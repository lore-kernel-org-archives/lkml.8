Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F20C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE607206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiPs69xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCLWpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:45:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41673 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:45:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id o10so8376274ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZeV6SGwYz2oD3/6K0sLROfW8IF3ilKt8DtskElDrSY=;
        b=oiPs69xdfQO1PidLik8ECa+vZDnXjhz4IA9cfdIrSFWeQSVkq3f6Vuqtg7nqOSGpzz
         aPWaBfMxN76W6k+YcI62A04x9LTXaoGqfRVdTioZMtxmFIZ2XX/m9C8hi/X99aUXJ914
         9ZtRAdysFJjEsfngds8YFemQQIhGyWn7G4Y+IJL3vZL9RHKV9oZAdCdRXkqabn6itURW
         KehVOuHkxHYZ9iwT8WXYqXYA8GHnZmhc1a05rnJWy6NO2Zi4yA063X/yFhLO6pNOpfVR
         Nonz5KsXWFXaNuIPo/oM14mD6mg9ict9ghMTx/DvkJzdTyQWtVsc+S8eNXdCJTm1ZqhJ
         Kd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZeV6SGwYz2oD3/6K0sLROfW8IF3ilKt8DtskElDrSY=;
        b=stum1973pT3H69rnOMhK/X9t3lMV8/pKFGKr+4LWen6RKAlmPPSRyOhZRUy2YR04Nz
         jKCkqGjj0DlHMKqIs4lCUAaP9gtWzqNZHJqlwmqfjMue0nys+wRQSrf6PbvIPGYoKOgc
         pc/4YB8G62J4zqhLdNqIHFpINQDFqlpwQVKi5KiUtX16AH9Rn53PK8JZ1wADhwSuwufL
         uP4cEUf+Np+HqbfInB4b53hPJM9SVU1VXhJ+IUp7RmSPSz9Pld4Acyk4EWEDNMwROWUp
         wFqovIwbFQBu6PrO1kl1mPvxqizYXY79QEhcr4L2OPsboQcz0jBi0NJxEw6QRkNrRsef
         S7EA==
X-Gm-Message-State: ANhLgQ37EB5cXqbMuHfxaz8diGAZxeEDKnpWj6cy7WGzsxWwsjpaHxWA
        DEehp2X084/07JA7mbEMIME4AdxaNmlZEMmfDk57hA==
X-Google-Smtp-Source: ADFU+vtWfdH9h+8ouBw1URtkmc7DSWqDje0HNsyXDSW5sqzgoSdTiC3LGQo1g/WEOkxlBaUBFPb4j6lbqK8aPWb9ouk=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr5954798ljk.99.1584053130191;
 Thu, 12 Mar 2020 15:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYv0U0RmT7snp+UejEXecq4wLkhc11DUniUfGYAgyXC=A@mail.gmail.com>
 <20200312190202.GA110276@google.com>
In-Reply-To: <20200312190202.GA110276@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 23:45:21 +0100
Message-ID: <CACRpkdZrSHTry1fmFbrAAwbVu_zi1oez-uD5-8RtOVL_H54O+w@mail.gmail.com>
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq correctly
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Aman Sharma <amanharitsh123@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 8:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> IIUC, in the link you mentioned, Linus T says that "dev->irq == 0"
> means we don't have a valid IRQ.  I think that makes sense, but I'm
> not sure it follows that 0 must be a sensical return value for
> platform_get_irq().  It seems to me that platform_get_irq() ought to
> return either a valid IRQ or an error, and the convention for errors
> is a negative errno.

OK I see your point.

I would be fine of the code is changed from:

if (irq <= 0)
  error;

To:

if (irq < 0)
   error retrieving IRQ

if (!irq)
   error driver requires a valid IRQ

To the driver (this one in specific) the IRQ is expected and
necessary and I think it holds for most PCI hosts.

Yours,
Linus Walleij
