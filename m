Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE86C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997CF208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aL3yjS0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEAVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbgEAVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588369319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OdOcvEZEhBr5Vq54X6k0G7YOitkQMN27mIGgBJ6KgyU=;
        b=aL3yjS0qISPNDayMSOf/6lJ6Syxijao+toJeIIG6MoVFZpFrT0FjeI+l1XTNrIVmj/3Fkt
        bRAQFQgYUcQRVqHcUGKgDyHZfHWO2PGC/TYOmlebT6VY20Ph3e6NqrutnWu7pJoCS2DSwQ
        EKp7U/doxPf1zTWIxpDPpDR0q/lXMiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-Sy8kGdfPMBuS2MOlTZVIJA-1; Fri, 01 May 2020 17:41:52 -0400
X-MC-Unique: Sy8kGdfPMBuS2MOlTZVIJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A16645F;
        Fri,  1 May 2020 21:41:50 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A01BD5EE11;
        Fri,  1 May 2020 21:41:47 +0000 (UTC)
Date:   Fri, 1 May 2020 17:41:44 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Message-ID: <20200501214144.GD27720@optiplex-lnx>
References: <20200501211540.71216-1-aquini@redhat.com>
 <20200501143751.97a25bb7f89f8d93ec443868@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501143751.97a25bb7f89f8d93ec443868@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 02:37:51PM -0700, Andrew Morton wrote:
> On Fri,  1 May 2020 17:15:40 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > Sometimes it is desirable to override SLUB's debug facilities
> > default behavior upon stumbling on a cache or object error
> > and just stop the execution in order to grab a coredump, at
> > the error-spotting time, instead of trying to fix the issue
> > and report in an attempt to keep the system rolling.
> > 
> > This patch introduces a new debug flag SLAB_PANIC_ON_ERROR,
> > along with its related SLUB-machinery, in order to extend
> > current slub_debug facilites and provide the aforementioned
> > behavior override.
> > 
> 
> Sees reasonable.
> 
> > --- a/Documentation/vm/slub.rst
> > +++ b/Documentation/vm/slub.rst
> > @@ -54,6 +54,8 @@ Possible debug options are::
> >  			caused higher minimum slab orders
> >  	-		Switch all debugging off (useful if the kernel is
> >  			configured with CONFIG_SLUB_DEBUG_ON)
> > +	C		Toggle panic on error (crash) to allow for post-mortem
> > +			analysis of a coredump taken at the error-spotting time
> 
> nit: "toggle" means to switch to the other state.  But what we're doing
> here is to set to the "on" state.  This:
>

Thanks Andrew, that's indeed much better.
 
> --- a/Documentation/vm/slub.rst~mm-slub-add-panic_on_error-to-the-debug-facilities-fix
> +++ a/Documentation/vm/slub.rst
> @@ -49,12 +49,12 @@ Possible debug options are::
>  	P		Poisoning (object and padding)
>  	U		User tracking (free and alloc)
>  	T		Trace (please only use on single slabs)
> -	A		Toggle failslab filter mark for the cache
> +	A		Enable failslab filter mark for the cache
>  	O		Switch debugging off for caches that would have
>  			caused higher minimum slab orders
>  	-		Switch all debugging off (useful if the kernel is
>  			configured with CONFIG_SLUB_DEBUG_ON)
> -	C		Toggle panic on error (crash) to allow for post-mortem
> +	C		Enable panic on error (crash) to allow for post-mortem
>  			analysis of a coredump taken at the error-spotting time
>  
>  F.e. in order to boot just with sanity checks and red zoning one would specify::
> _
> 
> 

