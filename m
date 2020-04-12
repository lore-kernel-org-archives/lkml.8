Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB217C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8975D206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Twbhi8Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDLIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:31:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=btNs3lgMM1MmivBhTS9UymSjo7ZGpu8VEj7lHMK0UrE=; b=Twbhi8CfFv6UQYtiET41wHsBj2
        ZTjRIdfGaz8CChjAZEbYX9IybcyCYZYxfNuhfzHRztR6njTgT3BtruFnpmYA4tMHc1E8MJE1ZN6Ma
        mtKLWw25jz0qApJbR6okEbXV8alTgabxjzQZJQlnHsGwl5p7FgoqF3htzlN3aOBoT1C50W8hak6Ig
        TmLzTuce1QSTCB9MUjTvgtJUypDA1w4gdAzVX6rXfv7YNNQIQjSVRUoeKT5/lheArcuQFyVf1v95+
        aUY4o2dwOvY+sdMkdfq+s0nkWwac7ndZYkQpop4zgms0TQ9WGbWiXSvcBmr6I5REBQqWCpTuMvife
        mFljJleQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNY1v-0007Is-Al; Sun, 12 Apr 2020 08:31:51 +0000
Date:   Sun, 12 Apr 2020 01:31:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 4/9] stacktrace: export-GPL stack_trace_save_user
Message-ID: <20200412083151.GA17521@infradead.org>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
 <20200409193543.18115-5-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409193543.18115-5-mathieu.desnoyers@efficios.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:35:38PM -0400, Mathieu Desnoyers wrote:
> The stack_trace_save symbol is already exported GPL. Add a GPL export
> for the stack_trace_save_user symbol as well.
> 
> This is useful for tracers implemented as kernel modules.

Which part of every added export needs an in-tree user did you not get?
