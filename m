Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0557F20678
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKTGWXwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404214AbgDCPSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:18:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404080AbgDCPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585927085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etiNrC6SF+z4dhOkBjuavSdV/C9Y+UgseJ5rH+u2MOc=;
        b=eKTGWXwrvKPNBCPhtJt7a5ouSDU7N2eMbDvBt8cKLpuMbR96YgCy6HU2R2rFLKkwzQBh1F
        e8YYsET+BUvk2+pv6OmozHf2JpuxCtvy/oG8x2DHf7ZUI1ePX2sauRFou1IzvcLL1h+ZqT
        L7m33o+7MieTtDuo1mTmd2LkdCw1oek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-qPb-2X7BME-03Ix2DbOnUA-1; Fri, 03 Apr 2020 11:18:03 -0400
X-MC-Unique: qPb-2X7BME-03Ix2DbOnUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2700218C35A2;
        Fri,  3 Apr 2020 15:18:02 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6D6226DC4;
        Fri,  3 Apr 2020 15:18:00 +0000 (UTC)
Date:   Fri, 3 Apr 2020 10:17:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200403151757.lhhia7pzqptvlqz5@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:11:55AM +0100, Julien Thierry wrote:
> 
> 
> On 4/2/20 4:40 PM, Peter Zijlstra wrote:
> > On Thu, Apr 02, 2020 at 04:31:05PM +0100, Julien Thierry wrote:
> > > My understanding is that once you find an intra-function call, either you
> > > hit a return, ending the branch, so the return should undo the modification
> > > the intra-function call did (whether is it a retpoline return or not).
> > > Otherwise, the intra-function call branch will need to reach an end in some
> > > way (e.g. hitting a CONTEXT_SWITCH instruction, calling a
> > > dead_end_function).
> > > 
> > > Am I missing something?
> > 
> > The thing is basically doing:
> > 
> > 	mov  $n, cx
> > 1:	call 2f
> > 2:	dec  cx
> > 	jnz  1b
> > 	add  8*n, sp
> > 
> > So it does N calls to self, then subtracts N words from the stack.
> > 
> > The reason being that the CPU has a return-stack-buffer for predicting
> > returns, and call/ret being naturally paired, that works. The above
> > is a software flush of the RSB.
> > 
> 
> Ah, lovely... Maybe that's where SAVE/RESTORE unwind hints could be nice ;)
> .
> 
> Otherwise, I don't really have a good suggestion for this...

Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
work here?

-- 
Josh

