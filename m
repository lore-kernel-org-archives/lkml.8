Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863ABC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE024655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPWd6aqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAWMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:30:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40028 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAWMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:30:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2334320wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGSddkn2oPOfmTp45og+40fbCbT5YOVg/hcLGMG+SRk=;
        b=iPWd6aqZDSVrowqY+yXr1t9T8eaRJ1u9DG41qvU1O/8NZKaepvdruPPR1G72He/3ab
         DgGnv0WNIMRDUFPC+37qhVZjcINw1xTizwvb6gP5948KHncNbjO03x2lN7Kyr27i9Pux
         I63pzRi/28bAVU0gr1Aa1lXXrvT+KZH5r3zB7YYjqctolvbmW3nCsYXepFsDnwxloaMU
         uzWlqF2sjgPrSFenojEg1eDKzz81bJYbYP6WWoDs0QtB+1ImRZOeUmVT1snmvSDlLq0Q
         kyKoS6w4efa6VYEQKGe5MOuYkO8HEOe8VJL28Lj7v9eWiUjXMNkwqZ8oFEl54l/aGAPg
         5n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGSddkn2oPOfmTp45og+40fbCbT5YOVg/hcLGMG+SRk=;
        b=BO4cFy8N+k/ubo+ImybPPhPoEvBMHG95aPOUAh9b/ZcMUILe2/K8ImHa8CV6Rk8OPI
         shouqGzJJBZtaBo80S6w+Ih8GMuI3lhR99ybHODO194PESYcXjgttCXi5Ho0jRsfjyQL
         GIGgA67EH+wdOYeZOJ+m/mVSxXZHVig3WMQDq5aU42ASOIM222olBAosZ4TIkDMU3vAl
         t6TTU5JNh5suMB1ftsaORIDUt2xocyflBALVq2tIzWGWn1woi3Uk3Felgfj7Dldqw/mw
         FWEa1iUHV612ErBwqnKZMeQRsO1QyzLQ7oclx8ZwbGWB5PpY4VOO86FuyOAV5wpbpgDz
         jSvA==
X-Gm-Message-State: APjAAAUDMvGuCYYkvNKsCoH1NhyBZYodaqe3t2RnOcVFW7RqILWPvGCo
        PWGg4txc75+A+W9vtjqhPCxW8wPI6Sug7Uqhcn+Jtw3aMhU=
X-Google-Smtp-Source: APXvYqwRdDw6IKpVxqtsb6wHOmHsoYFzKFkd0ur/MlxkxDjV/8oc+nyjFNKke74ZHCyQ/IDGPGm8XXZQ+xfwl2i5HHk=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr2273208wmj.1.1579782606500;
 Thu, 23 Jan 2020 04:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114141647.109347-1-ardb@kernel.org> <20200114141647.109347-3-ardb@kernel.org>
 <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
In-Reply-To: <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 23 Jan 2020 13:29:55 +0100
Message-ID: <CAKv+Gu-9KvzLEcNQnRfsOkU=5oc1otY_NS15fR5Oi4Z4UVvurw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 at 13:27, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > window that is backed by the SPI command sequencer in the SPI bus
> > controller. This arrangement has the limitation that only byte size
> > accesses are supported, and so we'll need to provide a separate set
> > of read and write accessors that take this into account.
>
> What is SynQuacer platform?
>

It is an arm64 SoC manufactured by Socionext.

> I'm also missing a resolution why tpm_tis.c is extended to handle both
> and not add tpm_tis_something.c instead. It does not follow the pattern
> we have in place (e.g. look up tpm_tis_spi.c).
>

We could easily do that instead, if preferred. It's just that it would
duplicate a bit of code.
