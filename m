Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964FFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C1820897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVpmqJ2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH1T3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgH1T3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598642962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdtdj/qJuUKfcRUuUdikqfvob9h1F3K434hS7QpQjU8=;
        b=RVpmqJ2tN3tS1g+w8YXgjka9Z5vcBV/DNL2TqI6FMLyQ1/f20BSOlPLRiy4xbPJHVnCix8
        SQlBXBM0UCeOA4CUF6gSQvffH7V31+NCJTodkntVRbeCj6j6aqRtAa+Al2k9zhNqnjgqRJ
        acD0xltj6fgJO+nk9lQMRQ3rao0lTTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-LNNBwONNO0ekvrInyxOPKA-1; Fri, 28 Aug 2020 15:29:20 -0400
X-MC-Unique: LNNBwONNO0ekvrInyxOPKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE6E31007B01;
        Fri, 28 Aug 2020 19:29:17 +0000 (UTC)
Received: from treble (ovpn-115-159.rdu2.redhat.com [10.10.115.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DBCA7A1C1;
        Fri, 28 Aug 2020 19:29:13 +0000 (UTC)
Date:   Fri, 28 Aug 2020 14:29:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200828192911.ezqspexfb2gtvrr7@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:50:06AM -0500, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
> 
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
> 
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
> 
> Remove all existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing.
> 
> barrier_nospec() is now unused, and can be removed.
> 
> Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Ping?

-- 
Josh

