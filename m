Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9375C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884DF20757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584759342;
	bh=WYHey6RdRp28Eiok84ttrbASQ178kyK/M8p22x1XXyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aoqRiUB8mjc7fljUnFhP+DxFBlknGPn8cchfiIzmjr7I1yCPV+TZFVVryTnJFhgqF
	 gipDh9GzOBD7UdPpiLh9rzbzejlpE21Eaf1P/nDujLNiGXPDG8e+JOgdbiokZf/GU3
	 m1roqkiVdB4yu9ZbnfaSinhInr8IH+MhY4tkhcOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCUCzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 22:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCUCzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 22:55:41 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8801220752;
        Sat, 21 Mar 2020 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584759340;
        bh=WYHey6RdRp28Eiok84ttrbASQ178kyK/M8p22x1XXyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E+21iFKKZXSdPrF54pyoIvvbYXUcitnppAnAKc3x8GtUJ8FgITLDWGCGgluyU5JHk
         2zi5pOwCs87RA2FoYcpoHt74Kzc/Ml8H/yQ2mYl1RNYyYnVFqgZ3hlkwxzN4/INqVV
         mX3AGepeFjLPFpN3UI6UFeFor++cpS1/wxWmDRWo=
Date:   Fri, 20 Mar 2020 19:55:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] psi: Move PF_MEMSTALL out of task->flags
Message-Id: <20200320195540.4b50a01e601d67bb3574cf2a@linux-foundation.org>
In-Reply-To: <CALOAHbDGvbZ6x6pDcPah3_3YV9mwMtuFWbLhi0hTQmRro73jqg@mail.gmail.com>
References: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com>
        <158470908459.28353.7390210153247885071.tip-bot2@tip-bot2>
        <CALOAHbDGvbZ6x6pDcPah3_3YV9mwMtuFWbLhi0hTQmRro73jqg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020 10:47:05 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> This patch was aleady added into Andrew's -mm tree.[1]
> I'm not sure whether that could cause merge conflict when both of them
> are merged into Linus's tree.
> 

That's OK - if a patch turns up in someone else's -next tree I'll drop
my copy.  Usually after checking that the other copy was the same
version (it usually is) and after checking whether it has up to date
cc:stable and review/ack tags (it usually doesn't!).

