Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B59A2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEABLgi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgEUN0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:26:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52436 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729289AbgEUN0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590067581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9nJJxhm6AhP9YB0H6QD9cJhNAGEF9IdB2qwK5+C+IM=;
        b=YEABLgi9ieZH4occIn1htDqy0ha09n5ij5tY9fCf5c4ejz8RUyA9k2wY7dvIwZsdMOx9Fj
        0GZcnv/jEB74lKOOF9ib9haWCSvLUHyMFdiRq7ChPUW8reQ5egoxA0WVDZjVGhF0MRF1HL
        PzPCF4fHfZcS4i6EjtXeiRC8hpT8dFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-BhqEgp7JMjOBXpwha5nBWg-1; Thu, 21 May 2020 09:26:19 -0400
X-MC-Unique: BhqEgp7JMjOBXpwha5nBWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DBA3107ACCD;
        Thu, 21 May 2020 13:26:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE02D60C84;
        Thu, 21 May 2020 13:26:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 May 2020 15:26:17 +0200 (CEST)
Date:   Thu, 21 May 2020 15:26:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200521132610.GA8813@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
 <20200520152439.GC26470@redhat.com>
 <20200520153603.GP317569@hirez.programming.kicks-ass.net>
 <20200520201033.GA325303@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520201033.GA325303@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20, Peter Zijlstra wrote:
>
> I had a another go; I ended up with this...

Oh, thanks Peter!

Oleg.

