Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F588C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A3C20768
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHXEKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 00:10:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgHXEKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 00:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4231063;
        Sun, 23 Aug 2020 21:10:00 -0700 (PDT)
Received: from [10.163.67.29] (unknown [10.163.67.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58BE3F66B;
        Sun, 23 Aug 2020 21:09:57 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/hotplug: Improve memory offline event notifier
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <15c8debd-b388-ec75-742f-5401a5546db4@arm.com>
Date:   Mon, 24 Aug 2020 09:39:25 +0530
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

Wrong email address here for Will.

+ Will Deacon <will@kernel.org>

s/will@kernel.com/will@kernel.org next time around.
