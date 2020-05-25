Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A98C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1454207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="uC/DUKVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgEYIMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:12:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:12:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so19834101ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQlv94/UsIcWqqoQiFz4Gmt5TSCy0PaSYRGYfGZ8ASE=;
        b=uC/DUKVPr4AEHq5tZ0tk/8BJui59Ip+3Hv4adGb5DQ14R3VOvZPglrknK3jEuEDUri
         0d/s8L/nPTs2TjywXIwDlAjAl0pbo1y4d4KL36xuI94CirTpSML2vZQUsvsl4pKnfCT/
         N1Dr1x0yKT+NPvdkJagD16frkkV4x2sD0QXMuT8oRsZpcVs7WIynSnod8WL8W7zEpzVp
         9VYGC1iie7CLhJuFTjwO+eudzrsEauJNzNODWYn+/OMtBZijYLasRQSg6Mccp6nvsS7K
         yPzPRVs3STK0Cn+lL+DaqTkrNgfUs+i/dYHTpAqH/NTlrp/7vli8ofSqHDlLR/MYqwVQ
         KVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQlv94/UsIcWqqoQiFz4Gmt5TSCy0PaSYRGYfGZ8ASE=;
        b=Cqe1LVuVuG3THhIwevcCXuY3b//lpqJr07Y7nxFq4Q1UvhjpOnJmfkSMFcOi+Gbl4Y
         XIQeqKrG/5u6zygO5z6kNB7yuCzxVgLMQa5qw1/cnjOIZoQiCSvcRPXjbODJkylXs54c
         0Rr9Fd0Xo0y6v7a2H3IsXhOd6uiVPuLymIk6RUy1MRMU0pkSSJ/QRYqxY5O8Ym8Yxiy/
         NP1TNzbgrDWa8FflMaq8egIOwMT3IyLrs4xrkrHp8qDv+gEprTdtaAkYFLJyXAVV9dNi
         cg0ShuaCkvU9R6pKMB+NlmTeiXVujMWS95CKdsDLhTxY8w0fa3FHH75vqireNTexQdeX
         RdmA==
X-Gm-Message-State: AOAM5316GQc5AIQIh8YW0ausg94kAuhIyC3vJN/GJEALHl7LfYUy/DWx
        5vEW2IaBpRDrc1q7JOz33f/epVAWgZUqUQ==
X-Google-Smtp-Source: ABdhPJyJtREc8uUJDAMfpETQ8xnMzoK/Y5+TXrGnZ2HOaSMhu/3tzdRc4VuGqCS4FTW3P1QcfIskmw==
X-Received: by 2002:a2e:2a02:: with SMTP id q2mr11637583ljq.311.1590394353496;
        Mon, 25 May 2020 01:12:33 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:425b:15e7:251c:5b3:d625:2d43? ([2a00:1fa0:425b:15e7:251c:5b3:d625:2d43])
        by smtp.gmail.com with ESMTPSA id m10sm4627606lfd.15.2020.05.25.01.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 01:12:32 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] MIPS: Do not flush tlb page when updating PTE
 entry
To:     Bibo Mao <maobibo@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Maciej W. Rozycki" <macro@wdc.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
References: <1590375160-6997-1-git-send-email-maobibo@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <79778fc3-c029-272b-358e-4f8f8e5772d3@cogentembedded.com>
Date:   Mon, 25 May 2020 11:12:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1590375160-6997-1-git-send-email-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 25.05.2020 5:52, Bibo Mao wrote:

> It is not necessary to flush tlb page on all CPUs if suitable PTE
> entry exists already during page fault handling, just updating
> TLB is fine.
> 
> Here redefine flush_tlb_fix_spurious_fault as empty on MIPS system.

    Need empty line here.

> V6:
> - Add update_mmu_tlb function as empty on all platform except mips
>    system, we use this function to update local tlb for page fault
>    smp-race handling
> V5:
> - define update_mmu_cache function specified on MIPS platform, and
>    add page fault smp-race stats info
> V4:
> - add pte_sw_mkyoung function to implement readable privilege, and
>    this function is  only in effect on MIPS system.
> - add page valid bit judgement in function pte_modify
> V3:
> - add detailed changelog, modify typo issue in patch V2
> v2:
> - split flush_tlb_fix_spurious_fault and tlb update into two patches
> - comments typo modification
> - separate tlb update and add pte readable privilege into two patches

   It was a bad idea to keep the version change log in the 1st patch only,
we have either cover letter for that, or all the individual patches...

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[...]

MBR, Sergei
