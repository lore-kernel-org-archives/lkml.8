Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC0C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116B2077D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1PZ8Cqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVVfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:35:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43938 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCVVfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:35:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so14510749wrj.10;
        Sun, 22 Mar 2020 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUvRLsjgwJ+TBSJqaMXvpvNSsdA9yXVRnh9TT4FaGvM=;
        b=A1PZ8CqgivPjuO/QZ6+euBAJfgsC/ssOHGCCoModfOHrSZztWqUAxe7vhdNiMlAOZn
         vAiXtWb1mzZlFNPrd6Algd++ZmZiP0dQ3ZWd5cl4uEko851Y3CS6zOriKPsPNDYYrxY7
         fXWSbPHjHPfPjltA+xNW/321IcFF/st6Rr2O1gGKCjX2u239aEv0e318IuOmPfXGIc4J
         WFXjO6sLVPq2iYpntKqQuNY0OOpeKzwl+MW9hLv+YrMEMVXi38SqNP6R3pYBNni1OPv9
         xNbHFfCl9MDg3fsDJMzuapg2wVaD0jM/AS1wzpf9zfj7wyhxFo9tkJiykL+jfGhG48rM
         7jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jUvRLsjgwJ+TBSJqaMXvpvNSsdA9yXVRnh9TT4FaGvM=;
        b=BnGwglZ2LI0a5j69ygC3Aod94awB6kw4CeVzl/7tDoBO5cGbcXd/W2H01Y/Wi8YZKc
         NNlfPf7Dyx4xWlx0rjXCa9QfWcM7ugMnX1vAk7EVB6kaEILw055H5mFhDKom39TQOPps
         rbYeZXbeDgaYLpLh0u0p91qfTlkasDmsaxAi5IVzc5pFrv/uinSBpY4zSV86Y+YW6WPi
         d7x54wpdLLbjXUgxEVOTR3dUISCAmbehVz5eS/D0lnVqmLT0FtQ/hfaeeHydQhJIYS95
         rJL9KUWel19VT7bpTqJq9D1WTOcKAAEslDpLTIz3TaHCAJZvCZgm1VwryYwE2oWx+KoL
         KIFg==
X-Gm-Message-State: ANhLgQ2d476rk8+U4nBVuPqqZI6cLawLOhMQmc2ynCZlKw+Py6T3Wqy+
        9GPMYVJy687Ac8w6kU/3dXRFjCwG
X-Google-Smtp-Source: ADFU+vs/UqRKUb6mnTli6Cz/Ljj+yBgtW2UDmVvs9r6D1dAKnUwIHF+S6SYh907fpFX4LRzPt5C16Q==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr1902468wrt.149.1584912922434;
        Sun, 22 Mar 2020 14:35:22 -0700 (PDT)
Received: from [10.230.186.223] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 138sm19234524wmb.21.2020.03.22.14.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 14:35:21 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware
 binding to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
 <20200204235552.7466-13-f.fainelli@gmail.com> <20200206192333.GA30325@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <47e12841-d9bb-3204-76c0-5bc0ef74b094@gmail.com>
Date:   Sun, 22 Mar 2020 14:35:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200206192333.GA30325@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2020 11:23 AM, Rob Herring wrote:
> On Tue, Feb 04, 2020 at 03:55:52PM -0800, Florian Fainelli wrote:
>> Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
>> Verified with dt_binding_check and dtbs_check.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
>>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++++++
>>  2 files changed, 33 insertions(+), 14 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>> deleted file mode 100644
>> index 6824b3180ffb..000000000000
>> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -Raspberry Pi VideoCore firmware driver
>> -
>> -Required properties:
>> -
>> -- compatible:		Should be "raspberrypi,bcm2835-firmware"
>> -- mboxes:		Phandle to the firmware device's Mailbox.
>> -			  (See: ../mailbox/mailbox.txt for more information)
>> -
>> -Example:
>> -
>> -firmware {
>> -	compatible = "raspberrypi,bcm2835-firmware";
>> -	mboxes = <&mailbox>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
>> new file mode 100644
>> index 000000000000..db355d970f2b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
>> @@ -0,0 +1,33 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Raspberry Pi VideoCore firmware driver
>> +
>> +maintainers:
>> +  - Eric Anholt <eric@anholt.net>
>> +  - Stefan Wahren <wahrenst@gmx.net>
>> +
>> +properties:
>> +  compatible:
>> +    const: raspberrypi,bcm2835-firmware simple-bus
>                                           ^
> 
> I need to check for spaces with the meta-schema...

I believe I had tried to use:

const: raspberrypi,bcm2835-firmware
const: simple-bus

but this did not work, and I had to resort to doing this.

> 
>> +
>> +  mboxes:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> 
> Already has a type, just need to define how many items and what they are 
> if more than one.

OK, thanks!
-- 
Florian
