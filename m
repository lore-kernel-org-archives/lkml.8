Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD792192A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5rBkAjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGNCvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 19:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fiiZnEYG1QnhgVM3Xxq9kA7j2/YA18FQvN2M1Z9IM1w=; b=D5rBkAjHu1cIwv0MsZQoxUzIXd
        9wwXgWiIXiuIphDFWKhMGiOWnG0mrUH/WrNqdyZTEv3VAsiyDS7g2I28XgZUqcWN22upRhxTU0wo0
        qFMNeEvaDVLDFxH085RFsyP46UXeLQjdj30WJlpkR/v6lVBmxJu0gPn1ypB0t28CeV3U3F71fF2wV
        OzzsdyX3UwesQqI/d4/rAIAjXC0PB4+iKKw2qThEJrG/wDhNM/bbMIyOuXy5n0c0mAH+V+BBU07k8
        IQuJP7ODBSCsUXIRKnALCNsm1YQuwUAKact/9q/xhiwOmzSviOxh5LSmKrsetg0AyC94MO1oHN1AA
        pv7PRHzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvB22-0002cx-7C; Tue, 14 Jul 2020 02:50:58 +0000
Date:   Tue, 14 Jul 2020 03:50:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Changming <charley.ashbringer@gmail.com>, rdunlap@infradead.org,
        keescook@chromium.org, mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: prevent panic_timeout * 1000 from overflow
Message-ID: <20200714025058.GZ12769@casper.infradead.org>
References: <0d4601d65709a0e2d80e2a8880gmail.com>
 <20200711051728.1499-1-charley.ashbringer@gmail.com>
 <20200713185739.03d576cca0dc9f618ea76d67@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713185739.03d576cca0dc9f618ea76d67@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 06:57:39PM -0700, Andrew Morton wrote:
> +++ a/kernel/panic.c
> @@ -313,13 +313,16 @@ void panic(const char *fmt, ...)
>  		 * Delay timeout seconds before rebooting the machine.
>  		 * We can't use the "normal" timers since we just panicked.
>  		 */
> +		u64 timeout = panic_timeout * 1000;	/* avoid overflow */

1000ULL to not truncate before the assignment.

> +		u64 timer;

... as you implied later

		u64 timer, timer_next;

> (untested)

Well, there's the rub.  Testing requires 49 days (2^32 / 1000 seconds).

