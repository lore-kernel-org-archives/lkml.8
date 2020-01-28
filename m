Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7474C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A3020663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA1RhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:37:11 -0500
Received: from foss.arm.com ([217.140.110.172]:32890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1RhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:37:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 688F0328;
        Tue, 28 Jan 2020 09:37:08 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A65B3F52E;
        Tue, 28 Jan 2020 09:37:06 -0800 (PST)
Subject: Re: [PATCH v2 3/6] arm64/kvm: disable access to AMU registers from
 kvm guests
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-4-ionela.voinescu@arm.com>
 <bc3f582c-9aed-8052-d0cb-b39c76c8ce73@arm.com>
 <0690745f-fa38-f623-30a5-42d0eadfb668@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <5de3d3c7-2d78-9d18-f3ca-7cb6cf9ce36c@arm.com>
Date:   Tue, 28 Jan 2020 17:37:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0690745f-fa38-f623-30a5-42d0eadfb668@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 28/01/2020 17:26, Suzuki Kuruppassery Poulose wrote:
>> So, providing I didn't get completely lost on the way, I have to ask:
>> why do we use CPACR_EL1 here? Couldn't we use CPTR_EL2 directly?
> 
> Part of the reason is, CPTR_EL2 has different layout depending on
> whether HCR_EL2.E2H == 1. e.g, CPTR_EL2.TTA move from Bit[28] to Bit[20].
> 
> So, to keep it simple, CPTR_EL2 is used for non-VHE code with the shifts
> as defined by the "CPTR_EL2 when E2H=0"
> 
> if E2H == 1, CPTR_EL2 takes the layout of CPACR_EL1 and "overrides" some
> of the RES0 bits in CPACR_EL1 with EL2 controls (e.g: TAM, TCPAC).
> Thus we use CPACR_EL1 to keep the "shifts" non-conflicting (e.g, ZEN)
> and is the right thing to do.
> 
> It is a bit confusing, but we are doing the right thing. May be we could improve the comment like :
> 
>     /*
>      * With VHE (HCR.E2H == 1), CPTR_EL2 has the same layout as
>      * CPACR_EL1, except for some missing controls, such as TAM.
>      * And accesses to CPACR_EL1 are routed to CPTR_EL2.
>      * Also CPTR_EL2.TAM has the same position with or without
>      * HCR.E2H == 1. Therefore, use CPTR_EL2.TAM here for
>      * trapping the AMU accesses.
>      */
> 

Thanks for clearing this up! I also bothered MarcZ in the meantime who
also cleared up some of my confusion (including which layout takes effect).

So yeah, I think what we want here is to keep using CPTR_EL2_TAM but have a
comment that explains why (which you just provided!).

> Suzuki
