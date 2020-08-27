Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1262080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgH0PXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgH0Lap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:30:45 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867CA22CB3;
        Thu, 27 Aug 2020 11:13:47 +0000 (UTC)
Date:   Thu, 27 Aug 2020 12:13:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
Message-ID: <20200827111344.GK29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia>
 <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:05:55PM +0100, Vincenzo Frascino wrote:
> On 8/27/20 11:40 AM, Catalin Marinas wrote:
> > On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> >> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >> index 152d74f2cc9c..6880ddaa5144 100644
> >> --- a/arch/arm64/mm/proc.S
> >> +++ b/arch/arm64/mm/proc.S
> >> @@ -38,7 +38,7 @@
> >>  /* PTWs cacheable, inner/outer WBWA */
> >>  #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
> >>  
> >> -#ifdef CONFIG_KASAN_SW_TAGS
> >> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >>  #define TCR_KASAN_FLAGS TCR_TBI1
> >>  #else
> >>  #define TCR_KASAN_FLAGS 0
> > 
> > I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> > user series, just do this in __cpu_setup.
> 
> Not sure I understand... Enabling TBI1 only if MTE is present would break
> KASAN_SW_TAGS which is based on TBI1 but not on MTE.

You keep the KASAN_SW_TAGS as above but for HW_TAGS, only set TBI1 later
in __cpu_setup().

-- 
Catalin
