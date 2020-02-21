Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B3C35661
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1924650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtkNbFF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBUTuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:50:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31112 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbgBUTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582314651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Unie+N+CR+ixt+b/4tM+0L7Mc0IBXa5zja9FG566mHU=;
        b=WtkNbFF+ylcTUIVSPlpgLeOa9G5PgBTqX4RqkK68YIYaDhyTqe3hCBYrmT/4X42Z0Ss/3I
        8nXa2Ca4oBw2fZ2GVDGqYJKafDCEWPLB8jeTNImWG9dTnGBltB9+1W13zfSZ+uhe/h8LlG
        PtTRrrWYStZU+i1zlbUXnaEtV7RaG7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281--uOvEtZqPMmhiOqSvYd13A-1; Fri, 21 Feb 2020 14:50:47 -0500
X-MC-Unique: -uOvEtZqPMmhiOqSvYd13A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4BBA800D48;
        Fri, 21 Feb 2020 19:50:44 +0000 (UTC)
Received: from treble (ovpn-125-126.rdu2.redhat.com [10.10.125.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D637E5C28E;
        Fri, 21 Feb 2020 19:50:41 +0000 (UTC)
Date:   Fri, 21 Feb 2020 13:50:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200221195039.dptvoerfez4r76ay@treble>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
 <202002091742.7B1E6BF19@keescook>
 <20200210105117.GE14879@hirez.programming.kicks-ass.net>
 <43b7ba31-6dca-488b-8a0e-72d9fdfd1a6b@linux.intel.com>
 <20200210163627.GA1829035@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210163627.GA1829035@rani.riverdale.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:36:29AM -0500, Arvind Sankar wrote:
> On Mon, Feb 10, 2020 at 07:54:58AM -0800, Arjan van de Ven wrote:
> > > 
> > > I'll leave it to others to figure out the exact details. But afaict it
> > > should be possible to have fine-grained-randomization and preserve the
> > > workaround in the end.
> > > 
> > 
> > the most obvious "solution" is to compile with an alignment of 4 bytes (so tight packing)
> > and then in the randomizer preserve the offset within 32 bytes, no matter what it is
> > 
> > that would get you an average padding of 16 bytes which is a bit more than now but not too insane
> > (queue Kees' argument that tiny bits of padding are actually good)
> > 
> 
> With the patchset for adding the mbranches-within-32B-boundaries option,
> the section alignment gets forced to 32. With function-sections that
> means function alignment has to be 32 too.

We should be careful about enabling -mbranches-within-32B-boundaries.
It will hurt AMD, and presumably future Intel CPUs which don't need it.

-- 
Josh

