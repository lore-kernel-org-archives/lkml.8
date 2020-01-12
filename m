Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CAC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C927E214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 13:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbgALNWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 08:22:09 -0500
Received: from foss.arm.com ([217.140.110.172]:59420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732893AbgALNWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 08:22:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545F8DA7;
        Sun, 12 Jan 2020 05:22:08 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503703F534;
        Sun, 12 Jan 2020 05:22:07 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
 <20200109105228.GB10914@e105550-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f973e77b-9c0a-6506-da97-f7a0ea1829fd@arm.com>
Date:   Sun, 12 Jan 2020 13:22:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109105228.GB10914@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 10:52, Morten Rasmussen wrote:
>> AFAIA what matters here is memory controllers, less so LLCs. Cores within
>> a single die could have private LLCs and separate memory controllers, or
>> shared LLC and separate memory controllers.
> 
> Don't confuse cache boundaries, packages and nodes :-)
> 
> core_siblings are cpus in the same package and doesn't say anything
> about cache boundaries. It is not given that there is sched_domain that
> matches the core_sibling span.
> 
> The MC sched_domain is supposed to match the LLC span which might
> different for core_siblings. So the about example should be valid for a
> NUMA-in-package system with one package containing two nodes.
> 

Right, the point I was trying to make is that node boundaries can be pretty
much anything, so nodes can span over LLCs, or LLCs can span over nodes,
which is why we need checks such as the one in arch_topology() that lets us
build up a usable domain hierarchy (which cares about LLCs, at least at some
level).

> Morten
> 
