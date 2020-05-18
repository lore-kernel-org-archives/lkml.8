Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E066A207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgERPcK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:32:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38288 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:32:09 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jahkN-0002Gq-9Z
        for linux-kernel@vger.kernel.org; Mon, 18 May 2020 15:32:07 +0000
Received: by mail-pl1-f198.google.com with SMTP id t10so7723563plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DSec870v7lcetS/nj+jERIYNbmyiptV5Gs1Gq6B0yDE=;
        b=X8fWY6s6ryOPXeuWgcJgmIiC4sSAAaC3CYO9DRsLsy+H9lD2yLdQukHYE/cwfSFrCi
         omce8HPa2iIqyTE/BQF3BfqQ5qcYXLOW2JHRe8kxfSS+yRBYJMiwjPxpXXGM8MiLvOjv
         uUHWlG098RiKRN7p3DEDQcxuTLwN/xAuzKeKeRezVvRqT95Q/QCJxVw7KwlK/vMOxx1Z
         IOmhxy70wJ4+OKdvgiddv9YXCXlHdq/aDPtfXYftfXTTMYJah0UEVZ9dDK6JXI2cAlXq
         pBIOMgx9edpF+NNBUViP7rD+ObY5Q+DMIuDAsVeegU013Kb7w0cXGhpMyjVxIBwXbjkQ
         CJRw==
X-Gm-Message-State: AOAM532kdM+PN6XrW91/ITVNnJzpYknpk2OTtni2A3+/I4FJmXl17Hvx
        2whGNq+MRvFwPHzMftlaPpK475ZGre9pJs/FeRa/1JJ/oJ6L6VbdVS+Krpi28sMSs/18PkXjyOs
        iHQmqTWl00u9EviG15h7WhZMnF1kxuD5WnDO0ax9nuA==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr17396665pfh.61.1589815925910;
        Mon, 18 May 2020 08:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGxZm/plZKIuJE3WpwUAsM+BGrbLgozR6Kn1MCOfBfyaSgIZ8IrE5uES428hzb66aufTbupg==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr17396636pfh.61.1589815925588;
        Mon, 18 May 2020 08:32:05 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id m3sm8646593pjs.17.2020.05.18.08.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 08:32:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
Date:   Mon, 18 May 2020 23:32:02 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 18, 2020, at 22:05, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On May 18, 2020, at 21:32, Joerg Roedel <jroedel@suse.de> wrote:
>> 
>> On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
>>> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
>>> Function domain_flush_complete() doesn't seem to affect the status.
>>> 
>>> However, the .map_page callback was removed by be62dbf554c5
>>> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
>>> there's no easy revert for this issue.
>>> 
>>> This is still reproducible as of today's mainline kernel, v5.7-rc6.
>> 
>> Is there any error message from the IOMMU driver?
>> 
> 
> As of mainline kernel, there's no error message from IOMMU driver.
> There are some complains from v4.15-rc1:
> https://pastebin.ubuntu.com/p/qn4TXkFxsc/

Just tested v5.7-rc6, the issue disappears as soon as kernel boots with "iommu=off".

Kai-Heng

> 
> Kai-Heng

