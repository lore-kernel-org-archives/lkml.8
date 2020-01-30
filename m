Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4194C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858012082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2tx+EnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgA3PlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:41:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3PlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:41:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so4775735wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=IzeuyLNwcHGeqDrPxY0hfInJ/Fb4wBiuy591zoPKvm4=;
        b=R2tx+EnM5ZzTjItg0Tg5V2axHD+nEJ5NjMp2Ev7oVIqipAnp4Y0ybqeCE1+HZKApwi
         KtfNJ/pVQcuWLA5f3+oquh9bNNGdnUfvrm003U/iJwPSY9OKPQdesACoQ0vyzqmOI+ss
         ZXLtlAc0d/YLG538qIKqO9yhW3N6aTx7Cu038skXnDed81IvwIGxRMTjffMdjkcmQPzt
         riTl3yrRfqJkrWLNGsPkQrm4osqzs5qR2VNSzceFYPZxoqGgBZEOjkz5aWhlUQJBeQHZ
         FeoJcDzrcMt4Q6hVAFCAKTe53mHYD54QPk/GdByiOm2dFhH6YpuxiTBjOiOkqncMOYfw
         lMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=IzeuyLNwcHGeqDrPxY0hfInJ/Fb4wBiuy591zoPKvm4=;
        b=W2ThonSdLvILBS3RuBPTjlLf/+SBr8HDT1MUhXWHOgCC5lb2Ug96FASyWL9k1q+iwx
         GYQErRouWm14BYVmANbE+uQOmlcZtqH38rRNJTUV62bTpp//4YiJWnf2EcHNaEaS2boe
         IuSji0DRbGNUXIJiiwBlWzhAwGsx0Pgd0pVFXA3yYwqHPK86Gywl3I6D9mKAv/9rxhVF
         hf2cV7glBdupGFeTqJDnunn04KZGV4KDKPjbMKXQbctnHloPyOWyJB2BEiA2+puqd6V0
         YvotiopnbeIUTc2ZCFoRl1G3V9OrZlTnoFyZp1aht2xGA3HFrY2s1jrJcSU53oumGNNr
         XBcA==
X-Gm-Message-State: APjAAAX7WZHJFT+y9FT+Q10XvL6mCswWpmqlgAK9muAb3NCur27HBmPE
        pap230/hf0VLGVmRhlA932xFHA==
X-Google-Smtp-Source: APXvYqyqINQ1Dub9uL0itvcPYMPK8EFOKgs62EfLhNvh8oAS/swT1ioulL8RsQiM/8PP3tVGifFHNg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6326916wmi.0.1580398872454;
        Thu, 30 Jan 2020 07:41:12 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
        by smtp.gmail.com with ESMTPSA id w22sm6652544wmk.34.2020.01.30.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 07:41:11 -0800 (PST)
Date:   Thu, 30 Jan 2020 07:41:11 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 15:24:25 GMT (+0000)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v2 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt machine
CC:     Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Paul Walmsley <paul.walmsley@sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001221147260.248939@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001221147260.248939@viisi.sifive.com>
  <20191203034909.37385-1-anup.patel@wdc.com> <20191203034909.37385-5-anup.patel@wdc.com>
Message-ID: <mhng-c7d78b33-d53f-41c5-955a-604eec4478c6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 19:49:54 GMT (+0000), Paul Walmsley wrote:
> On Tue, 3 Dec 2019, Anup Patel wrote:
>
>> We select Goldfish RTC driver using QEMU virt machine kconfig option
>> to access RTC device on QEMU virt machine.
>>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> I just grepped for Goldfish through the QEMU git tree, and it didn't come
> up with anything.  Per our discussion last year: as a general matter of
> policy, until QEMU merges support for a simulated hardware device into
> their master branch, we shouldn't speculatively enable support for it.
> So, NAK from me on this one until that happens.

Thanks, I thought they were going in through a hw/rtc tree and forgot about
them.  I've queued them up for QEMU via the RISC-V tree, there's still some
other patches I'd like to batch up but I'll send them up soon.  I don't see any
reason why the Linux patches can't go in via an early-ish RC, so we shoul be
fine.
