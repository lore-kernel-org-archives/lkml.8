Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0521C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BA824655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bZ/wRpPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAVTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:50:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45336 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:50:01 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so458285ioi.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XE7/hAeYrBhQF6sVXnevM16644WLVXjiFoETVe+XjZA=;
        b=bZ/wRpPICWfuWr1XYJvti8fIxacyBeuZmg7Ir8c968UixFzMtUPiE5uK3FfretQkg2
         l2J6Acl95yd0fB7FE+IaJ7UZXkRi5ainsgCeYRmebGnxE9xl6xY7sKLqLKRmCJlvDgMb
         sixoCcIv1vz6OXcl0hAd192DNDU6TVaUGtTUa3WJUrlpIqaWTl4tNCmiIAwK9MxIkfb3
         mPYTBm1BIMkGYLvka7lvpBfLYQPrQN/GGFZvAAMQVWzanxt62KIrMZVRb4aoxh/2tw1R
         n4KPdAhv2Fa5MLN8IwsU7KiUxrVeu5s0aFDAWjcbviiU1KuG06KPIDjgyDn8Zo1Fvqr4
         /yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XE7/hAeYrBhQF6sVXnevM16644WLVXjiFoETVe+XjZA=;
        b=oj1gmKKOeMhHADqV/H4XXBXrimrCRZ6WJtR5ezDtA42iLeyn8VeDNR0hY50spuZgQZ
         MtaYcL67xvFmEA8ag4DJumw0y8VukjZHtmJlk9ytjn4C+dXyzW6xhFwmRpOcJvA/raBb
         WrlfPlCezfdRixq1i+GRgFz/4Zi1j1cUkkKFIBJRYmiTA9wS42QXUVSk9ghXUKoI2j+Y
         GW9GblRlTHyrUvzIoJiHg3fmPA0wzwdtEv/WaJtLwn2nKeCNXXOQ8EghwikgbGZ7OsyV
         4PqEo2V8hFNny2gTkxXh+UB5DzNhEdlkbupHhY5j1s8xah8O41niUcLi0e+f6u1P0ed4
         KmlA==
X-Gm-Message-State: APjAAAUyEuQA86IAJfdIlGyalgHTx4SQCa8cGvg9PdX4B32vMwCASY5G
        6IYloHvnqmWyQ1h+m+4RUELvcQ==
X-Google-Smtp-Source: APXvYqzh/r4DbiV9EsamRPst625uR6XO0ZpBhDvW+aHXCTSvKfeXH9rK3zM+5mnmdMs4kQ1p8GfAmg==
X-Received: by 2002:a05:6602:1233:: with SMTP id z19mr7903174iot.89.1579722600606;
        Wed, 22 Jan 2020 11:50:00 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b145sm10955534iof.60.2020.01.22.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:49:56 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:49:54 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt
 machine
In-Reply-To: <20191203034909.37385-5-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.2001221147260.248939@viisi.sifive.com>
References: <20191203034909.37385-1-anup.patel@wdc.com> <20191203034909.37385-5-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019, Anup Patel wrote:

> We select Goldfish RTC driver using QEMU virt machine kconfig option
> to access RTC device on QEMU virt machine.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I just grepped for Goldfish through the QEMU git tree, and it didn't come 
up with anything.  Per our discussion last year: as a general matter of 
policy, until QEMU merges support for a simulated hardware device into 
their master branch, we shouldn't speculatively enable support for it.  
So, NAK from me on this one until that happens.


- Paul
