Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC2C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515D1221FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594724985;
	bh=z0OY3Bi/qrA2I/TTuCzgD3vQdt5c7DkNapFQwkQQDXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ek2RWnFS5I9foazN249tVoDR8IJdxmGY8HD2oAd3JzuBgIeH+PcpScV2KRLhUgpT+
	 cAB4iSMqApRBxIfUy3uQWzemohuVbmQrb1AWzpKBs9bkVee9jo+jHCIBvVHF1ecoEU
	 dDBZOwBdimu0lTIV+JsG7cEdvbP12mPY4uiwdNtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGNLJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:09:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26298 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGNLJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:09:43 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 06EB9N6M007255;
        Tue, 14 Jul 2020 20:09:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 06EB9N6M007255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594724964;
        bh=s+qGqbv3CTLs4XT47genE5qR5//Xe3CqrmsU7ugBumg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CzwbZZIfQDcMPUt8+yrFFQ1YJNYYX5aHiyggE32NZTFoY0mGNbZcUtbFoyrYyOLaC
         NeM8nDqvL1gldnVGWbkj88awT+PpjhU0EInQVQoAYnRAiHsLnZL0F1YNYrdoCXXx2Y
         7S1L0KogiGrmaDY3hNB6zV87DB5p9sAlVTzGMtMG82139iRgnWqzckxlHcB8G1snfE
         RJBt/nhWklQH3KSi1rPclJUwixXjcSqpCPAu/Mekwfi4PXFvsAoD4kRjQx/Oeq1IO0
         kb1J60B1klWKM8fYcqhK6/myexiflOFp6pEh08hqEdS8vLnkn1QChiAPv5K/XLDoro
         6LU02AXqg5kpA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id k7so5530481uan.13;
        Tue, 14 Jul 2020 04:09:23 -0700 (PDT)
X-Gm-Message-State: AOAM530/B8Z72J4C1Dji4v+k3oyGS3obQUg/QX3L0bYQUnZnCefmQ1sm
        QawwvsPpZfFbni0c4W6tmI1KvopWX90aMkY1HrY=
X-Google-Smtp-Source: ABdhPJzFoQKXXaO2byKTNGZBH3Q1438vhfsydjUWOj+DZJy+tjh7hGDv32uH8oQMzIflGPVWY3CW7MQ3X206v85g4Lw=
X-Received: by 2002:ab0:71d3:: with SMTP id n19mr2734135uao.25.1594724962474;
 Tue, 14 Jul 2020 04:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus> <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
 <20200714095259.GB4900@sirena.org.uk>
In-Reply-To: <20200714095259.GB4900@sirena.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Jul 2020 20:08:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
Message-ID: <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        DTML <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        - <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 14, 2020 at 03:13:26PM +0900, Masahiro Yamada wrote:
>
> > What do you mean by Reviewed-by ?
> > Do you expect this to go to the asoc tree?
>
> > I just thought the schema conversion
> > would go through the dt tree.
>
> No, bindings changes usually go through the subsystem - if there's any
> other work on the binding then it'll usually also involve driver
> changes.

OK, then please apply the following two if they look good.

https://lore.kernel.org/patchwork/patch/1261568/
https://lore.kernel.org/patchwork/patch/1261569/

Both got Rob's Reviewed-by.

-- 
Best Regards
Masahiro Yamada
