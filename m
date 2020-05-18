Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E69C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E992E20809
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgEROFl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:05:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEROFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:05:40 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jagOg-0003fD-MT
        for linux-kernel@vger.kernel.org; Mon, 18 May 2020 14:05:38 +0000
Received: by mail-pl1-f197.google.com with SMTP id t13so7506647plo.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eAqYxR1VuKxANFGYDzoTuNI/yexhnse0Gr19klQrpbA=;
        b=oVmYZEUggoRbn34OCipwxZRHlFTY/w3KTiILcMAkIxiL7tPPhOVii6myhHkkIH2gqE
         m3R+efcwFTXn3tCRY3Y3TPyHtBZuHFHqN6aEA/x03BeRz/au7IfesT9UYccVb9a6fuHM
         +VOJbmK/V4zgESrHEPUr5usc4ElJLRODI4238VE3q0AsTwwk37u9n+/sAL17/4rQ3bU6
         2NJPBs4uSdpUxVksRhfgByiT26/5EmsobDnRG15yR9f3fOqsdeGjGyh1FOpRCVCJYANc
         yxYcHzO/VhwlMplp3N7tbJVOzA5cnjcZyqmccE7tAOlTRgtaSshFoy62jQLA7fhir35J
         A/JA==
X-Gm-Message-State: AOAM532t02jPTdU9H6dtJO4XCk2XqKR35n+szrOloJFtIGXyGiQOTq9d
        Wk98AsH5ph6LLSBt4onM1Mfk3n1HsJBOwzkexKDdvQQNvbUKo0KkOHVGAlKBl+s9HD++bnknF3B
        53fB8N/XYMPM3V83ZX3CSdsjHWSTgKWRt2lIshH1lQA==
X-Received: by 2002:a17:902:8344:: with SMTP id z4mr16353679pln.207.1589810736905;
        Mon, 18 May 2020 07:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycffwbiHEQeNnNPZHbLIlc4DR6IBr7Axdu2pVGpb6ozEfZIbMcE3K2RMJRPR58CpoAsG+cNQ==
X-Received: by 2002:a17:902:8344:: with SMTP id z4mr16353654pln.207.1589810736557;
        Mon, 18 May 2020 07:05:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a16sm7971187pfl.167.2020.05.18.07.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 07:05:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200518133209.GM8135@suse.de>
Date:   Mon, 18 May 2020 22:05:33 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 18, 2020, at 21:32, Joerg Roedel <jroedel@suse.de> wrote:
> 
> On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
>> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
>> Function domain_flush_complete() doesn't seem to affect the status.
>> 
>> However, the .map_page callback was removed by be62dbf554c5
>> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
>> there's no easy revert for this issue.
>> 
>> This is still reproducible as of today's mainline kernel, v5.7-rc6.
> 
> Is there any error message from the IOMMU driver?
> 

As of mainline kernel, there's no error message from IOMMU driver.
There are some complains from v4.15-rc1:
https://pastebin.ubuntu.com/p/qn4TXkFxsc/

Kai-Heng
