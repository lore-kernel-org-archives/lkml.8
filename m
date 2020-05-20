Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D142D20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589933401;
	bh=ncS4/WJ13FIx6+ovp8byd0aXq8LXhHwOMR/bGy+ucpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MqUZOJzI+QR+CgPkzkn2HIhywZDb5ThXEWUGUgZ5nZ+2SkCz5zEiMfb0AaYZsK+G0
	 UHsjYxtlZfIaZ+3hFnyVD79tGSwBAsS9P8zoBnp4CrckMDTA56GukakPvcUQLi5Vie
	 Vu9l8XQCAo8QOlTQgs6xRl1SWKQHooy295IHVbCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgETAKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETAKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:10:00 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127CA207C4;
        Wed, 20 May 2020 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589933399;
        bh=ncS4/WJ13FIx6+ovp8byd0aXq8LXhHwOMR/bGy+ucpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T4knsEdcbJxOWgUV5tpYiL5MmKlO+Lup+tlcl6W5gxC7ZR1kNeChYC+sK2ciY9bbJ
         IDXkgQPZWuoHtFdmT06VI2UA+8pxn/h8x/CujDcnmo0Tc385EL3r++J5E26Jx/Q3hS
         C2mYP3dD9X2uXhyuPW5VrKIi7I2qNpiXTTvD8HOU=
Date:   Tue, 19 May 2020 17:09:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] kasan: Disable branch tracing for core runtime
Message-Id: <20200519170958.d6e399f7f98286c1162f1383@linux-foundation.org>
In-Reply-To: <CAAeHK+wcrmo=Hhwvqzd8kC-=5UR+fzRcA_4mo8wccWCTdrEzEQ@mail.gmail.com>
References: <20200519182459.87166-1-elver@google.com>
        <CAAeHK+wcrmo=Hhwvqzd8kC-=5UR+fzRcA_4mo8wccWCTdrEzEQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 23:05:46 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> On Tue, May 19, 2020 at 8:25 PM Marco Elver <elver@google.com> wrote:
> >
> > During early boot, while KASAN is not yet initialized, it is possible to
> > enter reporting code-path and end up in kasan_report(). While
> > uninitialized, the branch there prevents generating any reports,
> > however, under certain circumstances when branches are being traced
> > (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> > reboots without warning.
> >
> > To prevent similar issues in future, we should disable branch tracing
> > for the core runtime.
> >
> 
> ...
>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks, I queued this for 5.7.
