Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E022086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRm4T3Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:37:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E5C061756;
        Fri,  7 Aug 2020 11:37:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so1354146pgq.1;
        Fri, 07 Aug 2020 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qFnmuszKrF6FXzQfD8tHyoB3K5fStfG12pa426J7+D8=;
        b=pRm4T3KsynmikXm4wqi0vV1q008PA+mK/cj1YGM+UOwJh3zfqtx63af9q5iYR4U8VJ
         N9G22bRClCg8epLNAet1/P/++OXOzGbZNm3qGY6kDjShgRg1VMGnuMu3cmIlv622GX2W
         PNNsXrJiAq1bNYVM7FEVZ06kvtFpsI0BBaup7XJPEvbJoDvL1ieoUuxFBH0D+VOtTVck
         109rHnL7blAYoiBsjoc0CXmzjRYmklzzJ/luVB9k9eTCVwYDdtJD5rfGVFp+7mHwog65
         5UcAAqx/M+C9RVtTPm5y7W+WTyLbxqP4TqaSz1UZfm3xYFlYp5CR9qAJXR7MWJFyzrJi
         dOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qFnmuszKrF6FXzQfD8tHyoB3K5fStfG12pa426J7+D8=;
        b=aiYHBywIV3ew8oh2WFcD7l/sbVQRe7fCePmO9aq3wTYtu4pl5U1rXekBSYC/zbi790
         YFAD7Zy4wUiW4e5px1/JROkgM9HSguIHH637eyPlB40Af5C21oLQdbKXn7Y6Ri/0T4Pe
         2JeaeOXt22KpdTHqXlSr3rsF87c5YMfwLUMKnHBuj+OGNLq3WjUkCVxg99W9sQsSc8zK
         567qc72JG7NX+Btwp33622bq47a2yyFVcLMZIOoRSlmfYZTv9sWWG8Orym2i0qndrtAM
         ygvr/QcYf7XfPEetkH5QLDGMXH1uQwu5QS7tl/oJUPWNPH+fl/rlCE37zStP4kXrjOSY
         +1Hg==
X-Gm-Message-State: AOAM530xg9Aqungugi9pOQwj5xGobquqGdsCk2+f06o6UJws7PmxaS8T
        IIjcyI+2CHxu+G3lvnytxt4IqLwB
X-Google-Smtp-Source: ABdhPJxVaE8+pnhCsm6q/+T+U61tO3fJLZUaQE9spjqGBHTmzyBX+WCbdRmDzC46ubGT2FgreShccQ==
X-Received: by 2002:a05:6a00:1509:: with SMTP id q9mr14374226pfu.24.1596825471108;
        Fri, 07 Aug 2020 11:37:51 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k12sm11275487pjp.38.2020.08.07.11.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:37:50 -0700 (PDT)
Subject: Re: [PATCH 0/2] firmware: bcm47xx_sprom: Fix -Wmissing-prototypes
 warnings
To:     linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200726041521.5398-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <62385d10-a552-25a7-4c49-63eed22a97c1@gmail.com>
Date:   Fri, 7 Aug 2020 11:37:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726041521.5398-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2020 9:15 PM, Florian Fainelli wrote:
> Hi Thomas,
> 
> This patch series fixes W=1 -Wmissing-prototypes warnings for the
> bcm47xx_sprom.c firmware file.

Thomas, can you apply these patches if you are fine with them? Thanks

> 
> Thanks!
> 
> Florian Fainelli (2):
>   firmware: bcm47xx_sprom: Fix -Wmissing-prototypes warnings
>   MIPS: BCM47xx: Include bcm47xx_sprom.h
> 
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |  4 +---
>  drivers/firmware/broadcom/bcm47xx_sprom.c    |  1 +
>  include/linux/bcm47xx_sprom.h                | 10 ++++++++++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 

-- 
Florian
