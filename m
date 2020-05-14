Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792ECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD8720671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eVtu+uah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENJfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:35:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACBBC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:35:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so2746110ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T86/hv0y7BAgJ75aFy/dvx0cbN3V70JUKhyVGv5v+SE=;
        b=eVtu+uah7Sf+JulgCzgHMXNss1swnlz1dhsc2qk9bjYnlevMZ0Tnj2eYpa8hHrTzkd
         6YButrHIwOq+lsJPkmHfVfVwRMgwIX5UorYguxKvabgoMe1OF3+PMQwWLDeA8s0T7+QO
         3vQaApFX54tXuP3hZeUESmbXg2y/UFMt8DamklMimJAWNmyZcrJWf/KD9+UZ5tRfQkAX
         ISuRybvMkN+11K0+x3ND7PB9Zxipow7EHzXneIVyDDPsXP6kw6am0RzMJ4Xzg6DAwjLB
         ZP7/lN8WCPgm4qUPZwcXVBRxxwWWWHmR1BCRQpnAPw9bRhFLE11N/TxB7uux6suO1JzV
         gIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T86/hv0y7BAgJ75aFy/dvx0cbN3V70JUKhyVGv5v+SE=;
        b=rvW/lx6zljkWI7oiyK9lYo08EO2Qi8rogK5buoBuMWyktt/aR1Z/WVmf5z0MTe4RUC
         kEsfLHiqSgOz+3q8rinsmZhaVQWkuKEIg0rs5a0yNnBAklr4A1kBTm0xLCtA4hFysPFe
         JRi3WjpCmTGHhzsGn5l1TQgz0oDHYC6fBepEaI6a01jDgxHA4XEVlP6VGabityCMIg3e
         J790Il4y6xWVRZ8tC6QmWWnX9aBQy9AkrJGs5KC+PCnPplDgea7LJpNvckYq4GrsVsSA
         sL2CcU9cWliwIU6ly1a0tODOZMUsYRuXoMhy83tnLt3E+byTkfh7bbdtrMrY7wjWyQ56
         iz2Q==
X-Gm-Message-State: AOAM532LayNnU3kEazevrTxnT1b4nIQfuad4ixERhUSkgiSyZ5HI7OiF
        /5t48OjKqzqGPqPKDQ1dowRDV4ttnQk=
X-Google-Smtp-Source: ABdhPJx5l4XNtKpw1qvszJmMsFRAuhj3l7wewTDsFC78z5yMXn6Qvi1+jRmRVAuRQbmOCJlRc4GnpQ==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr2251265lji.237.1589448946762;
        Thu, 14 May 2020 02:35:46 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:428e:17ae:1023:2fd9:377b:94c8? ([2a00:1fa0:428e:17ae:1023:2fd9:377b:94c8])
        by smtp.gmail.com with ESMTPSA id q21sm1792342lfe.0.2020.05.14.02.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 02:35:46 -0700 (PDT)
Subject: Re: [PATCH] MIPS: update tlb even if pte entry has no change
To:     Bibo Mao <maobibo@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1589422677-11455-1-git-send-email-maobibo@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b46f4ac1-9738-6037-d60a-faebf2b4365c@cogentembedded.com>
Date:   Thu, 14 May 2020 12:35:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589422677-11455-1-git-send-email-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2020 5:17, Bibo Mao wrote:

> From: bibo mao <maobibo@loongson.cn>
> 
> If there are two threads reading the same memory and tlb miss happens,
> one thread fills pte entry, the other reads new pte value during page fault
> handling. PTE value may be updated before page faul, so the process need

    Fault.

> need update tlb still.
> 
> Also this patch define flush_tlb_fix_spurious_fault as empty, since it not
> necessary to flush the page for all CPUs
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[...]

MBR, Sergei
