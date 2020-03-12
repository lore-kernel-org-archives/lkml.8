Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B781420650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPO+ikxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCLOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:23:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32940 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgCLOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:23:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so6670908ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dt+A0XYoM4z0Muyh4Z1oK3OQIHOd+TenS7WS4Spt8M=;
        b=kPO+ikxEgegYspLtVJSTdDZGCrznn2iZHcCDSpipCfIKchWvbMXImnOGvH1GmkJfoD
         KcE6fvz9RgDqdCcl4OhN7O0CjnJ+M6liGFX7kS02szV8Mo1+CU8jkrhYkKZ+cX6rh0Qw
         H/nnJeTMB5ClokfZT4zcoYejI5wYd4XBiBYB1T5WDgosR4K8w/H85ETqh8BS+y3N6LvM
         5Y95Pb1xYZfEjIrgLVRhecU/tTp74SEk3Ps55TNUzCeR9gXSB6amj6Kc+BpjDlZq6zaG
         WIiIfQNErmoQIOMBgKTJD8wyx6zy8TH+bDi310hmLvyph1kUIo4otwnn+KNf7P9k3532
         g2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dt+A0XYoM4z0Muyh4Z1oK3OQIHOd+TenS7WS4Spt8M=;
        b=Bj5kKVObZ1DrRD1wBlTmKy/Tzqpcr+5PJdy6fjmcLM1BCvnt2nRyI7YKFRl5UgritY
         E5s8bnmNfSBQzgwz/LJVtEmJmGK1Y7v3afPD3Cxd3FQn3F53l6A6ZQda7setwE/sr2sJ
         l5nvv6JYxKZw80NWfkBXaezuw5CD8nDR5iup/LnYw5HkyvASLVh0035gXMudn0c3QQMP
         H44nC62/fdsU4DmS1x07XdS+k9JhRm/5VRp5bXvBVWRmEB/UL0k3f+4wsTTQB4L1eR+q
         yjz0o92WQ585TSs5YPT7ocux5okm/mgW48ThE2vPBf1idibQNPr/Y+inqU3RkxQIZBv4
         KNzA==
X-Gm-Message-State: ANhLgQ0bRFxPh4gag008VhviAU1jL9uabnFaJPCyoFfcAq0/IcKciMjv
        2O/vwZiJ2nnMBK3A0dk3bzV1gr+f+losf5D9C1AYBA==
X-Google-Smtp-Source: ADFU+vv7LNhuqWt6huv0FXgE1q4FBl/D6hN2gAx1rsopSHV4jlVMS8grUwQme6vafr3oWKM7JsBOgEJp0guAr/W7u10=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr5600275ljo.39.1584022999468;
 Thu, 12 Mar 2020 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be> <20200218151812.7816-2-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 15:23:08 +0100
Message-ID: <CACRpkdZGKB9opaOFT8Yz-tfE9vcCVeF9EvvBi7jWWuAAh3C_FA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] gpiolib: Add support for gpiochipN-based table lookup
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIO controllers can only be referred to by label in GPIO
> lookup tables.
>
> Add support for looking them up by "gpiochipN" name, with "N" the
> corresponding GPIO device's ID number.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Just like with patch 2/5 I have the same problem here that
the commit message doesn't state the technical reason why
we need to change this and support the device name in these
tables and not just labels.

(Possibly again I will realize it...)

Yours,
Linus Walleij
