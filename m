Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE73D21527
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgE1HrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:47:13 -0400
Received: from foss.arm.com ([217.140.110.172]:48838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:47:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 250E731B;
        Thu, 28 May 2020 00:47:12 -0700 (PDT)
Received: from [10.163.78.176] (unknown [10.163.78.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4AC53F52E;
        Thu, 28 May 2020 00:47:09 -0700 (PDT)
Subject: Re: [PATCH V3] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        suzuki.poulose@arm.com
References: <1590573876-19120-1-git-send-email-anshuman.khandual@arm.com>
 <159057996975.77588.7036217455816555869.b4-ty@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <398e2d07-3076-9266-ae16-1be64e221fc7@arm.com>
Date:   Thu, 28 May 2020 13:16:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <159057996975.77588.7036217455816555869.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/27/2020 05:55 PM, Will Deacon wrote:
> On Wed, 27 May 2020 15:34:36 +0530, Anshuman Khandual wrote:
>> There is no way to proceed when requested register could not be searched in
>> arm64_ftr_reg[]. Requesting for a non present register would be an error as
>> well. Hence lets just WARN_ON() when search fails in get_arm64_ftr_reg()
>> rather than checking for return value and doing a BUG_ON() instead in some
>> individual callers. But there are also caller instances that dont error out
>> when register search fails. Add a new helper get_arm64_ftr_reg_nowarn() for
>> such cases.
> 
> Applied to arm64 (for-next/cpufeature), thanks!
> 
> [1/1] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
>       https://git.kernel.org/arm64/c/3577dd37c703

Thanks Will, for changing the comment per Catalin.
