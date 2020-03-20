Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5001FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3351C20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:07:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:07:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C7DE1FB;
        Fri, 20 Mar 2020 11:07:03 -0700 (PDT)
Received: from [10.37.12.158] (unknown [10.37.12.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B523F305;
        Fri, 20 Mar 2020 11:07:01 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-4-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <54e53bb4-beb3-1a36-e8a4-2f3bda433739@arm.com>
Date:   Fri, 20 Mar 2020 18:11:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1580215149-21492-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
> SpecSEI in ID_MMFR4 register per ARM DDI 0487E.a.

It might be worth adding a comment here mentioning why SpecSEI is
HIGHER_SAFE, unlike the majority.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
