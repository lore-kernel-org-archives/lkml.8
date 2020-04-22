Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C520776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxpNiQo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgDVRDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:03:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgDVRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587575014;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=K+Vw95hzbBrvACE7p1+DGBuatgWYBdD+qziGcMPXbJ0=;
        b=AxpNiQo8cNoISyIjci7l1IYB8ofUH+5fXJ8zb2Oql6BO1cNCl3lAgIorGo9bIkQ3NfCGc8
        Eg2skCy+AUHlfDx64m3+tUkp18h2Mbq3y3pubZ6rJOlOUTKHT1sZySD1UklXySw1ByhEN1
        uvbZQPV9kmxc1so2hb5xVKg0ufkrnr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-HYUCnAmwNdGbaFJx3Q681A-1; Wed, 22 Apr 2020 13:03:28 -0400
X-MC-Unique: HYUCnAmwNdGbaFJx3Q681A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DD918B9FC3;
        Wed, 22 Apr 2020 17:03:26 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 231BE10190D6;
        Wed, 22 Apr 2020 17:03:25 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 03MH3AfF003682;
        Wed, 22 Apr 2020 19:03:15 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 03MH2pcI003681;
        Wed, 22 Apr 2020 19:02:51 +0200
Date:   Wed, 22 Apr 2020 19:02:51 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200422170251.GQ2424@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net>
 <20200422134924.GB26846@zn.tnic>
 <20200422135531.GM2424@tucnak>
 <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
 <20200422165339.GE26846@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422165339.GE26846@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:53:39PM +0200, Borislav Petkov wrote:
> > $ cat asm-detect.c
> > int foo(int a);
> > int bar(int a)
> > {
> >   int r = foo(a);
> >   asm ("");
> >   return r;
> > }
> > 
> > $ gcc -O2 -c asm-detect.c -S -o/dev/stdout | grep jmp
> > [no output]
> 
> That is a good test to run at the beginning of the compilation I guess.

If it is x86 specific, it can work, though I'd suggest -o - instead of
-o/dev/stdout and being more picky on where you want to match the jmp,
as you don't want to match it in comments, or say filenames in the asm file
etc.  E.g. require that jmp must be preceeded on the line only by whitespace
and followed by whitespace.

	Jakub

