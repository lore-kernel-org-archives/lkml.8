Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04D1206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ9hvMhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391134AbgDCPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbgDCPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585929327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBpiA5SE7bEaYQLZT8VAY3Z8TzYQ+tyL/MDheL+0R44=;
        b=cZ9hvMhBOLezUkZvyOToBMoY7YZqjEvw0grJokiTyj2/oWwzFIbtZcENs0ySOF0xRoOs7j
        oa6uR7FN1MEnKHPvkv8/xMAdR7JA7GbMbBSLSUYLwi94fK1ge5KAa1MlYGFmedCZHRGPIN
        YaTImdV4fpvwPgjoZkbd8+WCzP9YYRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-JU5LsWLmO9uzwvT6q3V-zA-1; Fri, 03 Apr 2020 11:55:25 -0400
X-MC-Unique: JU5LsWLmO9uzwvT6q3V-zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EBA1005513;
        Fri,  3 Apr 2020 15:55:24 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84DD06EF97;
        Fri,  3 Apr 2020 15:55:23 +0000 (UTC)
Date:   Fri, 3 Apr 2020 10:55:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200403155521.6s23hnqd4y3mukna@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403154620.GS20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > work here?
> 
> Yes, it would.

Only thing is we'd need to unroll the RSB loop so each instruction has
a deterministic stack size.

-- 
Josh

