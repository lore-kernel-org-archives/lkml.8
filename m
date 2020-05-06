Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B28C4725B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730A320747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="rPTQCTEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgEFSQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgEFSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:16:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A92C0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:16:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so2154869lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KEXpBFdxDsOsxHUJbKHvTc13/63fZoyJiUI7zCS8HKc=;
        b=rPTQCTExlqHfI8liKWG2uYWysFbuJpKzXBvgKhuaKXumurQdsmN6X5rXcyzcrnvTqe
         hjLgZMiOTGz3bC7k/hXGytt5QJw0YgmMep5W+QROGqanjsux/SsiM/fcd4/WTiMx9wVX
         DhXBp1zjJziGEecwATXN2bilY9Ak3JH+3FAAFRKortUPAENzF43pyO9lvaAkJOQh+EL0
         u32+izeEWl/qlexOGNb/t11LYZQB/+N33G3sTrz5AFrKgcXaIOL4pwl6s/7pyZnR4UsX
         CRvgW+H5vvR/QiFp9M0BN9wS3B7Dw7INdqu0/rmH70DuccuHyS/UQxEtgy6TSSQhZQkh
         k5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KEXpBFdxDsOsxHUJbKHvTc13/63fZoyJiUI7zCS8HKc=;
        b=QZQ3Tr6dOMD++F1HX7/q8aeC9Bx3+6azmFJ7EwiTTraE8boHdYgoiAc0RehVgvmTsn
         5jg8Vv2FlFwE9NQ55fMxYqOZ9RD47qCAgfggbX1vJy/xnqTzMzfl63V/+jDaW1JJC7nQ
         KHztSAxMytXfYrXEpw4RmY7C5C7O8exqUcgeTnWgAqVy5vlg8Y+JfXxOtba9fFy0JWu7
         CLWd9HQT7/rCopgoognAqQKdGAHWDtr5opLGqRiyDLLL5W1HcchHiBBz2/rFKnY72HJk
         cktp7auBZB07QAu/xpM/saLhkgc1jzQ9fUo98s/Ywk6LFY0y8KRm8Lc+0E9/hb2hUfYJ
         KtRg==
X-Gm-Message-State: AGi0PubtsbKsZdLO8akF6UqrLYCwxTVnA3LXLyXws2eGfeUFMRd8D2hI
        +qmYE2Soqj2R40Pq24L6fU1zuUnX1KYkUQ==
X-Google-Smtp-Source: APiQypLGUWwNuylqLwt0ewr21qw7FidtN22GXOYoec8xwlCm+ZbM/KF1pXlnii0P1kP7utaJvncpwQ==
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr5747624lfq.127.1588788986770;
        Wed, 06 May 2020 11:16:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:46f7:c018:da89:7e41:8ab5:299d])
        by smtp.gmail.com with ESMTPSA id 25sm2087051lfr.92.2020.05.06.11.16.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 11:16:25 -0700 (PDT)
Subject: Re: [PATCH v2 14/20] mips: Use offset-sized IO-mem accessors in CPS
 debug printout
To:     Sergey.Semin@baikalelectronics.ru,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-15-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <82e98cee-d39e-7df2-8b0d-ac77defd5dd8@cogentembedded.com>
Date:   Wed, 6 May 2020 21:16:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200506174238.15385-15-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05/06/2020 08:42 PM, Sergey.Semin@baikalelectronics.ru wrote:

> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Similar to commit 8e5c62e38a88 ("mips: early_printk_8250: Use offset-sized
> IO-mem accessors") the IO-memory might require to use a proper load/store
> instructions (like Bailal-T1 IO-memory). To fix the cps-vec UART debug

   Baikal? :-)

> printout lets use the memory access instructions in accordance with the
> UART registers offset config specified at boot time.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> There might be another problem in cps-vec-ns16550.S connected with the
> difference in CPU/devices endinanness on some platforms. But there is

   Endianness.

> no such for Baikal-T1 SoC.
[...]

MBR, Sergei
