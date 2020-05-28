Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF59C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C036207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXv+0Oeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE1Od4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:33:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26988 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbgE1Odw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590676431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBQOiMcyjxJF5KMUzY58hCHngjZNJvMhsoqslwe6gEA=;
        b=YXv+0Oeh1Q0yutAWk4URrAAvVh6i/aRW9cwk5OME/lf3tc6+SGMRJ49VniXkoTEV0SElvc
        KeuXycQ/ivnwDx5f0fYkiedLT4MR4NQSqU8I9Il/ux00BsYmjqOBg4VAlPLSXX0QHm1s4R
        9WxMFE4fwTy2lRXDzeCSLF78ODpXZzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MJXjkSsVN8mXu_JMQ8LJVQ-1; Thu, 28 May 2020 10:33:46 -0400
X-MC-Unique: MJXjkSsVN8mXu_JMQ8LJVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE4083DB39;
        Thu, 28 May 2020 14:33:44 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B5692C24F;
        Thu, 28 May 2020 14:33:43 +0000 (UTC)
Date:   Thu, 28 May 2020 09:33:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
Message-ID: <20200528143341.ntxtnq4rw5ypu3k5@treble>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
 <20200528134913.GA1810@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528134913.GA1810@lca.pw>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:49:13AM -0400, Qian Cai wrote:
> On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > The kasan_report() functions belongs to report.c, as it's a common
> > functions that does error reporting.
> > 
> > Reported-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Today's linux-next produced this with Clang 11.
> 
> mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled
> 
> kasan_report at mm/kasan/report.c:536

Peter, this was also reported with GCC about a month ago.  Should we add
__stack_chk_fail() to the uaccess safe list?

-- 
Josh

