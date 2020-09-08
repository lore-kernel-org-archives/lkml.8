Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AB121741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgIHJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:23:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgIHJX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:23:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CC71045;
        Tue,  8 Sep 2020 02:23:58 -0700 (PDT)
Received: from [10.163.71.211] (unknown [10.163.71.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4173F66E;
        Tue,  8 Sep 2020 02:23:55 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/hotplug: Improve memory offline event notifier
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <da6e3670-2d4c-cf11-4799-dc2b88ffc83e@arm.com>
Date:   Tue, 8 Sep 2020 14:53:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2020 09:34 AM, Anshuman Khandual wrote:
> This brings about three different changes to the sole memory event notifier
> for arm64 platform and improves it's robustness while also enhancing debug
> capabilities during potential memory offlining error conditions.
> 
> This moves the memory notifier registration bit earlier in the boot process
> from device_initcall() to setup_arch() which will help in guarding against
> potential early boot memory offline requests.
> 
> This enables MEM_OFFLINE memory event handling. It will help intercept any
> possible error condition such as if boot memory some how still got offlined
> even after an expilicit notifier failure, potentially by a future change in
> generic hotplug framework. This would help detect such scenarious and help
> debug further.
> 
> It also adds a validation function which scans entire boot memory and makes
> sure that early memory sections are online. This check is essential for the
> memory notifier to work properly as it cannot prevent boot memory offlining
> if they are not online to begin with. But this additional sanity check is
> enabled only with DEBUG_VM.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on 5.9-rc2
> 
> Changes in V2:
> 
> - Dropped all generic changes wrt MEM_CANCEL_OFFLINE reasons enumeration
> - Dropped all related (processing MEM_CANCEL_OFFLINE reasons) changes on arm64
> - Added validate_boot_mem_online_state() that gets called with early_initcall()
> - Added CONFIG_MEMORY_HOTREMOVE check before registering memory notifier
> - Moved notifier registration i.e memory_hotremove_notifier into setup_arch()
Gentle ping, any updates on this ?
