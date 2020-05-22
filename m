Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED8A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FsB9N5UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgEVPgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgEVPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:36:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFEBC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:36:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb16so4910282qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=61+HQokeJZQ8qkHJ2OEdKbbtcdPY4X5ntDI2ko215XA=;
        b=FsB9N5UHSBWaHC/PI7gccIUfEYQI9QY2OJ2DpQw6NYmUIu/yS181SpbIsrMxh4tBq2
         251MX3ARNKmg1PIdHLrIfedovaTFRuT7fr6qAJ0OzP4eZ9kHh5QC9Uqu8z6t+H3RAa5L
         F060Wo09d4reWusv3yHvuVJT+swTL3Pz0DXKljhhGyA3kFwjN4C8iZYyafihOn7/z3Qg
         0IuxiDtjd4U1Id+/0zAMVIS4TwL0Ptw3vYEV4ApNhTbJ9HL4cLaRC/CpSTAqYS2lFN8k
         vztqA+6NvLDs6svcdY+jVjLfyDAKQ9YtsTkPHdPtxR9XEgWCjKhKy8Zuuz0XJ0fQto/0
         lmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=61+HQokeJZQ8qkHJ2OEdKbbtcdPY4X5ntDI2ko215XA=;
        b=dtfn49EARIslgvC7KHDaIEQIgE7W/SXHt6c0k1vSzUPaTCTLXlHkpxyCtMZGZdCWgq
         N8riM8mqlxjhINr5MzVWZpoTVRsjzA5D1SNL0bajKp8QbiqDhgRu1hGU7mzpD2y4wOCE
         6i4cRjrWE2yZp294hyDEA/E5r3jsk9nF9OR5M6rGUbqgTO9LUMKgRaQJRIp47ZAtFBmv
         JwkNRyW7kNsPsp4MSenbvWk39k5jVDUIiZ1KwTi0TKtiDCrgZNsc+X2q6kpDhhPapvkm
         sJ7KNasfc+srKO/zpZebW0AAWjQ1cgfiBRnIg+cXHbQ5WHFnhsB2T3XkVIAvei8J21jv
         3mcA==
X-Gm-Message-State: AOAM5302b3gLImDSaDXNzfVX3cdO5WxSnJsAUAg8wniqLLV+7y9y0HoL
        a/tFFgDcrpFOSyjvKNprEoeHHAwC5gPX4llaExemzA==
X-Google-Smtp-Source: ABdhPJxlFh9zM8Njqgrp9/xR4Z1brfdmQPtm73E6Mi4XIQKqvXjo8/lYWwCLTLOHbqsxApeDG9Che+ylwvNrK03MWBo=
X-Received: by 2002:a0c:be88:: with SMTP id n8mr4247699qvi.134.1590161766309;
 Fri, 22 May 2020 08:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200522120700.838-1-brgl@bgdev.pl> <20200522120700.838-7-brgl@bgdev.pl>
 <5627e304-3463-9229-fa86-d7d31cad7a61@gmail.com>
In-Reply-To: <5627e304-3463-9229-fa86-d7d31cad7a61@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 May 2020 17:35:55 +0200
Message-ID: <CAMpxmJVg3VPt7Xu0U9Qnt4wYRmT75iryMDu1qaYdoGib1bhdiQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] net: ethernet: mtk-star-emac: new driver
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 maj 2020 o 17:06 Matthias Brugger <matthias.bgg@gmail.com> napisa=
=C5=82(a):
>
>
>
> On 22/05/2020 14:06, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This adds the driver for the MediaTek STAR Ethernet MAC currently used
> > on the MT8* SoC family. For now we only support full-duplex.
>
> MT85** SoC family, AFAIU it's not used on MT81** devices. Correct?
>

It's used on MT81**, MT83** and MT85**. What's wrong with the
description anyway?

Bart
