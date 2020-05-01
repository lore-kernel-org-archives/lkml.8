Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED1C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F246C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaLqkKvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgEAPt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:49:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728946AbgEAPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588348167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4RTZ0CbhEIBMzYEl8v7jF1WWsPB2iFQM6cIOM/+yR0=;
        b=GaLqkKvWTYTrc6tqt5/OOucH3GKho7qLnk6H+bFY+oln4tcoZrL0YtKwDgiLWlEJWZI28a
        hPDgXRmN2ODo+KgnjoiP3hjkwVv4xyVfUULiQ0TbSBSgEtRitpqiYoLVt092q+A02ehgSL
        m2L/iiO+kXJzxhLSIO794sUovAhdo18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-qLj1j1XkOU-fwqAOIoMv5w-1; Fri, 01 May 2020 11:49:23 -0400
X-MC-Unique: qLj1j1XkOU-fwqAOIoMv5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744481902EBB;
        Fri,  1 May 2020 15:49:22 +0000 (UTC)
Received: from treble (ovpn-114-104.rdu2.redhat.com [10.10.114.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9A3761524;
        Fri,  1 May 2020 15:49:19 +0000 (UTC)
Date:   Fri, 1 May 2020 10:49:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501154917.azhvf2wtfo6stlkl@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <20200501010733.ptvgzl3nbxybo4rd@treble>
 <20200501123319.GC3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501123319.GC3762@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 02:33:19PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 30, 2020 at 08:07:33PM -0500, Josh Poimboeuf wrote:
> > On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133: call to do_strncpy_from_user() with UACCESS enabled
> > > lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to do_strnlen_user() with UACCESS enabled
> > 
> > Does this fix it?
> > 
> 
> GCC is a moron, a static function with inline and a single callsite,
> let's out-of-line it, shees!, try this instead:

Yeah, that's easier :-)

-- 
Josh

