Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD41BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24D0206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJfn5M9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbgDCRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:24:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgDCRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585934656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQcoDzg7dqsbSOK/FNjmA6dmkRKt+JbKVQHmTtEj3TE=;
        b=VJfn5M9PpoOT1n9MWv98oZfchJaOTOMbxr3FC/mlBPtlWnBkN8uB/3GfjA+qvOXOEdcJUX
        fItGybK4v0xPtnBoQIyYKjmUT3EoHKHHlJlXQZ50XnCC3h0VW2pMhFdCqfGpDeETe9qXZQ
        3/MYYFHRuvnh3XV70N9frGnu9rGgpwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-FdqbzCerOFm2yu-ZDwDc6w-1; Fri, 03 Apr 2020 13:24:13 -0400
X-MC-Unique: FdqbzCerOFm2yu-ZDwDc6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91D7800D53;
        Fri,  3 Apr 2020 17:24:11 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFD791001938;
        Fri,  3 Apr 2020 17:24:10 +0000 (UTC)
Date:   Fri, 3 Apr 2020 12:24:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Message-ID: <20200403172408.odvcsymwlyx6ises@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
 <20200403160538.qwu237amhanr6pyi@treble>
 <20200403161607.jxz6duaz7dud22wf@treble>
 <2c615bae-6002-80b7-493d-b24ec48f69c9@oracle.com>
 <20200403171836.GB20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403171836.GB20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:18:36PM +0200, Peter Zijlstra wrote:
> What we need in this case though is only a different stack layout inside
> the alternative, and that is doable.

I'm not sure what you mean... any stack changes within the alternative
have to match exactly the stack changes at the same offsets of the
original code because ORC doesn't know the difference between the two.

-- 
Josh

