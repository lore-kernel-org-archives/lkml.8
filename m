Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF14C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7739A206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enQpIqps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEHQR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbgEHQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588954676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cq6j25gVWDrKA1Gzu7PgTeE3kgyozrCkdo4cZnz6hso=;
        b=enQpIqpsrNhH0TrJupQPhf4w+IBRKz0l2/hsk4twJmZBB+W/GotELaH5gZd4JO0AsJddE2
        nivqiU9KW+8My8JLdofRLIDUnI3kHip2+B791e9a7wBxkvh2PgMSMTrpF+VM79aRo4/TP9
        iyt08YF2I+3klxqkFHiTsM7F3465eBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-fmT4O0YmMcm1AXxXqTN_wQ-1; Fri, 08 May 2020 12:17:54 -0400
X-MC-Unique: fmT4O0YmMcm1AXxXqTN_wQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F00FA1B18BC1;
        Fri,  8 May 2020 16:17:52 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6650260FC2;
        Fri,  8 May 2020 16:17:52 +0000 (UTC)
Date:   Fri, 8 May 2020 11:17:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508161750.bl5c7wh36gh6gcvp@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
 <20200508095509.GX5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508095509.GX5298@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:55:09AM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 11:27:39AM +0200, Arnd Bergmann wrote:
> 
> > Right, makes sense. It would be nice though to have a way of intentionally
> > turning all objtool warnings into errors. I do my randconfig tests
> > with '-Werror'
> > at the moment in order to catch all new warnings, but this does not catch
> > objtool errors at the moment. For now, this is probably the right thing to do,
> > as there are a couple of warnings that I have no patches for, but at some point
> > I would prefer to trap immediately when a new warning pops up.
> 
> Completely untested, and I'm 100% unsure of the Makefile change, but
> something like so, then?

Mostly looks good, but it only errors out on fatal errors, right?  For
-Werror (and what Arnd is asking about) should it also return error on
"warnings > 0"?

-- 
Josh

