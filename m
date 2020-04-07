Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC048C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E7206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD3Q/HT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgDGNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728915AbgDGNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586266535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2H/nDRAzZ+OGlMxBcAYNBB1VSVG7oxv1UHGK2TnTwUQ=;
        b=cD3Q/HT8x9FfpXf8EEETVWHUgssq0/FyXnaPMKwUZN8lR22FBT4W9gwFGtgNXM81axSAjh
        3uwv5LNRJbyM3GUPJ6yCEdlUzbU+G/hAYhycVTsIEIp2RlTtEB7sjZJZuBJwqSjD63Etez
        id6prq9Wgaxfqxjj/ErtrNGgQ2/ph2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-SSra-W0VMfC3O-cIc41Dsg-1; Tue, 07 Apr 2020 09:35:33 -0400
X-MC-Unique: SSra-W0VMfC3O-cIc41Dsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CD21926DA0;
        Tue,  7 Apr 2020 13:35:32 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E89AB92FA2;
        Tue,  7 Apr 2020 13:35:30 +0000 (UTC)
Date:   Tue, 7 Apr 2020 08:35:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 0/9] objtool changes to remove all
 ANNOTATE_NOSPEC_ALTERNATIVE
Message-ID: <20200407133528.htoxyrfc7fv625lh@treble>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:33AM +0200, Alexandre Chartre wrote:
> Hi,
> 
> This is version v2 of this patchset based on the different comments
> received so far. It now uses and includes PeterZ patch to add
> UNWIND_HINT_RET_OFFSET. Other changes are described below.
> 
> Code like retpoline or RSB stuffing, which is used to mitigate some of
> the speculative execution issues, is currently ignored by objtool with
> the ANNOTATE_NOSPEC_ALTERNATIVE directive. This series adds support
> for intra-function calls to objtool so that it can handle such a code.
> With these changes, we can remove all ANNOTATE_NOSPEC_ALTERNATIVE
> directives.
> 
> Changes:
>  - replace RETPOLINE_RET with PeterZ UNWIND_HINT_RET_OFFSET
>  - make objtool intra-function call action architecture dependent
>  - objtool now automatically detects and validates all intra-function
>    calls but it issues a warning if the call was not explicitly tagged
>  - change __FILL_RETURN_BUFFER to work with objtool
>  - add generic ANNOTATE_INTRA_FUNCTION_CALL macro
>  - remove all ANNOTATE_SPEC_ALTERNATIVE (even for __FILL_RETURN_BUFFER)

I had trouble applying the patches.  What branch are they based on?  In
general the latest tip/master is good.

-- 
Josh

