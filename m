Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC5C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA2020740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGzSAsAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgELVNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:13:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589318013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aavQl6/bQGWFpbfuMfQNQQXdmDLvW34FK5u+IfoItfs=;
        b=LGzSAsAJ6dJ4rQaYZZQJrgqibicT4hzfO/26V7RydAjkdz3RoHg6+dizFAEt8fAEf22efc
        lyW7dz6LAlLogGFoUoMZiqhkkAgnlBSkScAAVrqj7X9UTGSgJ90/LTz/QkuAf/I6eWsnCL
        nd0uZZkppL5BAlJhw4dZ7PttDojDZMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-4FUuUMHUONu2ZMrnV2vKJQ-1; Tue, 12 May 2020 17:13:31 -0400
X-MC-Unique: 4FUuUMHUONu2ZMrnV2vKJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98C7EC1A6;
        Tue, 12 May 2020 21:13:29 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAB4638F;
        Tue, 12 May 2020 21:13:27 +0000 (UTC)
Date:   Tue, 12 May 2020 17:13:24 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tytso@mit.edu
Subject: Re: [PATCH] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-ID: <20200512211324.GJ367616@optiplex-lnx>
References: <20200512174653.770506-1-aquini@redhat.com>
 <20200512135326.49daaa924b1fa2fb694e2d74@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512135326.49daaa924b1fa2fb694e2d74@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 01:53:26PM -0700, Andrew Morton wrote:
> On Tue, 12 May 2020 13:46:53 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > The sysctl knob
> 
> /proc/sys/kernel/tainted, yes?
> 
> > allows users with SYS_ADMIN capability to
> > taint the kernel with any arbitrary value, but this might
> > produce an invalid flags bitset being committed to tainted_mask.
> > 
> > This patch introduces a simple way for proc_taint() to ignore
> > any eventual invalid bit coming from the user input before
> > committing those bits to the kernel tainted_mask.
> > 
> > ...
> >
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -597,6 +597,8 @@ extern enum system_states {
> >  #define TAINT_RANDSTRUCT		17
> >  #define TAINT_FLAGS_COUNT		18
> >  
> > +#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> > +
> >  struct taint_flag {
> >  	char c_true;	/* character printed when tainted */
> >  	char c_false;	/* character printed when not tainted */
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..fb2d693fc08c 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2623,11 +2623,23 @@ static int proc_taint(struct ctl_table *table, int write,
> >  		return err;
> >  
> >  	if (write) {
> > +		int i;
> > +
> > +		/*
> > +		 * Ignore user input that would cause the loop below
> > +		 * to commit arbitrary and out of valid range TAINT flags.
> > +		 */
> > +		if (tmptaint > TAINT_FLAGS_MAX) {
> > +			tmptaint &= TAINT_FLAGS_MAX;
> > +			pr_warn_once("%s: out-of-range taint input ignored."
> > +				     " tainted_mask adjusted to 0x%lx\n",
> > +				     __func__, tmptaint);
> > +		}
> > +
> >  		/*
> >  		 * Poor man's atomic or. Not worth adding a primitive
> >  		 * to everyone's atomic.h for this
> >  		 */
> > -		int i;
> >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> 
> Could simply replace BITS_PER_LONG with TAINT_FLAGS_COUNT here?
> 
> (That "&& tmptaint >> i" seems a rather silly optimization?)
> 
> >  			if ((tmptaint >> i) & 1)
> >  				add_taint(i, LOCKDEP_STILL_OK);
> 
> In fact the whole thing could be simplified down to
> 
> 	for (i = 1; i <= TAINT_FLAGS_COUNT; i <<= 1)
> 		if (i & tmptaint)
> 			add_taint(...)
> 
> and silently drop out-of-range bits?
>

Sure!

-- Rafael

