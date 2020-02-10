Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE7C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B5214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581301212;
	bh=c9R1yL17Ieuk+QF6jhqru/+TVSnntO0E6LwgLPaJB5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zN27CqzndHbfKF6gOawSVZzHI+gzgcOySE/Csg3jQN7fZ5W4dpgxRbQFugK0uPN4O
	 2WmsiX15slqCIpbBI1WgmCP/EgMOqcvbeP3+Yt6NInZY+rW2t+7tP3Pvl+YJ7L/9yV
	 Oc+f7TeSMmVe6iR+sJIlawVu0VqcV+VIBjJyr96U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBJCUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgBJCUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:20:11 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E907F20578;
        Mon, 10 Feb 2020 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581301209;
        bh=c9R1yL17Ieuk+QF6jhqru/+TVSnntO0E6LwgLPaJB5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lLD/+OqYa2flV1yIcil8qIGO7j8MWm1DgNl2AlT4UoFHBX9YBrSSzL9S90u8kbKem
         f0Rme8LLpw2Ymd1ER75n9IBSltGzpDGwhgxIEy3GrWZVq0QVgHZj2o5ujZw4kRdn4c
         rh6BcW9jRbLcYq1JUiH+7itRqvwaUY8bmsXuaIbM=
Date:   Sun, 9 Feb 2020 18:20:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, jhubbard@nvidia.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in
 page_zonenum
Message-Id: <20200209182008.008c06f1cf4347a95f9de0a5@linux-foundation.org>
In-Reply-To: <95A69596-D5F9-41EB-84A0-AE32D17FE320@lca.pw>
References: <20200206183000.913-1-cai@lca.pw>
        <20200206202005.GY8731@bombadil.infradead.org>
        <95A69596-D5F9-41EB-84A0-AE32D17FE320@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 15:25:41 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Feb 6, 2020, at 3:20 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Thu, Feb 06, 2020 at 01:30:00PM -0500, Qian Cai wrote:
> >> Both the read and write are done only with the non-exclusive mmap_sem
> >> held. Since the read only check for a specific bit range (up to 3 bits)
> >> in the flag but the write here never change those 3 bits, so load
> >> tearing would be harmless here. Thus, just mark it as an intentional
> >> data races using the data_race() macro which is designed for those
> >> situations [1].
> > 
> > This changelog makes me think you don't really understand the situation.
> > 
> > A page never changes its zone number.  The zone number happens to be
> > stored in the same word as other bits which are modified, but the zone
> > number bits will never be modified by any other write.  So we can accept
> > a reload of the zone bits after an intervening write and we don't need
> > to use READ_ONCE().
> 
> Maybe your explanation is better, but I did try to explain the same thing.
> I’ll let Andrew to decide if he would like to update the commit log a bit
> with your wording.

Using data_race() here seems misleading - there is no race, but we're
using data_race() to suppress a false positive warning from KCSAN, yes?

That's a bit hacky.  If this happens rarely then perhaps adding a
suitable comment in page_zonenum() which explains this will suffice. 
But if we keep on abusing data_race() in this fashion then it would be
better to add a new macro for this purpose.


