Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05671207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:39:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgESKju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:39:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6134A101E;
        Tue, 19 May 2020 03:39:49 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B534A3F305;
        Tue, 19 May 2020 03:39:47 -0700 (PDT)
Subject: Re: [PATCH V4 03/17] arm64/cpufeature: Make doublelock a signed
 feature in ID_AA64DFR0
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-4-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6bbdb3e5-d6bd-db8f-4de9-a964f19c9ac4@arm.com>
Date:   Tue, 19 May 2020 11:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
> Double lock feature can have the following possible values.
> 
> 0b0000 - Double lock implemented
> 0b1111 - Double lock not implemented
> 
> But in case of a conflict the safe value should be 0b1111. Hence this must
> be a signed feature instead. Also change FTR_EXACT to FTR_LOWER_SAFE. While
> here, fix the erroneous bit width value from 28 to 4.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
