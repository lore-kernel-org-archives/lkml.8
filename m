Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59837C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A8207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAMPPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:15:32 -0500
Received: from foss.arm.com ([217.140.110.172]:40676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMPPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:15:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 281F011B3;
        Mon, 13 Jan 2020 07:15:31 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E713F68E;
        Mon, 13 Jan 2020 07:15:30 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
 <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
 <1fbe4475-363d-e800-8295-a1591d5e52d9@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3b389423-4bc7-0706-660f-dbddf8445abd@arm.com>
Date:   Mon, 13 Jan 2020 15:15:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1fbe4475-363d-e800-8295-a1591d5e52d9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2020 14:49, Dietmar Eggemann wrote:
> LGTM. This code detects the issue in cpu_coregroup_mask(), which is the
> the cpumask function of the sched domain MC level struct
> sched_domain_topology_level of ARM64's (and other archs)
> default_topology[].
> I wonder how x86 copes with such a config error?
> Maybe they do it inside their cpu_coregroup_mask()?
> 
> 
> We could move validate_topology_spans() into the existing
> 
> for_each_cpu(i, cpu_map)
>     for_each_sd_topology(tl)
> 
> loop in build_sched_domains() saving some code?
> 

[...]

Yeah that should work. Folks might want to gate it under SCHED_DEBUG, but
that's another discussion.
