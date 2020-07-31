Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AA722B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgGaOVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgGaOVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:21:31 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66956208E4;
        Fri, 31 Jul 2020 14:21:29 +0000 (UTC)
Date:   Fri, 31 Jul 2020 15:21:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/4] kasan, arm64: don't instrument functions that enable
 kasan
Message-ID: <20200731142126.GE29569@gaia>
References: <cover.1596199677.git.andreyknvl@google.com>
 <55d432671a92e931ab8234b03dc36b14d4c21bfb.1596199677.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d432671a92e931ab8234b03dc36b14d4c21bfb.1596199677.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 03:20:39PM +0200, Andrey Konovalov wrote:
> This patch prepares Software Tag-Based KASAN for stack tagging support.
> 
> With stack tagging enabled, KASAN tags stack variable in each function
> in its prologue. In start_kernel() stack variables get tagged before KASAN
> is enabled via setup_arch()->kasan_init(). As the result the tags for
> start_kernel()'s stack variables end up in the temporary shadow memory.
> Later when KASAN gets enabled, switched to normal shadow, and starts
> checking tags, this leads to false-positive reports, as proper tags are
> missing in normal shadow.
> 
> Disable KASAN instrumentation for start_kernel(). Also disable it for
> arm64's setup_arch() as a precaution (it doesn't have any stack variables
> right now).
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
