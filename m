Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A264C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46207207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgH0JwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:52:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0JwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:52:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53D7101E;
        Thu, 27 Aug 2020 02:52:00 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C99F3F66B;
        Thu, 27 Aug 2020 02:51:58 -0700 (PDT)
Subject: Re: [PATCH 19/35] kasan: don't allow SW_TAGS with ARM64_MTE
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
 <5185661d553238884613a432cf1d71b1480a23ba.1597425745.git.andreyknvl@google.com>
 <20200827080442.GA29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <56ba1b14-36af-31ea-116b-23300525398d@arm.com>
Date:   Thu, 27 Aug 2020 10:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827080442.GA29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 8/27/20 9:04 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:01PM +0200, Andrey Konovalov wrote:
>> Software tag-based KASAN provides its own tag checking machinery that
>> can conflict with MTE. Don't allow enabling software tag-based KASAN
>> when MTE is enabled.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  lib/Kconfig.kasan | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index b4cf6c519d71..e500c18cbe79 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -69,6 +69,7 @@ config KASAN_GENERIC
>>  config KASAN_SW_TAGS
>>  	bool "Software tag-based mode"
>>  	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
>> +	depends on !ARM64_MTE
> 
> I think that's better as:
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 10cf81d70657..736c32bd8905 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -131,7 +131,7 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> -	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> +	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN && !ARM64_MTE
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> 

I agree with Catalin here, "select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN &&
!ARM64_MTE" should be sufficient.

-- 
Regards,
Vincenzo
