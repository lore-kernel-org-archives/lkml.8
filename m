Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DDAC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DED6206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV0GwK5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgEKX72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:59:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589241565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=su7IZNhrlE7HNdooJKGpydIdN6GK+u6wNKS/k/H3gwU=;
        b=gV0GwK5cUb7WDE3saJPkEc7ym4otGNFxXbOroWcjUlHVgVibM/QgZAOvVNVaKMfyVZH0TJ
        UYkEiNXXmzxbMhkL8JScCXv7txb4OLFFBSrhue6cEUITXJuPT1+zaX9iO+mjtEPfIA1CV6
        nWv1KledZg0AmOzjwADt0LWejIFEt1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-5uBBaGbQOweF80mZGFTuOA-1; Mon, 11 May 2020 19:59:21 -0400
X-MC-Unique: 5uBBaGbQOweF80mZGFTuOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B203518A0724;
        Mon, 11 May 2020 23:59:19 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 974156444B;
        Mon, 11 May 2020 23:59:17 +0000 (UTC)
Date:   Mon, 11 May 2020 19:59:14 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tso Ted <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200511235914.GF367616@optiplex-lnx>
References: <20200511215904.719257-1-aquini@redhat.com>
 <20200511231045.GV11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511231045.GV11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:10:45PM +0000, Luis Chamberlain wrote:
> On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> > The sysctl knob allows any user with SYS_ADMIN capability to
> > taint the kernel with any arbitrary value, but this might
> > produce an invalid flags bitset being committed to tainted_mask.
> > 
> > This patch introduces a simple way for proc_taint() to ignore
> > any eventual invalid bit coming from the user input before
> > committing those bits to the kernel tainted_mask, as well as
> > it makes clear use of TAINT_USER flag to mark the kernel
> > tainted by user everytime a taint value is written
> > to the kernel.tainted sysctl.
> > 
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  kernel/sysctl.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..f0a4fb38ac62 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
> >  		return err;
> >  
> >  	if (write) {
> > +		int i;
> > +
> > +		/*
> > +		 * Ignore user input that would make us committing
> > +		 * arbitrary invalid TAINT flags in the loop below.
> > +		 */
> > +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
> 
> This looks good but we don't pr_warn() of information lost on intention.
>

Are you thinking in sth like:

+               if (tmptaint > TAINT_FLAGS_MAX) {
+                       tmptaint &= TAINT_FLAGS_MAX;
+                       pr_warn("proc_taint: out-of-range invalid input ignored"
+                               " tainted_mask adjusted to 0x%x\n", tmptaint);
+               }

?
 
> > +
> >  		/*
> >  		 * Poor man's atomic or. Not worth adding a primitive
> >  		 * to everyone's atomic.h for this
> >  		 */
> > -		int i;
> >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> >  			if ((tmptaint >> i) & 1)
> >  				add_taint(i, LOCKDEP_STILL_OK);
> >  		}
> > +
> > +		/*
> > +		 * Users with SYS_ADMIN capability can include any arbitrary
> > +		 * taint flag by writing to this interface. If that's the case,
> > +		 * we also need to mark the kernel "tainted by user".
> > +		 */
> > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 
> I'm in favor of this however I'd like to hear from Ted on if it meets
> the original intention. I would think he had a good reason not to add
> it here.
>

Fair enough. The impression I got by reading Ted's original commit
message is that the intent was to have TAINT_USER as the flag set 
via this interface, even though the code was allowing for any 
arbitrary value. I think it's OK to let the user fiddle with
the flags, as it's been allowed since the introduction of
this interface, but we need to reflect that fact in the
tainting itself. Since TAINT_USER is not used anywhere,
this change perfectly communicates that fact without
the need for introducing yet another taint flag.

Cheers!
-- Rafael

