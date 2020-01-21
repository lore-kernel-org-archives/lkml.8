Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA524655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s/rSw8mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgAUWLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:11:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35915 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgAUWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:11:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so4690490edp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x52RfIzWuhptiT6HtlO6I538NLkJPevuS3cIwYyZteg=;
        b=s/rSw8mvL48WPMh/ngVylCpVlto/w/+l5lPClTNQgf8CDydp9BA5lDSfeI1kWU6uHG
         +nNcYIO7Ec+B/37EzZnnAzaHWk8rXhIIWEpJrS4SBTW+VSPxVwoC0T2MgqNgkhyLq9ur
         sXrxGR+rzlid5R924smwd9wb1o3y6PWF9nRCkdfDNO47lnYRCW+iMnf2QUZ7KLXiiF4g
         ACFETfI7/6ZW/XcM55v/bWCZeS+noIhIpfUWyiWFshrbcEgv0qRlAoW+yD8F67NyYHGE
         IsCiVkI+FbIHz5detETS+LDAYI+hWa5kFOUTYXZysK3vuocEt4A27ojjizGTd8MpNjX0
         JUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x52RfIzWuhptiT6HtlO6I538NLkJPevuS3cIwYyZteg=;
        b=TLYYeki8lUeFr7Gw7nDdXQH2QvjzvjngbAH8KSrNcrZKbcONuOnmOPivT9YYI+O+Pg
         V+ASkD+I3b6fGknRIYGnviCFGhkIeYJIl1NPOO+GCsVLvHMR1hGVqALtet2uTKuRnaxk
         NZtuhB8tCpOmaJB8dmbTTIAAlKfAVBsH+w9owcoZfQqUdbIbERJUxJ6ekPBFxFCham0L
         l5V+DQL0bo04+FqHpfLQJtmXD8K+eB0dEh6kyBl/+lGJO6+2BEfEzQ427OGqpNPyA6co
         W6phZ2nfDr2tFyR30ZHYNwOaZsz9A8uTQ6mnj2w1Y096ldfX2D3tsqj3h0UgQn4Yh1/o
         8F8w==
X-Gm-Message-State: APjAAAU8AoGI/8p+jm8F8S0orcpUk0EwYSSHYUxSQiuKqA03uSmJ+IeM
        CMInbS3VJwB551h1OE2v+85Pi+5+FkWvoPyiqiU=
X-Google-Smtp-Source: APXvYqy2Lvp66HQg3tF0U4y7uCLYIvj+NbcFeMsCn8O5mdlF4fZ8zrHwSodtdIlnVzrkNoyj9B2fqN0+7Jg90Y1Co7s=
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr342907edb.110.1579644686374;
 Tue, 21 Jan 2020 14:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-12-geert+renesas@glider.be>
In-Reply-To: <20200121103722.1781-12-geert+renesas@glider.be>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 Jan 2020 23:11:15 +0100
Message-ID: <CAFBinCD=LTAT-HQ+wSSmLQux+W5Y6vBju6RQDwf_1t1FhZoXgw@mail.gmail.com>
Subject: Re: [PATCH 12/20] ARM: meson: Drop unneeded select of COMMON_CLK
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:47 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Support for Amlogic Meson SoCs depends on ARCH_MULTI_V7, and thus on
> ARCH_MULTIPLATFORM.
> As the latter selects COMMON_CLK, there is no need for ARCH_MESON to
> select COMMON_CLK.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
I assume that Kevin should take this through the linux-amlogic tree
(instead of someone else applying the whole series directly to the
arm-soc tree)?


Martin
