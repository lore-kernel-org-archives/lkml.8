Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CFC2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7118520740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7cvlEus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgEMItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgEMItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:49:08 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB663C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:49:07 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so9596847vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MOR1QlTjvbKcUgGpdddHANn6yzz6nycDuiauvE4gIU=;
        b=l7cvlEus3LmgvVz3Cs5oBp0AnMlNwsCBBqZF8CKqV435F0naDE6jwaOcHzDsaWeJJ4
         HxrFEP/z9/o7gqEo8Y3QT/nAKWFFcRRBkPHHoW9QcRSULhl95ctmLML1VVnNoe7zKtgT
         0gZ2Z8GLeJXaFn/CTx/HxAAt0G9IuPmTM15W7eAOcYBBAvv5UgyuKyjNc1KRTv+AxRra
         /Ux+uovN66Cxq7WjzDv4wTUjRpCUoSJdfavDnjZwzzHlx/xeSpUZFyNqZY63UOcWb+uY
         2D6gKOfpfqINndfqapVMpd6kSIEgVEKbl9RdjD++dOrGeQ3a0G4WGXHFbXNG/aUIldbd
         RypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MOR1QlTjvbKcUgGpdddHANn6yzz6nycDuiauvE4gIU=;
        b=mvI13ZIDCQ70QGyn2V5vWnqc+0DWTSRbIAOuc33ucpNnshr0et0xXed+jaGVUDKmme
         B+Mpwz6+omo1i1l/NBJgi3jrWbfoAjdzxTKoSjBRAayUq33T9C699QxDdkOQnPrSYStt
         78VY+LOgmG93l+sNTWZmj0zD9QnMmQd/uBotA7TaOJrHuM6MdWYu+x1p4cP2BmiHXewR
         tsHFENms+CMyGN54n48xdXWP7UZwjI8xEYI/qK2AHKdU+pYagzrNv3lhW4KIvDpjDFSA
         5gQpSAkyi1sqtyE1jIOG4ZrxQToQ3G0JOxZdVTDTgfCSCEx9GBHNYHCErxIzSERKxHZa
         e9ZA==
X-Gm-Message-State: AGi0Pubs0YqEOXUFkQa1jyT/4J/M1/i8lpi22XpRiqQM0tIdnvBZC9z+
        UMh2zxVhlkAhJ/UR+uhgEsaoVcAXpRobyFfzzTA=
X-Google-Smtp-Source: APiQypJvumPBj1SR9Bld5LMayu2uajBDS8z7VCc4d2Lh6exjKb+qeKC9R/SIamu+ZxdOASxGEtnrY0ugUQZXDmDIYQE=
X-Received: by 2002:a67:ffcf:: with SMTP id w15mr18426239vsq.213.1589359747093;
 Wed, 13 May 2020 01:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com> <20200513070847.GM2571@lahna.fi.intel.com>
In-Reply-To: <20200513070847.GM2571@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Wed, 13 May 2020 09:48:55 +0100
Message-ID: <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 08:08, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I think this one should contain KernelVersion as well, see
> Documentation/ABI/README.

Thanks, I'll fix that up.

> I think you can always include this header without #ifs

Thanks.

> >  static struct resource wdt_ich_res[] = {
> > @@ -221,6 +236,16 @@ enum lpc_chipsets {
> >       LPC_APL,        /* Apollo Lake SoC */
> >       LPC_GLK,        /* Gemini Lake SoC */
> >       LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
> > +     LPC_SPT,        /* Sunrise Point */
> > +     LPC_KLK,        /* Kaby Lake */
> KBL for Kaby Lake

I can fix up all those, but out of interest how did you "know" the
right three digit identifier to use?

> This is not PCH, Cactus Ridge is Thunderbolt host controller AFAIK.

This was suggested from someone testing the original spi_lpc.c code on
a macbook, I can remove it for now and work out if it's incorrect
later.

> For example these PCI IDs are for the SPI-NOR controller (not LPC
> controller) so this causes this driver to try to bind to a completely
> different device which it cannot handle.

I'm really wondering if drivers/mfd/lpc_ich.c is the right place for
this kind of "just expose one byte of PCI config space" functionality.
Certainly drivers/platform/x86/intel_spi_lpc.c is much simpler, and
would also allow me to do some of the chipsec tests in the future --
for instance if BIOSWE is unset but BLE is set, try setting BIOSWE and
check that SMM clears it back.

> > +     char tmp[2];
>
> Wouldn't this need to account the '\0' as well?

It's one char ('1' or '0') plus '`\0` -- no?

> I think "spi" is bit too general name here. I would expect "spi" to
> actually refer to something connected to spi bus and possibly coming
> from drivers/spi/*.
> Perhaps "bios_protections" or something like that.

Sure, that's a good idea. I know BIOS is a badword now, so how about
just "firmware"? so /sys/kernel/security/firmware/bioswe

> > +     securityfs_remove(priv->spi_dir);
> > +     return -1;
> I don't know securityfs well enought but I think -1 is not correct here
> and if you want that then maybe -EPERM instead.

I will look, I don't think the actual value is terribly important. The
only time I can trigger this is forgetting to remove the securityfs
file in module unload, and then trying to re-insert the module --
which failed with -EEXIST from memory.

> I wonder if you can simply call
>         securityfs_remove(priv->spi_dir);
> and that removes the children automatically? I'm do not know securityfs
> so it may not be the case.

No, that doesn't work.

> >  struct intel_spi_boardinfo {
> >       enum intel_spi_type type;
> >       bool writeable;
> > +     bool ble;
> > +     bool smm_bwp;
>
> I don't think these belong here. They should be part of the lpc private
> structure instead (lpc_ich_priv).

Can fix, thanks.

Richard.
