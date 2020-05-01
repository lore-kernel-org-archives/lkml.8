Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B73C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B41E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TntHSw7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgEARuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729393AbgEARub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588355429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucsSzBpiK2ssiDfbxZQQI4SWzJTSeJKTe65zvN75TBE=;
        b=TntHSw7X46jcYNQVw/VACPmckN+RqKvUvmirs34AeZGDFw9uF9GuPyzCljJnJRV3i8wCVu
        6PupF0u30afATKEIc8BQQqjTsgV5cCrpB3AvrN2BktgXcMo2wmU8joMDuI80KVKRXY5+z4
        e+s44Rcn75fyjECILeZHclTkAw1gGhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-GTX5sAw_MO-B9Pq1twleUg-1; Fri, 01 May 2020 13:50:26 -0400
X-MC-Unique: GTX5sAw_MO-B9Pq1twleUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EEED108BD16;
        Fri,  1 May 2020 17:50:25 +0000 (UTC)
Received: from treble (ovpn-114-104.rdu2.redhat.com [10.10.114.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 636845EE10;
        Fri,  1 May 2020 17:50:24 +0000 (UTC)
Date:   Fri, 1 May 2020 12:50:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501175022.yf3a34lu3ufui5ag@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
 <20200501172616.GG3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501172616.GG3762@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 07:26:16PM +0200, Peter Zijlstra wrote:
> On Fri, May 01, 2020 at 07:21:31PM +0200, Arnd Bergmann wrote:
> > On Thu, Apr 30, 2020 at 4:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > it gets into undefined behavior and stops emitting code after the call to
> 
> > Do we consider this expected behavior on gcc's side, or is it something
> > that should not happen and needs a gcc bug report?
> 
> When it hits UB it is of course free to do whatever it damn well
> pleases, but just stopping code gen seems a little extreme, at least
> issue a WARN that something is up or so.
> 
> Not sure how the GCC folks feel about this though.

When we've seen truncated code flow like this in the past, it's either
been a code bug (undefined behavior) or a GCC bug.  So this is new.

Is it only seen with GCC_PLUGIN_SANCOV enabled?  Maybe (hopefully) it's
an issue with the plugin and how it interacts with GCC 10.

-- 
Josh

