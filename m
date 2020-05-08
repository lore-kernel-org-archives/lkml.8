Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400ABC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E90820CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku9z/Hmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEHQ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:29:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588955362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsrbKd/D5PQo50yPbbpGTTA6lWR9/mOtKMgX8GS2HPY=;
        b=Ku9z/HmtMbJNAPhgHd85PIJeeP71uHPNpS6tjw7bokSefDfyW3Tk0c5UH4lSu+uA+65pmx
        k27+6Dbk8TcXE7UQbpS+YJH7lcbAW56w/2bLQ9sb9HQ+6WDtkB4Y5QcFXReoQKaTVoKrDf
        G9Okh8kzk56i/oETy4z2QQaIU4nxf9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-S3ISUO5_NEWFqhyY4XJGeg-1; Fri, 08 May 2020 12:29:21 -0400
X-MC-Unique: S3ISUO5_NEWFqhyY4XJGeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDBD461;
        Fri,  8 May 2020 16:29:19 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5378F61988;
        Fri,  8 May 2020 16:29:19 +0000 (UTC)
Date:   Fri, 8 May 2020 11:29:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508162917.nieghzwlzpkv676l@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
 <20200508095509.GX5298@hirez.programming.kicks-ass.net>
 <20200508161750.bl5c7wh36gh6gcvp@treble>
 <20200508162604.GE3344@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508162604.GE3344@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 06:26:04PM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 11:17:50AM -0500, Josh Poimboeuf wrote:
> > On Fri, May 08, 2020 at 11:55:09AM +0200, Peter Zijlstra wrote:
> > > On Fri, May 08, 2020 at 11:27:39AM +0200, Arnd Bergmann wrote:
> > > 
> > > > Right, makes sense. It would be nice though to have a way of intentionally
> > > > turning all objtool warnings into errors. I do my randconfig tests
> > > > with '-Werror'
> > > > at the moment in order to catch all new warnings, but this does not catch
> > > > objtool errors at the moment. For now, this is probably the right thing to do,
> > > > as there are a couple of warnings that I have no patches for, but at some point
> > > > I would prefer to trap immediately when a new warning pops up.
> > > 
> > > Completely untested, and I'm 100% unsure of the Makefile change, but
> > > something like so, then?
> > 
> > Mostly looks good, but it only errors out on fatal errors, right?  For
> > -Werror (and what Arnd is asking about) should it also return error on
> > "warnings > 0"?
> 
> Oh, good point. Extra knob or just: if (error && ret) return -1 ?

I think a single knob (hooked up to -Werror) is good enough for now.

-- 
Josh

