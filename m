Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB4EC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA95B207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAVDd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:33:57 -0500
Received: from foss.arm.com ([217.140.110.172]:50860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgAVDd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:33:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD1C30E;
        Tue, 21 Jan 2020 19:33:56 -0800 (PST)
Received: from [10.163.1.202] (unknown [10.163.1.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E263F6C4;
        Tue, 21 Jan 2020 19:33:42 -0800 (PST)
Subject: Re: [PATCH V12 0/2] arm64/mm: Enable memory hot remove
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
References: <1579157135-10360-1-git-send-email-anshuman.khandual@arm.com>
 <20200121151822.GA13306@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3cbdc6f9-093d-975e-f960-68c274aa75a1@arm.com>
Date:   Wed, 22 Jan 2020 09:05:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200121151822.GA13306@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/21/2020 08:48 PM, Will Deacon wrote:
> On Thu, Jan 16, 2020 at 12:15:33PM +0530, Anshuman Khandual wrote:
>> This series enables memory hot remove functionality on arm64 platform. This
>> is based on Linux 5.5-rc6 and particularly deals with a problem caused when
>> boot memory is attempted to be removed.

Hello Will,

> 
> Unfortunately, this results in a conflict with mainline since the arm64
> -next branches are based on -rc3 and there was a fix merged after that
> (feee6b298916 ("mm/memory_hotplug: shrink zones when offlining memory"))
> which changes the type of __remove_pages().

Right, that fix went in last couple of weeks.

> 
> So I think I'll leave this for 5.7.

Just wondering if there is any chance this can still make it to 5.6
or its already too late ?

> 
> Will
> 

- Anshuman
