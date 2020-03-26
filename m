Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E60C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4182B206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbQ/aCJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCZNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38282 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgCZNpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585230304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQtbs7TzLHWY5I9ZdLa1pDEr0Expi50AmSAdlfzHWB4=;
        b=RbQ/aCJ7MAbc0Ibeic7htehGGCmG5o+ksOBolvfb7y8peVNvUSAVhGZXsYjSJ9SRd9Kw/c
        EAffn+dWzCEflgkn2tHmd0nhdHl+bwYe7AA668qZMY/GWxLEiwIh4mA3XwLZP/eP3MsfpL
        01l/tEozD9G18jrctkPwqsh3JpcurTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-GYnRJ1LBM7OZzNORHMTx6A-1; Thu, 26 Mar 2020 09:44:53 -0400
X-MC-Unique: GYnRJ1LBM7OZzNORHMTx6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84CB71937FFA;
        Thu, 26 Mar 2020 13:44:51 +0000 (UTC)
Received: from treble (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A483260BF3;
        Thu, 26 Mar 2020 13:44:50 +0000 (UTC)
Date:   Thu, 26 Mar 2020 08:44:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326134448.5zci3ikdlf5ar2w5@treble>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326125844.GD20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326125844.GD20760@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:58:44PM +0100, Peter Zijlstra wrote:
> So instr_begin() / instr_end() have this exact problem, but worse. Those
> actually do nest and I've ran into the following situation:
> 
> 	if (cond1) {
> 		instr_begin();
> 		// code1
> 		instr_end();
> 	}
> 	// code
> 
> 	if (cond2) {
> 		instr_begin();
> 		// code2
> 		instr_end();
> 	}
> 	// tail
> 
> Where objtool then finds the path: !cond1, cond2, which ends up at code2
> with 0, instead of 1.

Hm, I don't see the nesting in this example, can you clarify?

> I've also seen:
> 
> 	if (cond) {
> 		instr_begin();
> 		// code1
> 		instr_end();
> 	}
> 	instr_begin();
> 	// code2
> 	instr_end();
> 
> Where instr_end() and instr_begin() merge onto the same instruction of
> code2 as a 0, and again code2 will issue a false warning.
> 
> You can also not make objtool lift the end marker to the previous
> instruction, because then:
> 
> 	if (cond1) {
> 		instr_begin();
> 		if (cond2) {
> 			// code2
> 		}
> 		instr_end();
> 	}
> 
> Suffers the reverse problem, instr_end() becomes part of the @cond2
> block and cond1 grows a path that misses it entirely.
> 
> So far I've not had any actual solution except adding a NOP to anchor
> the annotation on.

Are you adding the NOP to the instr_end() annotation itself?  Seems like
that would be the cleanest/easiest.

Though it is sad that we have to change the code to make objtool happy
-- would be nice if we could come up with something less intrusive.

-- 
Josh

