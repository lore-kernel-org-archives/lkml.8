Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1624FC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25EE208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVGTX217"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEAA3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:29:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40284 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727863AbgEAA3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588292944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYewA0fFlyADVd0p8CJX211MvejgB33mSe44gCbIHv4=;
        b=BVGTX217S/3ZmJ+NHMYCDnGIYbQKkFEuojAp+uSD7mqLnRmUMNfLgdcZoeNgbeY5M+X7qh
        SRhKWekNa/IRs/bAY+BZ1O3a/V0k02tYvQctpCkDyucCq5KNWyXtkaiS7j4bUB745CrPZJ
        XUPjd1aDSptop0ybpEDUtQilHdhCrNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-Lqw_XGd9Nz-mOnRTzxLZZQ-1; Thu, 30 Apr 2020 20:29:02 -0400
X-MC-Unique: Lqw_XGd9Nz-mOnRTzxLZZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EEC80B702;
        Fri,  1 May 2020 00:29:01 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07A795C1B0;
        Fri,  1 May 2020 00:29:00 +0000 (UTC)
Date:   Thu, 30 Apr 2020 19:28:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501002858.4wuiqqv5o32jcvxf@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> lib/locking-selftest.o: warning: objtool: locking_selftest()+0x117f: PUSHF stack exhausted
> lib/locking-selftest.o: warning: objtool: ww_tests()+0x1083: PUSHF stack exhausted

Peter,

These functions have a bunch of irqs_disabled() checks, which means a
bunch of PUSHFs with no POPFs.

Am I reading it correctly that objtool assumes PUSHF is always paired
with POPF?  irqs_disabled() doesn't do that.

-- 
Josh

