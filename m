Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2661C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6BE20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastree3d-com.20150623.gappssmtp.com header.i=@fastree3d-com.20150623.gappssmtp.com header.b="MJtJazoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGFPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgGFPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:19:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5C3C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:19:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so42915678ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/xxuSBaFwBsMKWLj22wDWl27eYoU7MIEcxTocbJmKvI=;
        b=MJtJazoU44U9pCLcGCNygqUIC40Jd8PYw5hLDFzG/7qpB7d7QZGYRssWokpQfub+1f
         Irfc2f1D5mxLKLDlMwZP2s7FyDna31thh8K/r1yuY9LYuvYINuQ21vyasvwr/p+pxyWY
         CxjFxYtQGbbaDb5x4txLeJ1QTdjWnWe/4/kCc02oNKaeqKtQlDXg7MBLBuW78VZWYnOH
         QOKyknnCQRxsDLx3scBYQgh/tFWKOzEDXtkXzC7u1YqCn/eYY1n/WjDegv0rc9/4qxsp
         8GYahdbmXkaRyilNMhigDIXvq9pmTkZSW6EpizC4hQA2V0Z/A3D+LnlujfejlYX2pfGm
         0Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/xxuSBaFwBsMKWLj22wDWl27eYoU7MIEcxTocbJmKvI=;
        b=B9hbN7Vwx59ih6JCZX8rhWr/YZui3IqRVEyC4LaAmoKztZMCLjIgCXZM9tbqcXGooN
         QZCV32YZjNaMhOeoCvEp/ZYvECZNzd9fg5N3wQ/DqpPipJsVvtYl8eNkXvB0xWQFCOuM
         rE81OEysSnirgNfC2VS4Z5tATVi4MlyXza7JSuqyyem7NvRrFgxXF4ohTyBhmz8jat9J
         qof5qjylZ/7972/vMXsOie+roVQO1HuQmmmhsKPmacqo8+/XG7I24uM61pNYxzs9o1R+
         +zAvLIaUcuPow01SrICR1Ay74D1x4lqX7S2PxFhVdXxDkkW4IaeuZUmFRtURnt0tFCxK
         wxig==
X-Gm-Message-State: AOAM533SZ6MEN6h+kVgcV3waX/sT/vAqAuty7yIqtF7TMp/nhJx1PdFs
        NmQ46xX2hQuSil9I7P/JPBNMPdcD9Q==
X-Google-Smtp-Source: ABdhPJwtkXu2xRZaKI169jRI14Ab1BOD0pJ1Z6zjsYnl3WDuq/VWuYjFuv5XT2ZZ2YSQRGcFl/ARhA==
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr35109494eje.2.1594048784895;
        Mon, 06 Jul 2020 08:19:44 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id gr15sm16590843ejb.84.2020.07.06.08.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 08:19:43 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain
 driver.
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
 <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
Message-ID: <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
Date:   Mon, 6 Jul 2020 17:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for your reply.

On 06.07.2020 17:10, Geert Uytterhoeven wrote:
> Hi Adrian,
>
> On Mon, Jul 6, 2020 at 11:23 AM Adrian Fiergolski
> <adrian.fiergolski@fastree3d.com> wrote:
>> Add documentation for SPI daisy chain driver.
>>
>> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
> Thanks for your patch!
>
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
>> @@ -0,0 +1,56 @@
>> +spi-daisy_chain : The driver handling SPI daisy chains.
>> +-----------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible           : Should be "spi,daisy_chain"
>> +- reg                  : Chip select assigned to the chain
>> +
>> +  For the SPI devices on a common SPI chain - nodes of daisy_chain):
>> +- spi-daisy-chain-len  : Length (in bytes) of the SPI transfer,
>> +                        when the SPI device is part of a device chain.
>> +- spi-daisy-chain-noop : Byte string of no-operation command which should
>> +                        be send when device is not addressed during the
>> +                        given SPI transfer
> The above two properties are device-specific, and the same for all
> devices of the same type, thus leading to duplication.
> Hence I think this should not be specified in DT, but instead handled
> by the driver.  I.e. for Linux, you would retrieve this from struct
> spi_device, as filled in by the slave driver.
The problem is that then this patch would not be compatible out of the
box with all SPI devices (as it's now) and would require rewrite (adding
this extra information in the spi_driver struct) of all SPI drivers
which support daisy chain.

Regards,

Adrian

