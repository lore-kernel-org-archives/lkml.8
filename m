Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8766C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88469206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqaFysNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDDOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:22:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58058 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgDDOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586010158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBXXFQq1y2qUkhtU8bFmrD9Xf22O0XSHFLk6Da/v1Ng=;
        b=fqaFysNpRD7ViHHR2RRO8/AekGdLA2OsSeC9AkpgF0sUmaDOpQ3dHHhyKo8VpN64KeTzCn
        LGzzsHOx37Denawkz9MjmIpvS96W0ZrL0sBaRR3HW08x/7Q90N4H+HW57g/SMfuMdhPISC
        T5Pp1ZZ5Ha9M3du54klAdn3Big1+MYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-AapuGhmOOn2xw4RaB3Ma6g-1; Sat, 04 Apr 2020 10:22:36 -0400
X-MC-Unique: AapuGhmOOn2xw4RaB3Ma6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D328018A2;
        Sat,  4 Apr 2020 14:22:35 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 479415C1B0;
        Sat,  4 Apr 2020 14:22:34 +0000 (UTC)
Date:   Sat, 4 Apr 2020 09:22:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200404142232.wpn7estahnabfy3z@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200404133218.GL20760@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > > work here?
> > 
> > Yes, it would.
> 
> Sorry, I have reconsidered. While it will shut up objtool, it will not
> 'work'. That is, the ORC data generated will not correctly unwind.
> 
> I'll try and write a longer email tonight.

Right, that's what I've been trying to say.  The ORC data will be
non-deterministic unless we unroll the loop.  Or did you mean something
else?

-- 
Josh

