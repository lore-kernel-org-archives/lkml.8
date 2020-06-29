Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16440C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9663206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgF2Wjo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:39:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgF2Wjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:39:43 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jpsyW-0006Sb-3E
        for linux-kernel@vger.kernel.org; Mon, 29 Jun 2020 12:33:28 +0000
Received: by mail-pg1-f199.google.com with SMTP id z16so12333545pgh.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6rSGUcxEtasmikuRjUacPJe3K2leqY94Ck1/E/gRXXI=;
        b=s6/hTmU3ducQme/h801M0JGULh6dnjAikD1L0GNjCZBDPuPtus9V7uXe2NBuZsesbV
         hbD2xuRY26sumxY6Fmpu+R80bhQEYWPSDQweZGqjlGgCpdZjsNlZMUBemf5fukZU9KFu
         vc3RFterKZIj3eoCw6to9AGu566tbTUPI0R8cnzSa6Jn1b1Mx89vLwqVnR2wQ6YyCQgM
         gLwW6ewVKMMXVKUORNq96X32DiN0DuWc4yZduDLcPc1nHfVuOMQ/b0D6VwCGTrGQFS2t
         G7twFaOkNuZPzRYn9Dp5njEteAA74ZQnDxiVtFbHwPjLmHdzH822lHT/nHC36yAYKC52
         aW/w==
X-Gm-Message-State: AOAM530JXWdOnI0KnD1GNRWDBEhWRpkHVYSdfFSWf9GzGxdMYgmrE0Og
        Zoum2WhHXSMpuadbmeMYNZ2Yqp5DLHyUNG1lUPgJ+G0zJpv5gUPUhWk9UFFt/el8q9UxLws3dcu
        QKwMAm5uF8fG8dHmMEBkrhR5xoq8jWQ6Uhqj+6iTUlw==
X-Received: by 2002:aa7:8b01:: with SMTP id f1mr14720684pfd.223.1593434006590;
        Mon, 29 Jun 2020 05:33:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSfSEI9VTobq3zQg6b2gevJg3MoMRLSL2CpTKRfwrmyfWZi30iMQn8TPZ63aVpR46Cp+GCvg==
X-Received: by 2002:aa7:8b01:: with SMTP id f1mr14720649pfd.223.1593434006025;
        Mon, 29 Jun 2020 05:33:26 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id bf11sm3556197pjb.48.2020.06.29.05.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 05:33:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
Date:   Mon, 29 Jun 2020 20:33:22 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 18, 2020, at 23:32, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On May 18, 2020, at 22:05, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On May 18, 2020, at 21:32, Joerg Roedel <jroedel@suse.de> wrote:
>>> 
>>> On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
>>>> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
>>>> Function domain_flush_complete() doesn't seem to affect the status.
>>>> 
>>>> However, the .map_page callback was removed by be62dbf554c5
>>>> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
>>>> there's no easy revert for this issue.
>>>> 
>>>> This is still reproducible as of today's mainline kernel, v5.7-rc6.
>>> 
>>> Is there any error message from the IOMMU driver?
>>> 
>> 
>> As of mainline kernel, there's no error message from IOMMU driver.
>> There are some complains from v4.15-rc1:
>> https://pastebin.ubuntu.com/p/qn4TXkFxsc/
> 
> Just tested v5.7-rc6, the issue disappears as soon as kernel boots with "iommu=off".

I am still seeing the issue on v5.8-rc3. The issue goes away as soon as "iommu=off" is added.

Kai-Heng

> 
> Kai-Heng
> 
>> 
>> Kai-Heng
> 

