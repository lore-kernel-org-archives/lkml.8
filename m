Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10722C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F8C217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOhTklyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgBDF3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:29:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40386 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDF3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:29:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so6783024plp.7;
        Mon, 03 Feb 2020 21:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JTvhXOHjRPPKE1y5KEW8/aayOOR/G5OH5/YprLgTId4=;
        b=DOhTklyXzP/LpRTbqkUSh0fGrsC16dg9KrqYi4kg9SyPZH7oVczGx9WSGMtlo2cXv+
         XKwrijvlcFR7DABZDV8fU8N1ALnHu9/fcEMrrWokT3nD+UuxSnySE4oGfiD3+eVXwnD2
         86bZf92Pl4HG7y305bibOcxcGNdnTg1svyzkEPW4TGAdqXDsm5qcQBon4bC7/5QkGP4t
         grQRt9LtPlHquddXWCLKWmMFAnsr/CDJnhergnCgKBF720tFdYYT0FTVKJF0miDzgSHi
         btXzSz0ESDa5NbCg+pCfg1kU0pNw4uUT/fMsHa1kwxvG5lQ/+Gq8wxNDaN8kfT1zHkHG
         wT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JTvhXOHjRPPKE1y5KEW8/aayOOR/G5OH5/YprLgTId4=;
        b=ZlMIfT5cnUT7x9aLJqGnD8ALf0R8iJ+PYghNYeQ4KC3JokFCHZ49x0TR9GVbsyvL4Q
         zewAE8lotr9xGfIm6mvIstlZ6SpYGYmVWXMsBpUGHy6zD4Ao/EQqASYerLE56KNuTs8L
         U/6m/TssuryUXANoQ3lZUmL849vC5mh0xYt9T6PR6UoxRMuNdgQVMkGWCOri+O+NoWPL
         pJ9f4HCyceNkRump8h41A1CqvvFvcrJC7NRDSjODMAzXns1Yu519WvaM5ezkzRVzyaX1
         ymiiYBGcnmN6wp6JboaV2qwMlsEAIDzDZ3FYBEJ6WHBO7igHx88P+ueDuyx553TNep93
         uQxQ==
X-Gm-Message-State: APjAAAUWPs/0ae7mp4cK51jya4VdYg5YauFitzvQ0MpU/iaQ93nyPPSf
        sbEhFbcVlxp+jtbVyPhJK24=
X-Google-Smtp-Source: APXvYqz8NvIZ76OPXRTLDnCo90QFSqV0Ohwz+80r05W5CfxOy2RMAp9cNjUKT+06BAh5G+N6JsfpBg==
X-Received: by 2002:a17:902:7e4b:: with SMTP id a11mr27493699pln.61.1580794172517;
        Mon, 03 Feb 2020 21:29:32 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y9sm961646pjj.17.2020.02.03.21.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 21:29:31 -0800 (PST)
Subject: Re: [PATCH 11/12] dt-bindings: arm: Document Broadcom SoCs
 'secondary-boot-reg'
To:     Maxime Ripard <maxime@cerno.tech>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-12-f.fainelli@gmail.com>
 <20200203083403.6wmuduxqsv7quujp@gilmour.lan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <2744136e-a6e7-de19-4142-04f7edf0c6ea@gmail.com>
Date:   Mon, 3 Feb 2020 21:29:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203083403.6wmuduxqsv7quujp@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2020 12:34 AM, Maxime Ripard wrote:
> On Sun, Feb 02, 2020 at 01:18:26PM -0800, Florian Fainelli wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index c23c24ff7575..6f56a623c1cd 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -272,6 +272,22 @@ properties:
>>        While optional, it is the preferred way to get access to
>>        the cpu-core power-domains.
>>
>> +  secondary-boot-reg:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description: |
>> +      Required for systems that have an "enable-method" property value of
>> +      "brcm,bcm11351-cpu-method", "brcm,bcm23550" or "brcm,bcm-nsp-smp".
>> +
>> +      This includes the following SoCs: |
>> +      BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664, BCM23550
>> +      BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
>> +
>> +      The secondary-boot-reg property is a u32 value that specifies the
>> +      physical address of the register used to request the ROM holding pen
>> +      code release a secondary CPU. The value written to the register is
>> +      formed by encoding the target CPU id into the low bits of the
>> +      physical start address it should jump to.
>> +
> 
> You can make the requirement explicit (and enforced by the schemas) using:
> 
> if:
>   properties:
>     enable-method:
>       contains:
>         enum:
> 	  - brcm,bcm11351-cpu-method
> 	  - brcm,bcm23550
> 	  - brcm,bcm-nsp-smp
> 
> then:
>   required:
>     - secondary-boot-reg

Thanks! That was exactly what I was looking for, it seems to be matching
a bit too greedily though:

  DTC     arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml
  CHECK   arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml
/home/ff944844/dev/linux/arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml:
cpu@0: 'secondary-boot-reg' is a required property
/home/ff944844/dev/linux/arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml:
cpu@1: 'secondary-boot-reg' is a required property
/home/ff944844/dev/linux/arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml:
cpu@2: 'secondary-boot-reg' is a required property
/home/ff944844/dev/linux/arch/arm/boot/dts/bcm2836-rpi-2-b.dt.yaml:
cpu@3: 'secondary-boot-reg' is a required property
  DTC     arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dt.yaml

not sure why though as your example appears correct.
-- 
Florian
