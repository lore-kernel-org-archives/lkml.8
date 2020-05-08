Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD69C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7133824954
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ6SSAW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgEHQBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:01:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEHQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588953691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LkMQAQyCyRsGiygZwM0QwLTkw6iqVkAYQ2dn3WWLSk=;
        b=KQ6SSAW5l89NPzkjnsm842JDFKd0Vxm9oz35fFhZeF8AjAh4DVBVxha8doNbZRLrfuc/+R
        +ONcWSUUDeJm2KJ45JKcHOAuZ5EkUK9xgOaPTmfpG/5F9iuIddbmpb8SvPdUCSJ68umAPp
        4/g2FpP0GYaYqOkygkLnkzDCqqx9IKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-WIhy7G_8NaWGf6v478Z7tg-1; Fri, 08 May 2020 12:01:28 -0400
X-MC-Unique: WIhy7G_8NaWGf6v478Z7tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39E8684B8A4;
        Fri,  8 May 2020 16:01:26 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 544516AD13;
        Fri,  8 May 2020 16:01:24 +0000 (UTC)
Date:   Fri, 8 May 2020 11:01:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-05-05-15-28 uploaded (objtool warning)
Message-ID: <20200508160122.hsqb25lzhd2xkisv@treble>
References: <20200505222922.jajHT3b4j%akpm@linux-foundation.org>
 <36dc367a-f647-4ee8-a327-d1c3457a7940@infradead.org>
 <20200508103830.GZ5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508103830.GZ5298@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 12:38:30PM +0200, Peter Zijlstra wrote:
> Subject: objtool: Allow no-op CFI ops in alternatives
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri May 8 12:34:33 CEST 2020
> 
> Randy reported a false-positive: "alternative modifies stack".
> 
> What happens is that:
> 
> 	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
>  13d:   89 9d 00 d0 7f ff       mov    %ebx,-0x803000(%rbp)
> 
> decodes to an instruction with CFI-ops because it modifies RBP.
> However, due to this being a !frame-pointer build, that should not in
> fact change the CFI state.
> 
> So instead of dis-allowing any CFI-op, verify the op would've actually
> changed the CFI state.
> 
> Fixes: 7117f16bf460 ("objtool: Fix ORC vs alternatives")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It helps to put an example of the fixed warning in the commit log, like:

This fixes the following warning:

  arch/x86/hyperv/hv_apic.o: warning: objtool: hv_apic_write()+0x25: alternative modifies stack

Otherwise it looks good.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

