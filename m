Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B84C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF39D2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgH0LoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgH0Ldh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:33:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38EF91045;
        Thu, 27 Aug 2020 04:33:30 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F033F68F;
        Thu, 27 Aug 2020 04:33:28 -0700 (PDT)
Subject: Re: [PATCH 31/35] kasan, arm64: implement HW_TAGS runtime
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1597425745.git.andreyknvl@google.com>
 <4e86d422f930831666137e06a71dff4a7a16a5cd.1597425745.git.andreyknvl@google.com>
 <20200827104517.GH29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <567f90b6-fa25-6ef3-73b8-45462cc7ceb2@arm.com>
Date:   Thu, 27 Aug 2020 12:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827104517.GH29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 11:45 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:13PM +0200, Andrey Konovalov wrote:
>> diff --git a/mm/kasan/mte.c b/mm/kasan/mte.c
>> new file mode 100644
>> index 000000000000..43b7d74161e5
>> --- /dev/null
>> +++ b/mm/kasan/mte.c
> 
> Since this is an arm64-specific kasan backend, I wonder whether it makes
> more sense to keep it under arch/arm64 (mte-kasan.c).
>

Yes I agree, I had a similar comment in patch 25. I think we should implement
the mte backend entirely in arch code because other architectures might want to
enable the feature (e.g. Sparc ADI).

>> diff --git a/mm/kasan/report_mte.c b/mm/kasan/report_mte.c
>> new file mode 100644
>> index 000000000000..dbbf3aaa8798
>> --- /dev/null
>> +++ b/mm/kasan/report_mte.c
> 
> Same for this one.
> 

-- 
Regards,
Vincenzo
