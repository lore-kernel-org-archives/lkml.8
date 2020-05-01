Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF8C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D696216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwDhz8qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEAVyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:54:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726045AbgEAVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588370093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vqe/h5bIx8Xwds5+Doaeo5m4e7NAmlXMvCMv86v34rc=;
        b=IwDhz8qFqZ3P8Ga2hQugrbtYcW+J78pfO9cvPbMOkT2rAZinNz/4xtIRQ0uvgOVXePAlsA
        Wdc9HX4DAUvE1T2BQqcWU6n0nH3f9fywqbfq2ZQPg09/bLMNlYOESYitMALTiCT3167M/z
        YpXBLjdbXE42RAXUEiHQJcqqrIGHsnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-Qwf3zUiVOfaeAGW9G-6Xxg-1; Fri, 01 May 2020 17:54:49 -0400
X-MC-Unique: Qwf3zUiVOfaeAGW9G-6Xxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EA545F;
        Fri,  1 May 2020 21:54:46 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BDE36A954;
        Fri,  1 May 2020 21:54:44 +0000 (UTC)
Date:   Fri, 1 May 2020 17:54:41 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Message-ID: <20200501215441.GE27720@optiplex-lnx>
References: <20200501211540.71216-1-aquini@redhat.com>
 <21CF143C-B9D1-4D3F-A875-370924265593@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21CF143C-B9D1-4D3F-A875-370924265593@lca.pw>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 05:29:19PM -0400, Qian Cai wrote:
> 
> 
> > On May 1, 2020, at 5:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
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
> 
> Instead of adding those things everywhere. How about adding something like panic_on_taint? Then, you could write specific taint flags you are interested in to that file because slab_bug() will taint it TAINT_BAD_PAGE.
>
It seems like a good idea which also would required "adding things"
elsewhere, but doesn't look mutually exclusive with the approach here.

Thanks
-- Rafael  

