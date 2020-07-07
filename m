Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D51F206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastree3d-com.20150623.gappssmtp.com header.i=@fastree3d-com.20150623.gappssmtp.com header.b="loAa2FBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGGLGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgGGLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:06:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13BC08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:06:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so37811277edm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QTMmJYpt8XeIPRCrXuUoBt4uLxoMywEnt4oaVG0h+8Y=;
        b=loAa2FBO3oZ+7T/ybIr1Ei3IJg3pbfEIFgTwxkDx2DoSADt2ssxjdUzBN2AhqU3dX5
         NEOZWvaSP3RJ0sYKGVusX55nVyP9bzOoRN3ciUUf/rd+FBA/CxNJZbC+/o1BOH8fICY4
         K628xYVAzOmF3JMYshAPVxbw9jXgsfOtj6VH1PvHAwi2RIxJyNey5ERb6VAWGDkLUb4C
         zbr52B/+5nvDm2jIXhKEyJPWwANvBLQEUxfGb2X4nJB2WXqy1z7fpZElccipAQsv5cy+
         U5VHzxoVhRhN+DoXptP/68zz7eE8Fbt4F3MBamMBZ/Aiu3ujftthWMZUY66RYXFyAzhC
         px2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QTMmJYpt8XeIPRCrXuUoBt4uLxoMywEnt4oaVG0h+8Y=;
        b=NUhy3koJf4T3B9a/VGzSs8ielR9PH5ffT/2HgHWH0HThsiZNbOJVKQKDGGymplokfp
         Yv96PAZaLETgyu8zxQgmFKeEFsfb1Nj6/WoKqoG/tezEPrKT+BEDjHzXw/Qo8x+cVylr
         VkcDyAh6CMfvbshNMeF/qRTeoJ2JFpPPTlQr2keM5Ao07FTssmDnWXangmCy9m/AMmOr
         eVH9sUWOP7UaJwdK7Elt3GpiULWkfgn3e8Hqw4Sj85AvtaZT+ySdfcEqYDLUucASynQU
         pXQSbKwZzemZn+N9kG1I5yCu7OWd0JO3Elhr5OKLXoa0BYJ0Ir/KPNUZWU/VjfQpbsmO
         y0cA==
X-Gm-Message-State: AOAM532wIdrLavYvYr+F1PDsa39fIvm4dXQcxTQR1W4/DFgTLbgDRPWv
        FbKWVhKEIuKrHiUXYbDnuop+0SC+TA==
X-Google-Smtp-Source: ABdhPJyiaXjWG/LDwij50+62W2FPlalTclwho2FyD3RPoNvnq0ePXYVdCp/Kjyn0toPqgiHQigg4Og==
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr60384794edv.358.1594119962293;
        Tue, 07 Jul 2020 04:06:02 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id x16sm25089864edr.52.2020.07.07.04.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 04:06:01 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Wunner <lukas@wunner.de>, kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706161810.GB6176@sirena.org.uk>
 <CAMuHMdXK92qO8KB6ejc6LLmfFsy=dZY18vNJGh+CKRZBAov-JA@mail.gmail.com>
 <20200707102511.GE4870@sirena.org.uk>
Message-ID: <2ed68c34-9b25-30a8-525b-aa469c9dd4d1@fastree3d.com>
Date:   Tue, 7 Jul 2020 13:06:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707102511.GE4870@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.07.2020 12:25, Mark Brown wrote:
> On Mon, Jul 06, 2020 at 09:57:53PM +0200, Geert Uytterhoeven wrote:
>> On Mon, Jul 6, 2020 at 6:18 PM Mark Brown <broonie@kernel.org> wrote:
>>> It would really help to have an example of how a client device will use
>>> this, right now it's a bit hard to follow.  Overall it feels like this
>>> should be better abstracted, right now there's lots of ifdefs throughout
>>> the code which make things unclear and also seem like they're going to
>>> be fragile long term since realistically very few systems will be using
>>> this.
>> Can't the ifdefs be avoided by implementing this as a new SPI controller?
>> I.e. the daisy chain driver will operate as a slave of the parent SPI
>> controller,
>> but will expose a new SPI bus to the daisy-chained slaves.
> Yes, that might work.  I do worry about locking issues with having a SPI
> controller connected via SPI but we mostly only lock at the controller
> level so it's probably fine.  Not sure how this would perform either.

I see your point here. I could evaluate how complicated it would be to
abstract the spi-daisy_chain driver as an SPI controller for its nodes.

Regards,

Adrian


