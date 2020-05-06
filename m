Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD481C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFBD208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMHMJrvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgEFRcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:32:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEFRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588786364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VOdssxZdNaLS0bokQVJ/VEmm5cI5XKzXe3OI8bosrIM=;
        b=bMHMJrvPWznKHuQLzc2q3LbB0XVE77nHkjn4FGignc86vuaecvP5VUFiHwqQC641MvJ254
        cPbah0ESEaKS7LnfMWBnnhxzZcw0d2hXB6XDrnXYaWGWtpyWAOcM++w7x4S249yjYxSLu0
        dIAqyuQBdd015MNoZYTFdVBkloiX80o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-NMff3vuvMxyKnVURQUHFjg-1; Wed, 06 May 2020 13:32:40 -0400
X-MC-Unique: NMff3vuvMxyKnVURQUHFjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3419F107ACCD;
        Wed,  6 May 2020 17:32:38 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EAB519451;
        Wed,  6 May 2020 17:32:31 +0000 (UTC)
Date:   Wed, 6 May 2020 12:32:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 00/18] Add static_call()
Message-ID: <20200506173229.hjl7s42hnz5bc23s@treble>
References: <20200501202849.647891881@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202849.647891881@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:28:49PM +0200, Peter Zijlstra wrote:
> static_call(), is the idea of static_branch() applied to indirect function
> calls. Remove a data load (indirection) by modifying the text.
> 
> The inline implementation still relies on objtool to generate the
> .static_call_sites section, mostly because this is a natural place for x86_64
> and works for both GCC and LLVM.  Other architectures can pick other means
> if/when they implement the inline patching. The out-of-line (aka. trampoline)
> variant doesn't require this.
> 
> Patches go on top of tip/objtool/core.
> 
> Patches can also be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call

So this branch has

  45a5c99a226a ("x86/tlb: Move trace_tlb_flush() declaration")

but I didn't see it posted here.  I guess you dropped it because it's no
longer needed b/c we fixed those 'undefined references' a different way.

-- 
Josh

