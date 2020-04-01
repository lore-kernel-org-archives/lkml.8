Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FBC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCAE20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbgDAOg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:36:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:49020 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbgDAOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:36:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4991F2D5;
        Wed,  1 Apr 2020 14:36:24 +0000 (UTC)
Date:   Wed, 1 Apr 2020 08:36:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Mathew <john.mathew@unikie.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@basemark.com
Subject: Re: [RFC PATCH 2/3] docs: scheduler: Add scheduler overview
 documentation
Message-ID: <20200401083623.1647d16a@lwn.net>
In-Reply-To: <20200401115403.GG21484@bombadil.infradead.org>
References: <20200401100029.1445-1-john.mathew@unikie.com>
        <20200401100029.1445-3-john.mathew@unikie.com>
        <20200401115403.GG21484@bombadil.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 04:54:03 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> > +the CPU core. The main members of the :c:type:`struct rq <rq>` are:
> > +
> > +:c:member:`nr_running`
> > +    Total number of tasks on the runqueue.  
> 
> This seems like it should be kernel-doc so the documentation is with the
> code ... meaning it might possibly get updated when the code changes as
> opposed to languishing over here.

That was my first impression as well.

Thanks for working on the docs; I'll take a closer look soon.

jon
