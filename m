Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD4C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997A3206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GotAERU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIAP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:59:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731348AbgIAP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598975924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhsKoxZOV+aMUeWUqsZWLQ4wnv3Es/RDZokZoWqv3Kk=;
        b=GotAERU2tv3wrbqMmdqCakhiw+1suNDCVMkBamtuk3g/0TRWN56FCS7NnTZdChpbrQ2Ytd
        GC8RfjGKFcTLZlRZ/sICNZaxS+UWReGSselqVK6KD3zt/mDCYR9c/Zc53K9m5G89cLs/+Q
        cuCLMG/5YE39CueVoLPd7ORLXSKXSqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-pdRs3gXXM0-lrlYitRpMFA-1; Tue, 01 Sep 2020 11:58:39 -0400
X-MC-Unique: pdRs3gXXM0-lrlYitRpMFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00120E75D;
        Tue,  1 Sep 2020 15:58:37 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8999078B55;
        Tue,  1 Sep 2020 15:58:37 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id D7A4520D; Tue,  1 Sep 2020 12:58:34 -0300 (BRT)
Date:   Tue, 1 Sep 2020 12:58:34 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     peterz@infradead.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Al Grant <al.grant@foss.arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200901155834.GC10147@redhat.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
 <20200901150630.GB1424523@kernel.org>
 <20200901151204.GE2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901151204.GE2674@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 01, 2020 at 05:12:04PM +0200, peterz@infradead.org escreveu:
> On Tue, Sep 01, 2020 at 12:06:30PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > Also you mixed up tools/ with include/ things, the perf part of the
> > kernel is maintained by Ingo, PeterZ.
> 
> Right, it helps if the right people are on Cc.
> 
> > Peter, the patch is the one below, I'll collect the
> > tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
> > please consider taking the kernel part.
> 
> Al, can you resend with the right people on Cc? Also see below.
> 
> > ---
> > 
> > From:   Al Grant <al.grant@foss.arm.com>
> > Subject: [PATCH] perf: correct SNOOPX field offset
> > Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
> > Date:   Mon, 24 Aug 2020 10:28:34 +0100
> > 
> > perf_event.h has macros that define the field offsets in the
> > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > were both 37. These are distinct fields, and the bitfield layout
> > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > 
> 
> This needs a Fixes: tag.

He provided it in a later message, here it goes:

    Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")

Also Andi has provided this:

    Reviewed-by: Andi Kleen <ak@linux.intel.com>

- Arnaldo

 
> > Signed-off-by: Al Grant <al.grant@arm.com>
> > 
> > ---
> > 
> >   include/uapi/linux/perf_event.h       | 2 +-
> >   tools/include/uapi/linux/perf_event.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > ---
> > 
> > diff --git a/include/uapi/linux/perf_event.h 
> > b/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..3e5dcdd48a49 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> > 
> >   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
> >   /* 1 free */
> > -#define PERF_MEM_SNOOPX_SHIFT  37
> > +#define PERF_MEM_SNOOPX_SHIFT  38
> > 
> >   /* locked instruction */
> >   #define PERF_MEM_LOCK_NA       0x01 /* not available */
> > diff --git a/tools/include/uapi/linux/perf_event.h 
> > b/tools/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..3e5dcdd48a49 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> > 
> >   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
> >   /* 1 free */
> > -#define PERF_MEM_SNOOPX_SHIFT  37
> > +#define PERF_MEM_SNOOPX_SHIFT  38
> > 
> >   /* locked instruction */
> >   #define PERF_MEM_LOCK_NA       0x01 /* not available */

