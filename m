Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0316920897
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIILe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIILaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B322B31B;
        Wed,  9 Sep 2020 04:21:09 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627073F68F;
        Wed,  9 Sep 2020 04:21:08 -0700 (PDT)
References: <20200829130016.26106-1-valentin.schneider@arm.com> <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com> <jhja6y8o3hb.mognet@arm.com> <678F3D1BB717D949B966B68EAEB446ED482431A1@DGGEMM506-MBX.china.huawei.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] arm64: topology: Stop using MPIDR for topology information
In-reply-to: <678F3D1BB717D949B966B68EAEB446ED482431A1@DGGEMM506-MBX.china.huawei.com>
Date:   Wed, 09 Sep 2020 12:21:03 +0100
Message-ID: <jhjzh5z5h7k.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/09/20 02:44, B wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> On 02/09/20 04:24, B wrote:
>> > I agree with your idea to remove the topology functionality of MPIDR ,
>> > but I think we need also consider ARM32 and GIC.
>> >
>>
>> Could you please elaborate? This change doesn't impact arch_topology, so
>> only arm64 is affected.
>
> Yes, this change only affects arm64, my question is that do we need to
>  leverage it to arm32 since arm32 got the same issue.
>
> And for GIC we are also using MPIDR for the topology info, but I am sure
> It's got the same issue or not, just a suggestion to have a look.

So technically yes, we can be bothered by this on arm32 - Sudeep pointed
out a list of DT files that shows platforms with non-zero values in Aff1 or
above.

However, the bigger issue is that artificial separation in clusters of 16
CPUs due to extra limitations on Aff0 (mainly due to GICv3 AIUI). Given
that GICv2 can support at most 8 CPU interfaces, I don't think we have it
as bad on arm32.
