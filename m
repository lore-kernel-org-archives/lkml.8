Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B21C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BDC2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgH0LmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbgH0Lb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:31:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FAE1045;
        Thu, 27 Aug 2020 04:31:03 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08D53F68F;
        Thu, 27 Aug 2020 04:31:01 -0700 (PDT)
Subject: Re: [PATCH 25/35] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
 <8a499341bbe4767a4ee1d3b8acb8bd83420ce3a5.1597425745.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b7884e93-008f-6b9f-32d8-6c03c7e14243@arm.com>
Date:   Thu, 27 Aug 2020 12:33:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a499341bbe4767a4ee1d3b8acb8bd83420ce3a5.1597425745.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 8/14/20 6:27 PM, Andrey Konovalov wrote:
> +config·KASAN_HW_TAGS
> +» bool·"Hardware·tag-based·mode"
> +» depends·on·HAVE_ARCH_KASAN_HW_TAGS
> +» depends·on·SLUB
> +» help
> +» ··Enables·hardware·tag-based·KASAN·mode.
> +
> +» ··This·mode·requires·both·Memory·Tagging·Extension·and·Top·Byte·Ignore
> +» ··support·by·the·CPU·and·therefore·is·only·supported·for·modern·arm64
> +» ··CPUs·(MTE·added·in·ARMv8.5·ISA).
> +

I do not thing we should make KASAN_HW_TAGS MTE specific especially because it
is in the common code (e.g. SPARC ADI might want to implement it in future).

Probably would be better to provide some indirection in the generic code an
implement the MTE backend entirely in arch code.

Thoughts?

-- 
Regards,
Vincenzo
