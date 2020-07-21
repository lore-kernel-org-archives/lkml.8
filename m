Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF9C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A31520771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf6Lc9Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGUJ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:27:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595323628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQico8pV1a2TFux4HtegeRv1HfcrTUY0AXTXyEI7ouw=;
        b=Pf6Lc9TiXa2rWvEZaCbIMFbVeqVDXCsBThXfPeVIcywVj8fSadjv1RfleZjXfVGZlf1vbm
        GXeFY3Jp+wHoFn47ArnGo4x/0cP1NvMv7H0HXZ5VE347IwmU7C9M0Ef+aZFA36td+1YiAb
        bjGTRAxouH/mCajw3IKWIbTf5Uym3L8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-CwJzldupNImtCRnfzLbJGg-1; Tue, 21 Jul 2020 05:27:07 -0400
X-MC-Unique: CwJzldupNImtCRnfzLbJGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C461009613;
        Tue, 21 Jul 2020 09:26:59 +0000 (UTC)
Received: from f32-m1.lan (ovpn-112-21.phx2.redhat.com [10.3.112.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E6492B5B5;
        Tue, 21 Jul 2020 09:26:59 +0000 (UTC)
Date:   Tue, 21 Jul 2020 02:26:58 -0700
From:   Kevin Buettner <kevinb@redhat.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_xstate_to_kernel: Fix typo which caused GDB
 regression
Message-ID: <20200721022658.299445d8@f32-m1.lan>
In-Reply-To: <87tuy1s0pw.fsf@mid.deneb.enyo.de>
References: <20200718002003.6e0a2aef@f32-m1.lan>
        <87tuy1s0pw.fsf@mid.deneb.enyo.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 10:59:07 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> * Kevin Buettner:
> 
> > This commit fixes a regression encountered while running the
> > gdb.base/corefile.exp test in GDB's test suite.
> >
> > In my testing, the typo prevented the sw_reserved field of struct
> > fxregs_state from being output to the kernel XSAVES area.  Thus the
> > correct mask corresponding to XCR0 was not present in the core file
> > for GDB to interrogate, resulting in the following behavior:
> >
> > [kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
> > Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
> > [New LWP 232880]
> >
> > warning: Unexpected size of section `.reg-xstate/232880' in core file.
> >
> > With the typo fixed, the test works again as expected.
> >
> > Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> > ---
> >  arch/x86/kernel/fpu/xstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 6a54e83d5589..9cf40a7ff7ae 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -1022,7 +1022,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
> >  		copy_part(offsetof(struct fxregs_state, st_space), 128,
> >  			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
> >  	if (header.xfeatures & XFEATURE_MASK_SSE)
> > -		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
> > +		copy_part(xstate_offsets[XFEATURE_SSE], 256,
> >  			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
> >  	/*
> >  	 * Fill xsave->i387.sw_reserved value for ptrace frame:  
> 
> Does this read out-of-bounds, potentially disclosing kernel memory?
> Not if the system supports AVX, I assume.

An overlarge offset (first parameter) passed to copy_part() will cause
fill_gap() to be called which will copy data out of &init_fpstate.xsave.
Care is taken in both fill_gap and copy_part to not copy more data
than the remaining count.

So, I think the answer is "no".

Kevin

