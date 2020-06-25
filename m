Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E358C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0D420767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405627AbgFYPKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:10:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405425AbgFYPKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B320FC0A;
        Thu, 25 Jun 2020 08:10:49 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36813F6CF;
        Thu, 25 Jun 2020 08:10:48 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] arm_pmu: Use NMI for perf interrupt
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
Message-ID: <4c615abd-7eee-ac3d-1ce4-939906d26b87@arm.com>
Date:   Thu, 25 Jun 2020 16:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617113851.607706-1-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/20 12:38 PM, Alexandru Elisei wrote:
> The series makes the arm_pmu driver use NMIs for the perf interrupt when
> NMIs are available on the platform (currently, only arm64 + GICv3). To make
> it easier to play with the patches, I've pushed a branch at [1]:
>
> $ git clone -b pmu-nmi-v5 git://linux-arm.org/linux-ae

For people who wanted to test the series, but couldn't because their firmware was
setting SCR_EL3.FIQ, I pushed some patches [1] to fix that. Now pseudo-NMIs work
on all GICv3 security + SCR_EL3.FIQ combinations.

[1] https://lists.infradead.org/pipermail/linux-arm-kernel/2020-June/580143.html

Thanks,
Alex
