Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9726FC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F94720720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAOCJDy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgA2PAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:00:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45823 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgA2PAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:00:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so5943899wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=izVbuVQfKjxlDiWpU3YFz1uZ6NyAhFYTQIwypULO3vE=;
        b=jAOCJDy7b+3jbarX0d8qXICDRSDylbN3qzBXUI8v23ZGpTQVbn6DyL60cgqzP/sHRD
         jHENIlTIZmK/3bANbEVuZjD519GTMC7EdKqOK7/jBPh2VK3lPyXLv4at1yR9S1YqsXnT
         s9MmDg/bDWEr9Zg6zBfgON7qHLaoDf9T47ZNmGVLM3RaGDcPBDKQ3Nwu59ZUI36uLYly
         CIP5g0MNuiIg9rOTNdLkXEkXddsnxaQf7gdgfZ+wqDFpFB2HCwfkL0axKLMHPpOAnaK8
         mzU1EecrudoQCDTi6RNmkSVmWI2/fXACqKsi+oMSTLYvKJfGWHfympKi6x9fFzhJ38Id
         AdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=izVbuVQfKjxlDiWpU3YFz1uZ6NyAhFYTQIwypULO3vE=;
        b=JLKKlj4B8P/gYf8B+Kc/WWqoe4Wy/fkSTwa2UzIkJr0di4U9A0lwM7/2ZU/ecS6n6w
         yYZH92gI/NXZZefoFDqu7q53ogperGileaHZxDQXKkiQ+RL9Diu95EhSknZ67VJywZiL
         F58TF0GWHkbeLYL6YcuXRK4nynZqVOyhJ/yLJ+W97VRC9MbirtHSK2osK/GqgAvNl5ZJ
         s8sNq2g2gDbMpAwG+elDFfSnWI8titobRC0KwM5lf82eveEXEKHaC5DtkOSKG2iZbAR4
         gcX97XWwSp97JtXvsk+86VVGjQ65eaD37n/l3OC70Bo7peCJIRopThb11mBdQ7AlVuHm
         Ds9w==
X-Gm-Message-State: APjAAAVndfafgb0AO5qDGRSR11e2B2sWCL4pTU5+pdZBdDRTuSdmViVJ
        IjEEoE+I0T4ZEIwJ6GhtcTb9bw==
X-Google-Smtp-Source: APXvYqwb5lM57o59SrwocyymNrtibeNLU9G8DkQ5nCCDlcJxe1cbV84jEra110J+DHdFaEONXPuKYA==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr37387337wrj.357.1580310020461;
        Wed, 29 Jan 2020 07:00:20 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
        by smtp.gmail.com with ESMTPSA id 18sm2492646wmf.1.2020.01.29.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 07:00:19 -0800 (PST)
Date:   Wed, 29 Jan 2020 07:00:19 -0800 (PST)
X-Google-Original-Date: Wed, 29 Jan 2020 15:00:18 GMT (+0000)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v4 0/6] GPIO & Hierarchy IRQ support for HiFive Unleashed
CC:     yash.shah@sifive.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, jason@lakedaemon.net,
        bmeng.cn@gmail.com, Atish Patra <Atish.Patra@wdc.com>,
        sagar.kadam@sifive.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com
To:     maz@kernel.org
In-Reply-To: <8dcb52c94eb5a585f6cf052c18571805@kernel.org>
References: <8dcb52c94eb5a585f6cf052c18571805@kernel.org>
  <1575976274-13487-1-git-send-email-yash.shah@sifive.com>
Message-ID: <mhng-cb360722-bdb6-4cf7-9fa7-1d92f6b6bbfa@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 09:09:51 GMT (+0000), maz@kernel.org wrote:
> On 2019-12-10 12:11, Yash Shah wrote:
>> This patch series adds GPIO drivers, DT documentation and DT nodes for
>> HiFive Unleashed board. The gpio patches are mostly based on Wesley's
>> patch.
>> The patchset also adds hierarchy irq domain support as it is required
>> by this
>> gpio driver. It also includes the irqdomain patch to introduce
>> irq_domain_translate_onecell() and irq-nvic driver patch to use this
>> newly
>> introduced function.
>>
>> This patchset is based on Linux 5.4-rc6 and tested on HiFive Unleashed
>> board
>>
>> Changes:
>> v4 vs v3:
>> - Rename the DT yaml document to more standard naming
>> (sifive,gpio.yaml)
>> - Drop "clock-names" property from yaml document
>> - Add "minItems" to "interrupts" node in yaml
>>
>> v3 vs v2:
>> - Include patch for irq-nvic driver to use irq_domain_translate_onecell
>> - Remove unnecessary inclusion of header files
>> - Use a single prefix for all symbols in this driver
>> - Rename the "enabled" field of struct sifive_gpio to "irq_state"
>> - Remove unused variables and locking from probe()
>> - Other minor changes
>>
>> v2 vs v1:
>> - Add patch to introduce irq_domain_translate_onecell() and use it in
>>   the sifive PLIC driver
>> - Drop the usage of own locks, instead use internal bgpio_locks
>> - Consistently use regmap for register access throughout the gpio code
>> - Convert the GPIO DT documentation into a json schema
>> - Other minor changes based upon feedback received on v1
>>
>> v1 vs RFC:
>> Incorporated below changes as suggested by Linus Walleij on RFC version
>> of this
>> patchset[0]
>> - Dropped PWM patches as they are already merged.
>> - Include "GPIO_GENERIC" and "REGMAP_MMIO" in Kconfig select option
>> - Remove unwanted inclusion of header files
>> - Use regmap MMIO instead of customised sifive_assign_bit()
>> - Use GPIOLIB_GENERIC and bgpio_init() to set up the accessors
>> - Use hierarchical irqdomain
>>
>> [0]
>> https://lore.kernel.org/linux-riscv/20181010123519.RVexDppaPFpIWl7QU_hpP8tc5qqWPJgeuLYn0FaGbeQ@z/
>>
>> Yash Shah (6):
>>   genirq: introduce irq_domain_translate_onecell
>>   irqchip: nvic: Use irq_domain_translate_onecell instead of custom
>> func
>>   irqchip: sifive: Support hierarchy irq domain
>>   gpio: sifive: Add DT documentation for SiFive GPIO
>>   gpio: sifive: Add GPIO driver for SiFive SoCs
>>   riscv: dts: Add DT support for SiFive FU540 GPIO driver
>
> I've queued the first 5 patches. The last one should go via the
> corresponding platform tree.

Thanks, I'd missed this one.

>
> Thanks,
>
>          M.
