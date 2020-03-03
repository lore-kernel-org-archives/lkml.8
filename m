Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF18C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A1B20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQ7H2iVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgCCUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:53:50 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39933 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgCCUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:53:49 -0500
Received: by mail-vs1-f67.google.com with SMTP id a19so3362925vsp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI+3uqtALMSmALpWLnGWke8tkMxf5efx+ZTp2G9Sook=;
        b=zQ7H2iVKiGhs1VsV1hpWcZUWXL3X5p4asnAO/kn8amUe/ygRYWOepzBBgd7DVgHR/d
         YYkJdpRhhU4B/T3+gGuEnJsvKukwb0KHk1qcCHpdkeDVN3etR+6Zb4JJHAz0rinjCh75
         FPd/KhrlB23XWHK5jWZ+cuvUoAIqQJ1ESH8gdHk8WY+2JTDLnpDKEG5mEOIefUKA33nY
         QTuybiUx53Yu68keH7MQTgTrBxazoiQlEAdSgFQJu1V/R7IQ60Gt7yFp2/TuY9qhjGX/
         PUfryvhzkSklIh7aZwS/62BbrA5pwhKxAH1exnZlCJcbPT2hYKZt3tF6W941Wj6b8xwY
         s2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI+3uqtALMSmALpWLnGWke8tkMxf5efx+ZTp2G9Sook=;
        b=crG1yjtLUVi2GBjs4W1PhJDBdodDEMBf+j8zZtPxjNHuvtQyCl9GGqX3OeSeWdkLaQ
         jgzrMXao3Km1O1tQLA4dy5Cr/t4zsLuTp1jhZq6xMMdlSPiSp1i/C+EFuMNi51X5YJZG
         lbrls+TOC4doK5r4dSN1H3LcaR02newTn0X8SLThx47SL3N1c88Lh/9+9J6SC/UJOJGr
         e+R8I3INzRdWPvkCor3MaKy8zb1FOFIUi2ctwOx0XyulVPyEcX9bHNriuH15eCsID/IV
         dfZnw8e6vbI9fOUm1v/7pw/goUdS1iCdGRUC4OJr5LAUCfiwQ6sGjjQEBhAaFHLpl10W
         XJag==
X-Gm-Message-State: ANhLgQ3LYxecmqjBwRuJgS5ggYBlAPwmFRa+FiWp200uDfT2/fES6xYU
        QANiDbm6pBfmKRx+1D0dD0AmOYKAFsRv6Ub1utjofu1P
X-Google-Smtp-Source: ADFU+vu3WUOrZlLZ0gfxuUVQ88HHcL9ESL+KhUTSd90Hqct++5Qybf7V0kW8Ce5eMdPC1a3PHUMmYFnsn6I2wcm7RlI=
X-Received: by 2002:a67:646:: with SMTP id 67mr3548791vsg.34.1583268827146;
 Tue, 03 Mar 2020 12:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20200108150920.14547-1-faiz_abbas@ti.com> <7edb2c28-11fd-e282-a8d7-e61aad8cace2@ti.com>
In-Reply-To: <7edb2c28-11fd-e282-a8d7-e61aad8cace2@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Mar 2020 21:53:11 +0100
Message-ID: <CAPDyKFpxVXqtcTC1oRfHxNy=mBHhR-jhOu9VrT86-_5NV2dv9A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update phy configuration for AM65x
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 20:11, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Uffe,
>
> On 08/01/20 8:39 pm, Faiz Abbas wrote:
> > The following patches update phy configurations for AM65x as given in
> > the latest data manual.
> >
> > The patches depend on my fixes series posted just before this:
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=225425
> >
> > Device tree patch updating the actual otap values will be posted
> > separately.
> >
> > Tested with Am65x-evm and J721e-evm.
> >
> > Faiz Abbas (3):
> >   dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
> >   mmc: sdhci_am654: Update OTAPDLY writes
> >   mmc: sdhci_am654: Enable DLL only for some speed modes
> >
> >  .../devicetree/bindings/mmc/sdhci-am654.txt   |  21 +-
> >  drivers/mmc/host/sdhci_am654.c                | 247 ++++++++++++------
> >  include/linux/mmc/host.h                      |   2 +
> >  3 files changed, 192 insertions(+), 78 deletions(-)
> >
>
> Can you help merge this?

Apologize with the delay, still focused on fixing various regressions in v5.6.

I start catching up on my mmc backlog as of tomorrow. Thanks for pinging me.

Kind regards
Uffe
