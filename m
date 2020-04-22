Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A7CC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6683520787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThmfsWXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDVNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:55:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587563747;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=YpE39E0ldMec6QTYNVZpMsjRjumdc9ypXwrtK5zGWF0=;
        b=ThmfsWXykufRfp+xnzqN6oPz7XJ5HnjhFmH4wY0x2dLtM0yUeU3Iuh/knCw5kzWhpadhgC
        SB3MNL5FAD5+59nKXe0/UiSFd9ZWr4ciHNI7ykZ7UCqsjj47hCaCcHWbRvq69DHBapDcKw
        DpGyNpkj2OhGNVvvXK90fGhmACSrenk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Y9yhyo1ROQeyrZpss2vJew-1; Wed, 22 Apr 2020 09:55:44 -0400
X-MC-Unique: Y9yhyo1ROQeyrZpss2vJew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054C318C35A0;
        Wed, 22 Apr 2020 13:55:42 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D5FC5DA82;
        Wed, 22 Apr 2020 13:55:41 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 03MDtcqP019898;
        Wed, 22 Apr 2020 15:55:38 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 03MDtVop019897;
        Wed, 22 Apr 2020 15:55:31 +0200
Date:   Wed, 22 Apr 2020 15:55:31 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422135531.GM2424@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net>
 <20200422134924.GB26846@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422134924.GB26846@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:49:24PM +0200, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:40:07PM +0200, Peter Zijlstra wrote:
> > You haz a whitespace issue there.
> 
> Fixed.
> 
> > Also, can we get this in writing, signed in blood, from the various
> > compiler teams ;-)
> 
> Yah, I wouldn't want to go fix this again in gcc11 or so. That's why I
> wanted the explicit marking but let's try this first - it is too simple
> to pass over without having tested it.

If virtual blood is enough, AFAIK GCC has never tried to accept volatile
inline asm (asm ("") is such; non-volatile asm such as int x; asm ("" : "=r" (x));
could be e.g. dead code eliminated) in the statements between function call and
return when deciding about what function can be tail-called or can use
tail-recursion and there are no plans to change that.

	Jakub

